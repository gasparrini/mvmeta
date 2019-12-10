-----------------------------------

### Changes in mvmeta 1.0.3 (10 Dec 2019)

#### Minor changes

    * Some functions imported from mixmeta are now exported in the namespace of
      mvmeta directly. This prevents issues with reverse dependencies with other
      packages calling mvmeta.
      
    * The package does not attach mixmeta anymore when loaded.

-----------------------------------

### Changes in mvmeta 1.0.2 (09 Dec 2019)

#### Major changes

    * The package is not superseded by the new package mixmeta. The users are
      strongly suggested to to replace it with the new package, as the
      development of mvmeta is now discontinued.
      
    * Some functions are now imported from mixmeta, which is included in the
      dependencies.
      
    * Change in mvmeta() to comply with changes in R 4.0.0 regarding the new
      class for matrix objects, now including 'array'.
      
#### Minor changes

    * ChangeLog replaced by NEWS.
    
    * Updated references, including the main one for the extended framework
      implemented in the new package mixmeta.

-----------------------------------

### Changes in mvmeta 0.4.11 (07 March 2018)

#### Minor changes

    * Updated web links.

-----------------------------------

### Changes in mvmeta 0.4.10 (06 March 2018)

#### Minor changes

    * Two useless lines of code excluded from methods na.omit() and na.exclude()
      for objects data.frame.mvmeta. The bug was identified by the CRAN (Kurt
      Hornik).

-----------------------------------

### Changes in mvmeta 0.4.9 (24 May 2016)

#### Minor changes

    * added importFrom(utils, modifyList) to namespace.

-----------------------------------

### Changes in mvmeta 0.4.8 (18 Aug 2015)

#### Minor changes

    * Fixed bug in mvmeta.vc which prevented using this method in the presence
      *f missing values.

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.4.7 (05 May 2015)

#### Minor changes

    * Models fitted using ikelihood-based estimators now return also the objects
      'par' and (optionally) 'hessian'. The former are the original parameters
      estimated in the optimization process, corresponding to trasformations of
      entries of the between-study (co)variance matrix of random effects,
      depending on the chosen structure. The latter is the related Hessian
      matrix, which is only returned with argument 'hessian=TRUE' (default to
      FALSE) in mvmeta.control().

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.4.5 (10 Aug 2014)

#### Major changes

    * Function augment() included in version 0.4.4 is replaced by inputna(). The
      reason is the potential confusion in terminology with data augmentation
      performed in network meta-analysis.

#### Minor changes

    * Fixed bug in mkS() occurring with univariate models and S supplied as a
      list.

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.4.4 (18 Jul 2014)

#### Major changes

    * Data augmentation now available trhough the new function augment(). This
      is called internally with the argument 'augment' in the control list.

    * Help pages of data sets changed to avoid warnings, as requested by the
       R CRAN.

#### Minor changes

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.4.3 (08 Apr 2014)

#### Major changes

    * New argument 'bscov' in mvmeta() to structure the between-study 
      (co)variance matrix Psi. New functions initpar() and par2psi() to set the
      initial values and derive Psi depending on the structure and type of
      parameterization. New function checkPD to check positive definiteness.
      #### Minor changes to functions mvmeta.ml(), mvmeta.reml() and other likelihood
      functions. New help page mvmetaCovStruct with info.

    * Added the option to input within-study correlations, when not provided,
      thorugh the argument 'Scor' in the control list. Added function
      inputcov() to input (co)variance matrices directly. Modifications to
      mvmeta.fit(), mvmeta.control(), mkS().

    * Starting values are now set through the new function initPar(). The values
      can be submitted through the argument 'initPsi' in the control list. If
      left NULL (the default), iter.igls() is called.

    * Changes to mvmeta.control(): arguments 'initPsi', 'Psifix', 'Psicor' and
      'Scor' to set initial values, to specify fixed Psi, correlations in Psi
      and correlations in S.

    * Bug fixed in mvmeta(): call to define argument 'S' now set with correct
      environment. Previously possible conflicts with suggested packages.

    * New data sets added: fibrinogen, hsls, hyp, p53, and smoking. Many
      examples included in help pages.

#### Minor changes

    * New code section in mvmeta() to set the fitting method and the structure
      *f Psi.

    * Small changes in the code of the function mvmetaSim().

    * Function mvmeta.igls() renamed iter.igls(). Functions mvmeta.ml* and
      mvmeta.reml* renames mlprof* and remlprof*.

    * Various internal function renamed without the initial dot '.'.

    * Modification to print() method of summary.mvmeta objects.

    * Special quotes "`" removed from names of the functions (this prevented
      the debugging tools of RStudio to work).

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.3.5 (08 Dec 2013)

#### Major changes

    * A new estimation method based on variance components has been added.

    * New arguments 'sd' and 'cor' added to mvmetaSim().

#### Minor changes

    * Modified print method for summary.mvmeta objects.

    * summary.mvmeta() and its print method improved.

    * Argument set.negeigen added to mvmeta.control().

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.3.4 (23 Jan 2013)

#### Major changes

    * An estimation method based on method of moments has been added, using
      method="mm" in mvmeta(). The algorithm is implemented in the function
      mvmeta.mm().

    * Function metaSim() and method simulate.mvmeta() added. These functions
      simulate data for multivariate and univariate meta-analysis from
      used-defined data or from a fitted model, respectively.

    * New control parameters added in mvmeta.control().

#### Minor changes

    * Bug fixed in mvmeta() with subset.

    * Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.3.2 (25 Aug 2012)


#### Minor changes

    * Bug fixed in coef.mvmeta() when k=1.

-----------------------------------

### Changes in mvmeta 0.3.1 (24 Aug 2012)

#### Minor changes

    * Bug fixed in .mkS() when k=1 and S is a list.

-----------------------------------

### Changes in mvmeta 0.3.0 (01 Aug 2012)

#### Major changes

    * The internal structure of the package has been substantially revised, with
      the aim to improve efficiency, stability and reliability. The function
      mvmeta() now resembles the standard regression functions such as lm() and
      glm(). These changes will also hopefully make easier further extensions
      and improvements. Specific changes are described below.

    *	Estimation procedure divided in steps: mvmeta() calls mvmeta.fit(), a
      wrapper for specific fitting functions mvmeta.fixed(), mvmeta.ml(), and
      mvmeta.reml(). The last two in turns call optim(), based on new likelihood
      functions with suffix .fn and .gr to compute the likelihood and the
      partial derivatives. The procedure is 15-25% faster.

    *	The structure of mvmeta() now is that of a proper regression function,
      properly based on model frames and terms objects. This allows icluding
      *ffset, extracting residuals, fitted values and the model matrix, among
      *ther benfits. Several default methods for regression functions are now
      available for mvmeta objects.

    * Handling of missing values exploits the new structure based on model
      frame with additional class "data.frame.mvmeta". Method function na.omit()
      and na.exclude() have been added to properly define missing observations.

    *	The method summary() now returns an object of class "summary.mvmeta", with
      a similar structure and printing methods of those of lm() and glm().

    * New function mvmeta.control() to provide different options in several
      steps of the model fitting. Likely to be extended in future versions.

    * Several new internal functions have been added but not exported in the
      namespace. All the method functions are now exported and documented.
	
#### Minor changes

    * Changed dependencies: not based anymore on functions in package Matrix.

    * AIC() and BIC() are now based on the default methods.

    * Coefficients are now reported in matrix form.

    * Labels are now internally defined and handled.

    *	The help page mvmetaObjects have been added.


-----------------------------------

### Changes in mvmeta 0.2.4 (06 Jan 2011)

#### Minor changes

    * Computation of quantities for Q test moved from qtest to mvmeta.

    *	Q test output now includes also tests for single outcomes.

    * Warning added to mvmeta when convergence not reached.

    * Bug fixed in mvmeta when formula is not specified.

    * beta changed to coef for coherence with other regression functions.

    * Simplified output of predict() and blup(): vector for meta-analysis or
      single prediction. Also label pred changed to fit, coherently with other 
      regression functions.

-----------------------------------

### Changes in mvmeta 0.2.3

#### Minor changes

    *	Depends changed to R (>= 2.13.0).

-----------------------------------

### Changes in mvmeta 0.2.2

#### Major changes

    *	The argument 'formula' now accept also matrix-type objects for simple
	    meta-analysis.

    *	Included 'fnscale=-1' for optim() and changed the sign of the
	    estimation algorithms: now the function maximizes.

    *	Also 'S' and 'mlab' now can be stored in 'data'.

    *	Included labels in the dataframe 'berkey98'.
	
#### Minor changes

    *	Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.2.1

#### Minor changes

    *	Fixed bug in printing of qtest.mvmeta().

    *	Documentation changed accordingly.

-----------------------------------

### Changes in mvmeta 0.2.0

#### Major changes

    *	The arguments 'y' and 'X' has been replaced by 'formula' in mvmeta().
	    Now the model is specified through a formula, making easier the 
	    inclusion of factors and other variable transformation.

    *	The objects 'class', 'contrasts' and 'model' have been added to mvmeta
      *bjects, storing info about the fitted model. In particular, method
      functions such as predict now use model.matrix() and other functions
      to re-build the model.

    *	The function kXlistmk() has been excluded from the package. Now the 
      Kronecker expansion is performed directly in the code. The argument 
      'cen' has been excluded from 'mvmeta().
	
#### Minor changes

    *	Changes in dependencies: created a new generic for blup(), in order
      to avoid the loading of metafor and its initial message. Function
      rankMatrix() imported from Matrix to check full-rank of desing matrix.

    *	Documentation changed accordingly.

-----------------------------------

### First version in R CRAN mvmeta 0.1.0

-----------------------------------
