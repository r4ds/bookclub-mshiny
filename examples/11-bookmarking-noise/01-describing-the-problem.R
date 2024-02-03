
# Problem to solve ----
# 
# you can’t share your work with someone else with a link in an email
# as  Shiny does not expose the current state of the app in its URL.

library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("omega", "omega", value = 1, min = -2, max = 2, step = 0.01),
      sliderInput("delta", "delta", value = 1, min = 0, max = 2, step = 0.01),
      sliderInput("damping", "damping", value = 1, min = 0.9, max = 1, step = 0.001),
      numericInput("length", "length", value = 100)
    ),
    mainPanel(
      plotOutput("fig")
    )
  )
)
server <- function(input, output, session) {
  t <- reactive(seq(0, input$length, length.out = input$length * 100))
  x <- reactive(sin(input$omega * t() + input$delta) * input$damping ^ t())
  y <- reactive(sin(t()) * input$damping ^ t())
  
  output$fig <- renderPlot({
    plot(x(), y(), axes = FALSE, xlab = "", ylab = "", type = "l", lwd = 2)
  }, res = 96)
}

shinyApp(ui, server)