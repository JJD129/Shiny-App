library(shiny)
shinyUI(fluidPage(
  titlePanel("Between red and white varieties, which wine has the higher alcohol volume?"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderAlcohol", "Alcohol Content", 5, 15, value = 7),
      sliderInput("sliderAcidity", "Fixed Acidity", 5, 15, value = 7),
      sliderInput("sliderVolatile", "Volatile Acidity", 5, 15, value = 7),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Alcohol from Reds:"),
      textOutput("pred1"),
      h3("Predicted Alcohol from Whites:"),
      textOutput("pred2")
    )
  )
))
