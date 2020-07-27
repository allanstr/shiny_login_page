library(shiny)

## Data frame for usernames and passwords
user_key <- data.frame(username = c("login1", "login2"),
                       secret = c("pass1", "pass2"))


#  Login page (first UI) ----------------------------------------------------------------------------------

ui1 <- fluidPage(
  
  div(id = "header",
      h1("Login page"),
      align = "center"
  ),
  
  div(id = "loginpage",
      
      fluidRow(
        br(),br(),br(),
        h4("Username and password", align = "center")
      ),
      
      fluidRow(
        column(
          width = 4, 
          offset = 4,
          wellPanel(
            textInput(inputId = "user", label = "User", placeholder = "User"),
            passwordInput(inputId = "pass", label = "Password", placeholder = "Password"),
            actionButton(inputId = "login", "Login")
          )
        ) 
      ),
      
      fluidRow(
        column(width = 4, offset = 4, span(textOutput("loginfail"), style='color:red'))
      ),
      
      fluidRow(HTML(paste0("<code>1) user/pass: login1/pass1</code>")),
               br(),
               HTML(paste0("<code>2) user/pass: login2/pass2</code>")),
               align = "center")
  )
)


# Page to be accessed (second UI) -----------------------------------------------------------------------

ui2 <- navbarPage("My page",
  
  selected = "First tab",
  
  tabPanel("First tab",
           
    h3("Hello World")
                  
  ),
  
  navbarMenu("...",
    
    tabPanel(
      
      title = "Another tab"
      
    ),
    
    tabPanel(
      
      title = "One more tab"
      
    )
  )
)


# Server ------------------------------------------------------------------

server <- function(input, output) {
  
  ## Server for login page (UI1) ------------------------------------------------------
  
  observeEvent(input$login, {
    
    x <- match(input$user, user_key$username)
    
    if(is.na(x) | input$pass != user_key$secret[x]){
      
      output$loginfail <- renderText("Username and password do not match")
      
    } else {
      
      removeUI(selector = "#loginpage")
      
      insertUI("#header", "beforeBegin", ui = ui2)
      
      removeUI(selector = "#header")
      
    }
    
  })
  
  ## Server for page after login (UI2) -------------------------------------------------
  
  
}


# Run app ---------------------------------------------------------------------------------------

shinyApp(ui = ui1, server = server)