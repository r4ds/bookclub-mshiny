
library(shiny)

ui <- fluidPage(
  
  tabsetPanel(
    
    id = "wizard",
    type = "hidden",
    tabPanel("page_1", 
             "Welcome!",
             br(),
             actionButton("page_12", "next")),
    tabPanel("page_2", 
             "Only one page to go",
             br(),
             actionButton("page_21", "prev"),
             actionButton("page_23", "next")),
    tabPanel("page_3",
             "You're done!",
             br(),
             actionButton("page_32", "prev"))
    
  )
)

# As we need to use updateTabsetPanel
# many times let's create a function

switch_page <- function(i) {
  updateTabsetPanel(inputId = "wizard", selected = paste0("page_", i))
}

server <- function(input, output, session) {
  
  # Going to next
  observeEvent(input$page_12, switch_page(2))
  observeEvent(input$page_23, switch_page(3))
  
  # Going back
  observeEvent(input$page_32, switch_page(2))
  observeEvent(input$page_21, switch_page(1))
  
}


shinyApp(ui, server)