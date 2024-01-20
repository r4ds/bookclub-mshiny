
# 2.
# Explain how this app works. Why does the password disappear when you
# click the enter password button a second time?
# 
# Because every time you click the "Enter password" we don't apply any
# modification on the value argument of the passwordInput input


library(shiny)

ui <- fluidPage(
  actionButton("go", "Enter password"),
  textOutput("text")
)


server <- function(input, output, session) {
  observeEvent(input$go, {
    showModal(modalDialog(
      passwordInput("password", NULL),
      title = "Please enter your password"
    ))
  })
  
  output$text <- renderText({
    if (!isTruthy(input$password)) {
      "No password"
    } else {
      "Password entered"
    }
  })
}

shinyApp(ui, server)