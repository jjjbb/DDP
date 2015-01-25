library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The James Hird Memorial Ladder Predictor"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h3('Game Performance'),
      sliderInput("goals",
                  "Average Number of Goals:",
                  min = 0,
                  max = 20,
                  value = 10,
                  step = 0.5),
      sliderInput("disposals",
                  "Average Number of Disposals:",
                  min = 300,
                  max = 450,
                  value = 350)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3('Your team\'s likely position in September'),
      verbatimTextOutput("prediction")
    )
    
  )
))