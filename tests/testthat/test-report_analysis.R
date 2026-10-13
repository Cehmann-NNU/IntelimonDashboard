box::use(
  data.table[data.table],
  testthat[describe, expect_equal, expect_length, expect_match, expect_null, expect_true, it],
)

box::use(
  app/logic/report_analysis,
)

impl <- attr(report_analysis, "namespace")

# Per-scan rows shaped like assign_time_steps() output: three plots scanned
# before (step 1) and after (step 2) a treatment on 2024-03-01, with midstory
# volume falling in every plot.
series <- function() {
  data.table(
    site = "A", plot = rep(c("1", "2", "3"), 2),
    combo = rep(c("A||1", "A||2", "A||3"), 2),
    date = as.Date(rep(c("2024-01-10", "2024-06-10"), each = 3)),
    value = c(10, 12, 14, 6, 7, 8),
    grp = rep(1:2, each = 3)
  )
}

describe("describe_series", {
  it("summarizes coverage, overall change and change across the treatment", {
    d <- report_analysis$describe_series(series(), "Midstory volume", FALSE,
                                         as.Date("2024-03-01"), "mMSvol")
    expect_match(d$summary, "6 scans at 3 plots in 2 time steps")
    expect_match(d$summary, "12.0 in the first time step and 7.00 in the last")
    expect_match(d$summary, "a decrease of 5.00 \\(41.7%\\)")
    expect_match(d$summary, "the 3 plots scanned before and after decreased by 5.00")
    expect_match(d$implication, "^Midstory volume \\(3-9 m\\)")
    expect_match(d$implication, "Across the treatment on 2024-03-01, it decreased. A decrease")
    expect_match(d$implication, "reduced ladder fuels")
  })

  it("says so when no plot was scanned in every time step", {
    long <- series()
    long$combo <- paste0("A||", 1:6)
    d <- report_analysis$describe_series(long, "Midstory volume", FALSE)
    expect_true(any(grepl("None of the 6 plots was scanned in every time step", d$cautions)))
  })

  it("flags small time steps and plots missing from some steps", {
    long <- series()[-6]
    d <- report_analysis$describe_series(long, "Midstory volume", FALSE, as.Date("2024-03-01"))
    expect_true(any(grepl("fewer than 3 scans", d$cautions)))
    expect_true(any(grepl("Only 2 of 3 plots were scanned in every time step", d$cautions)))
  })

  it("flags a treatment with no scans on one side", {
    d <- report_analysis$describe_series(series(), "Midstory volume", FALSE,
                                         as.Date("2025-01-01"))
    expect_true(any(grepl("No scans were collected after the treatment on 2025-01-01",
                          d$cautions)))
  })

  it("describes percent change in percentage points and calls small changes stable", {
    long <- series()
    long$value <- c(0, 0, 0, 1, 2, 3)
    d <- report_analysis$describe_series(long, "Basal area (% change)", TRUE,
                                         metric = "Basalarea")
    expect_match(d$summary, "percent change from each plot's first scan")
    expect_match(d$summary, "an increase of 2.00 percentage points")
    expect_match(d$implication, "Over the period monitored, it changed little")
  })

  it("describes many scans in one time step as a snapshot", {
    long <- series()[grp == 1]
    d <- report_analysis$describe_series(long, "Something new", FALSE, as.Date("2024-03-01"))
    expect_length(d$cautions, 1)
    expect_match(d$cautions, "All 3 scans at 3 plots fall in one time step (2024-01-10)",
                 fixed = TRUE)
    expect_match(d$cautions, "snapshot of conditions")
    expect_match(d$cautions, "Change over time and treatment effects cannot be assessed")
    expect_match(d$cautions, "pre-treatment baseline")
    expect_null(d$implication)
  })

  it("gives a single scan its own notice", {
    long <- series()[1]
    d <- report_analysis$describe_series(long, "Basal area", FALSE, as.Date("2024-03-01"))
    expect_length(d$cautions, 1)
    expect_match(d$cautions, "Basal area is based on a single scan (A / 1, 2024-01-10)",
                 fixed = TRUE)
  })

})

describe("metric_context", {
  it("matches model outputs by words in their label", {
    expect_match(report_analysis$metric_context("Fernmod", "Fern cover (%)")$what, "^Cover")
    expect_match(report_analysis$metric_context("MDDmod", "Mean duff depth (cm)")$what, "depths")
    expect_null(report_analysis$metric_context("zzz", "Unrelated"))
  })
})

scans_fixture <- function() {
  metrics <- data.frame(
    site = "A", plot = c("1", "2", "3", "1", "2"),
    date = as.Date(c("2024-01-10", "2024-01-10", "2024-01-11", "2024-06-10", "2024-06-10"))
  )
  scans <- data.frame(
    site = metrics$site, plot = metrics$plot, date = metrics$date,
    Unit = c("North", "North", "My Unit", "North", "North"), Agency = "USFS"
  )
  list(metrics = metrics, scans = scans)
}

describe("scan_context", {
  it("describes scans, units and treatments, and tabulates plots and time steps", {
    f <- scans_fixture()
    ctx <- report_analysis$scan_context(f$metrics, f$scans, as.Date("2024-03-01"))
    expect_match(ctx$text, "5 scans at 3 plots in 1 site")
    expect_match(ctx$text, "grouped into 2 time steps")
    expect_match(ctx$text, "provided by USFS")
    # the placeholder "My Unit" is not a management unit
    expect_match(ctx$text, "1 management unit: North \\(2 plots\\)")
    expect_match(ctx$text, "One treatment date was entered \\(2024-03-01\\)")
    expect_equal(ctx$plots$Unit, c("North", "North", ""))
    expect_equal(ctx$steps$Treatment, c("Before 2024-03-01", "After 2024-03-01"))
    expect_equal(ctx$steps$Dates[1], "2024-01-10 to 2024-01-11")
  })

  it("lists several management units", {
    f <- scans_fixture()
    f$scans$Unit <- c("North", "North", "South", "North", "North")
    ctx <- report_analysis$scan_context(f$metrics, f$scans, as.Date(character()))
    expect_match(ctx$text, "2 management units: North \\(2 plots\\) and South \\(1 plot\\)")
  })

  it("returns NULL with no scans", {
    expect_null(report_analysis$scan_context(data.frame(), NULL, as.Date(character())))
  })
})

describe("design_checks", {
  it("flags single-scan plots, small and unbalanced steps and unpaired treatments", {
    f <- scans_fixture()
    checks <- report_analysis$design_checks(f$metrics, f$scans, as.Date("2024-03-01"))
    expect_true(any(grepl("1 of 3 plots has a single scan", checks)))
    expect_true(any(grepl("fewer than 3 scans", checks)))
    expect_true(any(grepl("2 of 3 plots were scanned both before and after", checks)))
  })

  it("reports one time step as a snapshot instead of listing each plot", {
    metrics <- data.frame(
      site = "A", plot = c("1", "2", "3"),
      date = as.Date(c("2024-06-10", "2024-06-11", "2024-06-11"))
    )
    checks <- report_analysis$design_checks(metrics, NULL, as.Date("2024-03-01"))
    expect_length(checks, 1)
    expect_match(checks, "All 3 scans at 3 plots fall in one time step (2024-06-10 to 2024-06-11)",
                 fixed = TRUE)
    expect_match(checks, "with no pre-treatment scans to compare against")
  })

  it("reports a single loaded scan", {
    metrics <- data.frame(site = "A", plot = "1", date = as.Date("2024-06-10"))
    checks <- report_analysis$design_checks(metrics, NULL, as.Date(character()))
    expect_equal(length(checks), 1)
    expect_match(checks, "Only one scan is loaded (A / 1, 2024-06-10)", fixed = TRUE)
  })

  it("is empty for a balanced, paired design", {
    metrics <- data.frame(
      site = "A", plot = rep(c("1", "2", "3"), 2),
      date = as.Date(rep(c("2024-01-10", "2024-06-10"), each = 3))
    )
    expect_length(report_analysis$design_checks(metrics, NULL, as.Date("2024-03-01")), 0)
  })
})

describe("fmt_num", {
  it("keeps precision proportional to size", {
    expect_equal(impl$fmt_num(c(1234.4, 12.34, 1.234)), c("1,234", "12.3", "1.23"))
  })
})
