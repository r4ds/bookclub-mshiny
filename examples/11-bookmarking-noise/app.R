library(shiny)
library(ambient)


ui <- function(request){
  #the UI is made a function
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        sliderInput("freq", "frequency", value = 0.01, min = 0, max = 2, step = 0.01),
        radioButtons("fract", "fractal", choices = c("none","fbm", "billow", "rigid-multi"), 
                     selected = "fbm"),
        sliderInput("lac", "lacunarity", value = 2, min = 0, max = 10, step = 1),
        sliderInput("gain", "gain", value = 0.5, min = 0, max = 5, step = 0.1),
        # add a button for bookmaking
        # technically this is not needed since the URL auto-updates
        # bookmarkButton()
      ),
      mainPanel(
        plotOutput("fig")
      )
    )
  )
}


server <- function(input, output, session) {
  
  f1 <- reactive(as.numeric(input$freq))
  f2 <- reactive(input$fract)
  l <- reactive(as.numeric(input$lac))
  g <- reactive(as.numeric(input$gain))
  
  
  output$fig <- renderPlot({
    grid <- long_grid(seq(1, 10, length.out = 1000), seq(1, 10, length.out = 1000))
    grid$noise <- gen_simplex(grid$x, grid$y, frequency = f1(), fractal = f2(),
                              lacunarity = l(), gain = g()
    )
    plot(grid, noise)
  }, res = 96)
  
  # Automatically bookmark every time an input changes
  observe({
    reactiveValuesToList(input)
    # Do bookmarking and invoke the onBookmark 
    # and onBookmarked callback functions.
    session$doBookmark() 
  })
  # registers a function that will be called just after Shiny bookmarks state
  # Update the Query String aka the URL
  onBookmarked(updateQueryString)
}

shinyApp(ui, server, enableBookmarking = "url")