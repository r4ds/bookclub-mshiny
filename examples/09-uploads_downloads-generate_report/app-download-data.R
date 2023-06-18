library(shiny)
library(dplyr)

ui <- fluidPage(
  shinyFeedback::useShinyFeedback(),
  h3("A simple filtering app"),
  br(),
  # Add ui element
  fileInput("upload", 
            "Upload a file", 
            accept = c(".csv", ".tsv"),
            placeholder = "Give me some data", 
            multiple = TRUE),
  
  selectInput("state", "Filter by which state?", state.abb),
  
  numericInput("population", "Filter by population size", value = 200000),
  
  actionButton("filter", "Filter data"),
  
  # Output table in ui
  tableOutput("data_table"),
  
  # Download data
  br(),
  h5("Would you like a copy of the data?"),
  downloadButton("download_table")
)

server <- function(input, output, session) {
  
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
  filtered_data <- eventReactive(input$filter, {
    data() %>% 
      filter(state == input$state & poptotal >= input$population) %>% 
      select(PID, county, state, area, poptotal, percollege)
  })
  
  output$data_table <- renderTable({
    filtered_data()
  })
  
  # Download data 
  output$download_table <- downloadHandler(
    filename = function() {
      paste0(tolower(input$state), "_population_data.csv")    
    },
    content = function(file) {
      write.csv(filtered_data(), file)
    }
  )
  
}

shinyApp(ui, server)
