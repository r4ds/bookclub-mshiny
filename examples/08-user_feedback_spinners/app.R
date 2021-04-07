library(shiny)
# Spinners

ui <- fluidPage(
  waiter::use_waiter(),
  actionButton("go", "go"),
  plotOutput("plot"),
  actionButton("go2", "go2"),
  plotOutput("plot2"),
  actionButton("go3", "go3"),
  plotOutput("plot3"),
  actionButton("go4", "go4"),
  plotOutput("plot4"),
)

# ?waiter::spinners

server <- function(input, output, session) {
  data <- eventReactive(input$go, {
    waiter::Waiter$new(id = "plot")$show()
    Sys.sleep(3)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot <- renderPlot(plot(data()), res = 96)
  
  data2 <- eventReactive(input$go2, {
    waiter::Waiter$new(id = "plot2", html = spin_folding_cube())$show()
    Sys.sleep(3)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot2 <- renderPlot(plot(data2()), res = 96)
  
  data3 <- eventReactive(input$go3, {
    waiter::Waiter$new(id = "plot3", html = spin_hexdots())$show()
    Sys.sleep(3)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot3 <- renderPlot(plot(data3()), res = 96)
  
  data4 <- eventReactive(input$go4, {
    waiter::Waiter$new(id = "plot4", html = spin_heartbeat())$show()
    Sys.sleep(3)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot4 <- renderPlot(plot(data4()), res = 96)
  
  
}

shinyApp(ui = ui, server = server)