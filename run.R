library(shiny)

args <- commandArgs(trailingOnly = F)
this_file <- gsub('--file=', '', args[grepl('--file', args)])
shiny_dir <- normalizePath(dirname(this_file))

runApp(appDir = shiny_dir, host = '0.0.0.0', port = 3520)
