
# Complete the user interface below with a server function 
# that updates input$county choices based on input$state. 
# For an added challenge, also change the label from “County” 
# to “Parish” for Louisiana and “Borough” for Alaska.

library(openintro, warn.conflicts = FALSE)

states <- unique(county$state)

library(shiny)

ui <- fluidPage(
  selectInput("state", "State", choices = states),
  selectInput("county", "County", choices = NULL)
)

server <- function(input, output, session) {
  
  state_county <- reactive({
    subset(county, state == input$state)[["name"]] |>
      sub(pattern = " +County$", replacement = "")
  })
  
  observeEvent(state_county(),{
    
    new_label <- switch(
      input$state,
      Louisiana = "Parish",
      Alaska = "Borough",
      "County"
    )
    
    freezeReactiveValue(input, "county")
    
    updateSelectInput(session, 
                      "county",
                      choices = state_county(),
                      label = new_label)
  })
  
}

shinyApp(ui, server)