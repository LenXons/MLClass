# Step 1 : Load shiny library
library(shiny)

# Step 2 : Create an UI

ui <- fluidPage(
  titlePanel("QUADRATIC CALCULATOR"),
  sidebarLayout(
  sidebarPanel(
    selectInput("coeffx2","Coefficent of x2",c(0:10)),
    sliderInput("coeffx","Coefficent of x",value=0, min=1, max=10, 0.1),
    textInput("constant","Constant term")
  ),
  mainPanel(    
    textOutput("a")
  )
  )
)

# Step 3 : Create a server : Handles the backend 
server <- function(input,output,session){

#-----------------------------------------------------------  
  discriminant <- function(){
    a <- as.numeric(input$coeffx2)
    b <- as.numeric(input$coeffx)
    c <- as.numeric(input$constant)
    
    D <- b*b - 4*a*c
    return (D)
  }  
  
 
#-----------------------------------------------------------  
  output$a <- renderText(
    {
      paste("Discriminant",discriminant())
    }
  )
}
#-----------------------------------------------------------
# Step 4 : 
shinyApp(ui=ui,server=server)


  
