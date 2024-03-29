library(shiny)

# dataframe that holds usernames, passwords and other user data
user_base <- dplyr::tibble(
  user = c("user1", "user2"),
  password = c("pass1", "pass2"),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)

# instead of storing credentials inside the source app, save them in a 
# .yml file using the config package to retrive them
config <- config::get(file = "examples/22-security_shinyauthr/conf/config.yml")
config$user
config$password

user_base_config <- dplyr::tibble(
  user = config$user,
  password = config$password,
  permissions = "admin",#c("admin", "standard"),
  name = "User One" #c("User One", "User Two")
)



ui <- fluidPage(
  # add logout button UI
  div(class =  "pull-right",
      shinyauthr::logoutUI(
        id = "logout")),
  # add login panel UI function
      shinyauthr::loginUI(
        id = "login"),
  # setup table output to show user info after login
  tableOutput("user_table")
)




server <- function(input, output, session) {
  # call login module supplying data frame, 
  # user and password cols and reactive trigger
  credentials <- shinyauthr::loginServer(
    id       = "login",
    data     = user_base_config,
    user_col = user,
    pwd_col  = password,
    log_out  = reactive(logout_init())
  )
  
  # call the logout module with reactive trigger to hide/show
  logout_init <- shinyauthr::logoutServer(
    id = "logout",
    active = reactive(credentials()$user_auth)
  )
  
  output$user_table <- renderTable({
    # use req to only render results when credentials()$user_auth is TRUE
    req(credentials()$user_auth)
    credentials()$info
  })
}

shinyApp(ui = ui, server = server)
