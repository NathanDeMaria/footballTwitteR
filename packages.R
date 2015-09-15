packages <- c('ROAuth', 'XML', 'RSQLite', 'streamR')

sapply(packages, function(p) {
  has <- suppressWarnings(require(p, character.only = T))
  if (!has) {
    install.packages(p)
    require(p, character.only = T)
  }
})