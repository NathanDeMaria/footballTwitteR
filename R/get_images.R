library(stringr)
library(tidyr)
library(rvest)

set.seed(18)

tweets <- source('R/data.R')$value

tweets <- tweets[isRetweet == F]

link_regex <- 'https://t.co/[a-zA-Z0-9]+$'
tweets <- tweets[,url:=str_extract(text, link_regex)][!is.na(url)]

get_image <- Vectorize(function(url) {
  tryCatch({
    read_html(url) %>% 
      html_nodes(css='.permalink-tweet-container .OldMedia-singlePhoto .OldMedia-photoContainer img') %>% 
      html_attr('src')  
  }, error = function(e) {
    if(e$message == 'No matches') {
      return(NA_character_)
    } else if(e$message == 'SSL connect error') {
      return(NA_character_)
    }
    #stop(e)
    warning(e$message)
    NA_character_
  })
})

next_date <- function() {
  max(as.Date(list.files('images/'), format = '%Y%m%d')) + 1
}


save_images <- function(sample_date) {
  tweet_sample <- tweets[sample_date == as.Date(created)]
  tweet_sample[,image:=get_image(url)]
  tweet_sample <- data.table(unnest(tweet_sample, image))
  tweet_sample <- tweet_sample[!is.na(image), list(image = unlist(image)), by = c('id', 'team')]
  
  dir_name <- sprintf('images/%s', format.Date(sample_date, '%Y%m%d'))
  
  if (!dir.exists(dir_name)) {
    dir.create(dir_name)
  }
  
  tweet_sample[,filename:=sprintf('%s/%s_%s', dir_name, team, basename(image))]
  apply(tweet_sample, 1, function(r) {
    if (!file.exists(r['filename'])) {
      download.file(r['image'], destfile = r['filename']) 
    }
  })
  tweet_sample
}
