library(shiny)

# Make sure that rmarkdown can find the report
# even if running in production as rmarkdown works
# in the current working directory
(report_path <- tempfile(fileext = ".Rmd"))

file.copy(
  from = "report.Rmd", 
  to = report_path,
  overwrite = TRUE
)


# Wrapping the render function

render_report <- function(input, output, params) {
  
  rmarkdown::render(input,
                    output_file = output,
                    params = params,
                    
                    # Creates a new environments to
                    # - Make sure that any variable created during the rendering 
                    #   process will be confined to this new environment
                    # - Don't loss access to the variables in the global environment 
                    envir = new.env(parent = globalenv())
  )
}

# Defining the UI
ui <- fluidPage(
  
  selectInput(
    label = "Select a distribution",
    inputId = "dist", 
    choices = c("normal", "log normal")
  ),
  
  sliderInput(
    label = "Number of points",
    inputId = "n", 
    
    # Range
    min = 500,
    max = 1000,
    round = TRUE,
    step = 50,
    
    # Default
    value = 600
  ),
  
  downloadButton("report", "Generate report")
)


# Defining the app logic
server <- function(input, output) {
  
  # Just need need to create the report logic
  
  output$report <- downloadHandler(
    
    # Output name
    filename = "report.html",
    
    # Output name
    content = function(file) {
      
      # Show an IN PROCESS message
      notification_id <- showNotification(
        "Rendering report...",
        duration = NULL,
        type = "message"
      )
      
      # After ending the function remove the message
      on.exit(removeNotification(notification_id), add = TRUE)
      
      # Render in a separate R session to:
      # - Keep the app responsive while the rendering is complete
      # - Keep the app running if the report fails
      # - Avoid affecting the global environment by the rendering process
      callr::r(
        render_report,
        list(input = report_path, 
             output = file, 
             params = list(dist = input$dist, n = input$n))
      )
      
    }
  )
  
}

shinyApp(ui, server)
