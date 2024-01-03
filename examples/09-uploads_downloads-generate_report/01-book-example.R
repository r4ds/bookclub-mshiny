library(shiny)

# Default 5 MB
options(shiny.maxRequestSize = 50 * 1024^2)

ui <- fluidPage(
  # Input button
  fileInput("upload", NULL, buttonLabel = "Upload...", multiple = TRUE),
  
  # Displaying table
  tableOutput("files")
)


server <- function(input, output, session) {
  
  # Rendering upload data.frame
  output$files <- renderTable(input$upload)
  
}

shinyApp(ui, server)
