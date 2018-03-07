\name{mvmeta.ml}
\alias{mvmeta.ml}
\alias{mvmeta.reml}


\title{ ML and REML Estimators for mvmeta Models }

\description{
These functions implement maximum likeliihood (ML) and restricted maximum likelihood (REML) estimators for random-effects multivariate and univariate meta-analysis and meta-regression. They are meant to be used internally and not directly run by the users.
}

\usage{
mvmeta.ml(Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, control, ...)

mvmeta.reml(Xlist, ylist, Slist, nalist, k, m, p, nall, bscov, control, ...)
}

\arguments{
Assuming a meta-analysis or meta-regression based on \eqn{m} studies, \eqn{k} outcomes and \eqn{p} predictors:

  \item{Xlist }{ a \eqn{m}-dimensional list of study-specific design matrices for the fixed-effects part of the model. Rows corresponding to missing outcomes have been excluded.}
  \item{ylist }{ a \eqn{m}-dimensional list of study-specific vectors of estimated outcomes. Entries corresponding to missing outcomes have been excluded.}
  \item{Slist }{ a \eqn{m}-dimensional list of within-study (co)variance matrices of estimated outcomes. Rows and columns corresponding to missing outcomes have been excluded.}
  \item{nalist }{ a \eqn{m}-dimensional list of \eqn{k}-dimensional study-specific logical vectors, identifying missing outcomes.}
  \item{k, m, p, nall }{ numeric scalars: number of outcomes, number of studies included in estimation (equal to the length of lists above), number of predictors (including the intercept), number of observations (excluding missing).}
  \item{bscov }{ a string defining the between-study (co)variance structure in likelihood based models. See Details.}
  \item{control }{ list of parameters for controlling the fitting process, usually internally set to default values by \code{\link{mvmeta.control}}.}
  \item{\dots }{ further arguments passed to or from other methods. Currently not used.}
}

\details{
The estimation involves \eqn{kp} fixed-effects coefficients and a number of random-effects parameters defining the between-study (co)variance matrix, depending on the chosen \code{\link[=mvmetaCovStruct]{(co)variance structure}}. Up to \eqn{k(k+1)/2} parameters are needed for an unstructured form, while a smaller set are required for structed matrices

The hybrid estimation procedure is based first on few runs of iterative generalized least square algorithm and then quasi-Newton iterations, using specific \code{\link[=mlprof.fn]{likelihood functions}}, until convergence. The estimation algorithm adopts a profiled (or concentrated) approach, that is expressed only in terms of the random-effects parameters. Cholesky and and QR decompositions are used for computational stability and efficiency, and for assuring the positive-definiteness of the estimated between-study (co)variance matrix. See the help page for the \code{\link[=mlprof.fn]{likelihood functions}} for further details. The method is described in details in Gasparrini and collaborators (2012) (see references below).
}

\value{
These functions return an intermediate list object, whose components are then processed by \code{\link{mvmeta.fit}}. Other components are added later through \code{\link{mvmeta}} to finalize an object of class \code{"mvmeta"}.
}

\references{
Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].

Pinheiro JC and Bates DM (2000). \emph{Mixed-Effects Models in S and S-PLUS}. New York, Springer Verlag.

Lindstrom MJ and Bates DM (1988). Newton-Raphson and EM algorithms for linear mixed-effects models for repeated-measures data. \emph{Journal of the American Statistical Association}. \bold{83}(404):1014--1022.

White IR (2009). Multivariate random-effects meta-analysis. \emph{Stata Journal}. \bold{9}(1):40--56.

White IR (2011). Multivariate random-effects meta-regression: updates to mvmeta. \emph{Stata Journal}. \bold{11}(2):255-270.

Goldstein H (1986). Multilevel mixed linear model analysis using iterative generalized least squares. \emph{Biometrika}. \bold{73}(1):43.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
As stated earlier, these functions are called internally by \code{\link{mvmeta.fit}}, and are not meant to be used directly. In particular, their code does not contain any check on the arguments provided, which are expected in specific formats. The functions are not exported in the namespace, and only documented for completeness.

The arguments above are prepared by \code{\link{mvmeta.fit}} from its arguments \code{X}, \code{y} and \code{S}. The list structure, although requiring more elaborate coding, is computationally more efficient, as it avoids the specification of sparse block-diagonal matrices, especially for meta-analysis involving a large number of studies.

Some parameters of the fitting procedures are determined by the \code{control} argument, with default set by \code{\link{mvmeta.control}}. No missing values are accepted in the fitting functions. See details on \code{\link[=na.omit.data.frame.mvmeta]{missing values}}.
}

\seealso{
See \code{\link{mvmeta}} for the general usage of the functions. See \code{\link{mvmeta.control}} to determine specific parameters of the fitting procedures. Use the triple colon operator ('\code{:::}') to access the code of the internal functions, such as \code{glsfit}. See \code{\link{mvmeta-package}} for an overview of the package and modelling framework.
}

\examples{
# REML ESTIMATOR: UNIVARIATE MODEL
model <- mvmeta(yC,S=SCC,data=smoking)
summary(model)

# REML ESTIMATOR: REPRODUCE THE RESULTS IN WHITE (2011)
y <- as.matrix(smoking[11:13])
S <- as.matrix(smoking[14:19])
model <- mvmeta(y,S)
summary(model)

# ML ESTIMATOR: REPRODUCE THE RESULTS IN BERKEY ET AL. (1998)
year <- berkey98$pubyear - 1983
model <- mvmeta(cbind(PD,AL)~year,S=berkey98[5:7],data=berkey98,method="ml")
print(summary(model),digits=3)
round(model$Psi,3)

# UNSTRUCTURED AND STRUCTURED BETWEEN-STUDY (CO)VARIANCE
y <- as.matrix(fibrinogen[2:5])
S <- as.matrix(fibrinogen[6:15])
model <- mvmeta(y,S)
summary(model)
model <- mvmeta(y,S,bscov="diag")
summary(model)
model <- mvmeta(y,S,bscov="hcs")
summary(model)

# SEE help(mvmetaCovStruct) for additional info and examples
}


\keyword{models}
\keyword{regression}
\keyword{multivariate}
