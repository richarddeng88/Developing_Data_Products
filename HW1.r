# Q1
library(manipulate)
myPlot <- function(s) {
    plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
    abline(0, s)
}
manipulate(myPlot(s), s = slider(0, 2, step = 0.05))

# Q2
library(rCharts)
dTable(airquality, sPaginationType = "full_numbers")












