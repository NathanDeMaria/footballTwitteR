# TODO: include how to get `urls`...it's really similar to the stuff in `get_images.R`

view_image <- function(r) {
  temp_dir <- tempfile()
  dir.create(temp_dir)
  html_file <- file.path(temp_dir, "test.html")
  writeLines(sprintf('<h1>%s</h1><img src="%s" />', r$team, r$image), html_file)
  viewer <- getOption('viewer')
  viewer(html_file)
}

i <- 1
view_image(urls[i, list(team, image)]); i <- i + 1
