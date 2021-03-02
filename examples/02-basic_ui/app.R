#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

## Multiple Choice ARE OUTSIDE FLUIDPAGE
animals <- c("dog", "cat", "porpoise")
state_name <- c("AL", "AK", "MA", "RI", "Non sequitur")

## User Interface
#----------------
user_interface <- fluidPage(

    titlePanel("INPUTS"),

    ## Free Text
    textInput(inputId = "name",
              label = "What's your name?",
              placeholder = "First Name"),
    passwordInput("password", "What's your password?", 
                  placeholder = "Tell me a secret"),
    textAreaInput("story",
                  "Tell me about yourself",
                  rows = 3,
                  placeholder = "Expand here."),

    ## Numeric Values
    numericInput("num1", "X 1", value = 0, min = 0, max = 100),
    sliderInput("num2", "X 2", value = 50, min = 0, max = 100),
    sliderInput("rang", "Range", value = c(20, 80), min = 0, max = 100),

    ## Dates
    dateInput("dob", "Date of Birth?"),
    dateRangeInput("delivery_time", "Delivery Time Range?"),

    ## Multiple Choice
    selectInput("state", "What's your favourite state?", state_name),
    radioButtons("swimmer", "Who swims with you?", animals),

     ## Select More Than 1 Choice
     selectInput("states", "Choice a state & non sequitur",
                 state_name,
                 multiple = TRUE),

    # For a single checkbox for a single yes/no question
    checkboxInput("calc_value", "Calculate Equation?", value = FALSE),

    # Action buttons
    actionButton("click", "Click me!"),
    actionButton("drink", "Drink me!", icon = icon("cocktail")),

    # OUTPUT Text
    # Husker Du?
    # **renderText()** <-> **textOutput()**
    # **renderPrint()**  <-> **verbatimTextOutput()**
    textOutput(inputId = "text", label = "tell me your name."),
    verbatimTextOutput("print"),

    # Output Tables
    tableOutput("static"),
    dataTableOutput("dynamic"),

    #textOutput(name)
    plotOutput("negative_slope_plot")
)

## Define server functions
#-------------------------
server <- function(input, output) {

    # Output Text
    output$text <- renderText(input$text)
    
    output$print <- renderPrint(3.1415926*3.1415926)

    # Output Table
    output$static  <- renderTable(head(iris, n = 2))
    output$dynamic <- renderDataTable(iris, options = list(pageLength = 2))

    # Download button
    # requires new techniques in the server function,
    # so we’ll come back to that in Chapter 9.

    # Plot
    output$negative_slope_plot <- renderPlot({
        res = 96
        plot(1:5, 5:1,
             main = "Dependent vs Independent Variables",
             xlab = "X Variable",
             ylab = "Y Variable")
    })
} # To server function

# Run the application
shinyApp(ui = user_interface, server = server)
