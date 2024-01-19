
library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      numericInput("n", "Number of colours", value = 5, min = 1),
      uiOutput("col"),
    ),
    mainPanel(
      plotOutput("plot")  
    )
  )
)


`%||%` <- \(x, y) if(is.null(x)) y else x


server <- function(input, output, session) {
  col_names <- reactive(paste0("col", seq_len(input$n)))
  
  output$col <- renderUI({
    # We can change map with lapply
    lapply(col_names(), \(x) textInput(x, NULL, value = isolate(input[[x]])))
  })
  
  output$plot <- renderPlot({
    
    # We can change any NULL with "" with sapply
    cols <- sapply(col_names(), \(x) input[[x]] %||% "")
   
    # convert empty inputs to transparent
    # whether it was NULL or kept blank ("") by the user
    cols[cols == ""] <- NA
    
    barplot(
      rep(1, length(cols)), 
      col = cols,
      space = 0, 
      axes = FALSE
    )
  }, res = 96)
}

shinyApp(ui, server)