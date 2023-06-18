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
      
      selectInput("controller", "Show", "plot",choices = c("plot","summary")),
      
      actionButton("reset", "Reset")
    ),
    mainPanel(
      tabsetPanel(
        id = "switcher",
        type = "hidden",
        tabPanelBody("plot", "plot",plotOutput("plot")),
        tabPanelBody("summary", "summary",verbatimTextOutput("summary"))
        
      )
    )
  )
)
#############################################################################
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
  
  observeEvent(input$reset,{
    updateSliderInput(inputId = "controller", value="plot")
  })
  
  
  output$summary <- renderPrint({
    summary(d())
  })
  
  observeEvent(input$reset,{
    updateSliderInput(inputId = "controller", value="plot")
  })
  
}

# Run the application
shinyApp(ui, server)
