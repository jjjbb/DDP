# Define server logic required to draw a histogram
library(ggplot2)
library(plyr)
library(reshape2)


finalPosition <- function(goals, disposals){
  g    <- (goals - 12.73333)/1.467002
  b    <- (disposals - 362.0867)/15.57484
  pSI  <- 9.067-2.4308*b-2.8201*g
  if(pSI<1){1}
  else{if(pSI>18){18}else{round(pSI)}}
} 

shinyServer(
  function(input, output) {
    output$prediction <- renderPrint({finalPosition(input$goals,input$disposals)})
  }
)