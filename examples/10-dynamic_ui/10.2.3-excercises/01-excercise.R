
# 1.
# Use a hidden tabset to show additional controls 
# only if the user checks an “advanced” check box.

library(shiny)

ui <- fluidPage(
  
  # Defining first option
  textInput("name", "What is your Name?"),
  checkboxInput("box", "Advanced"),
  
  # Tabset doesn't support hiding elements
  conditionalPanel(
    condition = "input.box == true",
    textInput("job", "What do you do?")
  ),
  
  # Defining the botton to print results
  actionButton("send", "Send"),
  br(),
  
  # Returning the output
  textOutput("output_text")
)

server <- function(input, output, session) {
  
  # Makes sure that values print after clicking the button
  job <- eventReactive(input$send, input$job)
  name <- eventReactive(input$send, input$name)
  
  # Defining the value to return
  output$output_text <- renderText({
    if(input$box) {
      paste("Welcome", job(), name())
    } else {
      paste("Welcome", name())
    }
  })

}

# Run the add
shinyApp(ui, server)
