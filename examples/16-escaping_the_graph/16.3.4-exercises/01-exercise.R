
# Provide a server function that draws a histogram of 100 random numbers
#  from a normal distribution when normal is clicked, and 100 random uniforms.

library(shiny)

ui <- fluidPage(
  actionButton("rnorm", "Normal"),
  actionButton("runif", "Uniform"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  
  values <- reactiveVal(vector(mode = "numeric"))
  
  observeEvent(input$rnorm, values(rnorm(100)))
  
  observeEvent(input$runif, values(runif(100)))
  
  output$plot <- renderPlot({
    req(input$rnorm | input$runif)
    hist(values())
  })
}

shinyApp(ui, server)

# source: https://mastering-shiny-solutions.netlify.app/escaping-the-graph