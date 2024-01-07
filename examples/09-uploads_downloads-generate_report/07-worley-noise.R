
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Exercises --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# 1. --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Use the ambient package by Thomas Lin Pedersen
# to generate worley noise and download a PNG of it.

library(ambient)
library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h3('Dimensions'),
      numericInput("x_dim","X Size", 500),
      numericInput("y_dim","Y Size", 500),
      
      h3('More Options'),
      selectInput("pertubation", 
                  label = "Pertubation Type", 
                  choices = c("none", "normal", "fractal"),
                  selected  = "fractal"),
      numericInput("amplitude","Amplitude", 200),
      actionButton("render", "Render Plot")
    ),
    mainPanel(
      h3("Worley Noise Plot"),
      plotOutput("final_plot"),
      column(
        width = 2,
        downloadButton("image_plot", "Download PNG")
      )
    )
  )
)



server <- function(input, output, session) {
  
  simplex_raster <- reactive({
    
    noise_simplex(dim = c(input$x_dim, input$y_dim), 
                  pertubation = input$pertubation, 
                  pertubation_amplitude = input$amplitude) |>
      normalise() |>
      as.raster()
  })
  
  output$final_plot <- renderPlot({
    req(input$render)
    plot(simplex_raster())
  })
  
  output$image_plot <- downloadHandler(
    filename = "Worley Noise Plot.png",
    content = function(file) {
      png(file)
      plot(simplex_raster())
      dev.off()
    }
  )
  
}

shinyApp(ui, server)
