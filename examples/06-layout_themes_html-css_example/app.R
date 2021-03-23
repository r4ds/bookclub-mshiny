library(shiny)

ui <- fluidPage(
  tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
  h1("This is a heading", class = "my-class"),
  textInput("name", "What's your name?")
)

server <- function(input, output, session) { }

shinyApp(ui, server)