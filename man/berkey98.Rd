\name{berkey98}
\alias{berkey98}
\docType{data}

\title{ Five Published Trials on Periodontal Disease }

\description{
The dataset contains the results of 5 published trials comparing surgical and non-surgical treatments for medium-severity periodontal disease, one year after treatment. The 2 estimated outcomes are average improvements (surgical minus non-surgical, in mm) in probing depth (PD) and attachment level (AL).
}

\usage{berkey98}

\format{
  A data frame with 5 observations on the following 7 variables:
  \describe{
    \item{\code{pubyear}}{ publication year of the trial.}
    \item{\code{npat}}{ number of patients included in the trial.}
    \item{\code{PD}}{ estimated improvement of surgical versus non-surgical treatments in probing depth (mm).}
    \item{\code{AL}}{ estimated improvement of surgical versus non-surgical treatments in attachment level (mm).}
    \item{\code{var_PD}}{ variance of the estimated outcome for \code{PD}.}
    \item{\code{cov_PD_AL}}{ covariance of the estimated outcomes for \code{PD} and \code{AL}.}
    \item{\code{var_AL}}{ variance of the estimated outcome for \code{AL}.}
  }
  Row names specify the author of the paper reporting the results of each trial.
}

\source{
Berkey CS, Hoaglin DC, et al. (1998). Meta-analysis of multiple outcomes by regression with random effects. \emph{Statistics in Medicine}. \bold{17}:2537--2550.

Berkey C. S., Antczak-Bouckoms A., et al. (1995). Multiple-outcomes meta-analysis of treatments for periodontal disease. \emph{Journal of Dental Research}. \bold{74}(4):1030--1039.

Sera F, Armstrong B, Blangiardo M, Gasparrini A (2019). An extended mixed-effects framework for meta-analysis.\emph{Statistics in Medicine}. 2019;38(29):5429-5444. [Freely available \href{http://www.ag-myresearch.com/2019_sera_statmed.html}{\bold{here}}].

Gasparrini A, Armstrong B, Kenward MG (2012). Multivariate meta-analysis for non-linear and other multi-parameter associations. \emph{Statistics in Medicine}. \bold{31}(29):3821--3839. [Freely available \href{http://www.ag-myresearch.com/2012_gasparrini_statmed.html}{\bold{here}}].
}

\examples{
### REPRODUCE THE RESULTS IN BERKEY ET AL. (1998)

# INSPECT THE DATA
berkey98

# FIXED-EFFECTS
year <- berkey98$pubyear - 1983
model <- mvmeta(cbind(PD,AL)~year,S=berkey98[5:7],data=berkey98,method="fixed")
print(summary(model),digits=3)

# GLS MODEL (VARIANCE COMPONENTS) 
model <- mvmeta(cbind(PD,AL)~year,S=berkey98[5:7],data=berkey98,method="vc",
  control=list(vc.adj=FALSE))
print(summary(model),digits=3)
round(model$Psi,3)

# ML MODEL
model <- mvmeta(cbind(PD,AL)~year,S=berkey98[5:7],data=berkey98,method="ml")
print(summary(model),digits=3)
round(model$Psi,3)
}

\keyword{datasets}
