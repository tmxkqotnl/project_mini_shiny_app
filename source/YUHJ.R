library(tidyverse)
library(shiny)
library(ggplot2)
library(gapminder)

pd <- read.csv(file = 'C:/Users/wpghf/sta/source/adfee.csv')

str(pd)

ui <- fluidPage(titlePanel('주류별 광고비 지출'),
    sidebarPanel(
        sliderInput(inputId = 'year', label = '연도 :', min = 2010, max = 2019, value = 2011)),
        # a를 준 이유는? -> a가 연도를 설정하는 버튼이니까, a가 설정한 연도를 y축에 넣어주려고
    
    mainPanel(
        plotOutput('distPlot'))
        
)

server <- function (input, output) {
    output$distPlot <- renderPlot({
        userselection <- pd[, c(input$year - 2008)]
        ggplot(data = pd, aes(x = reorder(what, userselection), y = userselection)) +
            geom_bar(stat = 'identity', fill="steelblue")
    })
}


shinyApp(ui, server)

