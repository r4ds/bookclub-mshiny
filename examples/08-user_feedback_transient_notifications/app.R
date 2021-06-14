library(shiny)
# Notification

ui <- fluidPage(
    actionButton("goodnight", "Good night")
)

server <- function(input, output, session) {
    observeEvent(input$goodnight, {
        showNotification("So long", duration = 60)
        Sys.sleep(1)
        showNotification("Farewell", type = "message")
        Sys.sleep(1)
        showNotification("Auf Wiedersehen", type = "warning")
        Sys.sleep(1)
        showNotification("Adieu", type = "error")
    })
}


shinyApp(ui = ui, server = server)
