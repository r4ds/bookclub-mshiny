
# Modify your code from above for to work with this UI:

library(shiny)

ui <- fluidPage(
  selectInput("type", "type", c("Normal", "Uniform")),
  actionButton("go", "go"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  
  values <- reactiveVal(vector(mode = "numeric"))
  
  observeEvent(input$go, {
    if(input$type == "Normal") values(rnorm(100)) else values(runif(100))
  })
  
  output$plot <- renderPlot({
    req(input$go)
    hist(values())
  })
}

shinyApp(ui, server)

# source: https://mastering-shiny-solutions.netlify.app/escaping-the-graph