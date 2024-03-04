library(shiny)

ui <- fluidPage(
  titlePanel("req() function example"),
  sidebarLayout(
    sidebarPanel(
      numericInput("num", "Enter a number:", value = NULL),
      checkboxInput("cancelOutput","Cancel Output")
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output) {
  output$hist <- renderPlot({
    req(input$num > 0, cancelOutput = input$cancelOutput)
    hist(rnorm(input$num))
  })
}

shinyApp(ui = ui, server = server)