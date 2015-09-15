source('teams.R')

command_format <- '%s cd %s && Rscript %s/search.R "%s" >> %s/stream.log'

schedule <- "0 * * * *"  # hourly, but can probably to this less often

commands <- sapply(names(teams), function(search_string) {
  sprintf(command_format, schedule, getwd(), getwd(), search_string, getwd())
})

daily_backup <- "0 0 * * * cp %s/tweets.db %s/backup/tweets_$(date +\\%%Y\\%%m\\%%d).db"

commands <- c(commands, sprintf(daily_backup, getwd(), getwd()))

writeLines(commands, 'football.cron')