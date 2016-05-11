library(shiny)
ui <- fluidPage(
    titlePanel(h1("Richard's practice 05/09/2015", align="center")),
    
    sidebarLayout(
        sidebarPanel(
            h2("print data"),
            selectInput("dataset","choose a data set", c("iris","pressure","mtcars")),
            numericInput("obs","number of observations", 5),
            
            h2("submit you name"),
            textInput("first", "type your first name"),
            textInput("last", "type your last name"),
            submitButton("update!"),
            p("please click on the update button to update you info"),
            
            h2("download iris data as an example"),
            selectInput("var1", label="select x variable", choices = c("sepal.length"=1, "sepal,width"=2,
                                                             "petal.length"=3,"petal.width"=4)),
            
            selectInput("var2", label="select y variable", choices = c("sepal.length"=1, "sepal,width"=2,
                                                                       "petal.length"=3,"petal.width"=4)),
            radioButtons("var3", "select the file type", list("png","pdf"))
        ),
        
        
        mainPanel(
            h2("demonstration of data talbe print"),
            verbatimTextOutput("str"),
            tableOutput("table"),
            
            h2("demonstration of name submition"),
            textOutput("fir"),
            textOutput("las"),
            
            h2("demonstration of downloading"),
            plotOutput("plot"),
            #textOutput("xray"),
            downloadButton("down", "download the plot")
            
        )
    )
    
)

server <- function(input, output){
    output$str <- renderPrint({str(get(input$dataset))})
    output$table <- renderTable({head(get(input$dataset),input$obs)})
    
    output$fir <- renderText({paste("my first name is:", input$first)})
    output$las <- renderText({paste("my last name is:", input$last)})
    
    x <- reactive({iris[,as.numeric(input$var1)]})
    y <- reactive({iris[,as.numeric(input$var2)]})
    output$plot <- renderPlot({plot(x(),y())})
    #$xray <- renderText({x()[1:10]})
    output$down <- downloadHandler(
        filename = function(){ paste("iris", input$var3,sep=".")},# specify the file name
        content = function(file){
            if(input$var3=="pgn")
                png(file)
            else 
                pdf(file)
            plot(x(),y())
            dev.off()
        }
    )
}


shinyApp(ui=ui, server=server)





