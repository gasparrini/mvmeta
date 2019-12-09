\name{mvmeta}
\alias{mvmeta}
\alias{mvmeta.fit}


\title{ Fitting Multivariate and Univariate Meta-Analysis and Meta-Regression Models }

\description{
The function \code{mvmeta} performs fixed and random-effects multivariate and univariate meta-analysis and meta-regression, with various estimation methods. The function \code{mvmeta.fit} is a wrapper for actual fitting functions based on different estimation methods, usually called internally. See \code{\link{mvmeta-package}} for an overview.
}

\usage{
mvmeta(formula, S, data, subset, method="reml", bscov="unstr", model=TRUE,
  contrasts=NULL, offset, na.action, control=list())
    
mvmeta.fit(X, y, S, offset=NULL, method="reml", bscov="unstr", control=list())
}

\arguments{
Assuming a meta-analysis or meta-regression based on \eqn{m} studies, \eqn{k} outcomes and \eqn{p} predictors:

  \item{formula }{ an object of class \code{"\link{formula}"} (or one that can be coerced to that class) offering a symbolic description of the linear predictor of the model to be fitted to each outcome. Alternatively, for meta-analysis with no predictor, a single  vector (for univariate models) or matrix-type object (for multivariate models). Terms in \code{formula} must be vector or matrix-type objects, optionally provided in the \code{data} argument below. See Details.}
  \item{X }{ a \eqn{m \times p}{m x p} design matrix containing the study-specific predictors. Usually produced internally by \code{mvmeta} from \code{formula} above.}
  \item{y }{ a \eqn{m}-dimensional vector (for univariate models) or \eqn{m \times k}{m x k} matrix (for multivariate models) of outcomes. Usually produced internally by \code{mvmeta} from \code{formula} above.}
  \item{S }{ series of within-study (co)variance matrices of the estimated outcomes for each one of the \eqn{m} studies. Accepted formats by \code{mvmeta} are: a \eqn{m}-dimensional list of \eqn{k \times k}{k x k} matrices; a tri-dimensional \eqn{k \times k \times m}{k x k x m} array; a matrix or data frame with \eqn{m} rows and \eqn{k(k+1)/2} or \eqn{k} columns, depending on the availability of the within-study correlations. Optionally, terms may be provided in the \code{data} argument below. \code{mvmeta.fit} accepts only the last option. See Details below.}
  \item{data }{ an optional data frame, list or environment (or object coercible by \code{\link{as.data.frame}} to a data frame) containing the variables in \code{formula}. If not found in data, the variables are taken from \code{environment(formula)}, typically the environment from which \code{mvmeta} is called.}
  \item{subset }{ an optional vector specifying a subset of observations to be used in the fitting process.}
  \item{method }{ estimation method: \code{"fixed"} for fixed-effects models, \code{"ml"} or \code{"reml"} for random-effects models fitted through (restricted) maximum likelihood, \code{"mm"} for random-effects models fitted through method of moments, and \code{"vc"} for random-effects models fitted through variance components. See Details below. If \code{"model.frame"}, the model frame is returned, as in \code{\link{lm}} or \code{\link{glm}}.}
  \item{bscov }{ a string defining the between-study (co)variance structure in likelihood based models. Default to \code{"unstr"} (unstructured). Among other options, the user can select \code{"diag"} (diagonal), \code{"cs"} (compound symmetry), \code{"hcs"} (heterogeneous compound symmetry), \code{"ar1"} (autoregressive of first order), \code{"fixed"} (fixed). See Details.}
  \item{model }{ a logical value indicating whether the model frame should be included as a component of the returned value. See the \code{\link[=model.frame.mvmeta]{model.frame}} method function.}
  \item{contrasts }{ an optional list. See the \code{contrasts.arg} of \code{\link{model.matrix}}.}
  \item{offset }{ optionally, a \eqn{m}-dimensional numeric vector used to specify an a priori known component in the linear predictor. One or more \code{\link{offset}} terms can be included in the formula instead or as well. See \code{\link{model.offset}}.}
  \item{na.action }{ a function which indicates what should happen when the data contain \code{NA}s. Default to \code{na.action} setting of \code{\link{options}}, usually \code{\link[=na.omit.data.frame.mvmeta]{na.omit}}. \code{\link[=na.exclude.data.frame.mvmeta]{na.exclude}} can be useful. See details on \code{\link[=na.omit.data.frame.mvmeta]{missing values}} in \code{mvmeta}.}
  \item{control }{ list of parameters for controlling the fitting process. These are passed to  \code{\link{mvmeta.control}} by \code{mvmeta.fit} to replace otherwise selected default values.}
}

\details{
The function \code{mvmeta} resembles standard regression functions in \R (see \code{\link{lm}} or \code{\link{glm}}). This function defines the design matrix and the vector (for univariate models) or matrix (for multivariate models) of outcome responses, and calls the wrapper \code{mvmeta.fit} to perform the actual fitting. The latter prepares the data and calls specific fitting functions, depending on the chosen \code{method}. Functions other than \code{mvmeta} are not expected to be called directly for model fitting.

The model is specified through a regression formula. Simple meta-analysis is specified with the formula \code{y ~ 1}, where the left-hand side is a vector (in univariate models) or a matrix (in multivariate models), optionally of form \code{cbind(y1,...,yk)}, with terms stored in \code{data}. Alternatively, matrix or vector objects are allowed, and the formula is retrieved internally adding \code{~ 1}. In meta-regression, other terms are added in the right-hand side of the formula, defining the linear predictor common to all outcomes. Factors, variable transformations and interactions are allowed, following the standard formula specification. Labels are automatically retrieved from the objects in \code{formula}. See \code{\link{formula}} for further details. See \code{\link{lm}} or \code{\link{glm}} for info on the other arguments.

The within-study (co)variances are provided through the argument \code{S}, usually as a matrix. If the correlations are available, each of the \eqn{m} row represents the \eqn{k(k+1)/2} vectorized entries of the lower triangle of the related (co)variance matrix, taken by column (see \code{\link{xpndMat}}). If correlations are not available, each row represents the \eqn{k} variances, and the correlations are inputted internally through the argument \code{Scor} of the \code{control} list. See \code{\link{inputcov}}.

Different estimator are available in the package \code{mvmeta} and chosen through the argument \code{method}. In the current version, the options are:

\itemize{
  \item \code{method="fixed"}: \code{\link[=mvmeta.fixed]{Fixed-effects estimator}}
  \item \code{method="ml"}: \code{\link[=mvmeta.ml]{Maximum likelihood (ML) estimator}}
  \item \code{method="reml"}: \code{\link[=mvmeta.reml]{Restricted maximum likelihood (REML) estimator}}
  \item \code{method="mm"}: \code{\link[=mvmeta.mm]{Method of moments estimator}}
  \item \code{method="vc"}: \code{\link[=mvmeta.vc]{Variance components estimator}}
}

Specific fitting functions are called internally. Likelihood-based methods allow alternative \code{\link[=mvmetaCovStruct]{(co)variance structures}} for the between-study random effects through the argument \code{bscov}. See their help pages for further details on the estimation methods, following the links above.

Missing values are allowed in both sides of \code{formula}. In the case of missing predictors (right-hand side of \code{formula}), the related study is entirely excluded from estimation. In contrast, a study still contributes to estimation if at least outcome is non-missing. This behaviour is different than in standard regression functions such as \code{\link{lm}} or \code{\link{glm}}. Before the call to \code{mvmeta.fit}, studies matching such missing definition are removed from the the model frame. The missing pattern in \code{S} must be consistent with that in \code{y}. See further details on handling \code{\link[=na.omit.data.frame.mvmeta]{missing values}} in \code{mvmeta}.

The fitting procedure can be controlled through the additional terms specified in \code{control}, which are passed to the function \code{\link{mvmeta.control}}.
}

\value{
The \code{mvmeta} function typically returns a list object of class \code{"mvmeta"} representing the meta-analytical model fit, as described in \code{\link{mvmetaObject}}. When \code{method="data.frame"}, the model is not fitted and the model frame is returned, namely a data frame with special attributes (see the default method \code{\link{model.frame}}) and, in this case, the additional class \code{"data.frame.mvmeta"}.

The wrapper function \code{mvmeta.fit} is usually called internally in \code{mvmeta}, and returns an intermediate list object with some of the components expected in the \code{"mvmeta"} class.

Several method functions for regression objects are available, either default or specifically-written for the \code{"mvmeta"} class. See \code{\link{mvmetaObject}} for a complete list.
}

\references{
Sera F, Armstrong B, Blangiardo M, Gasparrini A (2019). An extended mixed-effects framework for meta-analysis.\emph{Statistics in Medicine}. 2019;38(29):5429-5444. [Freely available \href{http://www.ag-myresearch.com/2019_sera_statmed.html}{\bold{here}}].

Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].

Jackson D, Riley R, White IR (2011). Multivariate meta-analysis: Potential and promise. \emph{Statistics in Medicine}. \bold{30}(20);2481--2498.

White IR (2009). Multivariate random-effects meta-analysis. \emph{Stata Journal}. \bold{9}(1):40--56.

White IR (2011). Multivariate random-effects meta-regression: updates to mvmeta. \emph{Stata Journal}. \bold{11}(2):255-270.

Berkey, CS, Hoaglin DC, et al. (1998). Meta-analysis of multiple outcomes by regression with random effects. \emph{Statistics in Medicine}. \bold{17}(22):2537--2550.
}

\author{Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}}

\note{
In the current version, the same linear predictor specified in \code{formula} is set for all the outcomes.
}

\seealso{ 
See additional info on the estimation procedures at the related page of the fitting functions. See alternative \code{\link[=mvmetaCovStruct]{(co)variance structures}} for likelihood-based estimation methods. See handling of \code{\link[=na.omit.data.frame.mvmeta]{missing values}} in \code{mvmeta}. See \code{\link{lm}} or \code{\link{glm}} for standard regression functions. See \code{\link{mvmeta-package}} for an overview of this modelling framework.
}

\examples{
### BIVARIATE META-ANALYSIS, ESTIMATED THROUGH REML

# RUN THE MODEL
model <- mvmeta(cbind(PD,AL),S=berkey98[5:7],data=berkey98)

# SUMMARIZE THE RESULTS
summary(model)

# RESIDUALS AND FITTED VALUES
residuals(model)
fitted(model)

# LOG-LIKELIHOOD AND AIC VALUE
logLik(model)
AIC(model)


### BIVARIATE META-REGRESSION, ESTIMATED THROUGH METHOD OF MOMENTS

# RUN THE MODEL AND SUMMARIZE THE RESULTS
model <- mvmeta(cbind(PD,AL)~pubyear,S=berkey98[5:7],data=berkey98,method="mm")
summary(model)

# BLUP ESTIMATES AND 90% PREDICTION INTERVALS, AGGREGATED BY OUTCOME
blup(model,pi=TRUE,aggregate="y",pi.level=0.90)

# COCHRAN Q TEST FOR RESIDUAL HETEROGENEITY
qtest(model)

# PREDICTED AVERAGED OUTOCOMES AND STANDARD ERRORS FROM YEAR 1985 TO 1989
newdata <- data.frame(pubyear=1985:1989)
predict(model,newdata,se=TRUE)

# MODEL FRAME AND MODEL MATRIX
model.frame(model)
model.matrix(model)


### UNIVARIATE META-REGRESSION, FIXED-EFFECTS MODEL

# RUN THE MODEL
model <- mvmeta(sbp~ish,S=sbp_se^2,data=hyp,method="fixed")
summary(model)

# RESIDUALS AND FITTED VALUES
residuals(model)
fitted(model)

# COCHRAN Q TEST FOR RESIDUAL HETEROGENEITY
qtest(model)


### MULTIVARIATE META-ANALYSIS WITH MORE THAN 2 OUTCOMES

# RUN THE MODEL
y <- as.matrix(fibrinogen[2:5])
S <- as.matrix(fibrinogen[6:15])
model <- mvmeta(y,S)
summary(model)


### IN THE PRESENCE OF MISSING VALUES

# RUN THE MODEL
y <- as.matrix(smoking[11:13])
S <- as.matrix(smoking[14:19])
model <- mvmeta(y,S)
summary(model)

# MODEL FRAME: SEE help(na.omit.data.frame.mvmeta) FOR MORE EXAMPLES
model.frame(model)


### WHEN WITHIN-STUDY COVIARIANCES ARE NOT AVAILABLE AND/OR NEED TO BE INPUTTED

# GENERATE S
(S <- inputcov(hyp[c("sbp_se","dbp_se")],cor=hyp$rho))

# RUN THE MODEL
model <- mvmeta(cbind(sbp,dbp),S=S,data=hyp)

# INPUTTING THE CORRELATION DIRECTLY IN THE MODEL
model <- mvmeta(cbind(y1,y2),cbind(V1,V2),data=p53,control=list(Scor=0.95))
summary(model)

# SEE help(hyp) AND help(p53) FOR MORE EXAMPLES


### STRUCTURING THE BETWEEN-STUDY (CO)VARIANCE

# DIAGONAL
S <- as.matrix(hsls[5:10])
model <- mvmeta(cbind(b1,b2,b3),S,data=hsls,bscov="diag")
summary(model)
model$Psi

# COMPOUND SYMMETRY
model <- mvmeta(cbind(b1,b2,b3),S,data=hsls,bscov="cs")
summary(model)
model$Psi

# SEE help(mvmetaCovStruct) FOR DETAILS AND ADDITIONAL EXAMPLES


### USE OF THE CONTROL LIST

# PRINT THE ITERATIONS AND CHANGE THE DEFAULT FOR STARTING VALUES
y <- as.matrix(smoking[11:13])
S <- as.matrix(smoking[14:19])
model <- mvmeta(y,S,control=list(showiter=TRUE,igls.iter=20))

# SEE help(mvmeta.control) FOR FURTHER DETAILS
}

\keyword{models}
\keyword{regression}
\keyword{multivariate}

