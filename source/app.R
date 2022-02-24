# install.packages(c('shiny','tidyverse','ggplot2','patchwork'))

library(shiny)
library(tidyverse)
library(ggplot2)
library(patchwork)

df = read_csv(paste(getwd(), "mini/data/drink_sales.csv",
                    sep = "/"))

str(df)
colSums(is.na(df))
cols = names(df)

make_comp = function(x) {
  comp = c(1)
  for (i in c(2:length(x))) {
    temp = comp[i - 1] * (1 + round((x[i] -
                                       x[i - 1])/x[i - 1], digits = 3))
    comp = c(comp, temp)
  }
  
  comp
}

df = cbind(df, total_comp = make_comp(df$total))
df = cbind(df, import_comp = make_comp(df$import))
df = cbind(df, domestic_comp = make_comp(df$domestic))
df = cbind(df, soju_comp = make_comp(df$soju))
df = cbind(df, beer_comp = make_comp(df$beer))
df = cbind(df, whiskey_comp = make_comp(df$whiskey))
df = cbind(df, takyakju_comp = make_comp(df$takyakju))
df = cbind(df, etc_comp = make_comp(df$etc))

df$whiskey_comp[is.na(df$whiskey_comp)] = 0

df.comp.total = geom_point(aes(y = total,
                               size = total_comp), color = 2)
df.comp.import = geom_point(aes(y = import,
                                size = import_comp), color = 3)
df.comp.domestic = geom_point(aes(y = domestic,
                                  size = domestic_comp), color = 4)
df.comp.soju = geom_point(aes(y = soju, size = soju_comp),
                          color = 5)
df.comp.beer = geom_point(aes(y = beer, size = beer_comp),
                          color = 6)
df.comp.whiskey = geom_point(aes(y = whiskey,
                                 size = whiskey_comp), color = 7)
df.comp.takyakju = geom_point(aes(y = takyakju,
                                  size = takyakju_comp), color = 8)
df.comp.etc = geom_point(aes(y = etc, size = etc_comp),
                         color = 9)

ui <- fluidPage(titlePanel("이럴거면 프로젝트를 왜 하냐"),
                sidebarLayout(sidebarPanel(sliderInput(inputId = "years",
                                                       label = "range from Y:", min = 2012,
                                                       max = 2020, value = 2012)), mainPanel(plotOutput(outputId = "distPlot"))),
)

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    ggplot(data = df[which(df$year <=
                             input$years), ], mapping = aes(x = year,
                                                            alpha = 0.4)) + theme(legend.position = "None") +
      df.comp.total + df.comp.import +
      df.comp.domestic + df.comp.soju +
      df.comp.beer + df.comp.whiskey +
      df.comp.takyakju + df.comp.etc +
      labs(x = "연도", y = "판매량(kL)",
           title = "연도별 주류 판매량")
  })
}

shinyApp(ui = ui, server = server)
