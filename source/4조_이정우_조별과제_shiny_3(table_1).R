library(tidyverse)
library(shiny)
library(ggplot2)
library(gapminder)

#pd <- read.csv(file = 'C:/Users/wpghf/sta/source/adfee.csv')

#str(pd)

ui <- basicPage(titlePanel('대구광역시 연도별 주류 소비량'),
                
                mainPanel(
                  plotOutput('graph_1'))
                
)

server <- function (input, output) {
  output$graph_1 <- renderPlot({
    
    
    ggplot(data = df_al, aes(x = year, y = consumed_alcohol, size=tax)) +
      geom_point(alpha = 0.5) +
      labs(title = "대구광역시 연도별 주류 소비량",
           x="연도",
           y="주류 소비량 (kL)")+
      theme(plot.title = element_text(size = 20,
                                      face="bold",
                                      color="dark orange"))
  })
}


shinyApp(ui, server)
