\name{mvmeta.fixed}
\alias{mvmeta.fixed}


\title{ Fixed-Effects Estimator for mvmeta Models }

\description{
This function implements a generalized least square estimator for fixed-effects multivariate and univariate meta-analysis and meta-regression. It is meant to be used internally and not directly run by the users.
}

\usage{
mvmeta.fixed(Xlist, ylist, Slist, nalist, k, m, p, nall, control, ...)
}

\arguments{
Assuming a meta-analysis or meta-regression based on \eqn{m} studies, \eqn{k} outcomes and \eqn{p} predictors:

  \item{Xlist }{ a \eqn{m}-dimensional list of study-specific design matrices for the fixed-effects part of the model. Rows corresponding to missing outcomes have been excluded.}
  \item{ylist }{ a \eqn{m}-dimensional list of study-specific vectors of estimated outcomes. Entries corresponding to missing outcomes have been excluded.}
  \item{Slist }{ a \eqn{m}-dimensional list of within-study (co)variance matrices of estimated outcomes. Rows and columns corresponding to missing outcomes have been excluded.}
  \item{nalist }{ a \eqn{m}-dimensional list of \eqn{k}-dimensional study-specific logical vectors, identifying missing outcomes.}
  \item{k, m, p, nall }{ numeric scalars: number of outcomes, number of studies included in estimation (equal to the length of lists above), number of predictors (including the intercept), number of observations (excluding missing).}
  \item{control }{ list of parameters for controlling the fitting process, usually internally set to default values by \code{\link{mvmeta.control}}.}
  \item{\dots }{ further arguments passed to or from other methods. Currently not used.}
}

\details{
The estimation involves only the \eqn{kp} fixed-effects coefficients.

The routine is based on a standard generalized least square (GLS) algorithm implemented in the internal function \code{glsfit}. The between-study (co)variance matrix is set to zero, so the marginal (co)variance matrix, composed only by elements of the within-study component, is assumed as completely known. Similarly to the likelihood-based estimators implemented in  \code{\link{mvmeta.ml}} and \code{\link{mvmeta.reml}}, the computation involves Cholesky and and QR decompositions for computational stability and efficiency. The method is described in details in Gasparrini and collaborators (2012) (see references below).
}

\value{
This function returns an intermediate list object, whose components are then processed by \code{\link{mvmeta.fit}}. Other components are added later through \code{\link{mvmeta}} to finalize an object of class \code{"mvmeta"}.
}

\references{
Sera F, Armstrong B, Blangiardo M, Gasparrini A (2019). An extended mixed-effects framework for meta-analysis.\emph{Statistics in Medicine}. 2019;38(29):5429-5444. [Freely available \href{http://www.ag-myresearch.com/2019_sera_statmed.html}{\bold{here}}].

Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].

Berkey, CS, Anderson JJ, Hoaglin DC (1996). Multiple-outcome meta-analysis of clinical trials. \emph{Statistics in Medicine}. \bold{15}(5):537--547.

Berkey, CS, Hoaglin DC, et al. (1998). Meta-analysis of multiple outcomes by regression with random effects. \emph{Statistics in Medicine}. \bold{17}(22):2537--2550.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
As stated earlier, this function is called internally by \code{\link{mvmeta.fit}}, and is not meant to be used directly. In particular, its code does not contain any check on the arguments provided, which are expected in specific formats. The function is however exported in the namespace and documented for completeness.

The arguments above are prepared by \code{\link{mvmeta.fit}} from its arguments \code{X}, \code{y} and \code{S}. The list structure, although requiring more elaborate coding, is computationally more efficient, as it avoids the specification of sparse block-diagonal matrices, especially for meta-analysis involving a large number of studies.

Some parameters of the fitting procedures are determined by the \code{control} argument, with default set by \code{\link{mvmeta.control}}. No missing values are accepted in the fitting functions. See details on \code{\link[=na.omit.data.frame.mvmeta]{missing values}}.
}

\seealso{
See \code{\link{mvmeta}} for the general usage of the functions. See \code{\link{mvmeta.control}} to determine specific parameters of the fitting procedures. Use the triple colon operator ('\code{:::}') to access the code of the internal functions, such as \code{glsfit}. See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# UNIVARIATE FIXED-EFFECTS MODEL
model <- mvmeta(yC,S=SCC,data=smoking,method="fixed")
summary(model)

# MULTIVARIATE FIXED-EFFECTS MODEL
y <- as.matrix(smoking[11:13])
S <- as.matrix(smoking[14:19])
model <- mvmeta(y,S,method="fixed")
summary(model)

# MULTIVARIATE FIXED-EFFECTS MODEL: REPLICATE THE RESULTS IN BERKEY ET AL. 1998
model <- mvmeta(cbind(PD,AL)~I(pubyear-1983),S=berkey98[5:7],
  data=berkey98,method="fixed")
summary(model)
}


\keyword{models}
\keyword{regression}
\keyword{multivariate}
