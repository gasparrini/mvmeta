\name{mlprof.fn}
\alias{mlprof.fn}
\alias{remlprof.fn}
\alias{mlprof.gr}
\alias{remlprof.gr}
\alias{iter.igls}

\title{ Likelihood Functions for mvmeta Models }

\description{
These functions compute the value of the log-likelihood and the related vectors of first partial derivatives for random-effects multivariate and univariate meta-analysis and meta-regression, in terms of model parameters. They are meant to be used internally and not directly run by the users.
}

\usage{

mlprof.fn(par, Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, ctrl)
mlprof.gr(par, Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, ctrl)

remlprof.fn(par, Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, ctrl)
remlprof.gr(par, Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, ctrl)

iter.igls(Psi, Xlist, ylist, Slist, nalist, k, m)
}

\arguments{
Assuming a meta-analysis or meta-regression based on \eqn{m} studies, \eqn{k} outcomes and \eqn{p} predictors:

  \item{par }{ a vector representing the random-effects parameters defining the between-study (co)variance matrix.}
  \item{Psi }{ a \eqn{k \times k}{k x k} matrix representing the current estimate of the between-study (co)variance matrix.}
  \item{Xlist }{ a \eqn{m}-dimensional list of study-specific design matrices for the fixed-effects part of the model. Rows corresponding to missing outcomes have been excluded.}
  \item{ylist }{ a \eqn{m}-dimensional list of study-specific of vectors of estimated outcomes. Entries corresponding to missing outcomes have been excluded.}
  \item{Slist }{ a \eqn{m}-dimensional list of within-study (co)variance matrices of estimated outcomes. Rows and columns corresponding to missing outcomes have been excluded.}
  \item{nalist }{ a \eqn{m}-dimensional list of \eqn{k}-dimensional study-specific logical vectors, identifying missing outcomes.}
  \item{k, m, p, nall }{ numeric scalars: number of outcomes, number of studies included in estimation (equal to the length of lists above), number of predictors (including the intercept), number of observations (excluding missing).}
  \item{bscov }{ a string defining the between-study (co)variance structure in likelihood based models. See Details.}
  \item{ctrl }{  list of parameters for controlling the fitting process, usually internally set to default values by \code{\link{mvmeta.control}}. The name is chosen to avoid conflicts with the argument \code{control} in \code{\link{optim}}.}
}

\details{
These functions are called internally by the fitting functions \code{\link{mvmeta.ml}} and \code{\link{mvmeta.reml}} to perform iterative optimization algorithms for estimating random effects meta-analytical models.

The maximization of the (restricted) likelihood starts with few runs of an iterative generalized least square algorithm implemented in \code{iter.igls}. This can be regarded as a fast and stable way to get starting values close to the maximum for the Quasi-Newton iterative algorithm, implemented in \code{\link{optim}}. Alternatively, starting values can be provided by the user in the control list (see \code{\link{mvmeta.control}}). The function  \code{\link{optim}} requires the algorithms to compute the value of the (restricted) likelihood and (optionally) the vector of its first partial derivatives, provided by the related likelihood functions.

These functions actually specify the \emph{profiled} version of the (restricted) likelihood, expressed only in terms of random-effects parameters, while the estimate of the fixed-effects coefficients is provided at each iteration by the internal function \code{glsfit}, based on the current value of the between-study (co)variance matrix. At convergence, the value of this profiled version is identical to the full (restricted) likelihood. This approach is computationally efficient, as it reduces the number of parameters in the optimization routine, especially for meta-regression models.

The random-effects parameters in \code{par} depends on the chosen \code{\link[=mvmetaCovStruct]{structure}} for the between-study (co)variance matrix. The parameterization ensures the positive-definiteness of the estimated matrix. A Cholesky decomposition is then performed on the marginal (co)variance matrix in order to re-express the problem as standard least square equations, an approach which speeds up the computation of matrix inverses and determinants. These equations are finally solved through a QR decomposition, which guarantees stability. More details are provided in the references below.

Some parameters of the fitting procedures are determined through \code{\link{mvmeta.control}}. Specifically, the user can obtain the Hessian matrix of the estimated parameters (appropriately transformed, see \code{\link{mvmetaCovStruct}}) in the optimization function by setting \code{hessian=TRUE}, and specific control settings in the optimization process can be defined by the control list argument \code{optim}. These values are passed to the optimization function \code{\link{optim}}.
}

\value{
\code{mlprof.fn} and \code{remlprof.fn} return the value of the (restricted) log-likelihood for a given set of parameters in \code{par}. \code{mlprof.gr} and \code{remlprof.gr} return instead the related vector of first partial derivatives. \code{iter.igls} returns an updated estimate of \code{Psi} given its initial value or the value at the previous iteration.
}

\references{
Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/statmed2012.html}{\bold{here}}].

Goldstein H (1986). Multilevel mixed linear model analysis using iterative generalized least squares. \emph{Biometrika}. \bold{73}(1):43.

Lindstrom MJ and Bates DM (1988). Newton-Raphson and EM algorithms for linear mixed-effects models for repeated-measures data. \emph{Journal of the American Statistical Association}. \bold{83}(404):1014--1022.

Pinheiro JC and Bates DM (2000). \emph{Mixed-Effects Models in S and S-PLUS}. New York, Springer Verlag.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
As stated earlier, these functions are called internally by \code{\link{mvmeta.ml}} and \code{\link{mvmeta.reml}}, and are not meant to be used directly. In particular, their code does not contain any check on the arguments provided, which are expected in specific formats. They are however exported in the namespace and documented for completeness.
}

\seealso{
See \code{\link{mvmeta.fit}} and \code{\link{mvmeta.ml}} for additional info on the fitting procedures. See \code{\link{mvmeta.control}} to determine specific parameters of the fitting procedures. See \code{\link{mvmetaCovStruct}} for (co)variance structures. See \code{\link{chol}} and \code{\link{qr}} for info on the Cholesky and QR decomposition.
See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
