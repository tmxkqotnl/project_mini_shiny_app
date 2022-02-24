# install.packages(c('shiny','tidyverse','ggplot2','patchwork','rsconnect'))

# rsconnect::setAccountInfo(name='mini',
# token='6BD2CF4CDF5CC991191090AC41D3437C',
# secret='<>')


# server and ui 가 완료되면 배포용
# 코드 외 삭제

library(shiny)
library(tidyverse)
library(ggplot2)
library(patchwork)
library(rsconnect)

df = read_csv(paste(getwd(), "../data/drink_sales.csv",
                    sep = "/"))  # for execute runApp()
# df =
# read_csv(paste(getwd(),'data/drink_sales.csv',sep='/'))
# # error when runApp.. why?

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
df$year = df$year %>%
  as.character()

cs = sample(colors(), 8, replace = TRUE)

Category = cs[1]

df.comp.total = geom_point(aes(y = total,
                               size = total_comp, color = Category),
                           alpha = 0.4)
df.comp.import = geom_point(aes(y = import,
                                size = import_comp, color = cs[2]),
                            alpha = 0.4)
df.comp.domestic = geom_point(aes(y = domestic,
                                  size = domestic_comp, color = cs[3]),
                              alpha = 0.4)
df.comp.soju = geom_point(aes(y = soju,
                              size = soju_comp, color = cs[4]),
                          alpha = 0.4)
df.comp.beer = geom_point(aes(y = beer,
                              size = beer_comp, color = cs[5]),
                          alpha = 0.4)
df.comp.whiskey = geom_point(aes(y = whiskey,
                                 size = whiskey_comp, color = cs[6]),
                             alpha = 0.4)
df.comp.takyakju = geom_point(aes(y = takyakju,
                                  size = takyakju_comp, color = cs[7]),
                              alpha = 0.4)
df.comp.etc = geom_point(aes(y = etc,
                             size = etc_comp, color = cs[8]),
                         alpha = 0.4)


ui <- fluidPage(
  titlePanel("연도별 주류 판매량"), 
  sidebarLayout(sidebarPanel(
    sliderInput(inputId = "years",label = "range from Y:", min = 2012, max = 2020, value = 2012),
    br(),
    br(),
    p('전반적으로 주류 판매량은 줄어들고 있음을 알 수 있다.'),
    p('하지만, 그래프에서 알 수 있듯이 수입(Import) 주류는 꾸준히 증가하고 있음을 보여준다.')
    ), 
    mainPanel(plotOutput(outputId = "distPlot"))
    ),
)

server = function(input, output, session) {
  output$distPlot <- renderPlot({
    ggplot(data = df[which(df$year <=
                             input$years), ], mapping = aes(x = year)) +
      theme_classic() + df.comp.total +
      df.comp.import + df.comp.domestic +
      df.comp.soju + df.comp.beer +
      df.comp.whiskey + df.comp.takyakju +
      df.comp.etc + theme(legend.position = "None") +
      labs(x = "연도", y = "판매량(kL)",
           title = "연도별 주류 판매량") +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$total[1] + 100,
                              label = "total")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$import[1] + 2,
                              label = "import")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$domestic[1] +
                                100, label = "domestic")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$soju[1] + 100,
                              label = "soju")) + geom_text(mapping = aes(x = df$year[1],
                                                                         y = df$beer[1] + 100, label = "beer")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$whiskey[1] +
                                100, label = "whiskey")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$takyakju[1] +
                                100, label = "takyakju")) +
      geom_text(mapping = aes(x = df$year[1],
                              y = df$etc[1] + 100,
                              label = "etc")) + scale_size(range = c(3,
                                                                     10))
    
  })
}

shinyApp(ui = ui, server = server)

# rsconnect::deployApp()
