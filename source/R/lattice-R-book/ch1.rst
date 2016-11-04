Ch1 - Introduction
""""""""""""""""""
The source R script available :download:`here <ch1.R>`

.. contents:: `Contents`
    :depth: 2
    :local:


From http://lmdvr.r-forge.r-project.org/figures/figures.html

.. code-block:: R

    library(lattice)

    data(Chem97, package = "mlmRev")
    xtabs( ~ score, data = Chem97)

::

    ## score
    ##    0    2    4    6    8   10 
    ## 3688 3627 4619 5739 6668 6681

.. code-block:: R

    library("lattice")

Figure 1.1 (conditional histogram)
----------------------------------

.. code-block:: R

    histogram(~ gcsescore | factor(score), data = Chem97)

|image0|\ 

Figure 1.2 (conditional density plot)
-------------------------------------

.. code-block:: R

    densityplot(~ gcsescore | factor(score), data = Chem97, 
                plot.points = FALSE, ref = TRUE)

|image1|\ 

Figure 1.3 (grouped kde plot)
-----------------------------

.. code-block:: R

    densityplot(~ gcsescore, data = Chem97, groups = score,
                plot.points = FALSE, ref = TRUE,
                auto.key = list(columns = 3))

|image2|\ 

Figure 1.4 (conditional histogram and kde grouped in a single figure)
---------------------------------------------------------------------

.. code-block:: R

    tp1 <- histogram(~ gcsescore | factor(score), data = Chem97)
    tp2 <- 
      densityplot(~ gcsescore, data = Chem97, groups = score,
                  plot.points = FALSE,
                  auto.key = list(space = "right", title = "score"))
    class(tp2)

::

    ## [1] "trellis"

.. code-block:: R

    summary(tp1)

::

    ## 
    ## Call:
    ## histogram(~gcsescore | factor(score), data = Chem97)
    ## 
    ## Number of observations:
    ## factor(score)
    ##    0    2    4    6    8   10 
    ## 3688 3627 4619 5739 6668 6681

.. code-block:: R

    plot(tp1, split = c(1, 1, 1, 2))
    plot(tp2, split = c(1, 2, 1, 2), newpage = FALSE)

|image3|\ 

.. |image0| image:: ch1_files/figure-html/unnamed-chunk-3-1.png
.. |image1| image:: ch1_files/figure-html/unnamed-chunk-4-1.png
.. |image2| image:: ch1_files/figure-html/unnamed-chunk-5-1.png
.. |image3| image:: ch1_files/figure-html/unnamed-chunk-6-1.png
