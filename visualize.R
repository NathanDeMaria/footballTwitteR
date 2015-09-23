source('sqlite.R')
source('teams.R')
library(data.table)
library(ggplot2)

db <- create_sqlite_accessor('tweets.db')
tweets <- data.table(db$read_table('tweets'))

tweets[,team:=unlist(teams[search_string])]

tweets[,created:=as.POSIXct(created, origin='1970-01-01')]
tweets[,scrape_time:=as.POSIXct(scrape_time, origin='1970-01-01')]

tweets[,latitude:=as.numeric(latitude)]
tweets[,longitude:=as.numeric(longitude)]

states_map <- map_data('state')

map_plot <- ggplot() + geom_polygon(data = states_map, aes(long, lat, group=group), 
                             fill='gray', colour='white') + 
  geom_point(data=tweets[!is.na(longitude) & !is.na(latitude)], 
             aes(x=longitude, y=latitude, col=team)) +
  xlim(range(states_map$long)) + ylim(range(states_map$lat)) +
  theme(panel.background = element_blank())

time_plot <- ggplot(tweets) + geom_point(aes(created, scrape_time))
