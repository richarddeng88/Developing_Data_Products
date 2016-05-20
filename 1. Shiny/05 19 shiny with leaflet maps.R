library(shiny);library(leaflet)
ui <- bootstrapPage(
    
    h2("richard's project"),
    leafletOutput("mymap", height="600")
    
)

server <- function(input, output){

    output$mymap <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%
            setView(lng=-74.00653609,lat = 40.70955958,zoom = 14) %>%
            addMarkers(lng=-74.00653609,lat = 40.70955958,popup="hallo, richard!!")
        
        
    })
    
    zipsInBounds <- reactive({
        if (is.null(input$map_bounds))
            return(zipdata[FALSE,])
        bounds <- input$map_bounds
        latRng <- range(bounds$north, bounds$south)
        lngRng <- range(bounds$east, bounds$west)
        
        print bounds
    })
    
}

shinyApp(ui=ui, server = server)