progress_bar <- function(n, title) {
  
  progress <- 0
  
  tryCatch({
    pb <- winProgressBar(title = title, max = n, label = "Initializing...")
    
    start_time <- Sys.time()
    
    inc <- function() {
      progress <<- progress + 1
      current_time <- Sys.time()
      
      current_completion_rate <- progress / as.numeric(current_time - start_time, units = 'secs')
      time_remaining <- (n - progress) * current_completion_rate
      
      remaining_string <- sprintf("%.0f seconds remaining", time_remaining)
      
      completion <- sprintf("%.02f%% completed", progress / n * 100)
      setWinProgressBar(pb, progress, title = sprintf("%s (%s)", title, completion), label = remaining_string)
    }
    
    close_bar <- function() {
      close(pb)
      progress >= n
    }
    
    list(inc=inc, close=close_bar)  
  }, error = function(e) {
    if(e$message == 'could not find function "winProgressBar"') {
      # In case of non-Windows
      NULL
    } else {
      stop(e$message)
    }
  })
}
