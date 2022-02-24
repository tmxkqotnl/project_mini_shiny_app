library(shiny)
library(ggplot2)

ui <- pageWithSidebar(
  headerPanel("탭패널 예제"),
  sidebarPanel(
    checkboxGroupInput("showvars", "컬럼을 선택해보세요", names(df_al),
                       selected = names(df_al)),
    
    helpText("사이드 바")),
  
  mainPanel(
    
    tabsetPanel(
      tabPanel(title = "대구광역시 연간 주류 소비량",
               dataTableOutput("df_al")),
      tabPanel(title = "대구광역시 유흥밀집지역 지하철 하차인원",
               dataTableOutput("df_com"))
    )
  )
)

server <- function (input, output) {
  output$df_al <- renderDataTable({
    df_al[, input$showvars, drop=FALSE]
  })
  output$df_com <- renderDataTable({
    df_com
  }, options = list(bSortClasses = FALSE))
}

shinyApp(ui, server)

