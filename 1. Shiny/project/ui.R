library(shiny)
shinyUI(pageWithSidebar(
        headerPanel('Course Project - Predicting Miles Per Gallon(MPG)'),
        
        sidebarPanel(
                h3('Introduction'),
                p('Apply new algorithms to the Automobile data for prediction.'),
                h3('Please choose the values of predictors below.'),
                
                sliderInput('hp', 'Gross horsepower:', value= 140, min = 50, max = 350, step = 5), 
                radioButtons('cyl', 'Number of cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'),
                sliderInput('wt', 'Weight (lbs):',value= 3200, min = 1500, max = 5500, step = 100),
                submitButton("submit!")
                
                ),
        
        mainPanel(
                h6('Course Project by Richard, 12/27/2015'),
                h3('Predicted MPG'),
                h4('You entered:'),
                verbatimTextOutput("inputValues"),
                
                h4('Which resulted in a prediction of:'),
                verbatimTextOutput("prediction"),
                
                h4('MPG relative to cars in mtcars data set'),
                plotOutput('plots'),
                
                h3('Method'),
                p('multipul linear regression model is adopted to Auto data set from "ISLR" package.'),
                h5('References'),
                p('Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391-411.')
                )
        ))