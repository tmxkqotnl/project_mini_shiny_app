

#------------데이터 프레임으로 불러오기----------------

df_al <- read.csv("C:/R_practice/df_al.csv", header=T, encoding ="utf-8")
df_com <- read.csv("C:/R_practice/daegu_commuter.csv", header=T, encoding ="utf-8")

#install.packages("hrbrthemes")
#install.packages("viridis")
# Libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)


a <- ggplot(data = df_al, mapping=aes(x=year,
                          y=consumed_alcohol))

b <- ggplot(data = df_com,
            mapping = aes(x=year,
                          y=commuter))

#a+ geom_bar(aes(x=year, xend=year, y=consumed_alcohol, yend=consumed_alcohol))+
#  geom_point()

#(theme_bw()) #서식 설정

graph_1<-ggplot(data=df_al,
       mapping = aes(x=year,
                     y=consumed_alcohol,
                     size=tax))+
  geom_point(alpha = 0.5) +
  labs(title = "대구광역시 연도별 주류 소비량",
       x="연도",
       y="주류 소비량 (kL)")+
  theme(plot.title = element_text(size = 20,
                                  face="bold",
                                  color="dark orange"))

graph_1

#----------------------------------------
str(df_com)

graph_2<-ggplot(data=df_com,
       mapping = aes(x=year,
                     y=commuter,
                     group_by=station,
                     color=station))+
  geom_line(size=1.2)+
  geom_point(shape=21, size=2)+
  labs(title="대구 상가 밀집 주요 역 연도별 하차 인원수",
         x="연도",
         y="월평균 하차 인원수(명)")+
  theme(plot.title = element_text(size=20,
                                  face="bold",
                                  color="dark orange"))

graph_2
