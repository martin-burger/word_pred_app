



#setwd("~/Desktop/coursera-capstone/shiny-app")
library(shiny)

source("prediction.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive(predict(input$entry))
  
  output$top1 <- renderText({
    dataInput()[1] #  paste("Top 1:", dataInput())
  })

  output$text <- renderText({
    dataInput()
  })
  output$sent <- renderText({
    input$entry
  })
  
})


