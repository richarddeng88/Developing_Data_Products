# ui 1
shinyUI(pageWithSidebar(
    headerPanel("Illustrating inputs"),
    sidebarPanel(
        numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
        checkboxGroupInput("id2", "Checkbox",
                           c("Value 1" = "1",
                             "Value 2" = "2",
                             "Value 3" = "3")),
        dateInput("date", "Date:")
    ),
    mainPanel(
    )
))



library(shiny)
shinyServer(
    function(input, output) {
        output$oid1 <- renderPrint({input$id1})
        output$oid2 <- renderPrint({input$id2})
        output$odate <- renderPrint({input$date})
    }
)

##################################### ui 2 - prediction example######################################
library(shiny)
shinyUI(
    pageWithSidebar(
        
        # Application title
        headerPanel("Diabetes prediction"),
        
        sidebarPanel(
            numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
            submitButton('Submit, please click')
        ),
        
        mainPanel(
            h3('Results of prediction'),
            h4('You entered'),
            verbatimTextOutput("inputValue"), # give the input value
            
            h4('Which resulted in a prediction of '),
            verbatimTextOutput("prediction")  # give the ouput value
        )
    )
)



library(shiny)

diabetesRisk <- function(glucose) {sqrt(glucose) / 200}

shinyServer(
    function(input, output) {
        output$inputValue <- renderPrint({input$glucose})
        output$prediction <- renderPrint({diabetesRisk(input$glucose)})
    }
)



##################################### 3 - creating an image plot ######################################
library(shiny)
shinyUI(pageWithSidebar(
    
    headerPanel("Example plot"), #Create a header panel
    
    ## Constructs a slider widget to select a numeric value from a range.
    sidebarPanel(
        sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05)
    ),  
    
    
    mainPanel(
        plotOutput('newHist') #Create an plot or image output element
    ) 
))




library(UsingR)
data(galton)

shinyServer(
    function(input, output) {
        output$newHist <- renderPlot({
            hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
            mu <- input$mu
            lines(c(mu, mu), c(0, 200),col="red",lwd=5)
            mse <- mean((galton$child - mu)^2)
            text(63, 150, paste("mu = ", mu))
            text(63, 140, paste("MSE = ", round(mse, 2)))
        })
    }
)


##################################### 4- asd ######################################




