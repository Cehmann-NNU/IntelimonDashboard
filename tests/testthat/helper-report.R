box::use(
  ggplot2[aes, geom_line, ggplot, labs],
)

box::use(
  app/logic/report,
)

# Shared fixture for the report writer tests: a small report with a figure,
# a statistics table, a rothRmel figure and both Data tables.
sample_report_blocks <- function() {
  p <- ggplot(data.frame(x = 1:5, y = c(3, 4, 2, 5, 6)), aes(x, y)) +
    geom_line() +
    labs(title = "Crown-initiation intensity I₀ (kW/m)")
  stats <- data.frame(
    `Time step` = c("2024-01-01", "2024-06-01"), n = c("4", "4"),
    Mean = c("2.00", "2.20"), SD = c("0.40", "—"), check.names = FALSE
  )
  items <- list(
    report$report_item("figure", "Midstory volume", "Standard outputs",
      list(`Plot type` = "Box and Whisker"),
      plot = p
    ),
    report$report_item("table", "Midstory volume", "Standard outputs",
      table = stats, note = "Note."
    ),
    report$report_item("figure", "Crown-initiation intensity I₀ (kW/m)", "rothRmel", plot = p)
  )
  report$report_blocks(
    items, list(title = "Test report", author = "Tester", summary = "Summary text."),
    plots_table = data.frame(Site = "A", Plot = "1", Scans = 2L),
    treatments_table = data.frame(`Treatment date` = "2024-03-15", check.names = FALSE)
  )
}
