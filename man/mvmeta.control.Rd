\name{mvmeta.control}
\alias{mvmeta.control}


\title{ Ancillary Parameters for Controlling the Fit in mvmeta Models }

\description{
This internal function sets the parameter options used for fitting meta-analytical models, commonly to pre-specified default values. It is usually internally called by \code{\link{mvmeta.fit}}.
}

\usage{
mvmeta.control(optim=list(), showiter=FALSE, maxiter=100, initPsi=NULL,
  Psifix=NULL,Psicor=0, Scor=0, inputna=FALSE, inputvar=10^4, igls.iter=10, 
  hessian=FALSE, vc.adj=TRUE,reltol=sqrt(.Machine$double.eps),
  set.negeigen=sqrt(.Machine$double.eps))
}

\arguments{

  \item{optim }{ list of parameters passed to the \code{control} argument of the function \code{\link{optim}}, which performs the quasi-Newton optimization in likelihood-based random-effects models. See \code{\link{optim}} for the list of arguments. See Details for additional info.}
  \item{showiter }{ logical. If \code{TRUE}, the progress of iterative optimization is shown.}
  \item{maxiter }{ positive interger value. Maximum number of iterations in methods involving optimization procedures.}
  \item{initPsi }{ either a matrix or a vector of its lower triangular elements (with diagonal, taken by column) from which starting values of the parameters of the between-study (co)variance matrix are derived, used in the optimization procedure for likelihood-based random-effects models. If \code{NULL} (the default, and recommended), the starting value is created internally through an iterative generalized least square algorithm.}
  \item{Psifix }{ either a matrix or a vector of its lower triangular elements (with diagonal, taken by column) equal or proportional to the between-study (co)variance. Only used when \code{bscov="fixed"} or \code{bscov="prop"} in \code{\link{mvmeta}}, and, if not provided, it set internally to a 0 or identity matrix, respectively.}
  \item{Psicor }{  either a scalar, vector or matrix representing the between-study correlation(s) (see \code{\link{inputcov}}). Only used when \code{bscov="cor"} in \code{\link{mvmeta}}.}
  \item{Scor }{ either a scalar, vector or matrix representing the within-study correlation(s) to be inputted when the covariances are not provided, and ignored if they are (see \code{\link{inputcov}}).}
  \item{inputna }{ logical. If missing values must be internally inputted. To be used with caution, see \code{\link{inputna}}.}
  \item{inputvar }{ multiplier for inputting the missing variances, to be passed as an argument to \code{\link{inputna}}.}
  \item{igls.iter }{ number of iteration of the iterative generalized least square algorithm to be run in the hybrid optimization procedure of linkelihood-based models to provide the starting value. See \code{\link{iter.igls}}.}
  \item{hessian }{ logical. If \code{TRUE}, the Hessian matrix of the parameters estimated in the optimization process is computed and returned. Only applicable to likelihood-based estimation methods. For details, see the info provided in the help pages of the \code{\link[=mlprof.fn]{optimizations algorithms}} and \code{\link[=mvmetaCovStruct]{(co)variance structure}}.}
  \item{vc.adj }{ logical. If \code{TRUE}, an adjustement to the way the marginal variance part is computed in the variance components estimator is applied. See \code{\link{mvmeta.vc}}.}
  \item{reltol }{ relative convergence tolerance in methods involving optimization procedures. The algorithm stops if it is unable to reduce the value by a factor of \code{reltol * (abs(val) + reltol)} at a step.}
  \item{set.negeigen }{ positive value. Value to which negative eigenvalues are to be set in estimators where such method is used to force positive semi-definiteness of the estimated between-study (co)variance matrix.}
}

\details{
The control argument of \code{\link{mvmeta}} is by default passed to \code{\link{mvmeta.fit}}, which uses its elements as arguments of \code{mvmeta.control}.

Many arguments refer to specific fitting procedures. Refer to the help page of the related estimator for details.

The function automatically sets non-default values for some control arguments for \code{\link{optim}}, unless explicitly set in the list passed to it. Specifically, the function selects \code{fnscale=-1}, \code{maxit=maxiter} and \code{reltol=reltol}, where the latter two are specified by other arguments of this function.

The function is expected to be extended and/or modified at every release of the package \pkg{mvmeta}.
}

\value{
A list with components named as the arguments.
}

\references{
Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/statmed2012.html}{\bold{here}}].
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\seealso{ 
See \code{\link{mvmeta}}. See also \code{\link{glm.control}}. See the help pages of the related fitting functions for details on each parameter. See \code{\link{mvmeta-package}} for an overview of this modelling framework.
}

\examples{
# PRINT THE ITERATIONS (SEE ?optim) AND CHANGE THE DEFAULT FOR STARTING VALUES
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98,
  control=list(showiter=TRUE,igls.iter=20))
  
# INPUT THE CORRELATION
model <- mvmeta(cbind(y1,y2),S=cbind(V1,V2),data=p53,control=list(Scor=0.5))
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}
