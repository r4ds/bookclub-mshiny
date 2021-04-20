library(shiny)

##################  USER INTERFACE ##############################


ui <- fluidPage(
  titlePanel("App Statistics"),
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      # Input: Slider for the number of observations to generate ----
      sliderInput("n",
                  "Number of observations:",
                  value = 500,
                  min = 1,
                  max = 1000),
      
      selectInput("controller", "Show", choices = c("plot","summary"))
      
      
    ),
    mainPanel(
      tabsetPanel(
        id = "switcher",
        type = "hidden",
        tabPanelBody("plot", "plot",plotOutput("plot")),
        tabPanelBody("summary", "summary")
        
      )
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$controller, {
    updateTabsetPanel(inputId = "switcher", selected = input$controller)
  })
  
  d <- reactive({
    dist <-switch(input$dist,
                  norm = rnorm,
                  unif = runif,
                  lnorm = rlnorm,
                  exp = rexp,
                  rnorm)
    
    dist(input$n)
  })
  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })
  
  
  output$summary <- renderPrint({
    summary(d())
  })
  
}

# Run the application
shinyApp(ui, server)

