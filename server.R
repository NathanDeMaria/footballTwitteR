library(shiny)

shinyServer(function(input, output) {
  source('visualize.R', local = T)
  cat(sprintf('New connection at %s\n', Sys.time()))
  
  output$status_table <- renderTable({
    info <- data.frame(val=c(
      as.character(tweets[,max(scrape_time)]),
      as.character(tweets[,max(created)]),
      nrow(tweets)
    ))
    rownames(info) <- c(
      "Most Recent Scrape",
      "Most Recent Tweets",
      "# of Tweets"
    )
    info
  }, include.colnames=F)
  
  output$map <- renderPlot({
    suppressWarnings(print(map_plot))
  })
  
  output$time <- renderPlot({
    suppressWarnings(print(time_plot))
  })
})