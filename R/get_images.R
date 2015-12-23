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
    page <- read_html(url)
    site <- page %>% html_node(xpath = '//meta[@property="og:site_name"]') %>% html_attr('content')
    
    images <- NA_character_
    if(site == 'Twitter') {
      images <- page %>% 
        html_nodes(css='.AdaptiveMedia-container .AdaptiveMedia-photoContainer img') %>% 
        html_attr('src')  
    } else if(site == 'Instagram') {
      images <- page %>% html_node(xpath='//meta[@property="og:image"]') %>% html_attr('content')
    } else if(substr(site, 0, 6) == 'Flickr') {
      images <- page %>% html_node(css='img.main-photo:not(.is-hidden)') %>% 
        html_attr('src') %>% substr(3, nchar(.))
      images <- paste0('http://', images)
    }
    
    images
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
  tweet_images_lists <- data.table(unnest(tweet_sample, image))
  tweet_images <- tweet_images_lists[!is.na(image), list(image = unlist(image)), by = c('id', 'team')]
  
  dir_name <- sprintf('images/%s', format.Date(sample_date, '%Y%m%d'))
  
  if (!dir.exists(dir_name)) {
    dir.create(dir_name)
  }
  
  tweet_images[,filename:=sprintf('%s/%s_%s', dir_name, team, basename(image))]
  if(nrow(tweet_images) == 0) {
    return(tweet_images)
  }
  
  apply(tweet_images, 1, function(r) {
    if (!file.exists(r['filename'])) {
      download.file(r['image'], destfile = r['filename']) 
    }
  })
  tweet_images
}
