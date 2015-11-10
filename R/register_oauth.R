library(twitteR)

source('config/app_config.R')

capture.output(setup_twitter_oauth(get_config('consumer_key'), 
                    get_config('consumer_secret'), 
                    get_config('access_token'), 
                    get_config('access_token_secret')))
