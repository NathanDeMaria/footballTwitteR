library(ggplot2)

script_dir <- dirname(sys.frame(1)$ofile)
setwd(sprintf('%s/..', script_dir))
tweets <- source('R/data.R')

states_map <- map_data('state')

map_plot <- ggplot() + geom_polygon(data = states_map, aes(long, lat, group=group), 
                             fill='gray', colour='white') + 
  geom_point(data=tweets[!is.na(longitude) & !is.na(latitude)], 
             aes(x=longitude, y=latitude, col=team)) +
  xlim(range(states_map$long)) + ylim(range(states_map$lat)) +
  theme(panel.background = element_blank())

time_plot <- ggplot(tweets) + geom_point(aes(created, scrape_time))
