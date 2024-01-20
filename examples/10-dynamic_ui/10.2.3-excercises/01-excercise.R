
# 1.
# Use a hidden tabset to show additional controls 
# only if the user checks an “advanced” check box.

library(shiny)

ui <- fluidPage(
  
  # Defining first option
  textInput("name", "What is your Name?"),
  checkboxInput("box", "Advanced"),
  
  tabsetPanel(
    id = "switcher",
    type = "hidden",
    tabPanelBody("show", 
                 textInput("job", "What do you do?"),
                 actionButton("send1", "Send"),
                 br(),
                 textOutput("output_text1")),
    tabPanelBody("hidde", 
                 actionButton("send2", "Send"),
                 br(),
                 textOutput("output_text2"))
  )
  
)

server <- function(input, output, session) {
  
  # Makes sure that values print after clicking the button
  job <- eventReactive({input$send1 | input$box}, input$job)
  name <- eventReactive({input$send1 | input$send2}, input$name)
  
  # Select the tab to show
  observeEvent(input$box,{
    updateTabsetPanel(session, "switcher",
                      selected = ifelse(input$box,"show","hidde"))
  }) 
  
  # Defining the value to return on each panel
  observeEvent(input$send1 ,{
    output$output_text1 <- renderText(paste("Welcome", job(), name()))
  })
  
  observeEvent(input$send2 ,{
    output$output_text2 <- renderText(paste("Welcome", name()))
  })
  
}

# Run the add
shinyApp(ui, server)
