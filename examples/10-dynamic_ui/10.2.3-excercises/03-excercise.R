
# 3.
# Modify the app you created in the previous exercise to allow the user 
# to choose whether each geom is shown or not (i.e. instead of always using 
# one geom, they can picked 0, 1, 2, or 3). Make sure that you can control the 
# binwidth of the histogram and frequency polygon independently.

library(shiny)
library(ggplot2)

base_plot <- ggplot(diamonds, aes(carat))

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      
      selectInput("geom", "Select a geom to display carat",
                  choices = c("histogram", "freqpoly", "density"),
                  selected = character(),
                  multiple = TRUE),
      
      tabsetPanel(
        id = "histogram_select",
        type = "hidden",
        
        tabPanel("histogram",
                 numericInput("binwidth_h", "Histogram Binwidth", value = 0.5)),
        tabPanel("no_histogram",
                 div())
      ),
      
      
      tabsetPanel(
        id = "freqpoly_select",
        type = "hidden",
        
        tabPanel("freqpoly",
                 numericInput("binwidth_f", "Freqpoly Binwidth", value = 0.1)),
        tabPanel("no_freqpoly",
                 div())
      ),
      
      tabsetPanel(
        id = "density_select",
        type = "hidden",
        
        tabPanel("density",
                 numericInput("bw", "SD of the Smoothing Kernel", value = 0.01)),
        tabPanel("no_density",
                 div())
      ),
      
      actionButton("show","Display Plot")
      
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  
  observe({
    updateTabsetPanel(session, "histogram_select", 
                      selected = ifelse("histogram" %in% input$geom, "histogram", "no_histogram"))
  })
  
  observe({
    updateTabsetPanel(session, "freqpoly_select", 
                      selected = ifelse("freqpoly" %in% input$geom, "freqpoly", "no_freqpoly"))
  })
  
  observe({
    updateTabsetPanel(session, "density_select", 
                      selected = ifelse("density" %in% input$geom, "density", "no_density"))
  })
  
  geom <- eventReactive(input$show, input$geom)
  bw_value <- eventReactive(input$show, input$bw)
  binwidth_h<- eventReactive(input$show, input$binwidth_h)
  binwidth_f<- eventReactive(input$show, input$binwidth_f)
  
  output$plot <- renderPlot({
    
    final_plot <- base_plot
    
    if("density" %in% geom()) {
      final_plot <- final_plot + geom_density(bw = bw_value())
    }
    
    if("histogram" %in% geom()) {
      final_plot <- final_plot + geom_histogram(binwidth = binwidth_h())
    }
    
    if("freqpoly" %in% geom()) {
      final_plot <- final_plot + geom_freqpoly(binwidth = binwidth_f())
    }
    
    final_plot
    
  })
  
}

shinyApp(ui, server)