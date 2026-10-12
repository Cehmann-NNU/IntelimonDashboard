# ---------------------------------------------------------------------------
# Report builder tab: the last step of the workflow. Lists the items added
# with the "+ Report" buttons on cards (session$userData$report_items), lets
# the user order them, remove them and add a comment under each, collects the
# report details, and builds the report as Word or PDF.
#
# The build runs in a separate R process (mirai) so a report with many figures
# doesn't block the session; the writers are app/logic/report_docx.R and
# app/logic/report_pdf.R, both laid out from app/logic/report.R's blocks.
# ---------------------------------------------------------------------------

box::use(
  bslib,
  mirai[mirai],
  shiny,
  tools[file_ext],
)

box::use(
  app/logic/report[move_item, plots_summary, remove_item, report_blocks, report_filename,
                   settings_line, treatments_summary],
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)

  bslib$nav_panel(
    title = "Report builder",
    bslib$layout_sidebar(
      fillable = FALSE,
      sidebar = bslib$sidebar(
        width = 340,
        shiny$h5("Report details"),
        shiny$textInput(ns("title"), "Title", placeholder = "IntELiMon monitoring report"),
        shiny$textInput(ns("subtitle"), "Subtitle", placeholder = "Unit, project or treatment"),
        shiny$textInput(ns("author"), "Prepared by"),
        shiny$textInput(ns("organization"), "Organization"),
        shiny$dateInput(ns("date"), "Report date", value = Sys.Date(), format = "yyyy-mm-dd"),
        shiny$textAreaInput(ns("summary"), "Summary", rows = 5, resize = "vertical",
          placeholder = "Purpose, key findings and recommendations. Blank lines start new paragraphs."
        ),
        shiny$h5("Sections"),
        shiny$checkboxInput(ns("inc_plots"), "Plots and scans included", value = TRUE),
        shiny$checkboxInput(ns("inc_treat"), "Treatment dates", value = TRUE),
        shiny$checkboxInput(ns("inc_about"), "About these data and references", value = TRUE),
        shiny$radioButtons(ns("format"), "Format", inline = TRUE,
          choices = list("Word (.docx)" = "docx", "PDF" = "pdf"), selected = "docx"
        ),
        shiny$actionButton(ns("build"), "Build report", class = "btn-primary", width = "100%"),
        shiny$uiOutput(ns("build_status"))
      ),
      bslib$card(
        bslib$card_header(
          class = "d-flex justify-content-between align-items-center",
          shiny$span("Report contents"),
          shiny$actionLink(ns("clear"), "Clear all", class = "imn-report-clear")
        ),
        bslib$card_body(shiny$uiOutput(ns("items")))
      )
    )
  )
}

# One row in the contents list. Buttons report their action through a single
# input (`item_action`) rather than one observer per button.
item_row <- function(ns, item, n, n_items, comment) {
  action <- function(op, label, title, disabled = FALSE) {
    shiny$tags$button(
      type = "button", class = "btn btn-sm imn-report-btn", title = title,
      disabled = if (disabled) NA,
      onclick = sprintf(
        "Shiny.setInputValue('%s', {id: '%s', op: '%s'}, {priority: 'event'})",
        ns("item_action"), item$id, op
      ),
      label
    )
  }
  kind <- if (item$kind == "figure") "Figure" else "Table"
  shiny$div(
    class = "imn-report-item",
    shiny$div(
      class = "imn-report-head",
      shiny$span(class = "imn-report-num", n),
      shiny$span(class = paste0("imn-report-kind is-", item$kind), kind),
      shiny$div(
        class = "imn-report-text",
        shiny$div(class = "imn-report-title", item$title),
        shiny$div(class = "imn-report-settings",
                  settings_line(c(list(Source = item$source), item$settings)))
      ),
      shiny$div(
        class = "imn-report-actions",
        action("up", "\u2191", "Move up", disabled = n == 1),
        action("down", "\u2193", "Move down", disabled = n == n_items),
        action("remove", "\u2715", "Remove from report")
      )
    ),
    shiny$textAreaInput(
      ns(paste0("comment_", item$id)), label = NULL, value = comment, rows = 2,
      width = "100%", resize = "vertical",
      placeholder = "Comment printed below this item in the report (optional)"
    )
  )
}

#' @export
server <- function(id) {
  shiny$moduleServer(id, function(input, output, session) {
    items <- session$userData$report_items

    comment_of <- function(item) {
      typed <- input[[paste0("comment_", item$id)]]
      if (is.null(typed)) item$comment else typed
    }

    output$items <- shiny$renderUI({
      its <- items()
      if (length(its) == 0) {
        return(shiny$div(
          class = "imn-report-empty",
          shiny$p(shiny$tags$b("Nothing has been added to the report yet.")),
          shiny$p(
            "Each graph and statistics card has a ", shiny$tags$b("+ Report"),
            " button in its lower right corner. It adds what the card is showing, with ",
            "its current settings: the graph in Graph view, or the summary table in ",
            "Statistics view."
          )
        ))
      }
      # comments typed so far survive reordering and removal of other items
      shiny$tagList(lapply(seq_along(its), function(i) {
        item_row(session$ns, its[[i]], i, length(its), shiny$isolate(comment_of(its[[i]])))
      }))
    })

    shiny$observeEvent(input$item_action, {
      a <- input$item_action
      its <- items()
      items(switch(a$op,
        up = move_item(its, a$id, "up"),
        down = move_item(its, a$id, "down"),
        remove = remove_item(its, a$id),
        its
      ))
    })

    shiny$observeEvent(input$clear, {
      shiny$showModal(shiny$modalDialog(
        title = "Clear the report?",
        "This removes every item from the report. The cards are not affected.",
        footer = shiny$tagList(
          shiny$modalButton("Cancel"),
          shiny$actionButton(session$ns("clear_confirm"), "Clear all", class = "btn-danger")
        ),
        easyClose = TRUE
      ))
    })
    shiny$observeEvent(input$clear_confirm, {
      items(list())
      shiny$removeModal()
    })

    # ---- Build ------------------------------------------------------------
    build_task <- shiny$ExtendedTask$new(function(blocks, format, path, date) {
      mirai(
        {
          # the worker starts without the project's .Rprofile, so point it at
          # the app's (renv) library, working directory and box path
          .libPaths(lib_paths)
          setwd(project_dir)
          options(box.path = project_dir)
          loadNamespace("ggplot2") # the figures are ggplot objects
          box::use(app/logic/report_docx[render_docx], app/logic/report_pdf[render_pdf], )
          if (format == "docx") render_docx(blocks, path, date) else render_pdf(blocks, path, date)
          path
        },
        lib_paths = .libPaths(), project_dir = getwd(),
        blocks = blocks, format = format, path = path, date = date
      )
    })

    shiny$observeEvent(input$build, {
      if (build_task$status() == "running") {
        shiny$showNotification("A report is already being built.", type = "warning")
        return()
      }
      its <- lapply(items(), function(it) {
        it$comment <- comment_of(it)
        it
      })
      date <- if (length(input$date) == 1 && !is.na(input$date)) input$date else Sys.Date()
      blocks <- report_blocks(
        its,
        meta = list(
          title = input$title, subtitle = input$subtitle, author = input$author,
          organization = input$organization, date = format(date, "%B %d, %Y"),
          summary = input$summary
        ),
        plots_table = if (isTRUE(input$inc_plots)) plots_summary(session$userData$metrics()),
        treatments_table = if (isTRUE(input$inc_treat)) {
          treatments_summary(session$userData$trtmt_dates())
        },
        include_about = isTRUE(input$inc_about)
      )
      build_task$invoke(blocks, input$format, tempfile(fileext = paste0(".", input$format)), date)
    })

    output$build_status <- shiny$renderUI({
      status <- build_task$status()
      if (status == "initial") {
        return(NULL)
      }
      if (status == "running") {
        return(shiny$div(class = "imn-report-status", "Building the report\u2026"))
      }
      if (status == "error") {
        msg <- tryCatch(build_task$result(), error = conditionMessage)
        return(shiny$div(class = "imn-report-status imn-sim-warn",
                         shiny$tags$b("The report could not be built. "), msg))
      }
      shiny$div(
        class = "imn-report-status",
        shiny$downloadButton(session$ns("download"), "Download report", class = "btn-secondary",
                             style = "width:100%")
      )
    })

    output$download <- shiny$downloadHandler(
      filename = function() report_filename(file_ext(build_task$result()), input$date),
      content = function(file) file.copy(build_task$result(), file, overwrite = TRUE)
    )
  })
}
