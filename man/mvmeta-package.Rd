\name{mvmeta-package}
\alias{mvmeta-package}
\docType{package}

\title{
Multivariate and Univariate Meta-Analysis and Meta-Regression
}

\description{
The package \pkg{mvmeta} consists of a collection of functions to perform fixed and random-effects multivariate and univariate meta-analysis and meta-regression in \R.
}

\section{Modelling framework}{
Multivariate meta-analytical models represent an extension of the standard univariate techniques, where estimates of a single effect size, here defined generally as outcome, are pooled across studies. In multivariate meta-analysis, estimates of multiple outcomes are combined while accounting for their correlation. Multivariate meta-regression also models such multivariate distribution in terms of study-level predictors. These statistical tools were originally proposed to model multiple endpoints in clinical trials. Applications and methodological developments are currently proposed also for network meta-analysis (indirect treatment comparison), for the meta-analysis of multi-parameter associations and for meta-analysis of diagnostic studies, among others. See references below for details.

Similarly to univariate methods, fixed-effects models do not assume heterogeneity among studies, and the estimates are conditional on the set of studies collected in the meta-analysis, based on a multivariate weighted average of study-level estimates. Random-effects meta-analysis, instead, allows a degree of heterogeneity among studies, assuming the (true but unobserved) study-specific outcomes as randomly sampled from a multivariate normal distribution of studies. Inference from these models may therefore be extended to other unmeasured studies assumed to belong to the same (usually hypothetical) population.

Estimation and interpretation exploit here the framework of linear mixed models. The fixed part of the model provides an estimate of fixed effects, which represent the population-averaged outcomes and, in the case of meta-regression, are defined by a set of coefficients associated to study-level predictors. The random part of the model describes the deviation from the population averages, estimating the components of a between-study (co)variance matrix. Assuming \eqn{k} outcomes \eqn{\boldsymbol{y}_i}{yi} estimated in each of \eqn{i = 1, \ldots, m} studies, and related to \eqn{p} study-level predictors \eqn{\boldsymbol{x}_i}{xi}, random-effects multivariate meta-regression models can be generally described with:

\deqn{\boldsymbol{y}_i \sim \mbox{N}_k(\boldsymbol{X}_i \boldsymbol{\beta}, \boldsymbol{S}_i + \Psi)}{yi ~ Nk(Xi\beta , Si + \Psi)}

Here the outcomes \eqn{\boldsymbol{y}_i}{yi} are assumed to be sampled from a multivariate normal distribution of order \eqn{k}. Their distribution is centred on \eqn{\boldsymbol{X}_i \boldsymbol{\beta}}{Xi\beta}, with \eqn{\boldsymbol{X}_i}{Xi} as a \eqn{k \times kp}{k x kp} design matrix and \eqn{\boldsymbol{\beta}}{\beta} the vector of fixed-effects coefficients. The marginal \eqn{k \times k}{k x k} (co)variance matrix \eqn{\boldsymbol{\Sigma}_i = \boldsymbol{S}_i + \boldsymbol{\Psi}}{\Sigmai = Si + \Psi} is given by the sum of within (assumed known) and between-study (co)variance matrices \eqn{\boldsymbol{S}_i}{Si} and \eqn{\boldsymbol{\Psi}}{\Psi}, respectively.

Other models are taken as special cases of that above. In multivariate meta-analysis, \eqn{\boldsymbol{X}_i}{Xi} becomes an identity matrix with \eqn{p=1}, and \eqn{\boldsymbol{\beta}}{\beta} reduces to \eqn{k} intercepts, interpreted as the population-averaged outcomes. For \eqn{k=1}, the model reduces to the standard univariate meta-analysis or meta-regression. In fixed-effects meta-analytic models, \eqn{\boldsymbol{\Psi}}{\Psi} is assumed not to exist, and the variability between studies is due exclusively to the within-study estimation error.
}

\section{Estimation methods}{
The aim is to estimate the coefficients \eqn{\boldsymbol{\beta}}{\beta} and, for random-effects models, the components of the between-study (co)variance matrix \eqn{\boldsymbol{\Psi}}{\Psi}. If the same linear predictor of \eqn{p} terms \eqn{\boldsymbol{x}_i}{xi} measured in each study is specified for all the outcomes (the only option available in the current version), the dimension of \eqn{\boldsymbol{\beta}}{\beta} is \eqn{kp}. The parameters for the random part depend on the chosen structure of the between-study (co)variance matrix \eqn{\boldsymbol{\Psi}}{\Psi}, with \eqn{k(k+1)/2} parameters for an unstructured form, and a smaller set of parameters for structured (co)variances. 

Different estimator are implemented in the package \pkg{mvmeta}. The estimation options available in the current version are:

\itemize{
  \item \bold{Fixed-effects}
  \item \bold{Maximum likelihood} (ML)
  \item \bold{Restricted maximum likelihood} (REML)
  \item \bold{Method of moments}
  \item \bold{Variance components}
}

The fixed-effects model is fitted through generalized least squares (GLS), assuming the (co)variance structure, composed by the within-study error only, as completely known. Among random-effects models, ML and REML approaches provides fit criteria and inferential test derived from likelihood theory, such as AIC and likelihood ratio test. However, they are based on computationally intensive iterative procedures of optimization, and convergence can be slow for high-dimensional models (with a high number of outcomes). Estimators based on semiparametric alternatives such as the non-iterative method of moments or the iterative variance components approach are generally faster. Further details on estimation methods are given in the related help pages.
}

\section{Functions and data included in the package}{
The main function in the package is \code{\link{mvmeta}}, which performs the various models illustrated above. This function resembles standard regression functions in \R, and specifies the model through a regression formula. The function returns a list object of class \code{"mvmeta"} (see \code{\link{mvmetaObject}}).

The estimation is carried out internally through \code{\link{mvmeta.fit}}, a wrapper which prepares the data and calls specific estimation functions for fitting the models. Specifically, \code{\link{mvmeta.fixed}} is applied for fixed-effects models, while estimators for random-effects models are implemented in the functions \code{\link{mvmeta.ml}} and \code{\link{mvmeta.reml}} for (restricted) maximum likelihood, \code{\link{mvmeta.mm}} for the method of moments, and \code{\link{mvmeta.vc}} for variance components. For likelihood-based methods, iterative \code{\link[=mlprof.fn]{optimizations algorithms}} are used for maximizing the (restricted) likelihood, and specific \code{\link[=mvmetaCovStruct]{(co)variance structures}} for the between-study random effects are available. Fitting parameter options are set by \code{\link{mvmeta.control}}.

Method functions are available for objects of class \code{"mvmeta"} (see \code{\link{mvmetaObject}} for a complete list). The method \code{\link[=summary.mvmeta]{summary}} produces a list of class \code{"summary.mvmeta"} for summarizing the fit of the model and providing additional results. The method function \code{\link[=predict.mvmeta]{predict}} computes predicted values, optionally for a set of new values of the predictors. \code{\link[=blup.mvmeta]{blup}} gives the (empirical) best linear unbiased predictions for the set of studies used for estimation. Other default or specific method functions for regression can be used on objects of class \code{"mvmeta"}, such as \code{\link{fitted}} and \code{\link{residuals}}, \code{\link[=logLik.mvmeta]{logLik}}, \code{\link{AIC}} and \code{\link{BIC}}, among others.

Methods for \code{\link[=model.frame.mvmeta]{model.frame}} and \code{\link[=model.matrix.mvmeta]{model.matrix}} are used to extract and construct the model frame and the design matrix of the regression meta-analytical model, respectively. Methods for \code{\link[=na.omit.data.frame.mvmeta]{na.omit}} and \code{\link[=na.exclude.data.frame.mvmeta]{na.exclude}} help handle correctly missing values.

Simulations can be produced using the function \code{\link{mvmetaSim}} and the method function \code{\link[=simulate.mvmeta]{simulate}}, which return one or multiple sets of simulated outcomes for a group of studies. The function \code{\link{inputna}} and \code{\link{inputcov}} are used internally to augment the missing data values and to input missing correlations, respectively.

The method function \code{\link{qtest.mvmeta}} (producing an object with class of the same name) performs the (multivariate) Cochran Q test for (residual) heterogeneity, both on the overall multivariate distribution and on each single outcome. The generic method function is \code{\link{qtest}}.

Printing functions for the objects of classes defined above are also provided. Other functions are used internally in the source code, and not exported in the namespace. For users interested in getting into details of the package structure, these functions can be displayed using the triple colon ('\code{:::}') operator. For instance, \code{mvmeta:::glsfit} displays the code of the function \code{glsfit}. Also, some comments are added in the original source code.

The package includes the datasets \code{\link{berkey98}}, \code{\link{fibrinogen}}, \code{\link{hsls}}, \code{\link{hyp}}, \code{\link{p53}} and \code{\link{smoking}} as data frames, which are used in the examples.
}

\section{Additional information}{
A list of changes included in the current and previous versions can be found by typing:

\code{file.show(system.file("ChangeLog",package="mvmeta"))}

General information on the development and applications of the \pkg{mvmeta} package and on the modelling framework of multivariate meta-analysis, together with an updated version of the \R{} scripts for running the examples in published papers, can be found at \bold{\href{http://www.ag-myresearch.com}{www.ag-myresearch.com}}.
}

\note{
The functions included in the package \pkg{mvmeta} may be applied also to perform standard univariate meta-analysis and meta-regression. However, alternative packages provides a more exhaustive and efficient set of functions. See for example the packages \pkg{metafor}, \pkg{meta}, \pkg{rmeta} and \pkg{metaLik}, among others.

Functions for fitting multivariate models are available in other \R{} packages. The package \pkg{metafor} provides functions to perform fixed or random-effects multivariate models, the latter fitted through maximum or restricted maximum likelihood. A thorough comparison with the implementation offered in \pkg{mvmeta} is not available yet. The package \pkg{metaSEM} (not in CRAN) offers functions to perfor fixed-effects and likelihood-based random-effects multivariate meta-analysis through structural equation modelling. The package \pkg{mvtmeta} performs fixed-effects and random-effects multivariate meta-analysis using the same method of moments estimator adopted here, although without allowing for missing outcomes or meta-regression. The package \pkg{mada} contains functions for bivariate models used in diagnostic studies.

Use \code{citation("mvmeta")} to cite this package.
}

\section{Warnings}{
This release of the package \pkg{mvmeta} has been tested with different simulated and real datasets. The functions generally perform well under several scenarios, and comparisons with alternative software implementations show good agreement. However, bugs and bad performance under un-tested conditions may not be excluded. Please report any error or unexpected behaviour to the e-mail address below.
}

\author{
Antonio Gasparrini, \email{antonio.gasparrini@lshtm.ac.uk}
}

\references{
Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].

White IR (2009). Multivariate random-effects meta-analysis. \emph{Stata Journal}. \bold{9}(1):40--56.

Jackson D, Riley R, White IR (2011). Multivariate meta-analysis: Potential and promise. \emph{Statistics in Medicine}. \bold{30}(20);2481--2498.

White IR (2011). Multivariate random-effects meta-regression: updates to mvmeta. \emph{Stata Journal}. \bold{11}(2):255--270.

van Houwelingen HC, Arends LR, et al. (2002). Advanced methods in meta-analysis: multivariate approach and meta-regression. \emph{Statistics in Medicine}. \bold{21}(4):589--624.

Lu G, Ades AE (2004). Combination of direct and indirect evidence in mixed treatment comparisons. \emph{Statistics in Medicine}. \bold{23}(20):3105--3124.

Nam IS, Mengersen K, et al. (2003). Multivariate meta-analysis. \emph{Statistics in Medicine}. \bold{22}(14):2309--2333.

Arends LR, Voko Z, Stijnen T (2003). Combining multiple outcome measures in a meta-analysis: an application. \emph{Statistics in Medicine}. \bold{22}(8):1335--1353.

Ritz J, Demidenko E, Spiegelman G (2008). Multivariate meta-analysis for data consortia, individual patient meta-analysis, and pooling projects. \emph{Journal of Statistical Planning and Inference}. \bold{139}(7):1919--1933.

Berkey, CS, Anderson JJ, Hoaglin DC (1996). Multiple-outcome meta-analysis of clinical trials. \emph{Statistics in Medicine}. \bold{15}(5):537--547.

Berkey, CS, Hoaglin DC, et al. (1998). Meta-analysis of multiple outcomes by regression with random effects. \emph{Statistics in Medicine}. \bold{17}(22):2537--2550.

Jackson D, White IR, Riley RD (2013). A matrix based method of moments for fitting the multivariate random effects model for meta-analysis and meta-regression. \emph{Biometrical Journal}. \bold{55}(2):231-245.

Chen H, Manning AK, Dupuis J (2012). A method of moments estimator for random effect multivariate meta-analysis. \emph{Biometrics}. \bold{68}(4):1278-1284.

Cheung MWL, Chan W (2009). A two-stage approach to synthesizing covariance matrices in meta-analytic structural equation modeling. \emph{Structural Equation Modeling}. \bold{16}(1):28--53.

Doebler P, Holling H, Bohning D (2012). A mixed model approach to meta-analysis of diagnostic studies with binary test outcome. \emph{Psychological Methods}. \bold{17}(3):418--36.
}

\keyword{package}
