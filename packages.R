packages <- c('twitteR', 'XML', 'RSQLite')

sapply(packages, function(p) {
  has <- require(p)
  if (!has) {
    install.packages(p)
  }
})