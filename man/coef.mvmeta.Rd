\name{coef.mvmeta}
\alias{coef.mvmeta}
\alias{vcov.mvmeta}


\title{ Extract Coefficients and (Co)Variance Matrix from mvmeta Objects }

\description{
These method functions return the estimated fixed-effects coefficients and their (co)variance matrix for fitted univariate or multivariate meta-analytical models represented in objects of class \code{"mvmeta"}.
}

\usage{
\method{coef}{mvmeta}(object, format=c("vector","matrix"), \dots)

\method{vcov}{mvmeta}(object, \dots)
}

\arguments{
  \item{object }{ an object of class \code{"mvmeta"}.}
  \item{format }{ format of the returned object.}
  \item{\dots }{ further arguments passed to or from other methods.}
}

\value{
For \code{coef}, a vector (default) or matrix with the estimated fixed-effects coefficients. The matrix-structure is used to store the fixed-effects coefficients in \code{mvmeta} objects, and is preserved if \code{format="matrix"}.

For \code{vcov}, the (co)variance matrix of the estimated fixed-effects coefficients.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\seealso{
See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# RUN THE MODEL
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98)

# COEFFICIENTS
model$coef
coef(model)
coef(model,format="matrix")
summary(model)$coef

# (CO)VARIANCE MATRIX
vcov(model)
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
\keyword{methods}
