# ---------------------------------------------------------------------------
# Report builder core. Pure functions, no Shiny.
#
# Cards add *items* to the session's report (a figure or a table, exactly as
# the card showed it, plus the settings behind it). `report_blocks()` lays the
# items out as a flat list of *blocks* (title, heading, paragraph, warning,
# figure, table) with figures and tables numbered. The Word and PDF writers
# (app/logic/report_docx.R, app/logic/report_pdf.R) render the same blocks
# with the same REPORT_STYLE, so both formats share one template.
# ---------------------------------------------------------------------------

#' Shared template for both output formats. Colours match the light export
#' palette the figures are drawn with (EXPORT_PAL in app/view/plotting.R).
#' Sizes are points; page dimensions and margins are inches (US Letter).
#' @export
REPORT_STYLE <- list(
  font          = "Arial",
  size_title    = 22,
  size_subtitle = 13,
  size_h1       = 15,
  size_h2       = 12,
  size_body     = 10,
  size_caption  = 9,
  size_table    = 8.5,
  size_footer   = 8,
  ink           = "#1a1a1a",
  dim           = "#495057",
  accent        = "#0b7285",
  rule          = "#ced4da",
  head_fill     = "#0b7285",
  head_ink      = "#ffffff",
  stripe        = "#eef3f5",
  warn          = "#c92a2a",
  page_width    = 8.5,
  page_height   = 11,
  margin        = 1,
  fig_width     = 6.5,
  fig_height    = 3.9,
  product       = "IntELiMon Decision Support Tool"
)

#' Text of the rothRmel caveat, added to any report holding rothRmel output.
#' @export
ROTHRMEL_CAVEAT <- paste(
  "The fire models in the rothRmel tab should be used for change tracking and",
  "treatment success purposes only. These models have not been verified for use",
  "with custom fuel beds generated from TLS."
)

ABOUT_TEXT <- paste(
  "Data in this report come from the Interagency Ecosystem Lidar Monitoring",
  "Program (IntELiMon). Each plot is recorded with a single terrestrial laser",
  "scan (TLS) from plot center, and every scan is processed with the same",
  "automated pipeline into standardized forestry, fuels and ecological metrics",
  "(Murphy et al., 2024; Pokswinski et al., 2026). Scans are grouped into time",
  "steps, and treatment dates separate pre- and post-treatment scans."
)

REFERENCES <- c(
  paste(
    "Murphy, M. C., Loudermilk, E. L., Pokswinski, S., et al. (2024). Terrestrial 3D",
    "laser scanning for ecosystem and fire effects monitoring. Gen. Tech. Rep. SRS-277.",
    "Asheville, NC: U.S. Department of Agriculture, Forest Service, Southern Research",
    "Station. https://doi.org/10.2737/SRS-GTR-277"
  ),
  paste(
    "Pokswinski, S., Nelson, K., Maxwell, A., et al. (2026). IntELiMon: an automated",
    "framework for standardized terrestrial lidar processing in multi-disciplinary",
    "ecosystem monitoring. Forestry: An International Journal of Forest Research, 99(5),",
    "cpag083. https://doi.org/10.1093/forestry/cpag083"
  )
)

.item_counter <- new.env()
.item_counter$n <- 0L

#' One report item, as added from a card.
#' @param kind "figure" (a ggplot in `plot`) or "table" (a data.frame in `table`).
#' @param title Caption title, e.g. the metric label.
#' @param source Tab the card is on, e.g. "Standard outputs".
#' @param settings Named list of the card's settings, shown under the caption.
#' @param note Footnote printed under a table (fixed text from the card).
#' @return A list with a session-unique `id`.
#' @export
report_item <- function(kind, title, source, settings = list(), plot = NULL,
                        table = NULL, note = NULL) {
  stopifnot(kind %in% c("figure", "table"))
  .item_counter$n <- .item_counter$n + 1L
  list(
    id = paste0("item", .item_counter$n),
    kind = kind,
    title = title,
    source = source,
    settings = settings,
    plot = plot,
    table = table,
    note = note,
    comment = ""
  )
}

#' Settings as one line: "Plot type: Box and Whisker; Data type: Percent change".
#' Empty and NULL settings are skipped.
#' @export
settings_line <- function(settings) {
  keep <- vapply(settings, function(v) length(v) == 1 && !is.na(v) && nzchar(v), logical(1))
  settings <- settings[keep]
  if (length(settings) == 0) return("")
  paste(paste0(names(settings), ": ", unlist(settings)), collapse = "; ")
}

#' Move an item one place up or down in the list; out-of-range moves are no-ops.
#' @export
move_item <- function(items, id, direction = c("up", "down")) {
  direction <- match.arg(direction)
  i <- match(id, vapply(items, `[[`, character(1), "id"))
  j <- if (direction == "up") i - 1 else i + 1
  if (is.na(i) || j < 1 || j > length(items)) return(items)
  items[c(i, j)] <- items[c(j, i)]
  items
}

#' Drop the item with this id.
#' @export
remove_item <- function(items, id) {
  items[vapply(items, `[[`, character(1), "id") != id]
}

blk <- function(type, ...) list(type = type, ...)

nonblank <- function(x) !is.null(x) && length(x) == 1 && !is.na(x) && nzchar(trimws(x))

#' Lay out a report as a flat list of blocks for the writers.
#'
#' @param items Report items, in report order (see `report_item()`).
#' @param meta list(title, subtitle, author, organization, date, summary).
#' @param plots_table Optional data.frame describing the plots and scans
#'   included; NULL leaves the section out.
#' @param treatments_table Optional data.frame of treatment dates; NULL or no
#'   rows leaves the section out.
#' @param include_about Add the "About these data" section and references.
#' @export
report_blocks <- function(items, meta, plots_table = NULL, treatments_table = NULL,
                          include_about = TRUE) {
  out <- list()
  add <- function(b) out[[length(out) + 1]] <<- b
  n_fig <- 0L
  n_tab <- 0L
  add_table <- function(df, title, note = NULL) {
    n_tab <<- n_tab + 1L
    add(blk("table", label = paste0("Table ", n_tab, "."), title = title, data = df,
            note = note, settings = ""))
  }

  add(blk("title",
    title = if (nonblank(meta$title)) meta$title else "IntELiMon monitoring report",
    subtitle = if (nonblank(meta$subtitle)) meta$subtitle else NULL,
    lines = Filter(nonblank, list(meta$author, meta$organization, meta$date))
  ))

  if (nonblank(meta$summary)) {
    add(blk("heading", level = 1, text = "Summary"))
    for (p in strsplit(meta$summary, "\n[[:space:]]*\n")[[1]]) add(blk("paragraph", text = p))
  }

  has_plots <- !is.null(plots_table) && nrow(plots_table) > 0
  has_treat <- !is.null(treatments_table) && nrow(treatments_table) > 0
  if (has_plots || has_treat) {
    add(blk("heading", level = 1, text = "Data"))
    if (has_plots) add_table(plots_table, "Plots and scans included in this report.")
    if (has_treat) {
      add_table(treatments_table, "Treatment dates.",
                note = "Scans collected after a treatment date start a new time step.")
    }
  }

  if (length(items) > 0) {
    add(blk("heading", level = 1, text = "Results"))
    for (it in items) {
      if (it$kind == "figure") {
        n_fig <- n_fig + 1L
        add(blk("figure", label = paste0("Figure ", n_fig, "."), title = it$title,
                plot = it$plot, settings = settings_line(c(list(Source = it$source), it$settings))))
      } else {
        n_tab <- n_tab + 1L
        add(blk("table", label = paste0("Table ", n_tab, "."), title = it$title,
                data = it$table, note = it$note,
                settings = settings_line(c(list(Source = it$source), it$settings))))
      }
      if (nonblank(it$comment)) add(blk("paragraph", text = it$comment))
    }
    if (any(vapply(items, function(it) identical(it$source, "rothRmel"), logical(1)))) {
      add(blk("warning", text = ROTHRMEL_CAVEAT))
    }
  }

  if (include_about) {
    add(blk("heading", level = 1, text = "About these data"))
    add(blk("paragraph", text = ABOUT_TEXT))
    add(blk("heading", level = 2, text = "References"))
    for (r in REFERENCES) add(blk("paragraph", text = r, size = "small"))
  }
  out
}

#' Footer text shared by both formats (the page number is added by each writer).
#' @export
footer_text <- function(date = Sys.Date()) {
  paste0(REPORT_STYLE$product, " \u00b7 Generated ", format(date, "%Y-%m-%d"))
}

#' Plots-and-scans table for the Data section from the loaded metrics
#' (columns site, plot, date). NULL when nothing is loaded.
#' @export
plots_summary <- function(metrics) {
  if (is.null(metrics) || nrow(metrics) == 0 || !all(c("site", "plot", "date") %in% names(metrics))) {
    return(NULL)
  }
  key <- paste(metrics$site, metrics$plot, sep = "\r")
  groups <- split(as.Date(metrics$date), key)
  parts <- do.call(rbind, strsplit(names(groups), "\r", fixed = TRUE))
  out <- data.frame(
    Site = parts[, 1],
    Plot = parts[, 2],
    Scans = vapply(groups, function(d) length(unique(d)), integer(1)),
    `First scan` = vapply(groups, function(d) format(min(d)), character(1)),
    `Last scan` = vapply(groups, function(d) format(max(d)), character(1)),
    check.names = FALSE, stringsAsFactors = FALSE, row.names = NULL
  )
  out[order(out$Site, out$Plot), , drop = FALSE]
}

#' Treatment dates table for the Data section; NULL when there are none.
#' @export
treatments_summary <- function(trtmt_dates) {
  if (is.null(trtmt_dates) || nrow(trtmt_dates) == 0) return(NULL)
  d <- sort(as.Date(trtmt_dates$TreatmentDate))
  data.frame(`Treatment date` = format(d, "%Y-%m-%d"), check.names = FALSE)
}

#' File name for a built report, e.g. "intelimon_report_20261012.docx".
#' @export
report_filename <- function(format = c("docx", "pdf"), date = Sys.Date()) {
  format <- match.arg(format)
  paste0("intelimon_report_", format(date, "%Y%m%d"), ".", format)
}
