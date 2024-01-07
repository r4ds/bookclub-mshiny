library(shiny)

confir_df <- function(text){
  get(text , pos = "package:datasets") |> is.data.frame()
}

ValidTables <-
  ls("package:datasets") |>
  (\(x) x[sapply(x, confir_df)])()


ui <- fluidPage(
  selectInput("dataset_name", "Pick a dataset", ValidTables),
  textOutput("data_dim"),
  tableOutput("preview"),
  downloadButton("download", "Download .tsv")
)

server <- function(input, output, session) {
  
  # Selecting the data
  data <- reactive(get(input$dataset_name, "package:datasets"))
  
  # Defining data dimentions
  output$data_dim <- renderText(paste(dim(data()), collapse = " x "))
  
  # Showing some rows
  output$preview <- renderTable(head(data()))
  
  # Defining download instruction
  output$download <- downloadHandler(
    filename = function() {
      paste0(input$dataset_name, ".tsv")
    },
    content = function(file) {
      vroom::vroom_write(data(), file)
    }
    
  )
}

shinyApp(ui, server)
