\name{summary.mvmeta}
\alias{summary.mvmeta}
\alias{print.mvmeta}
\alias{print.summary.mvmeta}

\title{ Summarizing mvmeta Models }

\description{
Print and summary method functions for fitted univariate or multivariate meta-analytical models represented in objects of class \code{"mvmeta"}.
}

\usage{
\method{summary}{mvmeta}(object, ci.level=0.95, \dots)

\method{print}{summary.mvmeta}(x, digits=4, \dots)

\method{print}{mvmeta}(x, digits=4, \dots)
}

\arguments{
  \item{object }{ an object of class \code{"mvmeta"} produced by a call to \code{\link{mvmeta}}.}
  \item{x }{ an object of class \code{"mvmeta"} or \code{"summary.mvmeta"}, produced by calls to \code{\link{mvmeta}} or \code{summary.mvmeta}, respectively.}
  \item{ci.level }{ a numerical value between 0 and 1, specifying the confidence level for the computation of confidence intervals.}
  \item{digits }{ an integer specifying the number of digits to which printed results must be rounded.}
  \item{\dots }{ further arguments passed to or from other methods.}
}

\details{
The \code{print} method function for class \code{"mvmeta"} only returns basic information on the fitted model, namely the call, estimated fixed-effects coefficients, dimensions and fit statistics (log-likelihood, AIC, BIC).

The \code{summary} method function computes additional statistics and tests, and produces a list object of class \code{"summary.mvmeta"}. The \code{print} method function for this class shows additional information, such as tables reporting the estimates for the fixed and random-effects parts of the model, Cochran Q test for heterogeneity and \eqn{I^2}. 
}

\value{
The \code{summary} method function for \code{mvmeta} objects produces a list of class \code{"summary.mvmeta"}. The components of the lists are some of those stored in the related \code{mvmeta} object, plus the following:

  \item{coefficients }{ a matrix reporting point estimates, standard errors, z statistics and related p-values of the test, and confidence intervals for the \eqn{kp} fixed-effects coefficients. Note this is different than the component with the same name stored in \code{mvmeta} objects, simply reporting the point estimates (see \code{\link{mvmetaObject}}).}
  \item{AIC }{ the value of the Akaike information criterion for the fitted \code{mvmeta} model, obtained through a call to \code{\link{AIC}}.}
  \item{BIC }{  the value of the Bayesian information criterion for the fitted \code{mvmeta} model, obtained through a call to \code{\link{BIC}}.}
  \item{corFixed }{ the \eqn{kp \times kp}{kp x kp} correlation matrix of the fixed-effects coefficients, obtained from the (co)variance matrix \code{vcov} (see \code{\link{mvmetaObject}} and \code{\link[=vcov.mvmeta]{vcov}}).}
  \item{corRandom }{ the \eqn{k \times k}{k x k} correlation matrix of the random effects, obtained from the between-study (co)variance matrix \code{Psi} (see see \code{\link{mvmetaObject}}).}
  \item{qstat }{ results from the Cochran Q test for heterogeneity, namely a list corresponding to a \code{qtest.mvmeta} object without its class, obtained through \code{\link[=qtest.mvmeta]{qtest}}.}
  \item{ci.level }{ the confidence level used for defining the confidence intervals for the estimates of the fixed-effects coefficients.}

As usual, the \code{print} method functions for classes \code{"mvmeta"} and \code{"summary.mvmeta"} do not return any value.
}

\references{
Sera F, Armstrong B, Blangiardo M, Gasparrini A (2019). An extended mixed-effects framework for meta-analysis.\emph{Statistics in Medicine}. 2019;38(29):5429-5444. [Freely available \href{http://www.ag-myresearch.com/2019_sera_statmed.html}{\bold{here}}].

Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\seealso{
See \code{\link{mvmeta}} and \code{\link{mvmetaObject}}.
}


\examples{
# RUN THE MODEL 
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98)

# SIMPLE PRINT
model
# DEFINE DIGITS
print(model,digit=2)
# SUMMARY WITH 80TH CONFIDENCE INTERVALS
summary(model,ci.level=0.80)
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
\keyword{methods}
