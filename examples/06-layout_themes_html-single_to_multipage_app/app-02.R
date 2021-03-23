# Plot a wordcloud to summarise the tags that a stack-overflow user tends to
# answer/ask about

# Made from app-01.R
# - Added table of top-answers, sorted by cumulative answer-score
# - Added helper functions for converting the stack-overflow table to plots /
# tables

library(dplyr)
library(shiny)
library(wordcloud)
library(stackr)

# Helper functions

format_answer_score_table <- function(df) {
  df %>%
    dplyr::select(tag_name, answer_count, answer_score) %>%
    dplyr::filter(answer_count > 0) %>%
    dplyr::arrange(dplyr::desc(answer_score))
}

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
      plotOutput("word_cloud"),
      tableOutput("answer_table")
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

  output$answer_table <- renderTable(
    format_answer_score_table(stack_data())
  )
}

# Run the application
shinyApp(ui = ui, server = server)
