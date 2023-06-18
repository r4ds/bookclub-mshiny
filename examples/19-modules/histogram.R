
mod_histogram_ui <- function(id){
  # ns <- NS(id)
  tagList(
    selectInput(ns("var"), label = "Select", choices = names(mtcars)),
    tableOutput(ns("table"))
  )
}
    
mod_histogram_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    browser()
    output$table <- renderTable(mtcars[[input$var]])
  })
}
    
## To be copied in the UI
# mod_histogram_ui("histogram_1")
    
## To be copied in the server
# mod_histogram_server("histogram_1")

ui <- fluidPage(
  mod_histogram_ui("histogram_1")
)

server <- function(input, output){
  mod_histogram_server("histogram_1")
}

shinyApp(ui = ui, server = server)
