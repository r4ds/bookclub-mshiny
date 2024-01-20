
# 4.
# Add support for date and date-time columns make_ui() and filter_var().


library(shiny)

# Select slider or drop down list based on variable data type

define_input_option <- function(df_col, id_name_label) {
  
  if (is.numeric(df_col)) {
    
    rng <- range(df_col, na.rm = TRUE)
    
    sliderInput(id_name_label, 
                id_name_label, 
                min = rng[1], max = rng[2],  
                value = rng) # By default keeping all variables
    
  } else if (is.factor(df_col)) {
    
    levs <- levels(df_col)
    
    selectInput(id_name_label,
                id_name_label,
                choices = levs,
                selected = levs,  # By default keeping all variables
                multiple = TRUE)
    
  } else if (class(df_col) == "Date") {
    
    rng <- range(df_col, na.rm = TRUE)
    
    dateRangeInput(id_name_label,
                   id_name_label,
                   start = rng[1], 
                   end = rng[2],
                   min = rng[1], max = rng[2])
    
  } else {
    # Not supported
    NULL
  }
  
}


validate_col_var <- function(df_col, input_values) {
  
  if (is.numeric(df_col) | class(df_col) == "Date") {
    
    # For numeric we need to validate an interval
    !is.na(df_col) & df_col >= input_values[1] & df_col <= input_values[2]
  
  } else if (is.factor(df_col)) {
    
    # For factors we need to validate elements
    df_col %in% input_values
  
  } else {
    
    # No control, so don't filter
    TRUE
    
  }
  
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
    data.frame(a = seq.Date(as.Date("2024-01-01"), length.out = 12, by =  "months"),
               b = letters[1:12],
               c = 1:12)
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