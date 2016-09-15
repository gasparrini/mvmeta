\name{mvmetaSim}
\alias{mvmetaSim}
\alias{simulate.mvmeta}


\title{ Simulating Responses for mvmeta Models }

\description{
These functions simulate sets of multivariate or univariate responses for a group of studies, in terms of their mean (expected) values and within and between-study (co)variances. These sets of outcomes can be used in meta-analytical models for simulation purposes.
}

\usage{
mvmetaSim(y, S, Psi, sd, cor, nsim=1, seed=NULL, posdeftol)

\method{simulate}{mvmeta}(object, nsim=1, seed=NULL, \dots)
}

\arguments{
In order to simulate \eqn{k} outcomes for \eqn{m} studies:

  \item{y }{ a \eqn{m}-dimensional vector (for simulating univariate responses) or \eqn{m \times k}{m x k} matrix (for simulating multivariate responses) of mean (expected) outcomes.}
  \item{S }{ series of within-study (co)variance matrices of the outcomes for each one of the \eqn{m} studies. Accepted formats are a \eqn{m}-dimensional list of \eqn{k \times k}{k x k} matrices; a tri-dimensional \eqn{k \times k \times m}{k x k x m} array; or a \eqn{m \times k(k+1)/2}{m x k(k+1)/2} matrix or data frame where each row represents the vectorized entries of the lower triangle of the related (co)variance matrix, taken by column (see \code{\link{xpndMat}}).}
  \item{Psi }{ the between-study (co)variance matrices of the outcomes. Accepted formats are a \eqn{k \times k}{k x k} matrix or a \eqn{k(k+1)/2}-dimensional vector, representing the vectorized entries of the lower triangle of the related (co)variance matrix, taken by column (see \code{\link{xpndMat}}).}
  \item{sd }{ a \eqn{k}-dimensional vector of between-study standard deviations.}
  \item{cor }{ between-study correlations. Either a scalar, a vector or a matrix. See \code{\link{inputcov}}.}
  \item{nsim }{ number of simulation sets.}
  \item{seed }{ an object specifying if and how the random number generator should be initialized.}
  \item{posdeftol }{ tolerance (relative to largest variance) for numerical lack of positive-definiteness. Default to the square root of the machine precision.}
  \item{object }{  an object of class \code{"mvmeta"}.}
  \item{\dots }{ further arguments passed to or from other methods.}
}

\details{
The set(s) of responses can be simulated either from a fitted model, using the method function \code{simulate} for objects of class \code{"mvmeta"}, or directly through the function \code{mvmetaSim}. In the former case, the fitted values from the model are used as mean (expected) outcomes, together with the within and estimated between-study (co)variance. In the latter option, this information need to be provided by the user in the correct dimensions and forms.

In \code{mvmetaSim}, the between-study (co)variance matrix can be inputted directly through \code{Psi}, or given in the form \eqn{\boldsymbol{DRD}}{DRD}, with a diagonal matrix  \eqn{\boldsymbol{D}}{D} of standard deviations and correlation matrix \eqn{\boldsymbol{R}}{R}. These values are provided through \code{sd} and \code{cor}. See \code{\link{inputcov}} for details.

The functions simulate the responses for each study separately from a marginal multivariate normal distribution with mean equal to the expected values and (co)variance equal to the sum of the within and between-study components. The computation is identical to that implemented in the function \code{mvrnorm} of the package \pkg{MASS}, involving a eigen decomposition of the marginal (co)variance matrix. Numerical negative definiteness is allowed with a tolerance specified by \code{posdeftol}, and positive semi-definiteness is then forced by truncating the eigenvalues at zero.
}

\value{
If \code{nsim=1}, a matrix or vector of simulated \eqn{k} outcomes for the \eqn{m} studies. If more simulation sets are required (\code{nsim} higher than 1), a list of matrices or vectors.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
Studies with missing values in the fitted values or in the components of the within (co)variances are excluded by \code{simulate}. Missing values are instead not accepted in \code{metaSim}.
}

\seealso{ 
See \code{\link{simulate}} for the general method function. See \code{\link{inputcov}} for inputting correlations. See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# RUN A MODEL
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98)

# SIMULATE A NEW SET OF OUTCOMES
simulate(model)

# SIMULATE FROM SCRATCH: 3 OUTCOMES, 8 STUDIES
(y <- matrix(0,8,3))
(S <- inputcov(matrix(runif(8*3,0.1,2),8,3,dimnames=list(NULL,
  c("V1","V2","V3"))),cor=c(0,0.5,0.7)))
(Psi <- inputcov(1:3,cor=0.3))
mvmetaSim(y,S,Psi)

# ALTERNATIVELY, DEFINE Psi THROUGH STANDARD DEVIATIONS AND CORRELATION 0.2
mvmetaSim(y,S,sd=1:3,cor=0.3)

# 2 SIMULATION SETS
mvmetaSim(y,S,Psi,nsim=2)
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
\keyword{methods}
