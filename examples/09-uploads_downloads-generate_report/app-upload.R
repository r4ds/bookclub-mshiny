library(shiny)

ui <- fluidPage(
  # Add ui element
  fileInput("upload", 
            "Upload a file", 
            # accept = c(".csv", ".tsv"),
            placeholder = "Give me some data", 
            multiple = TRUE),
  
  # Output table in ui
  tableOutput("head")
  
)

server <- function(input, output, session) {
  
  # Use `req()` to pause app and wait for data upload
  
  data <- reactive({
    req(input$upload)
    
    # Validate the extension of the user's input
    ext <- tools::file_ext(input$upload$name)
    
    # Error handling
    switch(ext,
           csv = vroom::vroom(input$upload$datapath, delim = ","),
           tsv = vroom::vroom(input$upload$datapath, delim = "\t"),
           validate("Invalid file; Please upload a .csv or .tsv file")
           )
    
  })
  
  # Render the table
  output$head <- renderTable({
    head(data())
  })
  
}

shinyApp(ui, server)
