library(shiny)

# note: this is a modified version of apps from the book and
# https://github.com/hadley/mastering-shiny/tree/master/rmarkdown-report

# copies report to current working directory
report_path <- tempfile(fileext = ".Rmd")
file.copy("report.Rmd", report_path, overwrite = TRUE)

# will render report in new environment
render_report <- function(input, output, params) {
  rmarkdown::render(input,
                    output_file = output,
                    params = params,
                    envir = new.env(parent = globalenv())
  )
}

ui <- fluidPage(
  selectInput("dist", "Select a distribution",
              choices = c("normal", "log normal")
              ),
  sliderInput("n", "Number of points",
              min = 500,
              max = 1000,
              value = 600,
              step = 50,
              round = TRUE
              ),
  downloadButton("report", "Generate report")
)

server <- function(input, output) {
  output$report <- downloadHandler(
    filename = "report.html",
    content = function(file) {
      params <- list(dist = input$dist, n = input$n)
      
      # it can take a bit so inform user things are happening
      id <- showNotification("Rendering report...",
                             duration = NULL,
                             type = "message"
                             )
      on.exit(removeNotification(id), add = TRUE)
      
      callr::r(
        render_report,
        list(input = report_path, output = file, params = params)
      )
    }
  )
}

shinyApp(ui, server)