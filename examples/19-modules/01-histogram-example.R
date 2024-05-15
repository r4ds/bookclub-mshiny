library(shiny)

histogramUI <- function(id) {
  
  ns <- NS(id)
  
  tagList(
    selectInput(ns("var"), "Variable", choices = names(mtcars)),
    numericInput(ns("bins"), "bins", value = 10, min = 1),
    plotOutput(ns("hist"))
  )
  
}


histogramServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    data <- reactive(mtcars[[input$var]])
    
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
    
  })
}


histogramApp <- function() {
  
  ui <- fluidPage(
    histogramUI("hist1")
  )
  
  server <- function(input, output, session) {
    histogramServer("hist1")
  }
  
  shinyApp(ui, server)  
}


histogramApp()
