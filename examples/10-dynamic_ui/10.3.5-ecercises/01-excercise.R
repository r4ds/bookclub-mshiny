
# 1.
# How could you instead implement it using dynamic visibility?
# If you implement dynamic visibility, 
# how could you keep the values in sync when you change the controls?

library(shiny)

ui <- fluidPage(
  selectInput("type", "type", c("slider", "numeric")),
  uiOutput("numeric")
)
server <- function(input, output, session) {
  output$numeric <- renderUI({
    
    value <- if(is.null(input$n)) 0 else isolate(input$n)
    
    if (input$type == "slider") {
      sliderInput("n", "n", value = value, min = 0, max = 100)
    } else {
      numericInput("n", "n", value = value, min = 0, max = 100)  
    }
    
  })
}

shinyApp(ui, server)