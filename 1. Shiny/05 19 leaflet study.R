library(leaflet)

mymap <- leaflet()
mymap <- addTiles(mymap) # by default this using OSM base map

# mymap <- leaflet() %>% addTiles()

#mymap <- leaflet()
#mymap <- addProviderTiles(mymap, provider = "CartoDB.Position")

## adding markers
mymap <- setView(mymap,lng=-74.00653609,lat = 40.70955958,zoom = 4)
mymap <- addMarkers(mymap,lng=-74.00653609,lat = 40.70955958, popup = "welcom, Richard!" )

## save mymap into a html
library(htmlwidgets)
saveWidget(mymap, file = "mymap.html")


## add some ciclr to a map
df <- data.frame(Lat=1:10, Long= rnorm(10))
leaflet(df) %>% addCircles()
leaflet() %>% addCircles(data = df)

library(maps)
states <- map("state", fill=T, plot=F)
leaflet(data=states) %>% addTiles() %>% 
    addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = F)


## adding markers
df <- quakes
leaflet(df[1:20,]) %>% addTiles() %>%
    addMarkers(~long, ~lat, popup= ~as.character(mag))
    
leaflet(df[1:20,]) %>% addTiles() %>%
    addMarkers(~long, ~lat,clusterOptions= markerClusterOptions())
    
leaflet(df[1:20,]) %>% addTiles() %>%
    addCircleMarkers(~long, ~lat)

# Create a palette that maps factor levels to colors
pal <- colorFactor(c("navy", "red"), domain = c("ship", "pirate"))

leaflet(df) %>% addTiles() %>%
    addCircleMarkers(
        radius = ~ifelse(type == "ship", 6, 10),
        color = ~pal(type),
        stroke = FALSE, fillOpacity = 0.5
    )



























