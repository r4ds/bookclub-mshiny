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
    numericInput("a", "a", value = 10),
    numericInput("b", "b", value = 1),
    numericInput("c", "c", value = 1),
    plotOutput("x"),
    tableOutput("y"),
    textOutput("z")
)

server <- function(input, output, session) {
    rng <- reactive(input$a * 2,label = "rng")
    smp <- reactive(sample(rng(), input$b, replace = TRUE), label = "smp")
    bc <- reactive(input$b * input$c, label = "bc")
    
    output$x <- renderPlot(hist(smp()))
    output$y <- renderTable(max(smp()))
    output$z <- renderText(bc())
}

# Run the application 
shinyApp(ui = ui, server = server)
