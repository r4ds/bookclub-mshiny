library(shiny)
library(tidyverse)
library(glue)

ui <- fluidPage(
  textInput("name", "Enter your name:"),
  textOutput("name_output"),
  br(), 
  numericInput("age", "What is your age?", 18, min = 18, max = 99),
  textOutput("age_output"),
  br(),
  textInput("city", "What city do you live?"),
  textOutput("city_output"), 
  br(), 
  selectInput("state", "What state do you live?", selected = "AL", choices = state.name),
  textOutput("state_output")
)

server <- function(input, output, session) {
  output$name_output <- renderText({
    str_c("Hello, ", input$name, "!")
  })
  
  output$age_output <- renderText({
    str_c("You are ", input$age, " years old.")
  })

  output$city_output <- renderText({
    if (identical(input$city, "Lincoln")) {
      browser()
      str_c(input$city, " is home.")
    } else {
    str_c(input$city, " is home.")
    }
  })

  observeEvent(input$state, {
    message(glue("User selected {input$state} as their home state"))
  })

  state <- reactive(str_c("You live in the great state of ", input$state, "!"))

  output$state_output <- renderText({
    state()
  })
  
}

shinyApp(ui, server)