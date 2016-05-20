library(shiny);library(shinydashboard)
library(leaflet)

ui <- dashboardPage(skin = "purple", 
                    
                    dashboardHeader(title= "NYC Citibike Ridership Project",titleWidth=400,
                                    
                                    dropdownMenu(type = "messages",
                                                 messageItem(
                                                     from = "Sales Dept",
                                                     message = "Sales are steady this month."
                                                 )
                                    ),
                                    
                                    
                                    dropdownMenu(type = "notifications",
                                                 notificationItem(
                                                     text = "5 new users today",
                                                     icon("users")
                                                 )
                                    ),
                                    
                                    
                                    dropdownMenu(type = "tasks", badgeStatus = "success",
                                                 taskItem(value = 90, color = "green",
                                                          "Documentation"
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
                                     href = "https://github.com/richarddeng88/citibike"),
                            sidebarUserPanel("good")
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
                                            sliderInput("slider", "Number of observations:", 1, 100, 50),
                                            sliderInput("slider", "Number of observations:", 1, 100, 50)
                                        ),
                                        infoBox("new",20,icon=icon("credit card"))
                                    
                                    )
                            ),
                            
                            # Second tab content
                            tabItem(tabName = "modeling",
                                    h2("Widgets tab content")
                            ),
                            
                            
                            # Third tab content
                            tabItem(tabName = "geo",
                                    h2("Geographic tab content"),
                                    bootstrapPage("Interactive map",
                                             div(class="outer",
                                                 
                                                 tags$head(
                                                     # Include our custom CSS
                                                     includeCSS("styles.css"),
                                                     includeScript("gomap.js")),
                                                 
                                                 leafletOutput("map", width="100%", height="100%"),
                                                 
                                                 # Shiny versions prior to 0.11 should use class="modal" instead.
                                                 absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                                               draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                                               width = 330, height = "auto",
                                                               
                                                               h2("ZIP explorer"),
                                                               sliderInput("a","ad",1,49,2)
                                                               
                                                               #selectInput("color", "Color", vars),
                                                               #selectInput("size", "Size", vars, selected = "adultpop"),
                                                               #conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                                                                                # Only prompt for threshold when coloring or sizing by superzip
                                                               #                 numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                                                               )
                                                               
                                                               #plotOutput("histCentile", height = 200),
                                                               #plotOutput("scatterCollegeIncome", height = 250)
                                                 ),
                                                 
                                                 tags$div(id="cite",
                                                          'Data compiled for ', 
                                                          tags$em('Coming Apart: The State '), ' by Richard (Crown Forum, 2012).')
                                             

                                                )
                                    
                                            )
                                    )
                        
                        
                             )
                    )
                    
                    
                    
                    
                    
                    

server <- function(input, output) { 
    
    # create a map
    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
            ) %>%
            setView(lng = -93.85, lat = 37.45, zoom = 5) %>%
            addMarkers(lng=-74.00653609,lat = 40.70955958,popup="hallo, richard!!")
    })
    
    
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    
}




shinyApp(ui=ui, server=server)
