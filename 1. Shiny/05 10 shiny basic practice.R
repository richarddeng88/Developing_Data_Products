library(shiny)
ui <- fluidPage(
    
    titlePanel(h1("Richard's shiny parctice 05/11/2016", align="center")),
    
    sidebarLayout(
            sidebarPanel(  
                    
                    
                    h3("Choose the dist type"),
                    actionButton("norm","Normal distribution"),
                    actionButton("unif","Uniform"),
                    
                    h3("choose and click update"),
                    sliderInput("num", "choose a number", min=1, max=10000, value=2000, step = 5),
                    sliderInput("bin","choose the bin", min=20,max=100, value=50,step=2),
                    actionButton("go", "update"),
                    
                    actionButton("click","click me")
                        ),
            
        
            mainPanel(
                a(href="http://www.github.com/richarddeng88/citibike","my github code link"),br(),
                em("this is my practice for interface style"),br(),
                strong("this is strong case!"),br(),
                code("This is a Shiny app."),br(),
                p("This is a",tags$strong("Shiny"),"app."),
                img(height = 100,width = 280,src = "http://www.rstudio.com/images/RStudio.2x.png"),hr(),
                
                plotOutput("type"),
                plotOutput("hist")

                    )
                )
)

server <- function(input, output){
    
    rv <- reactiveValues(data=rnorm(100)) #
    observeEvent(input$norm, {rv$data <- rnorm(10000)})
    observeEvent(input$unif, {rv$data <- runif(10000)})
    output$type <- renderPlot({hist(rv$data, breaks=28)})
    
    
    data <- eventReactive(input$go ,{hist(rnorm(input$num),breaks=input$bin)})
    output$hist <- renderPlot({data()})
    click <- observeEvent(input$click, {print(as.numeric(input$click))})
    
}


shinyApp(ui=ui, server=server)