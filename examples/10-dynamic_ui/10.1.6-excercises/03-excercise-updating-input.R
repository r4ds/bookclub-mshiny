
# 3
# Complete the user interface below with a server function 
# that updates input$country choices based on the input$continent. 
# Use output$data to display all matching rows.

library(shiny)
library(gapminder)
continents <- unique(gapminder$continent)

ui <- fluidPage(
  selectInput("continent", "Continent", choices = continents), 
  selectInput("country", "Country", choices = NULL),
  tableOutput("data")
)

server <- function(input, output, session) {
  
  observeEvent(input$continent,{
    
    freezeReactiveValue(input, "country")
    
    countries <-
      gapminder$country[gapminder$continent == input$continent] |> unique()

    updateSelectInput(session, "country", choices = countries, selected = character())
    
  })
  
  output$data <- renderTable({
    
    gapminder |>
      subset(continent == input$continent &
               country == input$country,
             select = -c(country, continent))
    
  })
}

shinyApp(ui, server)