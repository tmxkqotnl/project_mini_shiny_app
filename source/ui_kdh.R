library(shiny)

ui <- fluidPage(titlePanel("이럴거면 프로젝트를 왜 하냐"),
                sidebarLayout(sidebarPanel(sliderInput(inputId = "years",
                                                       label = "range from Y:", min = 2012,
                                                       max = 2020, value = 2012)), mainPanel(plotOutput(outputId = "distPlot"))),
)
