source('sqlite.R')
source('data.R')

library(streamR)

args <- commandArgs(trailingOnly = T)
search_string <- args[1]
time <- as.numeric(args[2])

# search_string <- '#huskers'
# time <- 10

# TODO: separate out some sort of logger util
log_base <- paste0('%s <', search_string, '> %s\n')

cat(sprintf(log_base, Sys.time(), 'Collecting tweets'))
tweets <- read_tweets(search_string, time)
cat(sprintf(log_base, Sys.time(), sprintf('Collected %d tweets', nrow(tweets))))
n <- save_tweets(tweets)
cat(sprintf(log_base, Sys.time(), sprintf('Saved %d tweets', n)))
