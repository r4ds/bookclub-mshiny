# Plot a wordcloud to summarise the tags that a stack-overflow user tends to
# answer/ask about

# Made from app-03.R

library(dplyr)
library(shiny)
library(wordcloud)
library(stackr)

# Constants

colours <- c(
  "orange" = "#f48024",
  "green" = "#5eba7d",
  "blue" = "#0077cc",
  "black" = "#0c0d0e",
  "grey" = "#d6d9dc",
  "white" = "#fff"
)

so_palette <- grDevices::colorRampPalette(colours[1:2])(6)

theme <- bs_theme(
  fg = colours["black"],
  bg = colours["white"],
  primary = colours["blue"],
  secondary = colours["grey"]
)

# Helper functions

format_answer_score_table <- function(df) {
  df %>%
    dplyr::select(tag_name, answer_count, answer_score) %>%
    dplyr::filter(answer_count > 0) %>%
    dplyr::arrange(dplyr::desc(answer_score))
}

make_word_cloud <- function(df, palette) {
  with(
    df,
    wordcloud::wordcloud(
      words = tag_name,
      freq = answer_score,
      min.freq = 0,
      colors = palette,
      scale = c(10, 0.5)
    )
  )
}

# Define UI for application that plots information about a user's stack overflow
# presence

ui <- fluidPage(
  theme = theme,

  # Application title
  titlePanel("Stack Overflow: User Statistics"),

  # Sidebar for selecting which Stack Overflow user's data is presented
  sidebarLayout(
    sidebarPanel(
      textInput("user_id", "Select a Stack Overflow user ID:", "1845650")
    ),

    # Show a plot of a wordcloud and table of the user's answer-tags
    mainPanel(
      tabsetPanel(
        tabPanel("Word Cloud", plotOutput("word_cloud")),
        tabPanel("Answer Table", tableOutput("answer_table"))
      )
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
    make_word_cloud(stack_data(), so_palette)
  )

  output$answer_table <- renderTable(
    format_answer_score_table(stack_data())
  )
}

# Run the application
shinyApp(ui = ui, server = server)
