source('register_oauth.R')
source('sqlite.R')

search_string <- commandArgs(trailingOnly = T)[1]

today <- Sys.Date()
in_the_past <- as.character(today - 8)
yesterday <- as.character(today - 1)

tweets <- suppressWarnings(searchTwitter(search_string, n = 1000, since = in_the_past, until = yesterday))
tweet_df <- twListToDF(tweets)

tweet_df$search_string <- search_string
tweet_df$scrape_time <- Sys.time()

sqlite <- create_sqlite_accessor('tweets.db')

log_base <- paste0('%s <', search_string, '> %s\n')

collected <- nrow(tweet_df)
cat(sprintf(log_base, Sys.time(), sprintf("Collected %d tweets", collected)))

if (!file.exists('tweets.db')) {
  sqlite$create_table(tweet_df, 'tweets', id = 'id')
  saved <- collected
} else {
  saved <- sqlite$append_table(tweet_df, 'tweets')
}

cat(sprintf(log_base, Sys.time(), sprintf("Saved %d new tweets", saved)))
