library(shiny)

ui <- fluidPage(
  numericInput("n", "n", 0)
)
server <- function(input, output, session) {
  observeEvent(input$n,
               updateNumericInput(inputId = "n", value = input$n + 1)
  )
}

shinyApp(ui, server)