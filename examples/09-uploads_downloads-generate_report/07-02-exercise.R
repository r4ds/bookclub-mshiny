
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Exercises --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# 2. --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Create an app that lets you upload a csv file,  select a variable, 
# and then perform a t.test() on that variable. After the user has uploaded 
# the csv file, you’ll need to use updateSelectInput() to fill in the
# available variables. See Section 10.1 for details.

library(shiny)

ui <- fluidPage(
  fileInput("data", "Importing section", buttonLabel = "Pick a CSV"),
  selectInput("variable_name", "Pick a column", choices = NULL),
  verbatimTextOutput("t_test")
)

server <- function(input, output, session) {
  
  
  df_num <- eventReactive(input$data,{
    read.csv(input$data$datapath) |>
      (\(x) x[sapply(x, is.numeric)])()
  })
  
  
  observeEvent(df_num(),{
    updateSelectInput(inputId = "variable_name", 
                      choices = names(df_num()),
                      selected = "")
  })
  
  output$t_test <- renderPrint({
    req(input$variable_name)
    t.test(df_num()[[input$variable_name]]) 
  })
  
}

shinyApp(ui, server)

