library(shiny)
# Feedback

ui <- fluidPage(
    shinyFeedback::useShinyFeedback(),
    numericInput("n", "n", value = 11),
    textOutput("half"),
    numericInput("n3", "n", value = 10),
    textOutput("third")
)


server <- function(input, output, session) {
    half <- reactive({
        even <- input$n %% 2 == 0
        shinyFeedback::feedbackWarning(inputId = "n", show = !even, text = "Warning: Please select an even number")
        shinyFeedback::feedback("n", even, "Feedback: you selected an even number")
        input$n / 2    
    })
    
    output$half <- renderText(half())
    
    third <- reactive({
        test <- input$n3 %% 3 == 0
        shinyFeedback::feedbackDanger("n3", !test, "Danger: Please select number, dividable by three")
        shinyFeedback::feedbackSuccess("n3", test, "Success: you selected a number dividable by three")
        input$n3 / 3    
    })
    
    output$third <- renderText(third())
}

shinyApp(ui = ui, server = server)