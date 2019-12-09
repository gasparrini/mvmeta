-----------------------------------

## Multivariate and Univariate Meta-Analysis and Meta-Regression

The package consists of a collection of functions to perform various meta-analytical models, including standard univariate fixed and random-effects meta-analysis and meta-regression, and non-standard extensions such as multivariate, multilevel, longitudinal, and dose-response models. The methodology is illustrated in detail in a series of articles referenced at the end of this document.

### Info on the `mvmeta` package

The package `mvmeta` is now superseded by the package [mixmeta](https://cran.r-project.org/package=mixmeta). The users are strongly suggested to replace it with the new package, as the development of `mvmeta` is now discontinued. For the time being, the `mvmeta` package is still maintained and available on the Comprehensive R Archive Network (CRAN), with info at the related web page (https://cran.r-project.org/package=mvmeta). A (discontinued) development website is available on GitHub (https://github.com/gasparrini/mvmeta).

### Installation

The last version officially released on CRAN can be installed directly within R by typing:

```r
install.packages("mvmeta")
```

### R code in published articles

Several peer-reviewed articles and documents provide R code illustrating methodological developments of `mvmeta` or replicating substantive results using this package. An updated version of the code can be found at the GitHub (https://github.com/gasparrini) or personal web page (http://www.ag-myresearch.com) of the package maintainer.

### References:

Gasparrini A. Multivariate meta-analysis for non-linear and other multi-parameter associations.
*Statistics in Medicine*. 2012;
**31**(29):3821-3839. [freely available [here](http://www.ag-myresearch.com/2012_gasparrini_statmed.html)]

Gasparrini A., Armstrong, B., Kenward M. G. Reducing and meta-analyzing
estimates from distributed lag non-linear models. *BMC Medical Research
Methodology*. 2013; **13**(1):1. [freely available [here](http://www.ag-myresearch.com/2013_gasparrini_bmcmrm.html)].