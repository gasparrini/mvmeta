\name{hsls}
\alias{hsls}
\docType{data}

\title{ High School Longitudinal Study }

\description{
This is a nationally representative, longitudinal study of more than 21,000 9th graders in 944 schools who will be followed through their secondary and postsecondary years. The data are used for testing whether sex, socioeconomic status and sex by socio-economic status interaction are predictive of the mathematics standardized score in each of the eight race groups.
}

\usage{hsls}

\format{
  A data frame with 8 observations on the following 10 variables:
  \itemize{
    \item{\code{race}: race group.}
    \item{\code{b1, b2, b3}: estimated regression coefficients for sex, socio-economic status and sex by socio-economic status interaction, respectively, on the mathematics standardized score.}
    \item{\code{V11, V22, V33}: variances of the estimated coefficients.}
    \item{\code{V12, V13, V23}: covariances of the estimated coefficients.}
  }
}

\source{
Chen H, Manning AK, Dupuis J (2012). A method of moments estimator for random effect multivariate meta-analysis. \emph{Biometrics}. \bold{68}(4):1278-1284.
}

\examples{
### REPRODUCE THE RESULTS IN CHEN ET AL. (2012)

# INSPECT THE DATA
hsls

# FIXED-EFFECTS MODEL
S <- as.matrix(hsls[5:10])
model <- mvmeta(cbind(b1,b2,b3),S,data=hsls,method="fixed")
summary(model)

# MM MODEL
model <- mvmeta(cbind(b1,b2,b3),S,data=hsls,method="mm")
summary(model)
model$Psi
}

\keyword{datasets}
