
# Loading libraries

library(shiny)
library(shinytest2)

# Defining the app

ui <- fluidPage(
  textInput("name", "What's your name"),
  textOutput("greeting"),
  actionButton("reset", "Reset")
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    req(input$name)
    paste0("Hi ", input$name)
  })
  observeEvent(input$reset, updateTextInput(session, "name", value = ""))
}


# Adding interaction

app <- AppDriver$new(shinyApp(ui, server))

app$set_inputs(name = "Hadley")
app$get_value(output = "greeting")

app$click("reset")
app$get_value(output = "greeting")


# Testing interaction

test_that("can set and reset name", {
  
  app <- AppDriver$new(shinyApp(ui, server))
  
  app$set_inputs(name = "Hadley")
  expect_equal(app$get_value(output = "greeting"), "Hi Hadley")
  
  app$click("reset")
  expect_equal(app$get_value(output = "greeting")$message, "")
  
})

