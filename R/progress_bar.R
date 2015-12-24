progress_bar <- function(n, title) {
  
  progress <- 0
  
  tryCatch({
    pb <- winProgressBar(title = title, max = n, label = "0% completed")
    
    inc <- function() {
      progress <<- progress + 1
      completion <- sprintf("%.02f%% completed", progress / n * 100)
      setWinProgressBar(pb, progress, label = completion)
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
