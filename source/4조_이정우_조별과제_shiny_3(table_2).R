library(tidyverse)
library(shiny)
library(ggplot2)
library(gapminder)

df_com = read.csv("../data/daegu_commuter.csv", header=T, encoding ="utf-8")

ui <- basicPage(titlePanel('대구 상가 밀집 주요 역 연도별 하차 인원수'),
                
                mainPanel(
                  plotOutput('graph_2'))
                
)

server <- function (input, output) {
  output$graph_2 <- renderPlot({
    ggplot(data = df_com, aes(x = year, y = commuter, group_by=station,
                              color=station)) +
      geom_line(size=1.2)+
      geom_point(shape=21, size=2)+
      labs(title="대구 상가 밀집 주요 역 연도별 하차 인원수",
           x="연도",
           y="월평균 하차 인원수(명)")+
      theme(plot.title = element_text(size=20,
                                      face="bold",
                                      color="dark orange"))
  })
}


shinyApp(ui, server)
