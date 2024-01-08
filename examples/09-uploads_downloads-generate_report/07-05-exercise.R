
# The final app in Section 9.3 contains this one large reactive:
# Break it up into multiple pieces so that 
# (e.g.) janitor::make_clean_names() is 
# not re-run when input$empty changes.

library(shiny)

# Uploading and parsing the file

ui_upload <- sidebarLayout(
  sidebarPanel(
    fileInput("file", "Data", buttonLabel = "Upload..."),
    textInput("delim", "Delimiter (leave blank to guess)", ""),
    numericInput("skip", "Rows to skip", 0, min = 0),
    numericInput("rows", "Rows to preview", 5, min = 1)
  ),
  mainPanel(
    h3("Raw data"),
    tableOutput("preview1")
  )
)


# Cleaning the file

ui_clean <- sidebarLayout(
  sidebarPanel(
    checkboxInput("snake", "Rename columns to snake case?"),
    checkboxInput("constant", "Remove constant columns?"),
    checkboxInput("empty", "Remove empty cols?")
  ),
  mainPanel(
    h3("Cleaner data"),
    tableOutput("preview2")
  )
)

# Downloading the file

ui_download <- fluidRow(
  column(
    width = 12, 
    downloadButton("download", class = "btn-block")
  )
)

# Get assembled

ui <- fluidPage(
  ui_upload,
  ui_clean,
  ui_download
)



server <- function(input, output, session) {
  # Upload ---------------------------------------------------------
  raw <- reactive({
    req(input$file)
    delim <- if (input$delim == "") NULL else input$delim
    vroom::vroom(input$file$datapath, delim = delim, skip = input$skip)
  })
  output$preview1 <- renderTable(head(raw(), input$rows))
  
  # Clean ----------------------------------------------------------
  
  cleaned_names <- reactive({
    out <- raw()
    if (input$snake) {
      names(out) <- janitor::make_clean_names(names(out))
    }
    out
  })
  
  no_empty <- reactive({
    out <- cleaned_names()
    if (input$empty) {
      out <- janitor::remove_empty(out, "cols")
    }
    out
  })
  
  no_const <- reactive({
    out <- no_empty()
    if (input$constant) {
      out <- janitor::remove_constant(out)
    }
    out
  })

  output$preview2 <- renderTable(head(no_const(), input$rows))
  
  # Download -------------------------------------------------------
  output$download <- downloadHandler(
    filename = function() {
      # Remove current extension
      paste0(tools::file_path_sans_ext(input$file$name), ".tsv")
    },
    content = function(file) {
      vroom::vroom_write(tidied(), file)
    }
  )
}

shinyApp(ui, server)