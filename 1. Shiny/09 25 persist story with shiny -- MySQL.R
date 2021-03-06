library(shiny)
library(RMySQL)

####### create a db and tabe in MySQL 
# create table responses (
#     name varchar(40),
#     used_shiny varchar(30),
#     r_num_years int
# );

options(mysql = list(
    "host" = "127.0.0.1",
    "port" = 3306,
    "user" = "root",
    "password" = "1234"
))
databaseName <- "myshinydatabase"
table <- "responses"

saveData <- function(data) {
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    # Construct the update query by looping over the data fields
    query <- sprintf(
        "INSERT INTO %s (%s) VALUES ('%s')",
        table, 
        paste(names(data), collapse = ", "),
        paste(data, collapse = "', '")
    )
    # Submit the update query and disconnect
    dbGetQuery(db, query)
    dbDisconnect(db)
}

loadData <- function() {
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    # Construct the fetching query
    query <- sprintf("SELECT * FROM %s", table)
    # Submit the fetch query and disconnect
    data <- dbGetQuery(db, query)
    dbDisconnect(db)
    data
}

# Define the fields we want to save from the form
fields <- c("name", "used_shiny", "r_num_years")

# Shiny app with 3 fields that the user can submit data for
shinyApp(
    ui = fluidPage(
        DT::dataTableOutput("responses", width = 300), tags$hr(),
        textInput("name", "Name", ""),
        checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
        sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
        actionButton("submit", "Submit")
    ),
    server = function(input, output, session) {
        
        # Whenever a field is filled, aggregate all form data
        formData <- reactive({
            data <- sapply(fields, function(x) input[[x]])
            data
        })
        
        # When the Submit button is clicked, save the form data
        observeEvent(input$submit, {
            saveData(formData())
        })
        
        # Show the previous responses
        # (update with current response when Submit is clicked)
        output$responses <- DT::renderDataTable({
            input$submit
            loadData()
        })     
    }
)

