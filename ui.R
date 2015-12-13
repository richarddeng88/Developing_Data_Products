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