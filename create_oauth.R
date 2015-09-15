library(ROAuth)
source('config/app_config.R')

req_url <- 'https://api.twitter.com/oauth/request_token'
access_url <- 'https://api.twitter.com/oauth/access_token'
auth_url <- 'https://api.twitter.com/oauth/authorize'
consumer_key <- get_config('consumer_key')
consumer_secret <- get_config('consumer_secret')
oh_awth <- OAuthFactory$new(
  consumerKey = consumer_key,
  consumerSecret = consumer_secret,
  requestURL = req_url,
  accessURL = access_url,
  authURL = auth_url
)

oh_awth$handshake(cainfo = system.file('CurlSSL', 'cacert.pem', package='RCurl'))

saveRDS(oh_awth, 'oauth.rds')