library(shiny)

options(shiny.maxRequestSize = 50 * 1024^2)

ui <- fluidPage(
  
  # Button
  fileInput("upload", NULL, accept = c(".csv", ".tsv")),
  
  # User options
  numericInput("n", "Rows", value = 5, min = 1, step = 1),
  
  # Display results
  tableOutput("head")
  
)


server <- function(input, output, session) {
  
  # Taking the data to R
  data <- reactive({
    
    # Make sure your code waits 
    # until the file is uploaded
    req(input$upload)
    
    # As multiple = FALSE in fileInput
    # input$upload has length of one
    ext <- tools::file_ext(input$upload$name)
    
    # Select the importing method based of extension
    switch(ext,
           csv = vroom::vroom(input$upload$datapath, delim = ","),
           tsv = vroom::vroom(input$upload$datapath, delim = "\t"),
           validate("Invalid file; Please upload a .csv or .tsv file"))
    
  })
  
  # Finaly Rendering the table to display
  output$head <- renderTable({
    head(data(), input$n)
  })
  
}

shinyApp(ui, server)

