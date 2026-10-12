# ---------------------------------------------------------------------------
# PDF writer for the report builder. Lays out the blocks from report_blocks()
# (app/logic/report.R) page by page with grid on R's own Cairo PDF device,
# styled from REPORT_STYLE so it matches the Word writer. Pure R: no LaTeX,
# pandoc or browser, so it runs the same on the server and in the desktop build.
#
# Layout keeps a cursor (inches down from the top of the page). Each block
# measures itself, starts a new page when it doesn't fit, and draws; long
# paragraphs break between lines and long tables between rows, repeating the
# header row.
# ---------------------------------------------------------------------------

box::use(
  grDevices[cairo_pdf, dev.off],
  grid,
  here[here],
  png[readPNG],
)

box::use(
  app/logic/report[REPORT_STYLE, footer_text],
)

LOGO <- here("app", "static", "images", "intelimon_logo.png")
LINE_GAP <- 1.3 # line height as a multiple of the font size

gp <- function(size, color = REPORT_STYLE$ink, face = "plain") {
  grid$gpar(fontfamily = "sans", fontsize = size, col = color, fontface = face)
}

pts <- function(size) size / 72 * LINE_GAP # one line of text, in inches

# Arial has no subscript digits (e.g. the I\u2080 in "crown-initiation
# intensity"), so they are drawn as plain digits.
pdf_text <- function(x) chartr(intToUtf8(0x2080:0x2089), "0123456789", x)

# Width in inches of each string. Measured one at a time: grobWidth() of a
# multi-label textGrob reports the first label only, not the widest.
text_width <- function(x, g) {
  vapply(x, function(s) {
    grid$convertWidth(grid$grobWidth(grid$textGrob(s, gp = g)), "in", valueOnly = TRUE)
  }, numeric(1), USE.NAMES = FALSE)
}

#' Greedy word wrap to a width in inches, measured with the real font.
#' Newlines in `x` start new lines.
wrap_text <- function(x, g, width) {
  x <- pdf_text(x)
  out <- character()
  for (para in strsplit(x, "\n", fixed = TRUE)[[1]]) {
    words <- strsplit(para, "[[:space:]]+")[[1]]
    words <- words[nzchar(words)]
    line <- ""
    for (w in words) {
      candidate <- if (nzchar(line)) paste(line, w) else w
      if (nzchar(line) && text_width(candidate, g) > width) {
        out <- c(out, line)
        line <- w
      } else {
        line <- candidate
      }
    }
    out <- c(out, line)
  }
  out
}

new_layout <- function(date) {
  s <- REPORT_STYLE
  env <- new.env()
  env$page <- 0L
  env$y <- 0
  env$left <- s$margin
  env$width <- s$page_width - 2 * s$margin
  env$bottom <- s$page_height - s$margin
  env$footer <- footer_text(date)
  env
}

new_page <- function(lay) {
  s <- REPORT_STYLE
  grid$grid.newpage()
  lay$page <- lay$page + 1L
  lay$y <- s$margin
  grid$grid.text(
    paste0(lay$footer, "  \u00b7  Page ", lay$page),
    x = grid$unit(s$page_width - s$margin, "in"), y = grid$unit(s$margin / 2, "in"),
    just = c("right", "center"), gp = gp(s$size_footer, s$dim)
  )
}

ensure <- function(lay, height) {
  if (lay$page == 0L || lay$y + height > lay$bottom) new_page(lay)
}

# Draw one line of text with its top at the cursor and advance.
draw_line <- function(lay, label, g, size, x_offset = 0) {
  grid$grid.text(
    label,
    x = grid$unit(lay$left + x_offset, "in"),
    y = grid$unit(REPORT_STYLE$page_height - lay$y - pts(size) * 0.8, "in"),
    just = c("left", "bottom"), gp = g
  )
  lay$y <- lay$y + pts(size)
}

draw_text <- function(lay, x, size, color = REPORT_STYLE$ink, face = "plain",
                      before = 0, after = 6 / 72) {
  g <- gp(size, color, face)
  lines <- wrap_text(x, g, lay$width)
  lay$y <- lay$y + before
  # keep at least two lines together at a page break
  ensure(lay, pts(size) * min(2, length(lines)))
  for (l in lines) {
    ensure(lay, pts(size))
    draw_line(lay, l, g, size)
  }
  lay$y <- lay$y + after
}

draw_rule <- function(lay, after = 0.15) {
  y <- REPORT_STYLE$page_height - lay$y
  grid$grid.lines(
    x = grid$unit(c(lay$left, lay$left + lay$width), "in"), y = grid$unit(c(y, y), "in"),
    gp = grid$gpar(col = REPORT_STYLE$rule, lwd = 0.8)
  )
  lay$y <- lay$y + after
}

draw_caption <- function(lay, b) {
  s <- REPORT_STYLE
  draw_text(lay, paste(b$label, b$title), s$size_caption, face = "bold",
            after = if (nzchar(b$settings)) 0 else 6 / 72)
  if (nzchar(b$settings)) {
    draw_text(lay, b$settings, s$size_caption - 1, s$dim, face = "italic")
  }
}

draw_title <- function(lay, b) {
  s <- REPORT_STYLE
  new_page(lay)
  if (file.exists(LOGO)) {
    h <- 0.6 * 132 / 114
    grid$grid.raster(
      readPNG(LOGO),
      x = grid$unit(lay$left, "in"), y = grid$unit(s$page_height - lay$y, "in"),
      width = grid$unit(0.6, "in"), height = grid$unit(h, "in"), just = c("left", "top")
    )
    lay$y <- lay$y + h + 0.1
  }
  draw_text(lay, b$title, s$size_title, s$accent, "bold", after = 2 / 72)
  if (!is.null(b$subtitle)) draw_text(lay, b$subtitle, s$size_subtitle, s$dim, after = 2 / 72)
  for (l in b$lines) draw_text(lay, l, s$size_body, s$dim, after = 0)
  lay$y <- lay$y + 0.08
  draw_rule(lay)
}

draw_figure <- function(lay, b) {
  s <- REPORT_STYLE
  caption_h <- pts(s$size_caption) * 3
  ensure(lay, s$fig_height + caption_h)
  grid$pushViewport(grid$viewport(
    x = grid$unit(lay$left + (lay$width - s$fig_width) / 2, "in"),
    y = grid$unit(s$page_height - lay$y, "in"),
    width = grid$unit(s$fig_width, "in"), height = grid$unit(s$fig_height, "in"),
    just = c("left", "top")
  ))
  print(b$plot, newp = FALSE)
  grid$popViewport()
  lay$y <- lay$y + s$fig_height + 0.05
  draw_caption(lay, b)
}

# Column widths in inches: each column's widest cell plus padding, scaled to
# the text width when the table would overflow it. Returns the widths and the
# font size (shrunk, to a floor, for very wide tables).
table_geometry <- function(df, width) {
  s <- REPORT_STYLE
  size <- s$size_table
  repeat {
    widths <- vapply(seq_along(df), function(j) {
      cells <- pdf_text(c(names(df)[j], as.character(df[[j]])))
      max(text_width(cells, gp(size, face = "bold"))) + 0.16
    }, numeric(1))
    if (sum(widths) <= width || size <= 6.5) break
    size <- size - 0.5
  }
  if (sum(widths) > width) widths <- widths * width / sum(widths)
  list(widths = widths, size = size)
}

draw_table <- function(lay, b) {
  s <- REPORT_STYLE
  df <- as.data.frame(b$data, stringsAsFactors = FALSE)
  geo <- table_geometry(df, lay$width)
  row_h <- pts(geo$size) + 0.05
  ensure(lay, pts(s$size_caption) * 3 + row_h * min(nrow(df) + 1, 4))
  draw_caption(lay, b)
  x0 <- lay$left + c(0, cumsum(geo$widths))[seq_along(df)]

  draw_row <- function(cells, fill, g, header = FALSE) {
    top <- s$page_height - lay$y
    grid$grid.rect(
      x = grid$unit(lay$left, "in"), y = grid$unit(top, "in"),
      width = grid$unit(sum(geo$widths), "in"), height = grid$unit(row_h, "in"),
      just = c("left", "top"), gp = grid$gpar(fill = fill, col = NA)
    )
    for (j in seq_along(cells)) {
      right <- j > 1
      grid$grid.text(
        pdf_text(cells[j]),
        x = grid$unit(if (right) x0[j] + geo$widths[j] - 0.08 else x0[j] + 0.08, "in"),
        y = grid$unit(top - row_h / 2, "in"),
        just = c(if (right) "right" else "left", "center"), gp = g
      )
    }
    lay$y <- lay$y + row_h
  }
  header <- function() {
    draw_row(names(df), s$head_fill, gp(geo$size, s$head_ink, "bold"), header = TRUE)
  }

  header()
  for (i in seq_len(nrow(df))) {
    if (lay$y + row_h > lay$bottom) {
      new_page(lay)
      header()
    }
    draw_row(as.character(unlist(df[i, ])), if (i %% 2 == 0) s$stripe else NA, gp(geo$size))
  }
  bottom <- s$page_height - lay$y
  grid$grid.lines(
    x = grid$unit(c(lay$left, lay$left + sum(geo$widths)), "in"),
    y = grid$unit(c(bottom, bottom), "in"), gp = grid$gpar(col = s$rule, lwd = 0.8)
  )
  lay$y <- lay$y + 0.05
  if (!is.null(b$note) && nzchar(b$note)) {
    draw_text(lay, b$note, s$size_caption - 1, s$dim, before = 0.02)
  }
  lay$y <- lay$y + 0.08
}

# Height of the first part of a block that must stay on the same page as the
# heading above it: a whole figure, a table's caption and first rows, or the
# first lines of text.
lead_height <- function(b) {
  s <- REPORT_STYLE
  if (is.null(b)) return(0)
  switch(b$type,
    figure = s$fig_height + pts(s$size_caption) * 3,
    table = pts(s$size_caption) * 3 + (pts(s$size_table) + 0.05) * min(nrow(b$data) + 1, 4),
    pts(s$size_body) * 3
  )
}

draw_block <- function(lay, b, next_block = NULL) {
  s <- REPORT_STYLE
  switch(b$type,
    title = draw_title(lay, b),
    heading = {
      size <- if (b$level == 1) s$size_h1 else s$size_h2
      before <- if (b$level == 1) 0.2 else 0.1
      ensure(lay, before + pts(size) + 4 / 72 + lead_height(next_block))
      draw_text(lay, b$text, size, s$accent, "bold", before = before, after = 4 / 72)
    },
    paragraph = draw_text(lay, b$text, if (identical(b$size, "small")) s$size_caption else s$size_body),
    warning = draw_text(lay, b$text, s$size_body, s$warn, "bold", before = 0.06, after = 0.12),
    figure = draw_figure(lay, b),
    table = draw_table(lay, b)
  )
}

#' Write report blocks to a PDF file.
#' @param blocks Output of `report_blocks()`.
#' @param path File to write.
#' @return `path`, invisibly, with the number of pages in its "pages" attribute.
#' @export
render_pdf <- function(blocks, path, date = Sys.Date()) {
  s <- REPORT_STYLE
  cairo_pdf(path, width = s$page_width, height = s$page_height, onefile = TRUE, family = "sans")
  on.exit(dev.off())
  lay <- new_layout(date)
  for (i in seq_along(blocks)) {
    draw_block(lay, blocks[[i]], if (i < length(blocks)) blocks[[i + 1]])
  }
  if (lay$page == 0L) new_page(lay)
  invisible(structure(path, pages = lay$page))
}
