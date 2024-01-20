# https://gist.github.com/jcheng5/45813fd5b4ae6b418cc8a081e8d21830

library(shiny)
library(ggplot2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Dataset", c("cars", "pressure", "mtcars")),
      selectInput("x", "x variable", character(0)),
      selectInput("y", "y variable", character(0))
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
  
  observe({
    freezeReactiveValue(input, "x")
    freezeReactiveValue(input, "y")
    columns <- names(dataset())
    updateSelectInput(session, "x", choices = columns, selected = columns[[1]])
    updateSelectInput(session, "y", choices = columns, selected = columns[[2]])
  })
  
  output$plot <- renderPlot({
    Sys.sleep(1)
    ggplot(dataset(), aes_string(input$x, input$y)) + geom_point()
  })
}

shinyApp(ui, server)
