
# 5.
# (Advanced) If you know the S3 OOP system, consider 
# how you could replace the if blocks in make_ui() 
# and filter_var() with generic functions.


library(shiny)

# Select slider or drop down list based on variable data type

define_input_option <- function(df_col, id_name_label) {
  
  UseMethod("define_input_option")
  
}

define_input_option.default <- function(df_col, id_name_label) {
  # Not supported
  NULL
}

define_input_option.numeric <- function(df_col, id_name_label) {
  
  rng <- range(df_col, na.rm = TRUE)
  
  sliderInput(id_name_label, 
              id_name_label, 
              min = rng[1], max = rng[2],  
              value = rng) # By default keeping all variables
  
}

define_input_option.factor <- function(df_col, id_name_label) {
  
  levs <- levels(df_col)
  
  selectInput(id_name_label,
              id_name_label,
              choices = levs,
              selected = levs,  # By default keeping all variables
              multiple = TRUE)
  
}


define_input_option.Date <- function(df_col, id_name_label) {
  
  rng <- range(df_col, na.rm = TRUE)
  
  dateRangeInput(id_name_label,
                 id_name_label,
                 start = rng[1], 
                 end = rng[2],
                 min = rng[1], 
                 max = rng[2])
  
}

validate_col_var <- function(df_col, input_values) { 

  UseMethod("validate_col_var")
    
}


validate_col_var.default <- function(df_col, input_values) { 
  
  TRUE
  
}

validate_col_var.default <- function(df_col, input_values) { 
  
  TRUE
  
}


validate_col_var.numeric <- function(df_col, input_values) { 
  
  # For numeric we need to validate an interval
  !is.na(df_col) & df_col >= input_values[1] & df_col <= input_values[2]
  
}

validate_col_var.Date <- function(df_col, input_values) { 
  
  # For numeric we need to validate an interval
  !is.na(df_col) & df_col >= input_values[1] & df_col <= input_values[2]
  
}

validate_col_var.factor <- function(df_col, input_values) { 
  
  # For factors we need to validate elements
  df_col %in% input_values
  
}


dfs <- Filter(x = ls("package:datasets"),
              f = \(x) is.data.frame(get(x, "package:datasets")))

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", label = "Dataset", choices = dfs),
      uiOutput("filter")
    ),
    mainPanel(
      tableOutput("data")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  col_names <- reactive(names(data()))
  
  output$filter <- renderUI(
    lapply(col_names(), 
           \(x) define_input_option(data()[[x]], x))
  )
  
  selected <- reactive({
    
    lapply(col_names(),
           \(x) validate_col_var(data()[[x]], input[[x]])) |>
    Reduce(f = `&`)
    
  })
  
  output$data <- renderTable(head(data()[selected(), ], 12))
}


shinyApp(ui, server)