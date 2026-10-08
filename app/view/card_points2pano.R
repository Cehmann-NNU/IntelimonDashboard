box::use(
  bslib,
  shiny,
)

box::use(
  app/logic/load_data_api[build_points2pano_url_sdsc],
)

#' @export
ui <- function(id) {
  ns <- shiny$NS(id)

  bslib$card(
    area = "panoViewer",
    full_screen = TRUE,
    bslib$card_header(
      class = "d-flex justify-content-between align-items-center",
      shiny$span("Points2Pano"),
      shiny$div(
                class = "d-flex align-items-center gap-2",
                shiny$actionButton(ns("btn_pano_prev"), "\u25C0", class = "btn-sm"),
                shiny$div(
                  class = "pano-info",
                  shiny$textOutput(ns("pano_label"), inline = TRUE)
                ),
                shiny$actionButton(ns("btn_pano_next"), "\u25B6", class = "btn-sm"))
    ),
    bslib$card_body(
      padding = 0,
      shiny$uiOutput(ns("pano_frame"), style = "height: 100%;")
    )
  )
}

#' @export
server <- function(id, session) {
  shiny$moduleServer(id, function(input, output, session) {
    pano_idx <- shiny$reactiveVal(1)

    # Populated scans available to the viewer (in scan_calls order)
    pano_scans <- shiny$reactive({
      sc <- session$userData$scan_selection()
      sc[nzchar(date)]
    })


    # Reset to the first record whenever scan_calls changes
    shiny$observeEvent(session$userData$scan_selection(), {
      pano_idx(1)
    })

    shiny$observeEvent(input$btn_pano_prev, {
      n <- nrow(pano_scans())
      if (n == 0) {
        return()
      }
      pano_idx(if (pano_idx() <= 1) n else pano_idx() - 1) # wrap
    })

    shiny$observeEvent(input$btn_pano_next, {
      n <- nrow(pano_scans())
      if (n == 0) {
        return()
      }
      pano_idx(if (pano_idx() >= n) 1 else pano_idx() + 1) # wrap
    })

    output$pano_label <- shiny$renderText({
      df <- pano_scans()
      if (nrow(df) == 0) {
        return("No scans loaded")
      }

      row <- df[min(pano_idx(), nrow(df))]
      date_fmt <- row$date

      sprintf(
        "Site: %s | Plot: %s | %s | Scanner: %s",
        row$site, row$plot, date_fmt, row$scanner_id
      )
    })

    output$pano_frame <- shiny$renderUI({
      df <- pano_scans()

      if (nrow(df) == 0) {
        return(shiny$div(
          style = "display:flex; align-items:center; justify-content:center;
                   height:100%; color:#888; text-align:center; padding:20px;",
          "No scans loaded - select plots on the Selection Map tab and press Get Scans."
        ))
      }

      idx <- min(pano_idx(), nrow(df))
      row <- df[idx]

      pano_url <- build_points2pano_url_sdsc(row$site, row$plot, row$date)

      # the URL hides the page's site list and map (see
      # build_points2pano_url_sdsc()); the page's header and bottom button bar
      # are cropped out by .imn-pano-crop / .imn-pano-frame in main.scss
      shiny$div(
        class = "imn-pano-crop",
        shiny$tags$iframe(
          class = "imn-pano-frame",
          src = pano_url,
          title = paste("Points2Pano:", row$scan_name)
        )
      )
    })
  })
}
