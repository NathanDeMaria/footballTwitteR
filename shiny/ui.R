library(shiny)

shinyUI(
  bootstrapPage(
    tabsetPanel(
      tabPanel('Status', tableOutput('status_table')),
      tabPanel('Map', plotOutput('map')),
      tabPanel('Time', plotOutput('time'))
    )
  )
)