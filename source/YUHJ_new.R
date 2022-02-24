library(tidyverse)
library(shiny)
library(ggplot2)
library(gapminder)

pd <- read.csv(file = '../data/adfee.csv')

str(pd)

ui <- fluidPage(titlePanel('주류별 광고비 지출'),
    sidebarPanel(
        sliderInput(inputId = 'year', label = '연도 :', min = 2010, max = 2019, value = 2010)),
    
    mainPanel(
        plotOutput('distPlot'))
        
)

server <- function (input, output) {
    output$distPlot <- renderPlot({
        userselection <- pd[, c(input$year - 2008)]
        ggplot(data = pd, aes(x = reorder(what, userselection), y = userselection)) +
            geom_bar(stat = 'identity', fill="antiquewhite3") + coord_flip() +
            theme_bw() +
            theme(panel.grid.major.x = element_blank()) +
            labs(title = '주류별 광고비 지출액', x = '주류 종류', y = ' ') +
            theme(plot.title = element_text(size = 24,
                                            face = 'bold',
                                            color = 'black'),
                  axis.text.y = element_text(face = 'bold', size = 11))
    })
}


shinyApp(ui, server)

