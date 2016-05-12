library(shiny);library(shinydashboard)

ui <- dashboardPage(skin = "purple",
    
    dashboardHeader(title= "Citi Bike Ridership",
                    
                    dropdownMenu(type = "messages",
                                 messageItem(
                                     from = "Sales Dept",
                                     message = "Sales are steady this month."
                                 ),
                                 messageItem(
                                     from = "New User",
                                     message = "How do I register?",
                                     icon = icon("question"),
                                     time = "13:45"
                                 ),
                                 messageItem(
                                     from = "Support",
                                     message = "The new server is ready.",
                                     icon = icon("life-ring"),
                                     time = "2014-12-01"
                                 )
                    ),
                    
                    
                    dropdownMenu(type = "notifications",
                                 notificationItem(
                                     text = "5 new users today",
                                     icon("users")
                                 ),
                                 notificationItem(
                                     text = "12 items delivered",
                                     icon("truck"),
                                     status = "success"
                                 ),
                                 notificationItem(
                                     text = "Server load at 86%",
                                     icon = icon("exclamation-triangle"),
                                     status = "warning"
                                 )
                    ),
                    
                    
                    dropdownMenu(type = "tasks", badgeStatus = "success",
                                 taskItem(value = 90, color = "green",
                                          "Documentation"
                                 ),
                                 taskItem(value = 17, color = "aqua",
                                          "Project X"
                                 ),
                                 taskItem(value = 75, color = "yellow",
                                          "Server deployment"
                                 ),
                                 taskItem(value = 80, color = "red",
                                          "Overall project"
                                 )
                    )
                    
                    ),
   
    
    sidebar <- dashboardSidebar(
        sidebarMenu(
            sidebarSearchForm(textId = "searchText", buttonId = "searchButton",label = "Search..."),
            menuItem("Geo",tabName = "geo",icon=icon("calendar")),
            menuItem("Exploratory Analysis", tabName = "eda", icon = icon("dashboard")),
            menuItem("Modeling", tabName = "modeling", icon = icon("th"),badgeLabel = "new", badgeColor = "green"),
            menuItem("Source code", icon = icon("file-code-o"), 
                     href = "https://github.com/richarddeng88/citibike")
        )
    ),
    
    
    
    
    body <- dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "eda",
                    fluidRow(
                        box(plotOutput("plot1", height = 250)),
                        
                        box(
                            title = "Controls",
                            sliderInput("slider", "Number of observations:", 1, 100, 50)
                        )
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "modeling",
                    h2("Widgets tab content")
            ),
            
            
            # Third tab content
            tabItem(tabName = "geo",
                    h2("Geographic tab content")
            )
        )
        
    
    )
    
    
    
    
    
    
)

server <- function(input, output) { 
    
        set.seed(122)
        histdata <- rnorm(500)
        
        output$plot1 <- renderPlot({
            data <- histdata[seq_len(input$slider)]
            hist(data)
        })
        
    }



shinyApp(ui=ui, server=server)
