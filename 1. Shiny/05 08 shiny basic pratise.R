library(shiny)
ui <- fluidPage(
        titlePanel(h1("Richard's Practise Board 05/08/2016",align="center")),
        
        sidebarLayout(
        sidebarPanel(    
                h3("SidebarPanel"), h4("small widges"),
                sliderInput("a",'test', min = as.POSIXct(0 * 3600, origin = "1970-01-01", tz = "UTC"),
                            max=as.POSIXct(23* 3600, origin = "1970-01-01", tz = "UTC"),timeFormat ="%l %p",
                            value=c(as.POSIXct(0* 3600, origin = "1970-01-01", tz = "UTC"),
                                    as.POSIXct(23* 3600, origin = "1970-01-01", tz = "UTC"))),
                
                sliderInput("a",'test', 0,23,format ="%am",
                            value=c(0.23)),
                
                selectInput("var", "1. select the variable", c("sepal.lenght"=1, "sepal,widtt"=2,"petal.length"=3,"petal.width"=4)),
                sliderInput("bin", "2. select the number of bins", min=1,max=50, value=20),
                radioButtons("color", "3. select the color of the hist", c("lightblue","red","darkgreen"),"lightblue"),
                
                textInput("name", "Type your name", value = ""),
                radioButtons("size","what is the size", list("small","medium","large"),""),
                
                sliderInput("a", label="number simulation", min=1,max=10000, value=3000),
                #sliderInput("bin", label="bins", min=1,max=50, value=20),
                selectInput("b", label="select the gender:", c("male", "female"), selected = "female"),
                selectInput("variable", "Variable:",c("Cylinders" = "cyl","Transmission" = "am","Gears" = "gear")),
                selectInput("letter", "Letter", c("Choose one" = "", LETTERS), multiple = T)
            
        ),
     
        
        mainPanel(
                h3("IRIS dataset",align="center"),
                tabsetPanel(type = "tab", 
                            tabPanel("summary",verbatimTextOutput("summary")),
                            tabPanel("structure", verbatimTextOutput("str")),
                            tabPanel("data",tableOutput("data")), 
                            tabPanel("plot",plotOutput("spider"))),
                
                textOutput("name"),textOutput("size1"),
                plotOutput("norm"),
                textOutput("gender")
                
        )
        )
) 


server <- function(input, output){
    
        col <- reactive({
            as.numeric(input$var)
        })
        output$summary <- renderPrint(summary(iris))
        output$str <- renderPrint(str(iris))
        output$data <- renderTable({
                # col <- as.numeric(input$var)
                iris[col] # here if we wirte iris[,col], it is wrong, because it does not return a table, but a array of numbers.
                #head(iris,10);
                })
        output$spider <- renderPlot({
                col <- as.numeric(input$var) # the value is character type, and has to be transfered to numeric
                hist(iris[,col],breaks= input$bin,col=input$color, main="hist of iris data", xlab=names(iris)[col])
        })
        
        output$name <- renderText(paste("your name is: ", input$name))
        output$size1 <- renderText(paste("your chosen size is : ", input$size))
        output$gender <- renderText(input$b)
        output$norm <- renderPlot(hist(rnorm(input$a), breaks = input$bin, col = 'darkgray', border = 'white'))
        
}

shinyApp(ui=ui, server=server)
