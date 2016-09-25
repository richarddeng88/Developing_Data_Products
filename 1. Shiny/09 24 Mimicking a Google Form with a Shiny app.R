library(shiny)
library(shinyjs)

fieldsMandatory <- c("name", "favourite_pkg")

ui <- fluidPage(
    titlePanel("Mimicking a Google Form with a Shiny app"),
    div(
        id = "form",
        
        textInput("name", "Name", ""),
        textInput("favourite_pkg", "Favourite R package"),
        checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
        sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
        selectInput("os_type", "Operating system used most frequently",
                    c("",  "Windows", "Mac", "Linux")),
        actionButton("submit", "Submit", class = "btn-primary")
    )
)

server <- function(input, output, session) {
    
    observe({
        # check if all mandatory fields have a value
        mandatoryFilled <-
            vapply(fieldsMandatory,
                   function(x) {
                       !is.null(input[[x]]) && input[[x]] != ""
                   },
                   logical(1))
        mandatoryFilled <- all(mandatoryFilled)
        
        # enable/disable the submit button
        shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
        
        
    })
    
}

shinyApp(ui=ui, server=server)
