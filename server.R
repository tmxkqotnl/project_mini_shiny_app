library(shiny)
library(ggplot2)
library(magrittr) #%>% 쓰기위해서~
library(dplyr) # group_by 쓰기 위해서~
df2 <- read.csv("drink_tax.csv", header= TRUE, sep= ",", quote="\"",
                dec = ".", fill = TRUE, comment.char= "")
df3 <- read.csv("covid.csv", header= TRUE, sep= ",", quote="\"",
                dec = ".", fill = TRUE, comment.char= "")
df2_t <- df2 %>% group_by(date) %>% summarise(출고량 = sum(출고량)) 
df2_tl <- df2 %>% group_by(date,location) %>% summarise(출고량 = sum(출고량))
df2_tlp <-  ggplot(data = df2_tl,aes(x=date, y=출고량,color=location))+geom_point()+geom_line()# x가 str이니 bar로할까?
df2_tlp
df2_type <- df2 %>% group_by(date,type) %>% summarise(출고량 = sum(출고량)) 
df2_ty_v <- df2_type[df2_type$type =="맥주" |df2_type$type == "희석식소주",]
df2_type_p <- ggplot(data= df2_ty_v, aes(x=date, y=출고량,color=type))+geom_point()+geom_line()
df2_loc <- df2[df2$location == "서울" | df2$location == "대구", ]
df2_loc_t <- df2_loc %>% group_by(date, location) %>% summarise(출고량 = sum(출고량)) 
df2_locp <- ggplot(data= df2_loc_t, aes(x=date, y=출고량, color=location))+geom_point()+geom_line()

df3_t <- df3 %>% group_by(년도,달) %>% summarise(국내발생 =sum(국내발생.명.)) #mean으로 안하고 sum으로 테이블
p_df3_t <- ggplot(data=df3_t, aes(달,국내발생, color=년도))+geom_line(lineend="round",size=1)
server <- function (input, output) {
    output$Plot <- renderPlot({
        plot(c("2018","2019","2020"), df2_t$출고량, main="출고량",xlab="년도",ylab="출고량",type="o",col="red")
    })
    output$Plot2 <- renderPlot({
        df2_tlp
    })
    output$Plot3 <- renderPlot({
        df2_type_p
    })
    output$Plot4 <- renderPlot({
        df2_locp
    })
    output$df3_Plot1 <- renderPlot({
        p_df3_t
    })
    output$df3_Plot2 <- renderPlot({
        p_df3_t +facet_wrap(~ 년도, nrow=1)
    })
    output$df3_Plot3 <- renderPlot({
        barplot(df3_t[df3_t$년도 == "2020년", ]$국내발생,names=df3_t[df3_t$년도 == "2020년", ]$달, 
                main="2020 코로나 확진자 수", xlab="달(Month)", ylab="확진자수")
    })
    output$df3_Plot4 <- renderPlot({
        barplot(df3_t[df3_t$년도 == "2021년", ]$국내발생,names=df3_t[df3_t$년도 == "2021년", ]$달,
                main="2021 코로나 확진자 수",  xlab="달(Month)", ylab="확진자수")
    })
    output$df3_Plot5 <- renderPlot({
        barplot(df3_t[df3_t$년도 == "2022년", ]$국내발생,names=df3_t[df3_t$년도 == "2022년", ]$달,
                main="2022 코로나 확진자 수",  xlab="달(Month)", ylab="확진자수" )
    })
    output$df3_Plot6 <- renderPlot({
        count <- as.character(input$count)
        count_s <- paste(count,"년",sep="")
        print(count_s)
        barplot(df3_t[df3_t$년도 == count_s, ]$국내발생,names=df3_t[df3_t$년도 == count_s, ]$달,
                main="코로나 확진자 수",  xlab="달(Month)", ylab="확진자수" )
    })
    output$mytable1 <- renderDataTable({
        df2[, input$showvars, drop= FALSE]
    },options = list(bSortClasses = TRUE))
    output$mytable2 <- renderDataTable({
        df3}, options = list(bSortClasses = TRUE))
}
#x2 <- paste("2022","년",sep="")
#x2
