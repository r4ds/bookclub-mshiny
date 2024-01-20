library(shiny)

ui <- fluidPage(
  selectInput("dataset", "Choose a dataset", c("pressure", "cars")),
  selectInput("column", "Choose column", character(0)),
  verbatimTextOutput("summary")
)

server <- function(input, output, session) {
  dataset <- reactive(get(input$dataset, "package:datasets"))
  
  observeEvent(dataset(), {
    # HIERARCHICAL SELECTION can briefly create an invalid set of inputs
    # it’s actually good practice to ALWAYS use freezeReactiveValue when 
    # you dynamically change an input value
    freezeReactiveValue(input, "column")
    updateSelectInput(inputId = "column", choices = names(dataset()))
  })
  
  output$summary <- renderPrint({
    summary(dataset()[[input$column]])
  })
}
shinyApp(ui, server)