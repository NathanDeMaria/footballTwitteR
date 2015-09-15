
read_tweets <- function(search_string, time) {
  oh_auth <- readRDS('oauth.rds')
  f <- tempfile(fileext = '.json')
  filterStream(file.name = f, 
               track = search_string, 
               timeout = time,
               oauth = oh_auth)
  tweets <- tryCatch({
    tweets <- parseTweets(f, verbose = F)
    tweets$search_string <- search_string
    tweets
  }, error = function(e) {
    if (!grepl('did not contain any tweets', e$message)) {
      stop(e$message)
    }
    NULL
  })
  
  tweets
}

save_tweets <- function(tweets, db_name='tweets.db') {
  
  if(is.null(tweets)) {
    return(0)
  }
  
  source('sqlite.R', local = T)
  sqlite <- create_sqlite_accessor(db_name)
  
  if (!file.exists(db_name)) {
    new_rows <- sqlite$create_table(tweets, 'tweets', id = 'id')
  } else {
    new_rows <- sqlite$append_table(tweets, 'tweets')
  }
  new_rows
}