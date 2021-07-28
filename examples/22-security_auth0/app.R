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


# use_auth0() # it creates a ylm file with client&server info
options(auth0_config_file = "examples/22-security_auth0/_auth0.yml")
auth0::use_auth0()

# note that here we're using a different version of shinyApp!
auth0::shinyAppAuth0(ui, server)




library(shiny)
library(auth0)

auth0_ui(fluidPage(logoutButton()))

#------------------------------------------

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
