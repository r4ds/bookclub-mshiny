library(shiny)
library(auth0)
# usethis::edit_r_environ("project")
# auth0_disable = FALSE


ui <- fluidPage(
  fluidRow(plotOutput("plot"))
)


server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(1:10)
  })
}




# shinyApp(ui, server)

# note that here we're using a different version of shinyApp!
auth0::shinyAppAuth0(ui, server)

# use_auth0() # it creates a ylm file with client&server info




library(shiny)
library(auth0)

auth0_ui(fluidPage(logoutButton()))



library(shiny)
library(auth0)

# simple UI with user info
ui <- fluidPage(
  verbatimTextOutput("user_info"),
  verbatimTextOutput("credential_info")
)

server <- function(input, output, session) {
  
  # print user info
  output$user_info <- renderPrint({
    session$userData$auth0_info
  })
  
  output$credential_info <- renderPrint({
    session$userData$auth0_credentials
  })
  
}

shinyAppAuth0(ui, server)
