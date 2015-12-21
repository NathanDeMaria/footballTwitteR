(function() {
  library(data.table)
  
  source('R/sqlite.R', local = T)
  source('R/teams.R', local = T)
  
  sqlite <- create_sqlite_accessor('tweets.db')
  tweets <- data.table(sqlite$read_table('tweets'))
  
  tweets[,team:=unlist(teams[search_string])]
  
  tweets[,created:=as.POSIXct(created, origin='1970-01-01')]
  tweets[,scrape_time:=as.POSIXct(scrape_time, origin='1970-01-01')]
  
  tweets[,latitude:=as.numeric(latitude)]
  tweets[,longitude:=as.numeric(longitude)]
  tweets
})()
