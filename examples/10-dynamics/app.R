library(shiny)

##################  USER INTERFACE ##############################
ui <- fluidPage(
  # Panel title
  titlePanel("App Statistics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("controller", "Show", choices = c("plot","summary")),
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      
      br(), # to add vertical spacing
      sliderInput("n",
                  "Number of observations:",
                  value = 500,
                  min = 1,
                  max = 1000)
    ),
    mainPanel(
      # The "tabsetPanel()" sets the tabs, the titles and the output 
      tabsetPanel(
        id="switcher",
        type = "hidden",
        tabPanel("Plot", plotOutput("plot")),
        tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
)


server <- function(input, output,session) {
      d <- reactive({
      dist <- switch(input$dist,
                     norm = rnorm,
                     unif = runif,
                     lnorm = rlnorm,
                     exp = rexp,
                     rnorm)
      
      dist(input$n)
    })
      
      observeEvent(input$controller, {
        # 
        updateTabsetPanel(inputId = "switcher", selected = input$controller)
      })
  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "navy", border = "white")
  })
  output$summary <- renderPrint({
    summary(d())
  })
}

# Run the application
shinyApp(ui, server)
