library(shiny)
df2 <- read.csv("drink_tax.csv", header= TRUE, sep= ",", quote="\"",
                dec = ".", fill = TRUE, comment.char= "")
df3 <- read.csv("covid.csv", header= TRUE, sep= ",", quote="\"",
                dec = ".", fill = TRUE, comment.char= "")

ui <- pageWithSidebar(
    headerPanel(h1("데이터테이블 예제")),
    sidebarPanel(
        sliderInput("count", "Number of values: ",
                    min=2020, max=2022, value=2021),
        checkboxGroupInput("showvars",
                           "컬럼을 선택해보세요:",
                           names(df2),
                           selected = names(df2)),
        helpText("오른쪽에서 탭을 선택하면 다른 데이터도 볼 수 있음."),
        
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("df2", 
                     dataTableOutput("mytable1"),
                     plotOutput("Plot"),
                     plotOutput("Plot2"),
                     plotOutput("Plot3"),
                     plotOutput("Plot4"),
                     ),
            tabPanel("df3", 
                     dataTableOutput("mytable2"),
                     plotOutput("df3_Plot1"),
                     plotOutput("df3_Plot2"),
                     plotOutput("df3_Plot3"),
                     plotOutput("df3_Plot4"),
                     plotOutput("df3_Plot5"),
                     plotOutput("df3_Plot6")
                     )
        )
    )
)
#c(df2,df3)
#출고량, date,location, type df2
#일자, 계.명. , 국내발생.명., 해외유입.명., 사망.명.,년도,달 df3

