
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Exercises --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# 3. --------------------------------------------------------------------
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Create an app that lets the user upload a csv file, select one variable,
# draw a histogram, and then download the histogram. For an additional challenge,
# allow the user to select from .png, .pdf, and .svg output formats.

library(shiny)

options(shiny.maxRequestSize = 50 * 1024^2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("data", "Importing section", 
                buttonLabel = "Pick a CSV",
                accept = ".csv"),
      selectInput("variable_name", "Pick a column", choices = NULL)
    ),
    mainPanel(
      plotOutput("hist_plot"),
      fluidRow(
        column(3, selectInput("output_ext", 
                              "Select format", 
                              choices = c("png", "pdf", "svg"))),
        column(3, 
               br(),
               downloadButton("download_file",))
      )
    )
  )
)

server <- function(input, output, session) {
  
  df_num <- reactive({
    req(input$data)
    
    if(tools::file_ext(input$data$name) != "csv"){
      validate("Select a csv file to continue")
    }else{
      read.csv(input$data$datapath) |>
        (\(x) x[sapply(x, is.numeric)])() 
    }
    
  })
  
  
  observeEvent(df_num(),{
    updateSelectInput(inputId = "variable_name", 
                      choices = names(df_num()),
                      selected = "")
  })
  
  output$hist_plot <- renderPlot({
    req(input$variable_name)
    hist(df_num()[[input$variable_name]],
         main = paste("Histogram of" , input$variable_name),
         xlab = input$variable_name)
  })
  
  output$download_file <- downloadHandler(
    filename = function() {
      paste0("Histogram of ", input$variable_name,".", input$output_ext)
    },
    content = function(file) {
      
      switch(input$output_ext,
             png = png(file),
             pdf = pdf(file),
             svg = svg(file))
      
      hist(df_num()[[input$variable_name]],
           main = paste("Histogram of" , input$variable_name),
           xlab = input$variable_name)
      
      dev.off()
    }
  )
}

shinyApp(ui, server)