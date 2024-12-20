library(shiny)
library(DT)
#----------------------------------------------------------
read_csv_file <- function(path){
  read.csv(path)
}

path <- "C:/Users/showe/Downloads/iris.csv"
#----------------------------------------------------------
ui <- fluidPage(
  titlePanel("EXPLORING IRIS DATASET"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      DTOutput("contents")
    )
    
    
  ),
  
)

#----------------------------------------------------------
server <- function(input,output,session){
  output$contents <- renderDT({
    read_csv_file(path)
  }
  )
  
}
  
#----------------------------------------------------------
shinyApp(ui=ui,server=server)

#----------------------------------------------------------

