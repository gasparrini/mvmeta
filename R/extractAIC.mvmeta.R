###
### R routines for the R package mvmeta (c)
#
extractAIC.mvmeta <-
function (object, ...) {
#
################################################################################
# EXTRACTS THE NUMBER OF OBSERVATIONS USED FOR FITTING. USED BY BIC
#
   c(object$df$df,AIC(object))
#
}
