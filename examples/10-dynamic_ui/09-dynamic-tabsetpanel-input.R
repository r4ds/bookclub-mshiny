
library(shiny)

# The tabsetPanel function works like the switch function

dynamic_ui <- tabsetPanel(
  
  # We will select the tab from the server
  id = "dist_selected",
  
  # HERE IS REAL TRICK
  # we don't need to show the options
  # to the final user
  type = "hidden",

  # Define the different UIs
  tabPanel("normal",
           numericInput("mean", "mean", value = 0),
           numericInput("sd", "standard deviation", min = 0, value = 1)),
  tabPanel("uniform", 
           numericInput("min", "min", value = -3),
           numericInput("max", "max", value = 3)),
  tabPanel("exponential",
           numericInput("rate", "rate", value = 6, min = 0))
  
)



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dist", "Distribution", 
                  choices = c("normal", "uniform", "exponential")),
      numericInput("n", "Number of samples", value = 5000),
      dynamic_ui,
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)



server <- function(input, output, session) {
  observeEvent(input$dist, {
    updateTabsetPanel(inputId = "dist_selected", selected = input$dist)
  }) 
  
  sample <- reactive({
    switch(input$dist,
           normal = rnorm(input$n, input$mean, input$sd),
           uniform = runif(input$n, input$min, input$max),
           exponential = rexp(input$n, input$rate))
  })
  output$hist <- renderPlot(hist(sample()), res = 96)
}


shinyApp(ui, server)