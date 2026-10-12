box::use(
  testthat[describe, expect_equal, expect_false, expect_null, expect_true, it],
)

box::use(
  app/logic/report,
)

fig <- function(title = "Midstory volume", source = "Standard outputs") {
  report$report_item("figure", title, source,
    settings = list(`Plot type` = "Box and Whisker", `Data type` = "Percent change"),
    plot = "a ggplot"
  )
}
tbl <- function() {
  report$report_item("table", "Midstory volume", "Standard outputs",
    table = data.frame(a = 1), note = "One row per time step."
  )
}
types <- function(blocks) vapply(blocks, `[[`, character(1), "type")
titles <- function(items) vapply(items, `[[`, character(1), "title")

describe("report_item", {
  it("gives every item its own id", {
    expect_false(fig()$id == fig()$id)
  })
})

describe("settings_line", {
  it("joins settings and skips empty ones", {
    s <- list(`Plot type` = "Bar", `Error bars` = NULL, Blank = "", `Data type` = "Values")
    expect_equal(report$settings_line(s), "Plot type: Bar; Data type: Values")
    expect_equal(report$settings_line(list()), "")
  })
})

describe("move_item and remove_item", {
  items <- list(fig("A"), fig("B"), fig("C"))

  it("swaps neighbours and ignores moves past either end", {
    expect_equal(titles(report$move_item(items, items[[2]]$id, "up")), c("B", "A", "C"))
    expect_equal(titles(report$move_item(items, items[[2]]$id, "down")), c("A", "C", "B"))
    expect_equal(titles(report$move_item(items, items[[1]]$id, "up")), c("A", "B", "C"))
    expect_equal(titles(report$move_item(items, items[[3]]$id, "down")), c("A", "B", "C"))
  })

  it("removes by id", {
    expect_equal(titles(report$remove_item(items, items[[2]]$id)), c("A", "C"))
  })
})

describe("report_blocks", {
  meta <- list(title = "Big Creek", summary = "First.\n\nSecond.")

  it("numbers figures and tables separately, in report order", {
    b <- report$report_blocks(list(fig(), tbl(), fig()), meta, include_about = FALSE)
    expect_equal(unlist(lapply(b, `[[`, "label")), c("Figure 1.", "Table 1.", "Figure 2."))
  })

  it("splits the summary into paragraphs and adds a comment under its item", {
    items <- list(fig())
    items[[1]]$comment <- "Volume fell after the burn."
    b <- report$report_blocks(items, meta, include_about = FALSE)
    expect_equal(types(b), c(
      "title", "heading", "paragraph", "paragraph", "heading", "figure", "paragraph"
    ))
    expect_equal(b[[7]]$text, "Volume fell after the burn.")
    expect_true(grepl("^Source: Standard outputs; Plot type", b[[6]]$settings))
  })

  it("adds the rothRmel caveat only when rothRmel output is included", {
    without <- report$report_blocks(list(fig()), meta, include_about = FALSE)
    with <- report$report_blocks(list(fig(source = "rothRmel")), meta, include_about = FALSE)
    expect_false("warning" %in% types(without))
    expect_true("warning" %in% types(with))
  })

  it("numbers the Data tables ahead of the result tables", {
    plots <- data.frame(Site = "A", Plot = "1")
    treat <- data.frame(`Treatment date` = "2024-03-15", check.names = FALSE)
    b <- report$report_blocks(list(tbl()), meta, plots, treat, include_about = FALSE)
    tables <- Filter(function(x) x$type == "table", b)
    expect_equal(vapply(tables, `[[`, character(1), "label"), c("Table 1.", "Table 2.", "Table 3."))
  })

  it("falls back to a default title and appends About and References", {
    b <- report$report_blocks(list(), list(title = ""))
    expect_equal(b[[1]]$title, "IntELiMon monitoring report")
    headings <- unlist(lapply(Filter(function(x) x$type == "heading", b), `[[`, "text"))
    expect_equal(headings, c("About these data", "References"))
  })
})

describe("plots_summary and treatments_summary", {
  it("counts distinct scan dates per site and plot", {
    m <- data.frame(
      site = c("A", "A", "A", "B"), plot = c("1", "1", "1", "2"),
      date = as.Date(c("2024-01-01", "2024-01-01", "2024-06-01", "2024-02-01"))
    )
    s <- report$plots_summary(m)
    expect_equal(s$Scans, c(2L, 1L))
    expect_equal(s$`Last scan`, c("2024-06-01", "2024-02-01"))
  })

  it("returns NULL when there is nothing to show", {
    expect_null(report$plots_summary(data.frame()))
    expect_null(report$treatments_summary(data.frame(TreatmentDate = as.Date(character()))))
  })

  it("sorts treatment dates", {
    dates <- data.frame(TreatmentDate = as.Date(c("2024-05-01", "2023-01-01")))
    expect_equal(report$treatments_summary(dates)$`Treatment date`, c("2023-01-01", "2024-05-01"))
  })
})

describe("report_filename", {
  it("dates the file and uses the format's extension", {
    expect_equal(
      report$report_filename("pdf", as.Date("2026-10-12")), "intelimon_report_20261012.pdf"
    )
  })
})
