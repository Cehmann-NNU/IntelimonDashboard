box::use(
  grDevices[dev.off, pdf],
  testthat[describe, expect_equal, expect_gt, expect_true, it],
)

box::use(
  app/logic/report_pdf,
)

impl <- attr(report_pdf, "namespace")

describe("render_pdf", {
  it("writes a multi-page PDF", {
    path <- tempfile(fileext = ".pdf")
    out <- report_pdf$render_pdf(sample_report_blocks(), path, as.Date("2026-10-12"))
    expect_true(file.exists(path))
    expect_equal(rawToChar(readBin(path, "raw", 5)), "%PDF-")
    expect_gt(attr(out, "pages"), 1)
  })
})

describe("wrap_text", {
  it("wraps to the width and keeps explicit line breaks", {
    pdf(NULL)
    on.exit(dev.off())
    g <- impl$gp(10)
    lines <- impl$wrap_text(paste(rep("word", 60), collapse = " "), g, 3)
    expect_gt(length(lines), 3)
    expect_true(all(vapply(lines, impl$text_width, numeric(1), g = g) <= 3))
    expect_equal(impl$wrap_text("one\ntwo", g, 6), c("one", "two"))
  })
})

describe("table_geometry", {
  it("sizes each column to its widest cell, not its header", {
    pdf(NULL)
    on.exit(dev.off())
    df <- data.frame(Site = c("A", "A much longer site name"), Plot = c("1", "2"))
    geo <- impl$table_geometry(df, 6.5)
    widest <- impl$text_width("A much longer site name", impl$gp(geo$size, face = "bold"))
    expect_true(geo$widths[1] > widest)
  })
})

describe("pdf_text", {
  it("turns subscript digits into plain digits", {
    expect_equal(impl$pdf_text("I\u2080 and R\u2080"), "I0 and R0")
  })
})
