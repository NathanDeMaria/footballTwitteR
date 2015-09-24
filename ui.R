library(shiny)

shinyUI(
  bootstrapPage(
    selectInput('select_plot', label = 'Plot', choices = c('Map', 'Time')),
    plotOutput('plot')
  )
)