library(shiny)

ui <- bootstrapPage(
  selectInput('select_plot', label = 'Plot', choices = c('Map', 'Time')),
  plotOutput('plot')
)

server <- function(input, output, session) {
  source('visualize.R', local = T)
  output$plot <- renderPlot({
    if(input$select_plot == 'Map') {
      selected_map <- map_plot
    } else {
      selected_map <- time_plot
    }
    suppressWarnings(print(selected_map))
  })
}

print(shinyApp(ui = ui, server = server, options=list(host='0.0.0.0', port = 3520)))
