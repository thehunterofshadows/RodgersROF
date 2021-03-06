#plots
library(data.table)
library(dplyr)
library(ggplot2)


pullYardsPerGame<-function(qbData){
#Pull yards per game data
  yards<-qbData %>%
    select(name, passing_yards,current_team) %>%
    group_by(name,current_team) %>%
    summarise(passing_yards=sum(passing_yards), num_games=n()) %>%
    filter(num_games >36)
  
  yards$y<-yards$passing_yards/yards$num_games
  
  yards<-yards[order(-yards$y),]
  graphTitle<<-"Yards per Game"
  yards<-tidyData(yards)
}

pullTotalYards<-function(qbData){
#Pull total yards data
  yards<-qbData %>%
    select(name, passing_yards,current_team) %>%
    group_by(name,current_team) %>%
    summarise(passing_yards=sum(passing_yards), num_games=n()) %>%
    filter(num_games >36)
  
  yards$y<-yards$passing_yards
  
  yards<-yards[order(-yards$y),]
  graphTitle<<-"Total Yards"
  yards<-tidyData(yards)
}

pullTouchDowns<-function(qbData){
#Pull total yards data
  yards<-qbData %>%
    select(name, passing_touchdowns,current_team) %>%
    group_by(name, current_team) %>%
    summarise(y=sum(passing_touchdowns), num_games=n()) %>%
    filter(num_games >36)

  yards<-yards[order(-yards$y),]
  graphTitle<<-"Touchdowns"
  yards<-tidyData(yards)
}

pullTouchDownsToInts<-function(qbData){
  #Pull total yards data
  yards<-qbData %>%
    select(name, passing_touchdowns,passing_interceptions,current_team) %>%
    group_by(name, current_team) %>%
    summarise(passing_touchdowns=sum(passing_touchdowns),passing_interceptions=sum(passing_interceptions), num_games=n()) %>%
    filter(num_games >36)
  yards$y<-yards$passing_touchdowns/yards$passing_interceptions
  
  yards<-yards[order(-yards$y),]
  graphTitle<<-"Touchdowns to Ints"
  yards<-tidyData(yards)
}



#Bar chart


#v6
yards<-pullTouchDownsToInts(qbData)
#fillColor<-c(replicate(8,"#3480EB"),"#203731","#3480eb")
#textColor<-c(replicate(8,"white"),"#FFB612","white")
#qbPos<-c(0,2,4,6,8,10,12,14,16,18)
g<-ggplot(
  data = yards[1:10,],
  mapping = aes(x=reorder(name,-y), 
                y=y 
  )
)+
  geom_bar(
    stat="identity",
    fill=yards$pri_color[1:10]
  )+
  theme(
    axis.title.x=element_text(size=14, color="#993333", face="bold"),
    axis.title.y=element_text(size=14, color="#993333", face="bold"),
    plot.title=element_text(size=14, color="red", face="bold",hjust=.5),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank()
  )+
  labs(
    title=graphTitle,x="QB Names",y=graphTitle
  )+
  geom_text(
    mapping=aes(label=name,hjust=1.1,vjust=.5),
    angle=90,size=8,colour=yards$sec_color[1:10]
  )+
  scale_colour_manual(
    values="white"
  )+
  coord_cartesian(
    ylim=c(
      min(yards$y[1:30]),
      max(yards$y[1:10]))
  )
g

#v5
# fillColor<-c(replicate(8,"#3480EB"),"#203731","#3480eb")
# textColor<-c(replicate(8,"white"),"#FFB612","white")
# qbPos<-c(0,2,4,6,8,10,12,14,16,18)
# g<-ggplot(
#   data = yards[1:10,],
#   mapping = aes(x=reorder(name,-y), 
#                 y=y 
#                 )
# )+
#   geom_bar(
#     stat="identity",
#     fill=yards$pri_color[1:10]
#     )+
#   theme(
#     axis.title.x=element_text(size=14, color="#993333", face="bold"),
#     axis.title.y=element_text(size=14, color="#993333", face="bold"),
#     plot.title=element_text(size=14, color="red", face="bold",hjust=.5),
#     axis.text.x=element_blank(),
#     axis.ticks.x=element_blank()
#   )+
#   labs(
#     title="Yards per Game",x="QB Names",y="Yards per Game"
#   )+
#   geom_text(
#     mapping=aes(label=name,y=((y*.9)-qbPos),vjust=.5),
#     angle=90,size=8,colour=yards$sec_color[1:10]
#   )+
#   scale_colour_manual(
#     values="white"
#   )+
#   coord_cartesian(
#     ylim=c(
#       min(yards$y),
#       max(yards$y))
#   )
# g
