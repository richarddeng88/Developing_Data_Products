# install.packages("plotly")
library(plotly);library(ggplot2)
# We can publish our charts to the web with plotly's web service. 
# Here to set up your account in R session.
Sys.setenv("plotly_username"="richarddeng88")
Sys.setenv("plotly_api_key"="cqs8spryhx")

# sample 1
plot_ly(midwest, x = percollege, color = state, type = "box")

# sample 2
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(d, x = carat, y = price, text = paste("Clarity: ", clarity),
        mode = "markers", color = carat, size = carat)


# sample 3 - ggplot2
p <- ggplot(data = d, aes(x = carat, y = price)) +
    geom_point(aes(text = paste("Clarity:", clarity)), size = 4) +
    geom_smooth(aes(colour = cut, fill = cut)) + facet_wrap(~ cut)

gg <- ggplotly(p)

# sample 4 - with a matrix
plot_ly(z = volcano, type = "surface")

# sample 5 - publish your chart
library(plotly)
p <- plot_ly(midwest, x = percollege, color = state, type = "box")
# plotly_POST publishes the figure to your plotly account on the web
plotly_POST(p, filename = "r-docs/midwest-boxplots", world_readable=TRUE)


# test
p <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species)) + geom_point()
gg <- ggplotly(p)
