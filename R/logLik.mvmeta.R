###
### R routines for the R package mvmeta (c)
#
logLik.mvmeta <-
function(object, ...) {
#
################################################################################
#
  val <- object$logLik
  attributes(val) <- object$df
#
  class(val) <- "logLik"
#
  val
}

