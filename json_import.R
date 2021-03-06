#import json
#use python to convert json first.  dont import json
library(data.table)




games<-fread('../../datascience/DataRodgersROF/nfl-football-player-stats/gamesv2.csv')
profiles<-fread('../../datascience/DataRodgersROF/nfl-football-player-stats/profiles.csv')

#now merge the two based on player id
data<-merge(profiles, games, by="player_id")

saveRDS(data, './data/nflData.rds')


positions<-data %>%
  group_by(position) %>%
  summarise(Count = n())

wrData<-data[data$position=="WR",]
wrData$prior_team_value<-wrData$team

#this code doesn't seem to work, didn't use it.  Might need to change to reviceing yards or something, idk.
source('./tidy_allPos_par.R')
wrDatav2<-tidy_main_par(wrData)

saveRDS(wrDatav2, './data/wrData.rds')

wrData<-readRDS('./data/wrData.rds')


unique(wrDatav2$prior_team_value)
unique(wrDatav2$team)

#limit to just packers WR's
gnbWRData<-wrData[wrData$team=="GNB",]

unique(gnbWRData$name)

#most yards
top_yards<-gnbWRData %>%
  select(name, receiving_yards) %>%
  group_by(name) %>%
  summarise(value = sum(receiving_yards)) %>%
  arrange(desc(value))

#most recieving TDs
top_tds<-gnbWRData %>%
  select(name, receiving_touchdowns) %>%
  group_by(name) %>%
  summarise(value = sum(receiving_touchdowns)) %>%
  arrange(desc(value))

#top single season

#most catches

#catch %?