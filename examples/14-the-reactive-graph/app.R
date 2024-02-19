#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
ui <- fluidPage(
  numericInput("a", "Range mid point", value = 10),
  numericInput("b", "Sample size", value = 1),
  numericInput("c", "Times sample size", value = 1),
  br(),
  h4("Sampled data from the range"),
  plotOutput("x"),
  h4("Highest number in the sampled data"),
  tableOutput("y"),
  h4("Times sample size"),
  textOutput("z")
)

server <- function(input, output, session) {
  rng <- reactive(input$a * 2,
                  label = "rng")
  smp <- reactive(sample(rng(), input$b, replace = TRUE),
                  label = "smp")
  bc <- reactive(input$b * input$c,
                 label = "bc")
  
  output$x <- renderPlot(hist(smp()))
  output$y <- renderTable(max(smp()))
  output$z <- renderText(bc())
}

# Run the application 
shinyApp(ui = ui, server = server)
