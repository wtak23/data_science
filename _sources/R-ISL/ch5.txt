Ch5 Cross-Validation and the Bootstrap
""""""""""""""""""""""""""""""""""""""
The source R script available :download:`here <ch5.R>`

.. include:: /table-template-knitr.rst

.. contents:: `Contents`
    :depth: 2
    :local:

Codes from http://www-bcf.usc.edu/~gareth/ISL/All%20Labs.txt

.. code-block:: R

    options(show.error.locations = TRUE)

The Validation Set Approach
===========================

.. code-block:: R

    library(ISLR)

::

    ## Warning: package 'ISLR' was built under R version 3.3.2

.. code-block:: R

    set.seed(1)
    train=sample(392,196)
    lm.fit=lm(mpg~horsepower,data=Auto,subset=train)
    attach(Auto)
    mean((mpg-predict(lm.fit,Auto))[-train]^2)

::

    ## [1] 26.14142

.. code-block:: R

    lm.fit2=lm(mpg~poly(horsepower,2),data=Auto,subset=train)
    mean((mpg-predict(lm.fit2,Auto))[-train]^2)

::

    ## [1] 19.82259

.. code-block:: R

    lm.fit3=lm(mpg~poly(horsepower,3),data=Auto,subset=train)
    mean((mpg-predict(lm.fit3,Auto))[-train]^2)

::

    ## [1] 19.78252

.. code-block:: R

    set.seed(2)
    train=sample(392,196)
    lm.fit=lm(mpg~horsepower,subset=train)
    mean((mpg-predict(lm.fit,Auto))[-train]^2)

::

    ## [1] 23.29559

.. code-block:: R

    lm.fit2=lm(mpg~poly(horsepower,2),data=Auto,subset=train)
    mean((mpg-predict(lm.fit2,Auto))[-train]^2)

::

    ## [1] 18.90124

.. code-block:: R

    lm.fit3=lm(mpg~poly(horsepower,3),data=Auto,subset=train)
    mean((mpg-predict(lm.fit3,Auto))[-train]^2)

::

    ## [1] 19.2574

Leave-One-Out Cross-Validation
==============================

.. code-block:: R

    glm.fit=glm(mpg~horsepower,data=Auto)
    coef(glm.fit)

::

    ## (Intercept)  horsepower 
    ##  39.9358610  -0.1578447

.. code-block:: R

    lm.fit=lm(mpg~horsepower,data=Auto)
    coef(lm.fit)

::

    ## (Intercept)  horsepower 
    ##  39.9358610  -0.1578447

.. code-block:: R

    library(boot)
    glm.fit=glm(mpg~horsepower,data=Auto)
    cv.err=cv.glm(Auto,glm.fit)
    cv.err$delta

::

    ## [1] 24.23151 24.23114

.. code-block:: R

    cv.error=rep(0,5)
    for (i in 1:5){
      glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
      cv.error[i]=cv.glm(Auto,glm.fit)$delta[1]
    }
    cv.error

::

    ## [1] 24.23151 19.24821 19.33498 19.42443 19.03321

k-Fold Cross-Validation
=======================

.. code-block:: R

    set.seed(17)
    cv.error.10=rep(0,10)
    for (i in 1:10){
      glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
      cv.error.10[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
    }
    cv.error.10

::

    ##  [1] 24.20520 19.18924 19.30662 19.33799 18.87911 19.02103 18.89609
    ##  [8] 19.71201 18.95140 19.50196

The Bootstrap
=============

.. code-block:: R

    alpha.fn=function(data,index){
      X=data$X[index]
      Y=data$Y[index]
      return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
    }
    alpha.fn(Portfolio,1:100)

::

    ## [1] 0.5758321

.. code-block:: R

    set.seed(1)
    alpha.fn(Portfolio,sample(100,100,replace=T))

::

    ## [1] 0.5963833

.. code-block:: R

    boot(Portfolio,alpha.fn,R=1000)

::

    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = Portfolio, statistic = alpha.fn, R = 1000)
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original        bias    std. error
    ## t1* 0.5758321 -7.315422e-05  0.08861826

Estimating the Accuracy of a Linear Regression Model
====================================================

.. code-block:: R

    boot.fn=function(data,index)
      return(coef(lm(mpg~horsepower,data=data,subset=index)))
    boot.fn(Auto,1:392)

::

    ## (Intercept)  horsepower 
    ##  39.9358610  -0.1578447

.. code-block:: R

    set.seed(1)
    boot.fn(Auto,sample(392,392,replace=T))

::

    ## (Intercept)  horsepower 
    ##  38.7387134  -0.1481952

.. code-block:: R

    boot.fn(Auto,sample(392,392,replace=T))

::

    ## (Intercept)  horsepower 
    ##  40.0383086  -0.1596104

.. code-block:: R

    boot(Auto,boot.fn,1000)

::

    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = Auto, statistic = boot.fn, R = 1000)
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* 39.9358610  0.02972191 0.860007896
    ## t2* -0.1578447 -0.00030823 0.007404467

.. code-block:: R

    summary(lm(mpg~horsepower,data=Auto))$coef

::

    ##               Estimate  Std. Error   t value      Pr(>|t|)
    ## (Intercept) 39.9358610 0.717498656  55.65984 1.220362e-187
    ## horsepower  -0.1578447 0.006445501 -24.48914  7.031989e-81

.. code-block:: R

    boot.fn=function(data,index)
      coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,subset=index))
    set.seed(1)
    boot(Auto,boot.fn,1000)

::

    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = Auto, statistic = boot.fn, R = 1000)
    ## 
    ## 
    ## Bootstrap Statistics :
    ##         original        bias     std. error
    ## t1* 56.900099702  6.098115e-03 2.0944855842
    ## t2* -0.466189630 -1.777108e-04 0.0334123802
    ## t3*  0.001230536  1.324315e-06 0.0001208339

.. code-block:: R

    summary(lm(mpg~horsepower+I(horsepower^2),data=Auto))$coef

::

    ##                     Estimate   Std. Error   t value      Pr(>|t|)
    ## (Intercept)     56.900099702 1.8004268063  31.60367 1.740911e-109
    ## horsepower      -0.466189630 0.0311246171 -14.97816  2.289429e-40
    ## I(horsepower^2)  0.001230536 0.0001220759  10.08009  2.196340e-21
