# ---------------------------------------------------------------------------
# The session's report: an ordered list of items (app/logic/report.R) in
# session$userData$report_items, filled by the "+ Report" buttons on cards and
# arranged on the Report builder tab.
# ---------------------------------------------------------------------------

box::use(
  shiny[isolate, showNotification],
)

#' Append an item to the session's report and confirm it with a notification.
#' @export
add_to_report <- function(session, item) {
  items <- c(isolate(session$userData$report_items()), list(item))
  session$userData$report_items(items)
  kind <- if (item$kind == "figure") "Figure" else "Table"
  showNotification(
    sprintf("%s added to the report (%d item%s): %s", kind, length(items),
            if (length(items) == 1) "" else "s", item$title),
    type = "message", duration = 4
  )
  invisible(items)
}
