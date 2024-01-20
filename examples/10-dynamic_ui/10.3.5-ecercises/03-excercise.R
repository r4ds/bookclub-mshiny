
# 3.
# In the app in Section 10.3.1, what happens if you drop 
# the isolate() from value <- isolate(input$dynamic)?
# 
# it ensures that we don’t create a reactive dependency that would cause 
# this code to re-run every time input$dynamic changes

library(shiny)

ui <- fluidPage(
  textInput("label", "label"),
  selectInput("type", "type", c("slider", "numeric")),
  uiOutput("numeric")
)

server <- function(input, output, session) {
  output$numeric <- renderUI({
    value <- input$dynamic
    if (input$type == "slider") {
      sliderInput("dynamic", input$label, value = input$dynamic, min = 0, max = 10)
    } else {
      numericInput("dynamic", input$label, value = input$dynamic, min = 0, max = 10)
    }
  })
}

shinyApp(ui, server)