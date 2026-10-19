box::use(
  data.table[data.table],
  testthat[describe, expect_equal, it],
)

box::use(
  app/logic/manage_data,
)

describe("remeasurement_numbers", {
  it("counts each plot's visits from 0, however close together", {
    scans <- data.table(
      site = c("A", "A", "A", "B", "A"),
      plot = c("1", "1", "2", "1", "1"),
      date = as.Date(c("2024-05-02", "2024-05-01", "2024-05-10", "2024-08-01", "2025-05-01"))
    )
    expect_equal(manage_data$remeasurement_numbers(scans), c(1L, 0L, 0L, 0L, 2L))
  })

  it("gives scans of a plot on the same date the same number", {
    scans <- data.table(site = "A", plot = "1", date = as.Date(c("2024-05-01", "2024-05-01")))
    expect_equal(manage_data$remeasurement_numbers(scans), c(0L, 0L))
  })
})
