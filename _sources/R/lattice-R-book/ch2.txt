Ch2 - A Technical Overview
""""""""""""""""""""""""""
The source R script available :download:`here <ch2.R>`

.. contents:: `Contents`
    :depth: 2
    :local:


Gives a "big picture" view of the system.

**Topics covered**

-  The formula interface
-  object dimensions and physical layout
-  Annotation
-  Scales and Axes
-  Panel functions

.. code-block:: R

    library(lattice)

    data(Oats, package = "MEMSS")

Dimension and Physical Layout
=============================

Figure 2.1 (A Trelis display of the **Data** Object)
----------------------------------------------------

.. code-block:: R

    tp1.oats <- 
      xyplot(yield ~ nitro | Variety + Block, data = Oats, type = 'o')
    print(tp1.oats)

|image0|\ 

.. code-block:: R

    dim(tp1.oats)

::

    ## [1] 3 6

.. code-block:: R

    dimnames(tp1.oats)

::

    ## $Variety
    ## [1] "Golden Rain" "Marvellous"  "Victory"    
    ## 
    ## $Block
    ## [1] "I"   "II"  "III" "IV"  "V"   "VI"

.. code-block:: R

    xtabs(~Variety + Block, data = Oats)

::

    ##              Block
    ## Variety       I II III IV V VI
    ##   Golden Rain 4  4   4  4 4  4
    ##   Marvellous  4  4   4  4 4  4
    ##   Victory     4  4   4  4 4  4

.. code-block:: R

    summary(tp1.oats)

::

    ## 
    ## Call:
    ## xyplot(yield ~ nitro | Variety + Block, data = Oats, type = "o")
    ## 
    ## Number of observations:
    ##              Block
    ## Variety       I II III IV V VI
    ##   Golden Rain 4  4   4  4 4  4
    ##   Marvellous  4  4   4  4 4  4
    ##   Victory     4  4   4  4 4  4

.. code-block:: R

    summary(tp1.oats[, 1])

::

    ## 
    ## Call:
    ## xyplot(yield ~ nitro | Variety + Block, data = Oats, type = "o", 
    ##     index.cond = new.levs)
    ## 
    ## Number of observations:
    ##              Block
    ## Variety       I
    ##   Golden Rain 4
    ##   Marvellous  4
    ##   Victory     4

Figure 2.2 (subset display of the Trellis object)
-------------------------------------------------

.. code-block:: R

    print(tp1.oats[, 1])

|image1|\ 

Figure 2.3 (aspect ratio control)
---------------------------------

.. code-block:: R

    update(tp1.oats, 
           aspect="xy")

|image2|\ 

Figure 2.4
----------

.. code-block:: R

    update(tp1.oats, aspect = "xy",
           layout = c(0, 18))

|image3|\ 

Figure 2.5 (fig 2.5 with spacing between column blocks)
-------------------------------------------------------

.. code-block:: R

    update(tp1.oats, aspect = "xy", layout = c(0, 18), 
           between = list(x = c(0, 0, 0.5), y = 0.5))

|image4|\ 

Grouped displays
================

Figure 2.6
----------

.. code-block:: R

    dotplot(variety ~ yield | site, barley, 
            layout = c(1, 6), aspect = c(0.7),
            groups = year, auto.key = list(space = 'right'))

|image5|\ 

Annotation: Captions, labels, and legends
=========================================

Figure 2.7
----------

.. code-block:: R

    key.variety <- 
      list(space = "right", text = list(levels(Oats$Variety)),
           points = list(pch = 1:3, col = "black"))
    xyplot(yield ~ nitro | Block, Oats, aspect = "xy", type = "o", 
           groups = Variety, key = key.variety, lty = 1, pch = 1:3, 
           col.line = "darkgrey", col.symbol = "black",
           xlab = "Nitrogen concentration (cwt/acre)",
           ylab = "Yield (bushels/acre)", 
           main = "Yield of three varieties of oats",
           sub = "A 3 x 4 split plot experiment with 6 blocks")

|image6|\ 

Scale and Axes
==============

Figure 2.8
----------

.. code-block:: R

    barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
             groups = Survived, stack = TRUE, layout = c(4, 1),
             auto.key = list(title = "Survived", columns = 2))

|image7|\ 

Figure 2.9
----------

.. code-block:: R

    barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
             groups = Survived, stack = TRUE, layout = c(4, 1), 
             auto.key = list(title = "Survived", columns = 2),
             scales = list(x = "free"))

|image8|\ 

The Panel function
==================

Figure 2.10
-----------

.. code-block:: R

    bc.titanic <- 
      barchart(Class ~ Freq | Sex + Age, as.data.frame(Titanic), 
               groups = Survived, stack = TRUE, layout = c(4, 1),
               auto.key = list(title = "Survived", columns = 2),
               scales = list(x = "free"))
    update(bc.titanic, 
           panel = function(...) {
             panel.grid(h = 0, v = -1)
             panel.barchart(...)
           })

|image9|\ 

Figure 2.11
-----------

.. code-block:: R

    update(bc.titanic, 
           panel = function(..., border) {
             panel.barchart(..., border = "transparent")
           })

|image10|\ 

.. |image0| image:: ch2_files/figure-html/unnamed-chunk-3-1.png
.. |image1| image:: ch2_files/figure-html/unnamed-chunk-4-1.png
.. |image2| image:: ch2_files/figure-html/unnamed-chunk-5-1.png
.. |image3| image:: ch2_files/figure-html/unnamed-chunk-6-1.png
.. |image4| image:: ch2_files/figure-html/unnamed-chunk-7-1.png
.. |image5| image:: ch2_files/figure-html/unnamed-chunk-8-1.png
.. |image6| image:: ch2_files/figure-html/unnamed-chunk-9-1.png
.. |image7| image:: ch2_files/figure-html/unnamed-chunk-10-1.png
.. |image8| image:: ch2_files/figure-html/unnamed-chunk-11-1.png
.. |image9| image:: ch2_files/figure-html/unnamed-chunk-12-1.png
.. |image10| image:: ch2_files/figure-html/unnamed-chunk-13-1.png
