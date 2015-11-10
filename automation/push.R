source('R/sqlite.R')
library(RPushbullet)
library(data.table)

sqlite <- create_sqlite_accessor('tweets.db')
tweets <- data.table(sqlite$read_table('tweets'))
tweets[,scrape_time:=as.POSIXct(scrape_time, origin = '1970-01-01')]
yesterday <- Sys.time() - 24 * 60 * 60

new_tweets <- nrow(tweets[scrape_time > yesterday])
pbPost('note', "New tweets", 
       sprintf("%d new tweets scraped in the past 24 hours", new_tweets))

