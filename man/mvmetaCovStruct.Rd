\name{mvmetaCovStruct}
\alias{mvmetaCovStruct}


\title{ Covariance Structures for mvmeta Models }

\description{
Alternative covariance structures for the between-study (co)variance matrix of random effects in multivariate meta-analysis or meta-regression, usually defined through the argument \code{bscov} of the function \code{\link{mvmeta}}.
}
  
\section{Options}{
Assuming a meta-analysis or meta-regression based on \eqn{k} outcomes:

  \itemize{
    \item \code{unstr}: an unstructured form for a general positive-definite matrix. The matrix is represented by \eqn{k(k+1)/2} unrestricted parameters defined as the upper triangular entries of its Cholesky decomposition.
    \item \code{diag}: a diagonal positive-definite matrix. The matrix is represented by \eqn{k} unrestricted parameters defined as the logarithm of the diagonal values.
    \item \code{id}: a multiple of the identity positive-definite matrix. The matrix is represented by a single unrestricted parameter defined as the logarithm of the diagonal value.
    \item \code{cs}: a positive-definite matrix with compound symmetry structure. The matrix is represented by 2 unrestricted parameters defined as the logarithm of the diagonal value and the transformed correlation. The latter is parameterized so to obtain a correlation value between \eqn{-1/(k-1)} and 1, in order to ensure positive-definiteness.
    \item \code{hcs}: a positive-definite matrix with heterogeneous compound symmetry structure. The matrix is represented by \eqn{k+1} unrestricted parameters defined as the logarithm of the diagonal values and the transformed correlation. The latter is parameterized so to obtain a correlation value between \eqn{-1/(k-1)} and 1, in order to ensure positive-definiteness.
    \item \code{ar1}: a positive-definite matrix with autoregressive structure of first order. The matrix is represented by \eqn{k+1} unrestricted parameters defined as the logarithm of the diagonal value and the logistic transformed correlation. The latter is parameterized so to obtain a correlation value between -1 and 1.
    \item \code{prop}: a positive-definite matrix proportional to that provided by the user through the argument \code{Psifix} in the control list (see \code{\link{mvmeta.control}}). The matrix is represented by 1 unrestricted parameter defined as the logarithm of the multiplier.
    \item \code{cor}: a positive-definite matrix with correlation structure provided by the user through the argument \code{Psicor} in the control list (see \code{\link{mvmeta.control}}). The matrix is represented by \eqn{k} unrestricted parameters defined as the logarithm of the diagonal values.
    \item \code{fixed}: a known matrix provided by the user through the argument \code{Psifix} in the control list (see \code{\link{mvmeta.control}}). The matrix is known and no parameters are needed to represent it.
  }
}

\section{Details}{
The structuring of the between-study (co)variance matrix of random effects is only available for models estimated through (restricted) maximum likelihood.

The unrestricted parameters defining the between-study matrix are estimated in the iterative optimization algorithm. The starting values are usually obtained by a iterative generalized least square algorithm (see the specific \code{\link[=mlprof.fn]{likelihood functions}}). The algorithm computes an unstructured matrix. For structured forms, the starting values for variances and/or correlations are taken as the average of the related elements. Although rarely needed and not recommeded, the user can provided a starting value of the (co)variance matrix, from which the parameters are derived (see \code{\link{mvmeta.control}}).
}

\references{
Pinheiro JC and Bates DM (2000). \emph{Mixed-Effects Models in S and S-PLUS}. New York, Springer Verlag.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\section{Note}{
The choice of structures can affect the performance of the optimization procedure, determining forms of likelihood surfaces which induce convergence to local maxima. In particular, structures such as multiple of identity of proportional to a fixed matrix are based on strong assumptions and should be used with caution.
}

\seealso{ 
See \code{\link{mvmeta}}. See \code{\link{lm}} or \code{\link{glm}} for standard regression functions. See \code{\link{mvmeta-package}} for an overview of this modelling framework.
}

\examples{
# UNSTRUCTURED AND STRUCTURED BETWEEN-STUDY (CO)VARIANCE
y <- as.matrix(fibrinogen[2:5])
S <- as.matrix(fibrinogen[6:15])
model <- mvmeta(y,S)
summary(model)
model$Psi

# DIAGONAL
model <- mvmeta(y,S,bscov="diag")
summary(model)
model$Psi

# HETEROGENEOUS COMPOUND SYMMETRY
model <- mvmeta(y,S,bscov="hcs")
summary(model)
model$Psi

# PROPORTIONAL
y <- as.matrix(smoking[11:13])
S <- as.matrix(smoking[14:19])
model <- mvmeta(y,S,bscov="prop",control=list(Psifix=diag(3)+1))
summary(model)
model$Psi

# CORRELATION
model <- mvmeta(y,S,bscov="cor",control=list(Psicor=0.2))
summary(model)
model$Psi
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}

