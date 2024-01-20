# https://gist.github.com/jcheng5/45813fd5b4ae6b418cc8a081e8d21830

library(shiny)
library(ggplot2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Dataset", c("cars", "pressure", "mtcars")),
      uiOutput("input_ui")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$input_ui <- renderUI({
    freezeReactiveValue(input, "x")
    freezeReactiveValue(input, "y")
    columns <- names(dataset())
    tagList(
      selectInput("x", "x variable", columns, columns[[1]]),
      selectInput("y", "y variable", columns, columns[[2]])
    )
  })
  
  output$plot <- renderPlot({
    Sys.sleep(1)
    ggplot(dataset(), aes_string(input$x, input$y)) + geom_point()
  })
}

shinyApp(ui, server)
