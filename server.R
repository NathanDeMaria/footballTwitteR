library(shiny)

shinyServer(function(input, output) {
  source('visualize.R', local = T)
  cat(sprintf('New connection at %s\n', Sys.time()))
  output$plot <- renderPlot({
    cat(sprintf('Requested %s at %s\n', input$select_plot, Sys.time()))
    if(input$select_plot == 'Map') {
      selected_plot <- map_plot
    } else {
      selected_plot <- time_plot
    }
    suppressWarnings(print(selected_plot))
  })
})