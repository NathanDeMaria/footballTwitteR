source('R/teams.R')

command_format <- '%s cd %s && Rscript %s/search.R "%s" >> %s/backup/stream.log'

schedule <- "0 * * * *"  # hourly, but can probably to this less often

commands <- sapply(names(teams), function(search_string) {
  sprintf(command_format, schedule, getwd(), getwd(), search_string, getwd())
})

daily_backup <- "0 0 * * * cp %s/tweets.db %s/backup/tweets_$(date +\\%%Y\\%%m\\%%d).db"
daily_update <- "0 12 * * * cd %s && Rscript %s/automation/push.R"

commands <- c(commands, 
              sprintf(daily_backup, getwd(), getwd()),
              sprintf(daily_update, getwd(), getwd()))

writeLines(commands, 'automation/football.cron')
