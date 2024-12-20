library(shiny)
library(DT)
library(ggplot2)
#----------------------------------------------------------
read_csv_file <- function(path){
  read.csv(path)
}
#----------------------------------------------------------
ui <- fluidPage(
  titlePanel("EXPLORING IRIS DATASET"),
 # shinythemes::themeSelector(),
  theme = shinythemes::shinytheme("simplex"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Select CSV file"),
      selectInput("features","Select a feature",
                  choices = c("sepal.length",
                              "sepal.width",
                              "petal.length",
                              "petal.width"
                              )
                  )
    ),
    mainPanel(
      plotOutput("histogram"),
      DTOutput("contents")
    )
  )
)
#----------------------------------------------------------
server <- function(input,output,session){
  
  data <- reactive({
    req(input$file)
    read_csv_file(input$file$datapath)
  })
  output$contents <- renderDT({
    data()
  })
##  
  output$histogram <- renderPlot({
    ggplot(data(),aes_string(x=input$features)) +
    geom_histogram(bins = 50,fill="violet",color="black") +
    labs(title = paste("Histogram of",input$features),
         x=input$features,
         y="Count")
  })
}
# ---------------------------------------------------------
shinyApp(ui=ui,server=server)
