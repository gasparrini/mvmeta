\name{mvmeta.mm}
\alias{mvmeta.mm}


\title{ Method of Moments Estimator for mvmeta Models }

\description{
This function implements a method of moments estimator for multivariate and univariate  random-effects meta-analysis and meta-regression. It is meant to be used internally and not directly run by the users.
}

\usage{
mvmeta.mm(Xlist, ylist, Slist, nalist, k, m, p, nall, control, ...)
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
The estimation involves \eqn{kp} fixed-effects coefficients and \eqn{k(k+1)/2} random-effects parameters, corresponding to the lower triangular entries of the between-study (co)variance matrix.

The approach implemented here represents the multivariate extension of the traditional estimator proposed by DerSimonian and Laird (1986), and simplifies to the standard method in the univariate case. This non-iterative routine forces the positive semi-definiteness of the estimated between-study (co)variance matrix by setting its negative eigenvalues to zero.

The specific method of moment estimator used here is described in Jackson and collaborators (2013), and represents a generalization of that developed by Chen and collaborators (2012). However, this general version is computationally more intensive, and may turn out to be slow when applied to meta-analysis of a relatively high number of studies. An alternative and computationally faster method of moment estimator was previously proposed by Jackson and collaborators (2010), although it is not invariant to reparameterization. This latter estimator is not implemented yet in \pkg{mvmeta}. See references below.
}

\value{
This function returns an intermediate list object, whose components are then processed by \code{\link{mvmeta.fit}}. Other components are added later through \code{\link{mvmeta}} to finalize an object of class \code{"mvmeta"}.
}

\references{
Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].

Jackson D, White IR, Riley RD (2013). A matrix based method of moments for fitting the multivariate random effects model for meta-analysis and meta-regression. \emph{Biometrical Journal}. \bold{55}(2):231-245.

Chen H, Manning AK, Dupuis J (2012). A method of moments estimator for random effect multivariate meta-analysis. \emph{Biometrics}. \bold{68}(4):1278-1284.

Jackson D, White IR, Thompson SG (2010). Extending DerSimonian and Laird's methodology to perform multivariate random effects meta-analyses. \emph{Statistics in Medicine}. \bold{29}(12):1282--1297.

DerSimonian R, Laird N (1986). Meta-analysis in clinical trials. \emph{Controlled Clinical Trials}. \bold{7}(3):177-188.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
As stated earlier, this function is called internally by \code{\link{mvmeta.fit}}, and is not meant to be used directly. In particular, its code does not contain any check on the arguments provided, which are expected in specific formats. The function is however exported in the namespace and documented for completeness.

The arguments above are prepared by \code{\link{mvmeta.fit}} from its arguments \code{X}, \code{y} and \code{S}. The list structure, although requiring more elaborate coding, is computationally more efficient, as it avoids the specification of sparse block-diagonal matrices, especially for meta-analysis involving a large number of studies.

Some parameters of the fitting procedures are determined by the \code{control} argument, with default set by \code{\link{mvmeta.control}}. No missing values are accepted in the fitting functions. See details on \code{\link[=na.omit.data.frame.mvmeta]{missing values}}.
}

\seealso{
See \code{\link{mvmeta}} for the general usage of the functions. See \code{\link{mvmeta.control}} to determine specific parameters of the fitting procedures. Use the triple colon operator ('\code{:::}') to access the code of the internal functions, such as \code{fbtr}. See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# MM ESTIMATOR: UNIVARIATE MODEL
model <- mvmeta(PD~pubyear,S=berkey98[,5],data=berkey98,method="mm")
summary(model)

# MM ESTIMATOR: REPRODUCE THE RESULTS IN CHEN ET AL. (2012)
S <- as.matrix(hsls[5:10])
model <- mvmeta(cbind(b1,b2,b3),S,data=hsls,method="mm")
summary(model)

# MM ESTIMATOR: REPRODUCE THE RESULTS IN JACKSON ET AL. (2013)
S <- inputcov(hyp[c("sbp_se","dbp_se")],cor=hyp$rho)
model <- mvmeta(cbind(sbp,dbp),S=S,data=hyp,method="mm")
summary(model)
}


\keyword{models}
\keyword{regression}
\keyword{multivariate}
