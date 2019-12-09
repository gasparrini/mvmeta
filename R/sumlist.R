###
### R routines for the R package mvmeta (c)
#
sumlist <-
function(list) {
#
################################################################################
#
  res <- 0
  for(i in seq(list)) res <- res + list[[i]]
#
  res
}
