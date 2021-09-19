library(shiny)
library(tidyverse)

ui <- fluidPage(
  textInput("name", "What is your name?"),
  textOutput("greeting"),
  textOutput("nice_day")
)

server <- function(input, output, session) {
  output$greeting <- renderText(str_c("Hello, ", input$name, "!"))
  output$nice_day <- renderText(str_c("Have a nice day, ", input$name, "!"))
}

shinyApp(ui, server)

