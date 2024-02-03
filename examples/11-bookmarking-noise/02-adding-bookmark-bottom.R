
# The simplest solution ----

# 1. Turn ui into a function with the request argument.
# 2. Add a bookmarkButton() to the UI to generate the bookmarkable URL
# 3. Add argument enableBookmarking = "url" to the shinyApp() call.


# Modificated app ----

library(shiny)

ui <- function(request) { # Here a change
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        sliderInput("omega", "omega", value = 1, min = -2, max = 2, step = 0.01),
        sliderInput("delta", "delta", value = 1, min = 0, max = 2, step = 0.01),
        sliderInput("damping", "damping", value = 1, min = 0.9, max = 1, step = 0.001),
        numericInput("length", "length", value = 100),
        bookmarkButton() # Here a change
      ),
      mainPanel(
        plotOutput("fig")
      )
    )
  )
}

server <- function(input, output, session) {
  t <- reactive(seq(0, input$length, length.out = input$length * 100))
  x <- reactive(sin(input$omega * t() + input$delta) * input$damping ^ t())
  y <- reactive(sin(t()) * input$damping ^ t())
  
  output$fig <- renderPlot({
    plot(x(), y(), axes = FALSE, xlab = "", ylab = "", type = "l", lwd = 2)
  }, res = 96)
}


shinyApp(ui, server, enableBookmarking = "url")

# Examples ----

# /?_inputs_&omega=0.53&delta=1.75&damping=0.9&length=100

# https://hadley.shinyapps.io/ms-bookmark-url/?_inputs_&damping=0.997&delta=1.37&length=500&omega=-0.9