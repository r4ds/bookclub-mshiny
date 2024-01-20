
# 4.
# Extend the previous app so that you can also choose to select
# all continents, and hence see all countries. You’ll need to
# add "(All)" to the list of choices, and then handle that 
# specially when filtering.

library(shiny)
library(gapminder)

continents <- c(
  "(All)",
  levels(gapminder$continent)
)

ui <- fluidPage(
  selectInput("continent", "Continent", choices = continents), 
  selectInput("country", "Country", choices = NULL),
  tableOutput("data")
)

server <- function(input, output, session) {
  
  observeEvent(input$continent,{
    
    freezeReactiveValue(input, "country")
    
    countries <- switch(
      input$continent,
      "(All)" = unique(gapminder$country),
      unique(gapminder$country[gapminder$continent == input$continent]) |> as.character()
    ) |>
      append(x = "(All)")
    
    updateSelectInput(session, "country", choices = countries, selected = character())
    
  })
  
  output$data <- renderTable({
    
    output <- gapminder
    
    if(input$continent != "(All)") {
      output <- output |>
        subset(continent == input$continent)
    }
    
    if(input$country != "(All)") {
      output <- output |>
        subset(country == input$country)
    }
  
    return(output)
    
  })
}

shinyApp(ui, server)