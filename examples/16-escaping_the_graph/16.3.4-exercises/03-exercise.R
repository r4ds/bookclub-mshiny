
# Rewrite your code from the previous answer to eliminate the use of 
# observe()/observeEvent() and only use reactive().
# Why can you do that for the second UI but not the first?

# Now we just need to track the event go.

library(shiny)

ui <- fluidPage(
  selectInput("type", "type", c("Normal", "Uniform")),
  actionButton("go", "go"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  
  values <- reactive({
    if(input$go == 0) return(NULL)
    if(input$type == "Normal"){
      rnorm(100)
    }else{
      runif(100)
    }
  })
  
  output$plot <- renderPlot({
    if(is.null(values())) return(NULL)
    hist(values())
  })
}

shinyApp(ui, server)

# source: https://mastering-shiny-solutions.netlify.app/escaping-the-graph