# Plot a wordcloud to summarise the tags that a stack-overflow user tends to
# answer/ask about

# In app-01.R, the app showed a wordcloud for a stack overflow user, based on
# the score that user has received for their answers to questions related to a
# specific stackoverflow-tag. It had a single-page interface.
#
# This app is an extension of that app
#
# Based on the learning objectives in the "Layouts, themes, HTML" chapter we:
# - added a multipanel layout (two tabPanels in a tabsetPanel):
#   - panel 1: the original wordcloud
#   - panel 2: the table from which the wordcloud was generated
# - changed the colourscheme to be more in-keeping with the stack-overflow
# colour scheme
#   - both the palette for the wordcloud and the app-theme were modified
#
# Differences between this app and app-01.R are highlighted (don't comment this
# liberally in production code :0) )

# -- NEW: required to manipulate the stack overflow dataset
#
library(dplyr)

library(shiny)
library(wordcloud)
library(stackr)

# Constants
# NEW:
# -- the colours were obtained by inspecting the CSS for the stackoverflow site
# -- `palette` is used to set the colour-scheme in the wordcloud to match that
# for the stackoverflow site
# -- `theme` is used to match the colour-scheme of the app with that of stack
# overflow

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

# -- NEW: this helper was introduced to ensure the newly-added answers table is
# ordered from the tag with the highest to the lowest score
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

# Define UI for application that plots information about a user's stack
# overflow presence

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
      # -- NEW: replaced the single-panel layout of the original app with a
      # two-panel layout (word-cloud in the first panel, answer-table in the
      # second)
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

  # -- NEW: this is the data from which the word-cloud was produced, it was
  # added so that a user can get more detailed information
  output$answer_table <- renderTable(
    format_answer_score_table(stack_data())
  )
}

# Run the application
shinyApp(ui = ui, server = server)
