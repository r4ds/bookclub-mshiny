library(shiny)

options(shiny.maxRequestSize = 50 * 1024^2)

ui <- fluidPage(
  
  # Button
  fileInput("upload", "Select a file", accept = c(".csv", ".tsv")),
  
  # User options
  numericInput("n", "Rows to select", value = 5, min = 1, step = 1),
  
  # Download button options
  downloadButton("download1", class = "btn btn-info"),
  downloadLink("download2"),
  
  # Display results
  tableOutput("head")
  
)


server <- function(input, output, session) {
  
  # Importing the data to R
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
  
  # Filtering the data
  data_filted <- reactive(head(data(), input$n))
  
  # Defining the download instruction
  download_instr <- downloadHandler(
    filename = function() {
      input$upload$name
    },
    content = function(file) {
      write.csv(data_filted(), file)
    }
  )
  
  # Assigning the download instruction
  output$download1 <- download_instr
  output$download2 <- download_instr
  
  # Finally Rendering the table to display
  output$head <- renderTable({
    data_filted()
  })
  
}

shinyApp(ui, server)
