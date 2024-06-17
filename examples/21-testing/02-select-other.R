
# Loading libraries

library(shiny)
library(shinytest2)


# Defining the app

ui <- fluidPage(
  radioButtons("fruit", "What's your favourite fruit?",
               choiceNames = list(
                 "apple", 
                 "pear", 
                 textInput("other", label = NULL, placeholder = "Other")
               ),
               choiceValues = c("apple", "pear", "other")
  ), 
  textOutput("value")
)


server <- function(input, output, session) {
  observeEvent(input$other, ignoreInit = TRUE, {
    updateRadioButtons(session, "fruit", selected = "other")
  })
  
  output$value <- renderText({
    if (input$fruit == "other") {
      req(input$other)
      input$other
    } else {
      input$fruit
    }
  })
}


# Testing interaction

test_that("automatically switches to other", {
  
  # Defining the app
  app <- AppDriver$new(shinyApp(ui, server))
  
  # Start typing a new fruit
  app$set_inputs(other = "orange")
  
  # Fruit must change to other
  expect_equal(app$get_value(input = "fruit"), "other")
  
  # The final output should show the typed orange
  expect_equal(app$get_value(output = "value"), "orange")
  
})



# Save screenshot to temporary file

path <- tempfile(fileext = ".png")
app <- AppDriver$new(shinyApp(ui, server))

app$get_screenshot(path)
showimage::show_image(path)
