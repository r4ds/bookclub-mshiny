
# Complete the app below with a server function 
# that updates out with the value of x only when 
# the button is pressed.

library(shiny)

ui <- fluidPage(
  numericInput("x", "x", value = 50, min = 0, max = 100),
  actionButton("capture", "capture"),
  br(),
  br(),
  textOutput("out")
)

server <- function(input, output, session) {
  
  value_out <- eventReactive(input$capture, input$x)
  
  output$out <- renderText(value_out())
  
}

shinyApp(ui, server)