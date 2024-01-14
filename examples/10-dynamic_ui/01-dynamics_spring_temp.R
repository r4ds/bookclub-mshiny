

# 10 Dynamics Spring Temp

library(shiny)

##################  switcher ##############################

ui <- fluidPage(
  sliderInput("temperature", "Spring temperature", 21, min = 19, max = 25),
  actionButton("reset", "Reset")
)

server <- function(input, output, session) {
  observeEvent(input$reset,{
    updateSliderInput(inputId = "temperature", value = 21)
  })
}


# Run the application
shinyApp(ui, server)
