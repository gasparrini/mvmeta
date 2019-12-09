###
### R routines for the R package mvmeta (c)
#
model.matrix.mvmeta <-
function(object, ...) {
#
################################################################################
#
  data <- model.frame(object,xlev=object$xlevels, ...)
  NextMethod("model.matrix",data=data,contrasts.arg=object$contrasts)
}
