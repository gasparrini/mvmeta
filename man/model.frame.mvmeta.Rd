\name{model.frame.mvmeta}
\alias{model.frame.mvmeta}
\alias{model.matrix.mvmeta}


\title{ Extract Model Frame and Design Matrix from mvmeta Objects }

\description{
These method functions return the model frame and design matrix for univariate or multivariate meta-analytical models represented in objects of class \code{"mvmeta"}.
}

\usage{
\method{model.frame}{mvmeta}(formula, \dots)

\method{model.matrix}{mvmeta}(object, \dots)
}

\arguments{
  \item{object, formula }{ an object of class \code{"mvmeta"}.}
  \item{\dots }{ further arguments passed to or from other methods.}
}

\details{
The model frame is produced by \code{\link{mvmeta}} when fitting the meta-analytical model, and stored in the \code{mvmeta} object if argument \code{model=TRUE}. Alternatively, the model frame is directly returned by \code{\link{mvmeta}} with argument \code{method="model.frame"}. The method function \code{model.frame} simply extracts the saved model frame if available, or otherwise evaluates a call to \code{\link{mvmeta}} when \code{method="model.frame"}.

The method function \code{model.matrix} extracts the design matrix from a fitted meta-analytical model. It first extract the model frame by calling \code{model.frame}, and then passes the call to the default method.

These methods functions are similar to those provided for regression objects \code{\link{lm}} and \code{\link{lm}}.
}

\value{
For \code{model.frame}, a data.frame with special attributes (see the default method \code{\link{model.frame}}) and the additional class \code{"data.frame.mvmeta"}.

For \code{model.matrix}, the design matrix used to fit the model.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
The reason why these specific method functions are made available for class \code{mvmeta}, and in particular why a new class \code{"data.frame.mvmeta"} has been defined for model frames, lies in the special handling of missing values in multivariate meta-analysis models fitted with \code{\link{mvmeta}}. Methods \code{\link[=na.omit.data.frame.mvmeta]{na.omit}} and \code{\link[=na.exclude.data.frame.mvmeta]{na.exclude}} for class \code{"data.frame.mvmeta"} are useful for properly accounting for missing values when fitting these models.
}

\seealso{
See the default methods \code{\link{model.frame}} and \code{\link{model.matrix}}. See \code{\link[=na.omit.data.frame.mvmeta]{na.omit}} and \code{\link[=na.exclude.data.frame.mvmeta]{na.exclude}} on the handling of missing values.
See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# RUN THE MODEL AND SUMMARIZE THE RESULTS
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98,method="ml")

# MODEL FRAME
model$model
model.frame(model)
update(model,method="model.frame")
class(model.frame(model))

# MODEL MATRIX
model.matrix(model)
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
\keyword{methods}
