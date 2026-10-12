# ---------------------------------------------------------------------------
# Word (.docx) writer for the report builder. Renders the blocks from
# report_blocks() (app/logic/report.R) with officer and flextable, styled from
# REPORT_STYLE so the document matches the PDF writer. Pure R: no pandoc, so it
# runs the same on the server and in the desktop build.
# ---------------------------------------------------------------------------

box::use(
  flextable,
  here[here],
  officer,
)

box::use(
  app/logic/report[REPORT_STYLE, footer_text],
)

LOGO <- here("app", "static", "images", "intelimon_logo.png")

txt <- function(size, color = REPORT_STYLE$ink, bold = FALSE, italic = FALSE) {
  officer$fp_text(
    font.family = REPORT_STYLE$font, font.size = size, color = color,
    bold = bold, italic = italic
  )
}

pp <- function(before = 0, after = 6, align = "left", rule = FALSE) {
  officer$fp_par(
    text.align = align, padding.top = before, padding.bottom = after,
    line_spacing = 1.15,
    border.bottom = if (rule) officer$fp_border(color = REPORT_STYLE$rule, width = 1) else
      officer$fp_border(width = 0)
  )
}

add_par <- function(doc, ..., fp_p = pp(), style = "Normal") {
  officer$body_add_fpar(doc, officer$fpar(..., fp_p = fp_p), style = style)
}

# Caption: bold label + title, then the settings line in small grey type.
add_caption <- function(doc, b, before = 4) {
  doc <- add_par(doc,
    officer$ftext(paste0(b$label, " "), txt(REPORT_STYLE$size_caption, bold = TRUE)),
    officer$ftext(b$title, txt(REPORT_STYLE$size_caption)),
    fp_p = pp(before = before, after = if (nzchar(b$settings)) 0 else 6)
  )
  if (nzchar(b$settings)) {
    doc <- add_par(doc,
      officer$ftext(b$settings, txt(REPORT_STYLE$size_caption - 1, REPORT_STYLE$dim, italic = TRUE)),
      fp_p = pp(after = 6)
    )
  }
  doc
}

style_table <- function(df) {
  s <- REPORT_STYLE
  ft <- flextable$flextable(df)
  ft <- flextable$font(ft, fontname = s$font, part = "all")
  ft <- flextable$fontsize(ft, size = s$size_table, part = "all")
  ft <- flextable$color(ft, color = s$ink, part = "body")
  ft <- flextable$bg(ft, bg = s$head_fill, part = "header")
  ft <- flextable$color(ft, color = s$head_ink, part = "header")
  ft <- flextable$bold(ft, part = "header")
  if (nrow(df) > 1) {
    ft <- flextable$bg(ft, i = seq(2, nrow(df), by = 2), bg = s$stripe, part = "body")
  }
  ft <- flextable$border_remove(ft)
  ft <- flextable$hline_bottom(ft, border = officer$fp_border(color = s$rule), part = "body")
  ft <- flextable$padding(ft, padding.top = 2, padding.bottom = 2, part = "all")
  # the first column holds labels; the rest are numbers or dates
  ft <- flextable$align(ft, j = 1, align = "left", part = "all")
  if (ncol(df) > 1) ft <- flextable$align(ft, j = 2:ncol(df), align = "right", part = "all")
  ft <- flextable$autofit(ft)
  full <- s$page_width - 2 * s$margin
  if (sum(flextable$dim_pretty(ft)$widths) > full) ft <- flextable$fit_to_width(ft, full)
  ft
}

add_block <- function(doc, b) {
  s <- REPORT_STYLE
  switch(b$type,
    title = {
      if (file.exists(LOGO)) {
        doc <- add_par(doc, officer$external_img(LOGO, width = 0.6, height = 0.6 * 132 / 114),
                       fp_p = pp(after = 4))
      }
      doc <- add_par(doc, officer$ftext(b$title, txt(s$size_title, s$accent, bold = TRUE)),
                     fp_p = pp(after = 2))
      if (!is.null(b$subtitle)) {
        doc <- add_par(doc, officer$ftext(b$subtitle, txt(s$size_subtitle, s$dim)),
                       fp_p = pp(after = 2))
      }
      for (l in b$lines) doc <- add_par(doc, officer$ftext(l, txt(s$size_body, s$dim)), fp_p = pp(after = 0))
      add_par(doc, officer$ftext(" ", txt(4)), fp_p = pp(after = 10, rule = TRUE))
    },
    heading = {
      size <- if (b$level == 1) s$size_h1 else s$size_h2
      add_par(doc, officer$ftext(b$text, txt(size, s$accent, bold = TRUE)),
              fp_p = pp(before = if (b$level == 1) 14 else 8, after = 4),
              style = paste("heading", b$level))
    },
    paragraph = {
      size <- if (identical(b$size, "small")) s$size_caption else s$size_body
      add_par(doc, officer$ftext(b$text, txt(size)))
    },
    warning = add_par(doc, officer$ftext(b$text, txt(s$size_body, s$warn, bold = TRUE)),
                      fp_p = pp(before = 6, after = 8)),
    figure = {
      doc <- officer$body_add_gg(doc, value = b$plot, width = s$fig_width, height = s$fig_height,
                                 res = 200, style = "centered")
      add_caption(doc, b, before = 2)
    },
    table = {
      doc <- add_caption(doc, b, before = 6)
      doc <- flextable$body_add_flextable(doc, style_table(b$data), align = "left")
      if (!is.null(b$note) && nzchar(b$note)) {
        doc <- add_par(doc, officer$ftext(b$note, txt(s$size_caption - 1, s$dim)),
                       fp_p = pp(before = 2, after = 8))
      }
      doc
    },
    doc
  )
}

#' Write report blocks to a .docx file.
#' @param blocks Output of `report_blocks()`.
#' @param path File to write.
#' @return `path`, invisibly.
#' @export
render_docx <- function(blocks, path, date = Sys.Date()) {
  s <- REPORT_STYLE
  doc <- officer$read_docx()
  doc <- officer$docx_set_paragraph_style(
    doc, style_id = "Normal", style_name = "Normal",
    fp_p = pp(), fp_t = txt(s$size_body)
  )
  for (b in blocks) doc <- add_block(doc, b)

  footer <- officer$block_list(officer$fpar(
    officer$ftext(paste0(footer_text(date), "  \u00b7  Page "), txt(s$size_footer, s$dim)),
    officer$run_word_field("PAGE", prop = txt(s$size_footer, s$dim)),
    fp_p = pp(after = 0, align = "right")
  ))
  doc <- officer$body_set_default_section(doc, officer$prop_section(
    page_size = officer$page_size(width = s$page_width, height = s$page_height, orient = "portrait"),
    page_margins = officer$page_mar(
      top = s$margin, bottom = s$margin, left = s$margin, right = s$margin,
      header = 0.5, footer = 0.5, gutter = 0
    ),
    footer_default = footer
  ))
  print(doc, target = path)
  invisible(path)
}
