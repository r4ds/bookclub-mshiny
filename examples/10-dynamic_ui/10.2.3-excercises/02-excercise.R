
# 2.
# Create an app that plots ggplot(diamonds, aes(carat)) 
# but allows the user to choose which geom to use: 
# geom_histogram(), geom_freqpoly(), or geom_density(). 
# Use a hidden tabset to allow the user to select different 
# arguments depending on the geom: geom_histogram() and geom_freqpoly() 
# have a binwidth argument; geom_density() has a bw argument.

library(shiny)
library(ggplot2)

base_plot <- ggplot(diamonds, aes(carat))

ui <- fluidPage(
  
  selectInput("geom", "Select a geom to display carat",
              choices = c("histogram", "freqpoly", "density"),
              selected = character()),
  
  tabsetPanel(
    id = "select",
    type = "hidden",
    
    tabPanel("binwidth",
             numericInput("binwidth_value", "Binwidth", value = 0.5)),
    tabPanel("bw",
             numericInput("bw_value", "bw", value = 1))
  ),
  
  actionButton("show","Display Plot"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  
  observeEvent(input$geom,{
    updateTabsetPanel(session, "select", 
                      selected = ifelse(input$geom == "density", "bw", "binwidth"))
  })
  
  geom <- eventReactive(input$show, input$geom)
  bw_value <- eventReactive(input$show, input$bw_value)
  binwidth_value <- eventReactive(input$show, input$binwidth_value)
  
  output$plot <- renderPlot({
    
    if(geom() == "density") {
      final_plot <- base_plot + geom_density(bw = bw_value())
    }
    
    if(geom() == "histogram") {
      final_plot <- base_plot + geom_histogram(binwidth = binwidth_value())
    }
    
    if(geom() == "freqpoly") {
      final_plot <- base_plot + geom_freqpoly(binwidth = binwidth_value())
    }
    
    final_plot
    
  })
  
}

shinyApp(ui, server)