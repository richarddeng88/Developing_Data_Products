library(shiny)

# USER INTERFACE
    ui <- fluidPage(
        sliderInput(inputId = "num",               # input name for internal use
                    label="choose a number",       # label to display 
                    value=300, min=1, max=1000),     # input specific argument
        
        numericInput(inputId = "number",
                     label = "type a number",
                     value=70, min=1,max=150),
        
        passwordInput(inputId = "PW",
                      label = "type your password"),
        
        # to display an output, add it here with an output function 
        plotOutput(outputId = "hist")
    )
    
    
# SERVER CODE  - use the server function to assemble inputs to outputs
    # Follow 3 rules: 1. save the output that you build to output$
                    # 2. build the output with a render() function
                    # 3. access input values with input$
    server <- function(input, output) {
        
        output$hist <- renderPlot({
            plot(rnorm(input$num,0,1),pch=20)
            #hist(iris$Sepal.Length)
        a})
        
    }


# APPRUN()    
    shinyApp(ui=ui, server=server)
    
    
    