# Plot a wordcloud to summarise the tags that a stack-overflow user tends to
# answer/ask about

library(shiny)
library(wordcloud)
library(stackr)

# Helper functions

make_word_cloud <- function(df) {
  with(
    df,
    wordcloud::wordcloud(
      words = tag_name,
      freq = answer_score,
      min.freq = 0,
      colors = RColorBrewer::brewer.pal(6, "Purples")[-1],
      scale = c(10, 0.5)
    )
  )
}

# Define UI for application that plots information about a user's stack
# overflow presence

ui <- fluidPage(

  # Application title
  titlePanel("Stack Overflow: User Statistics"),

  # Sidebar for selecting which Stack Overflow user's data is presented
  sidebarLayout(
    sidebarPanel(
      textInput("user_id", "Select a Stack Overflow user ID:", "1845650")
    ),

    # Show a plot of a wordcloud of the user's answer-tags
    mainPanel(
      plotOutput("word_cloud")
    )
  )
)

# Define server logic required to obtain data from stack-overflow and draw a
# wordcloud
server <- function(input, output) {
  stack_data <- reactive(
    stackr::stack_users(input[["user_id"]], "top-tags"),
  )

  output$word_cloud <- renderPlot(
    make_word_cloud(stack_data())
  )
}

# Run the application
shinyApp(ui = ui, server = server)
