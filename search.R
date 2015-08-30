source('register_oauth.R')
source('sqlite.R')

search_string <- commandArgs(trailingOnly = T)[1]

today <- Sys.Date()
two_days <- as.character(today - 2)
yesterday <- as.character(today - 1)

tweets <- suppressWarnings(searchTwitter(search_string, n = 1000, since = two_days, until = yesterday))
tweet_df <- twListToDF(tweets)

tweet_df$search_string <- search_string

sqlite <- create_sqlite_accessor('tweets.db')

log_base <- paste0('%s <', search_string, '> %s')
if (!file.exists('tweets.db')) {
  cat(sprintf(log_base, Sys.time(), sprintf('Creating new table with %d tweets', nrow(tweet_df))))
  sqlite$create_table(tweet_df, 'tweets', id = 'id')
  
} else {
  cat(sprintf(log_base, Sys.time(), sprintf('Appending %d tweets to table', nrow(tweet_df))))
  sqlite$append_table(tweet_df, 'tweets')
}
