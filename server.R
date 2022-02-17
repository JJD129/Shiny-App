library(shiny)
library(xlsx)
setwd("/Users/jenniferdimaano/Desktop/CourseraR/Developing Data Products/Shiny App/Shiny-App")
wineData<-read.xlsx("winequality.xlsx", sheetIndex = 1, header = TRUE)

shinyServer(function(input, output) {
  whiteData<-wineData[which(wineData$type=="White"),]
  redData<-wineData[which(wineData$type=="Red"),]
  model1 <- lm(quality ~ alcohol + fixed.acidity 
               + volatile.acidity 
               , data = redData)
  model2 <- lm(quality ~ alcohol + fixed.acidity 
               + volatile.acidity 
               , data = whiteData)
  
  model1pred <- reactive({
    alcoholInput <- input$sliderAlcohol
    acidityInput <- input$sliderAcidity
    volatileacidInput <-input$sliderVolatile
    predict(model1, newdata = data.frame(fixed.acidity = acidityInput 
                                         , volatile.acidity = volatileacidInput
                                         , alcohol = alcoholInput
                                         ))
  })
  
  model2pred <- reactive({
    alcoholInput <- input$sliderAlcohol
    acidityInput <- input$sliderAcidity
    volatileacidInput <-input$sliderVolatile
    predict(model2, newdata = 
              data.frame(fixed.acidity = acidityInput 
                         , volatile.acidity = volatileacidInput
                         , alcohol = alcoholInput
                         ))
  })
  output$plot1 <- renderPlot({
    alcoholInput <- input$sliderAlcohol
    acidityInput <- input$sliderAcidity
    volatileacidInput <-input$sliderVolatile
    
    plot(wineData$alcohol, wineData$quality, xlab = "Alcohol", 
         ylab = "Quality", bty = "n", pch = 16,
         xlim = c(1, 10), ylim = c(5, 16))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      abline(model2, col = "blue", lwd = 2)
    }
    legend(2, 15, c("Red Wine Prediction", "White Wine Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(alcoholInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(alcoholInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})