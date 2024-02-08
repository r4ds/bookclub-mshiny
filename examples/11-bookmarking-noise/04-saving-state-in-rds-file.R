
# Useful cases ----
# 1. You have a large number of inputs
# 2. Some inputs comes from a file

# Saving the state to an .rds file on the server ----
# 1. Turn ui into a function with the request argument.
# 2. Add a bookmarkButton() to the UI to generate the bookmarkable URL
# 3. Add argument enableBookmarking = "server" to the shinyApp() call.

# Limitations ----
# 1. Your app is going to take up more and more disk space over time
# 2. If you do delete the files, some old bookmarks are going to stop working.

# Example app ----

library(shiny)

ui <- function(request) {
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        sliderInput("omega", "omega", value = 1, min = -2, max = 2, step = 0.01),
        sliderInput("delta", "delta", value = 1, min = 0, max = 2, step = 0.01),
        sliderInput("damping", "damping", value = 1, min = 0.9, max = 1, step = 0.001),
        numericInput("length", "length", value = 100),
        bookmarkButton(label = "Save Bookmark")
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

# Here is the change
shinyApp(ui, server, enableBookmarking = "server")
