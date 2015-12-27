library(shiny);library(ISLR);library(MASS)
auto =Auto
names(auto)[c(2,4,5)] <- c("cyl","hp","wt")
# auto$cyl <- log(auto$cyl); auto$hp <- log(auto$hp); auto$wt <- log(auto$wt)

modelFit <- lm(mpg ~ log(hp) + log(cyl) + log(wt), data=auto)


mpg <- function(hp, cyl, wt) {
        modelFit$coefficients[1] + modelFit$coefficients[2] * log(hp) + 
                modelFit$coefficients[3] * log(cyl) + modelFit$coefficients[4] * log(wt)
}

shinyServer(
        function(input, output) {
                adjusted_weight <- reactive({input$wt})
                predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adjusted_weight())})
                output$inputValues <- renderPrint({paste(input$hp, "horsepower, ",
                                                         input$cyl, "cylinders, ",
                                                         input$wt, "lbs")})
                output$prediction <- renderPrint({paste("your prediciont is", round(predicted_mpg(), 2), "miles per gallon")})
                output$plots <- renderPlot({
                        par(mfrow = c(1, 3))
                        # (1, 1)
                        with(auto, plot(hp, mpg,
                                          xlab='Gross horsepower',
                                          ylab='MPG',
                                          main='MPG vs horsepower'))
                        points(input$hp, predicted_mpg(), col='red',pch=20, cex=3)                 
                        # (1, 2)
                        with(auto, plot(cyl, mpg,
                                          xlab='Number of cylinders',
                                          ylab='MPG',
                                          main='MPG vs cylinders'))
                        points(as.numeric(input$cyl), predicted_mpg(), col='red',pch=20, cex=3)  
                        # (1, 3)
                        with(auto, plot(wt, mpg,
                                          xlab='Weight (lb/1000)',
                                          ylab='MPG',
                                          main='MPG vs weight'))
                        points(adjusted_weight(), predicted_mpg(), col='red',pch=20, cex=3)  
                })
        }
)