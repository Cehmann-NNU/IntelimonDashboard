box::use(
  officer[docx_summary, read_docx],
  testthat[describe, expect_equal, expect_true, it],
)

box::use(
  app/logic/report_docx,
)

describe("render_docx", {
  it("writes a Word file holding the report's text and tables", {
    path <- tempfile(fileext = ".docx")
    report_docx$render_docx(sample_report_blocks(), path, as.Date("2026-10-12"))
    expect_true(file.exists(path))
    s <- docx_summary(read_docx(path))
    text <- paste(s$text, collapse = " ")
    for (x in c("Test report", "Figure 1.", "Table 3.", "Midstory volume", "rothRmel tab",
                "About these data")) {
      expect_true(grepl(x, text, fixed = TRUE), info = x)
    }
    expect_equal(length(unique(s$doc_index[s$content_type == "table cell"])), 3)
  })
})
