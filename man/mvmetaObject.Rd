\name{mvmetaObject}
\alias{mvmetaObject}


\title{ mvmeta Objects }

\description{
An object returned by the \code{\link{mvmeta}} function, inheriting from class \code{"mvmeta"}, and representing a fitted univariate or multivariate meta-analytical model.
}
  
\value{
Objects of class \code{"mvmeta"} are lists with defined components. Dimensions of such components may refer to \eqn{k} outcome parameters, \eqn{p} predictors and \eqn{m} studies used for fitting the model (the latter can be different from those originally selected due to missing). The following components needs to be included in a legitimate \code{mvmeta} object:

  \item{\code{coefficients} }{ a \eqn{p}-dimensional vector (for univariate models) or a \eqn{p \times k}{p x k} matrix (for multivariate models) of the fixed-effects coefficients.}
    \item{vcov }{ estimated \eqn{kp \times kp}{kp x kp} (co)variance matrix of the fixed-effects coefficients.}
  \item{Psi }{ for random-effects models, the estimated \eqn{k \times k}{k x k} between-study (co)variance matrix.}
  \item{residuals }{ a \eqn{m}-dimensional vector (for univariate models) or \eqn{m \times k}{m x k} matrix (for multivariate models) of residuals, that is observed minus fitted values.}
  \item{fitted.values }{ a \eqn{m}-dimensional vector (for univariate models) or \eqn{m \times k}{m x k} matrix (for multivariate models) of fitted mean values.}
  \item{df.residual }{ the residual degrees of freedom.}
  \item{rank }{ the numeric rank of the fitted model.}
  \item{logLik }{ the (restricted) log-likelihood of the fitted model. Set to \code{NA} for non-likelihood models.}
  \item{converged, niter }{ for models with iterative estimation methods, logical scalar indicating if the algorithm eventually converged.}
  \item{par }{ parameters estimated in the optimization process when using likelihood-based estimators. These correspond to trasformations of entries of the between-study (co)variance matrix of random effects, dependent on chosen \code{\link[=mvmetaCovStruct]{(co)variance structure}}. See also the \code{\link[=mlprof.fn]{optimizations algorithms}} for details.}
  \item{hessian }{ Hessian matrix of the estimated parameters in \code{par} above, only returned if \code{hessian=TRUE} in \code{\link{mvmeta.control}}. See the related \code{\link[=mlprof.fn]{optimizations algorithms}} for details.}
  \item{negeigen }{ for models fitted through method of moments, the number of negative eigenvalues in the estimated between-study (co)variance matrix, then set to 0.}
  \item{control }{ a list with the values of the control arguments used, as returned by \code{\link{mvmeta.control}}.}
  \item{method }{ the estimation method.}
  \item{bscov }{ a string defining the between-study (co)variance structure in likelihood based models.}
  \item{S }{ a \eqn{m \times k(k+1)/2}{m x k(k+1)/2} matrix, where each row represents the vectorized entries of the lower triangle of the related within-study (co)variance matrix, taken by column. See \code{\link{mvmeta}}.}
  \item{dim }{ list with the following scalar components: \code{m} (number of studies included in estimation, which could be lower than the total number in the presence of missing values), \code{k} (number of outcome parameters), \code{p} (number of coefficients for each outcome parameter).}
  \item{df }{ list with the following scalar components: \code{nall} (number of observations used for estimation, excluding missing values), \code{nobs} (equal to \code{nall}, minus the number of fixed-effects coefficients in REML models), \code{fixed} (number of estimated fixed-effects coefficients), \code{random} (number of estimated (co)variance terms).}
  \item{lab }{ list with the following label vectors: \code{m} for the \eqn{m} studies, \code{k} for the \eqn{k} outcome parameters, \code{p} for the \eqn{p} predictors (including intercept). The first two are derived from the vector/matrix of outcome parameters in \code{\link{formula}}, the third from the design matrix derived from \code{\link[=model.matrix.mvmeta]{model.matrix}}.}
  \item{model }{ the model frame used for fitting. Reported if \code{model=TRUE} in \code{\link{mvmeta}}. See \code{\link[=model.frame.mvmeta]{model.frame}}.}
  \item{call }{ the function call.}
  \item{na.action }{ (where relevant) information returned by \code{\link[=model.frame.mvmeta]{model.frame}} on the special handling of NAs. See info on \code{\link[=na.omit.data.frame.mvmeta]{missing values}}.}
  \item{formula }{ the model supplied.}
  \item{terms }{ the \code{\link{terms}} object representing the fitted model.}
  \item{contrasts }{ (where relevant) the contrasts used.}
  \item{xlevels }{ (where relevant) a record of the levels of the factors used in fitting.}
}

\section{Methods}{
A number of methods functions are available for \code{mvmeta} objects, most of them common to other regression functions.

Specifically-written method functions are defined for \code{\link[=predict.mvmeta]{predict}} (standard predictions) and \code{\link[=blup.mvmeta]{blup}} (best linear unbiased predictions). The method function \code{\link[=simulate.mvmeta]{simulate}} produces simulated outcomes from a fitted model, while \code{\link[=qtest.mvmeta]{qtest}} performs the Cochran Q test for heterogeneity. Other methods have been produced for \code{\link[=summary.mvmeta]{summary}}, \code{\link[=logLik.mvmeta]{logLik}}, \code{\link[=coef.mvmeta]{coef}}, and \code{\link[=vcov.mvmeta]{vcov}}.

Specific methods are also available for \code{\link[=model.frame.mvmeta]{model.frame}} and \code{\link[=model.matrix.mvmeta]{model.matrix}}. In particular, the former produces the model frame (a data frame with special attributes storing the variables used for fitting) with the additional class \code{"data.frame.mvmeta"}. Methods \code{\link[=na.omit.data.frame.mvmeta]{na.omit}} and \code{\link[=na.exclude.data.frame.mvmeta]{na.exclude}} for this class are useful for the handling of missing values in \code{mvmeta} objects.

Printing functions for the objects of classes defined above are also provided. \code{anova} methods for performing tests in \code{mvmeta} objects are in development.

All the methods above are visible (exported from the namespace) and documented. In additions, several default method functions for regression are also  applicable to objects of class \code{"mvmeta"}, such as \code{\link{fitted}}, \code{\link{residuals}}, \code{\link{AIC}}, \code{\link{BIC}} and \code{\link{update}}, among others.
}

\references{
Sera F, Armstrong B, Blangiardo M, Gasparrini A (2019). An extended mixed-effects framework for meta-analysis.\emph{Statistics in Medicine}. 2019;38(29):5429-5444. [Freely available \href{http://www.ag-myresearch.com/2019_sera_statmed.html}{\bold{here}}].

Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\seealso{ 
See \code{\link{mvmeta}}. See \code{\link{lm}} or \code{\link{glm}} for standard regression functions. See \code{\link{mvmeta-package}} for an overview of this modelling framework.
}

\examples{
# RUN THE MODEL
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98)

# INSPECT THE OBJECT
names(model)

# LABELS
model$lab

# FORMULA
model$formula

# CONVERGED?
model$converged
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}

