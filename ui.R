


library(shiny)

shinyUI(fluidPage(
  titlePanel("Word Prediction App"),
  sidebarLayout(
    sidebarPanel(
      textInput("entry",
                h5("What's the next word for my sentence? Input here:"),
                "Where are you"),
      submitButton("SUBMIT"),
      br(),
      helpText("Help Instruction:"),
      helpText("To prediction the next single word, please type a
               sentence into the input box and then press SUBMIT botton.
               Enjoy!",style = "color:purple")
      ),
    
    mainPanel(
      
      "Prediction",
      h3("Word Prediction"),
      h5('The sentence you just typed:'),                             
      span(h4(textOutput('sent')),style = "color:blue"),
      br(),
      h5('Single Word Prediction:'),
      span(h4(textOutput('top1')),style = "color:red"),
      
      br(),
      p('More details of the prediction algorithm and source codes', 
        code("prediction.R"), code("server.R"), code("ui.R"), 
        'cand be found in other Tags.')

      )
    )
  ))
