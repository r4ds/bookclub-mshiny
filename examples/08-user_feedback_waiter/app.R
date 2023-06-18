library(shiny)
library(waiter)
# Progress bar - waiter


ui <- fluidPage(
  waiter::use_waitress(),
  numericInput("steps", "How many steps?", 10),
  actionButton("go", "go"),
  textOutput("result")
)


server <- function(input, output, session) {
  data <- eventReactive(input$go, {
     # waitress <- waiter::Waitress$new(max = input$steps)
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay")
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay-opacity")
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay-percent")
     waitress <- waiter::Waitress$new(max = input$steps, selector = "#steps", theme = "overlay-percent")
    
    on.exit(waitress$close())
    
    for (i in seq_len(input$steps)) {
      Sys.sleep(0.5)
      # increment one step
      waitress$inc(1)
    }
    
    runif(1)
  })
  
  output$result <- renderText(round(data(), 2))
}


shinyApp(ui = ui, server = server)
