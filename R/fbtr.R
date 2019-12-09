###
### R routines for the R package mvmeta (c)
#
fbtr <- 
function(A,k) {
#
################################################################################
#
  btrA <- 0
  for(i in seq(dim(A)[1]/k)) {
    ind <- (i-1)*k+1:k
    btrA <- btrA + A[ind,ind]
  }
#
  btrA
}

#
