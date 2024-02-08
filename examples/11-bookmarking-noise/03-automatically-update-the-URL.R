
# Updating the URL in Browser ----

# 1. Turn ui into a function with the request argument.
# 2. Automatically bookmark every time an input changes.
# 3. Update the query string in browser


# Modificated app ----

library(shiny)

ui <- function(request) { # Here a change
  fluidPage(
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
}

server <- function(input, output, session) {
  
  t <- reactive(seq(0, input$length, length.out = input$length * 100))
  x <- reactive(sin(input$omega * t() + input$delta) * input$damping ^ t())
  y <- reactive(sin(t()) * input$damping ^ t())
  
  output$fig <- renderPlot({
    plot(x(), y(), axes = FALSE, xlab = "", ylab = "", type = "l", lwd = 2)
  }, res = 96)
  
  
  # Automatically bookmark every time an input changes
  observe({
    reactiveValuesToList(input)
    session$doBookmark()
  })
  
  # Update the query string
  onBookmarked(updateQueryString)
  
}


shinyApp(ui, server, enableBookmarking = "url")

# Examples ----

# /?_inputs_&omega=0.53&delta=1.75&damping=0.9&length=100

# https://hadley.shinyapps.io/ms-bookmark-url/?_inputs_&damping=0.997&delta=1.37&length=500&omega=-0.9