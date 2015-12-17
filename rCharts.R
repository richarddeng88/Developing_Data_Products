require(devtools)
# install_github('rCharts', 'ramnathv')
require(rCharts)

## Example 1 Facetted Scatterplot
names(iris) = gsub("\\.", "", names(iris))
rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')

## Example 2 Facetted Barplot
hair_eye = as.data.frame(HairEyeColor)
rPlot(Freq ~ Hair | Eye, color = 'Sex', data = hair_eye, type = 'bar')

#n1 <- rPlot(Freq ~ Hair, group = "Eye", type="multiBarChart", data = subset(hair_eye, Sex=="Male"))


dTable(airquality, sPaginationType = "full_numbers")