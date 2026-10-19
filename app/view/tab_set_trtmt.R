box::use(
  DT,
  bslib,
  dt = data.table,
  shiny,
)

box::use(
  app/logic/manage_data,
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)

  bslib$nav_panel(
    title = "Set Treatments",
    fillable = TRUE,
    bslib$layout_sidebar(
      fillable = TRUE,
      height = "100%",
      sidebar = bslib$sidebar(
        position = "right",
        width = 350,
        bslib$card(
          full_screen = FALSE,
          fill = FALSE,
          max_height = "500px",
          min_height = "100px",
          bslib$card_header(shiny$h4("Add Treatment Dates")),
          bslib$card_body(
            fill = FALSE,
            shiny$helpText(
              "Scans collected after a treatment date are moved into a new scan grouping.
              Adding or deleting a date regroups every scan and replaces scan groupings
              entered by hand."
            ),
            shiny$dateInput(
              ns("ui_selected_date"),
              label = shiny$h6("Select Date"),
              value = Sys.Date(),
              format = "yyyy-mm-dd",
              autoclose = TRUE
            ),
            shiny$actionButton(
              ns("btn_add_trtmt"),
              "Add Date"
            ),
            shiny$div(
              style = "text-align:right; margin-top: 5px;", # "display:flex; justify-content:flex-end;", #
              shiny$actionLink(
                ns("btn_delete_trtmt"),
                label = NULL, # "Delete selected",
                icon = shiny$icon("trash"),
              ),
              DT$DTOutput(
                ns("tbl_trtmt_dates")
              )
            )
          )
        ),
        bslib$card(
          bslib$card_header(shiny$h4("Set Unit Name, Remeasurement or Scan Grouping")),
          shiny$helpText(
            "To assign a unit name, remeasurement number or scan grouping, select the scans in the
            table to the left, enter the desired values below and hit the Assign button."
          ),
          shiny$textInput(
            ns("ui_enter_unit"),
            label = "Unit Name",
            placeholder = "BigCreek",
            value = "",
            updateOn = "change"
          ),
          shiny$textInput(
            ns("ui_enter_remeas"),
            label = "Scan Remeasurement",
            placeholder = "0 (initial scan)",
            value = "",
            updateOn = "change"
          ),
          shiny$textInput(
            ns("ui_enter_group"),
            label = "Scan Grouping",
            placeholder = "1 (first time step)",
            value = "",
            updateOn = "change"
          ),
          shiny$actionButton(
            ns("btn_assign"),
            "Assign"
          )
        )
      ),
      shiny$div(
        style = "text-align:right;",
        shiny$actionLink(
          ns("btn_clear_selection"),
          label = "Clear selection",
          icon = shiny$icon("xmark")
        )
      ),
      DT$DTOutput(
        ns("tbl_selected_scans"),
        height = "100%"
      )
    )
  )
}

# The scans in the order handed to the scan table. DT reports selected and
# edited rows by their position in this data, whatever order the table is
# displayed in, so assignments and edits are applied to this same order.
table_order <- function(scans) dt$copy(scans)[order(plot, site, -date)]

#' @export
server <- function(id) {
  shiny$moduleServer(id, function(input, output, session) {
    #----Add Treatment Dates---------------------
    shiny$observeEvent(input$btn_add_trtmt, {
      trtmt_dates <- session$userData$trtmt_dates()

      is_new <- !(input$ui_selected_date %in% trtmt_dates$TreatmentDate)
      if (!is_new) {
        shiny$showNotification(
          "Date already added.",
          type = "warning"
        )
        return()
      } else if (is_new) {
        trtmt_dates <- rbind(
          trtmt_dates,
          dt$data.table(
            TreatmentDate = input$ui_selected_date
          )
        )
        session$userData$trtmt_dates(trtmt_dates)

        manage_data$set_scan_groups(session)
      }
    })

    output$tbl_trtmt_dates <- DT$renderDT({
      trtmt_dates <- session$userData$trtmt_dates()


      DT$datatable(
        session$userData$trtmt_dates(),
        colnames = "",
        caption = "Treatment Dates",
        filter = "none",
        rownames = FALSE,
        height = "100%",
        selection = "single",
        # dates are changed by deleting and adding them, so the
        # scan groupings follow
        editable = FALSE,
        options = list(
          ordering = TRUE,
          searching = FALSE,
          paging = FALSE,
          dom = "t"
        )
      )
    })

    # delete treament dates
    shiny$observeEvent(input$btn_delete_trtmt, {
      row <- input$tbl_trtmt_dates_rows_selected
      if (is.null(row) || length(row) == 0) {
        shiny$showNotification(
          "Select a treatment date to delete.",
          type = "warning"
        )
        return()
      }
      trtmt_dates <- session$userData$trtmt_dates()

      trtmt_dates <- trtmt_dates[-row]
      session$userData$trtmt_dates(trtmt_dates)
      manage_data$set_scan_groups(session)
    })

    #------Assign Unit, Remeasurement or Scan Grouping----
    shiny$observeEvent(input$btn_assign, {
      # always initializes as NULL
      selected_rows <- input$tbl_selected_scans_rows_selected
      if (is.null(selected_rows)) {
        shiny$showNotification(
          "No scans selected. Click on the desired rows in the the table to the left",
          type = "warning",
          duration = 30
        )
        return()
      }

      # the selected rows index the table's data, not its sorted display
      displayed_scans <- table_order(session$userData$scan_selection())

      if (nzchar(input$ui_enter_unit)) {
        displayed_scans[selected_rows, "Unit" := as.character(input$ui_enter_unit)] # nolint: object_name_linter
      }

      if (nzchar(input$ui_enter_remeas)) {
        displayed_scans[selected_rows, "Remeasurement" := as.integer(input$ui_enter_remeas)] # nolint: object_name_linter
      }

      # the cards and the report group scans into time steps by this column
      if (nzchar(input$ui_enter_group)) {
        group <- as.integer(input$ui_enter_group)
        displayed_scans[selected_rows, "ScanGroup" := group] # nolint: object_name_linter
      }

      session$userData$scan_selection(displayed_scans)
    })

    #---Data Table-------------------------------
    columns <- c("site", "plot", "date", "scanner_id", "Unit", "Remeasurement", "ScanGroup")

    output$tbl_selected_scans <- DT$renderDT({
      selected_scans <- session$userData$scan_selection()
      dwnlded_scans <- session$userData$metrics()

      nscans <- nrow(selected_scans)
      ndwnld <- nrow(dwnlded_scans)
      metrics_msg <- "Selected scans have not been downloaded! Return to Selection Map tab."
      shiny$validate(
        shiny$need(
          nscans > 0,
          "No scans selected. Return to Selection Map tab."
        ),
        shiny$need(
          !is.null(dwnlded_scans),
          metrics_msg
        ),
        shiny$need(
          ndwnld == nscans,
          paste(metrics_msg, "\nScans downloaded: ", ndwnld, "\nScans selected: ", nscans)
        )
      )

      selected_scans <- table_order(selected_scans)

      DT$datatable(
        selected_scans[, ..columns],
        colnames = c(columns[-length(columns)], "Scan grouping"),
        filter = "top",
        rownames = FALSE,
        selection = "multiple",
        # make site, plot, date, scanner_id ReadOnly, but allow unit, remeasurement and scan
        # grouping to be changed
        editable = list(target = "cell", disable = list(columns = c(0, 1, 2, 3))),
        options = list(
          pageLength = 50,
          ordering = TRUE,
          paging = FALSE,
          # sort by date, then site w/in each date, then plot w/in each site
          order = list(list(2, "asc"), list(0, "asc"), list(1, "asc"))
        )
      )
    })

    proxy <- DT$dataTableProxy(
      "tbl_selected_scans",
      session = session
    )

    shiny$observeEvent(input$btn_clear_selection, {
      DT$selectRows(proxy, NULL)
    })

    # allow the user to change table values
    shiny$observeEvent(input$tbl_selected_scans_cell_edit, {
      changes <- input$tbl_selected_scans_cell_edit

      # edited rows index the table's data, in table_order()
      selected_scans <- table_order(session$userData$scan_selection())
      displayed_scans <- selected_scans[, ..columns]

      displayed_scans <- DT$editData(displayed_scans, changes, rownames = FALSE)

      session$userData$scan_selection(selected_scans[, (columns) := displayed_scans])
    })
  })
}
