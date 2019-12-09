###
### R routines for the R package mvmeta (c)
#
nobs.mvmeta <-
function (object, ...) {
#
################################################################################
# EXTRACTS THE NUMBER OF OBSERVATIONS USED FOR FITTING. USED BY BIC
#
  object$df$nobs
#
}
