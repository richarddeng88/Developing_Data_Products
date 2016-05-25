library(shiny)
library(ggplot2)
library(dplyr)




ui <- fluidPage(
    
        
        mainPanel(
            tabsetPanel(type="tab",
                 tabPanel("test1"),
                        
                        
                 tabPanel("test2",
                                 
                     sidebarPanel(
                         dateRangeInput("date","Input date:",format = "yyyy-mm-dd",start="2013-07-01",end= "2016-03-31", 
                                        min = "2013-07-1",max = "2016-03-31"),
                         sliderInput("hour", "Hours of a day:", 1, 24, value = c(1, 24)),
                         radioButtons("weekday","Day", c("Weekday","Weekend")),
                         radioButtons("gender","Gender", c("Male","Female"))
                     ),
                     mainPanel(
                         verbatimTextOutput("summary"),
                         textOutput("date_start"),
                         textOutput("date_end"),
                         verbatimTextOutput("tt"),
                         plotOutput("plot")

                     )
                
            )
        )
        )
        
)
        




server <- function(input, output){
    
    
    output$summary <- renderPrint({
        print(paste("the starting date is",input$date[1], "the ending date is ",input$date[2]))
    })
    
        output$date_start <- renderText(paste("The starting date is: ", input$date[1]))
        output$date_end <- renderText(paste("The ending date is: ", input$date[2]))
    
    data<- reactive({
             dis <- switch(input$weekday,
                       "Weekday" = 1,
                       "Weekend" = 0)
             gen <- switch(input$gender,
                           "Male" = "male",
                           "Female" = "female")
             ff <- kk[kk$is_weekday==dis & kk$gender== gen & kk$hour>=input$hour[1] & kk$hour<=input$hour[2],]
             #filter(kk, is_weekday==dis)
             ff <- ff[ff$date>=input$date[1] & ff$date <= input$date[2],]
             ff %>% group_by(hour) %>% summarize(trips= sum(trips)) %>% 
                 mutate(timestamp_for_x_axis = as.POSIXct(hour * 3600, origin = "1970-01-01", tz = "UTC"))
             
    })
    
    
    output$plot <- renderPlot({
        
        bb <- data()
        ggplot(bb, aes(x=timestamp_for_x_axis, y=trips, color="blue"))+
            geom_bar(stat="identity",position="dodge",color="black") +
            scale_x_datetime("", labels = date_format("%l %p")) 
        
    })
    
}

shinyApp(ui=ui, server=server)



