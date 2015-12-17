
# the code is not working

suppressPackageStartupMessages(library(googleVis))
m <- gvisMotionChart(Fruits, "Fruit","Year", options = list(width=600, height=400))
print(m, "chart")


g <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", 
                  options = list(width=600, height=400))
print(g, "chart")

