Ch3. Mastering the Grammar
""""""""""""""""""""""""""
The source R script available :download:`here <mastery.R>`

.. include:: /table-template-knitr.rst

.. contents:: `Contents`
    :depth: 2
    :local:

**NOTE** -- LOTS of stuffs on ``qplot`` is deprecated...I gave up
working for backward compatibility at this point...

.. code-block:: R

    library(ggplot2)

3.2 Fuel economy date
=====================

.. code-block:: R

    str(mpg)

::

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    234 obs. of  11 variables:
    ##  $ manufacturer: chr  "audi" "audi" "audi" "audi" ...
    ##  $ model       : chr  "a4" "a4" "a4" "a4" ...
    ##  $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
    ##  $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
    ##  $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
    ##  $ trans       : chr  "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
    ##  $ drv         : chr  "f" "f" "f" "f" ...
    ##  $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
    ##  $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
    ##  $ fl          : chr  "p" "p" "p" "p" ...
    ##  $ class       : chr  "compact" "compact" "compact" "compact" ...

.. code-block:: R

    print(xtable::xtable(head(mpg,n=10)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Fri Nov  4 21:39:21 2016 -->

.. raw:: html

   <table border="1">

.. raw:: html

   <tr>

.. raw:: html

   <th>

.. raw:: html

   </th>

.. raw:: html

   <th>

manufacturer

.. raw:: html

   </th>

.. raw:: html

   <th>

model

.. raw:: html

   </th>

.. raw:: html

   <th>

displ

.. raw:: html

   </th>

.. raw:: html

   <th>

year

.. raw:: html

   </th>

.. raw:: html

   <th>

cyl

.. raw:: html

   </th>

.. raw:: html

   <th>

trans

.. raw:: html

   </th>

.. raw:: html

   <th>

drv

.. raw:: html

   </th>

.. raw:: html

   <th>

cty

.. raw:: html

   </th>

.. raw:: html

   <th>

hwy

.. raw:: html

   </th>

.. raw:: html

   <th>

fl

.. raw:: html

   </th>

.. raw:: html

   <th>

class

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

1

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

auto(l5)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

18

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

29

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

2

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

manual(m5)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

21

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

29

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

3

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2008

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

manual(m6)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

20

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

31

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2008

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

auto(av)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

21

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

30

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

5

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6

.. raw:: html

   </td>

.. raw:: html

   <td>

auto(l5)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

16

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

26

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

6

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6

.. raw:: html

   </td>

.. raw:: html

   <td>

manual(m5)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

18

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

26

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

7

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

3.10

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2008

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6

.. raw:: html

   </td>

.. raw:: html

   <td>

auto(av)

.. raw:: html

   </td>

.. raw:: html

   <td>

f

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

18

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

27

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

8

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4 quattro

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

manual(m5)

.. raw:: html

   </td>

.. raw:: html

   <td>

4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

18

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

26

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

9

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4 quattro

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1999

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

auto(l5)

.. raw:: html

   </td>

.. raw:: html

   <td>

4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

16

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

25

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="right">

10

.. raw:: html

   </td>

.. raw:: html

   <td>

audi

.. raw:: html

   </td>

.. raw:: html

   <td>

a4 quattro

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2008

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4

.. raw:: html

   </td>

.. raw:: html

   <td>

manual(m6)

.. raw:: html

   </td>

.. raw:: html

   <td>

4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

20

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

28

.. raw:: html

   </td>

.. raw:: html

   <td>

p

.. raw:: html

   </td>

.. raw:: html

   <td>

compact

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

3.3 Building a scatterplot
==========================

.. code-block:: R

    # A scatterplot of engine displacement in litres (displ) vs.  average
    # highway miles per gallon (hwy).  Points are coloured according to
    # number of cylinders.  This plot summarises the most important factor
    # governing fuel economy: engine size.
    qplot(displ, hwy, data = mpg, colour = factor(cyl))

|image0|\ 

Mapping aesthetics to data
--------------------------

another deprecated option... replaced ``opts(drop = "legend_box")`` with
``theme(legend.position="none")``

.. code-block:: R

    # Instead of using points to represent the data, we could use other
    # geoms like lines (left) or bars (right).  Neither of these geoms
    # makes sense for this data, but they are still grammatically valid.

    # below is deprecated
    # qplot(displ, hwy, data=mpg, colour=factor(cyl), geom="line") + 
    #   opts(drop = "legend_box")
    qplot(displ, hwy, data=mpg, colour=factor(cyl), geom="line") +
      theme(legend.position="none")

|image1|\ 

.. code-block:: R

    # qplot(displ, hwy, data=mpg, colour=factor(cyl), geom="bar", 
    #       stat="identity", position = "identity") + 
    #   opts(drop = "legend_box")
    #| couldn't get this one to work...
    # qplot(displ, hwy, data=mpg, colour=factor(cyl), geom="bar") + 
    #   geom_smooth(stat="identity", position = "identity") + 
    #   theme(legend.position="none")

    # More complicated plots don't have their own names.  This plot takes
    # Figure~\ref{fig:mpg} and adds a regression line to each group.  What
    # would you call this plot?
    qplot(displ, hwy, data=mpg, colour=factor(cyl)) + 
    geom_smooth(data= subset(mpg, cyl != 5), method="lm")

|image2|\ 

3.4 A more complex plot
=======================

.. code-block:: R

    # A more complex plot with facets and multiple layers.
    qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth()

|image3|\ 

Below, replaced ``opts(keep = "legend_box")`` with ``theme(``

.. code-block:: R

    # Examples of legends from four different scales.  From left to right:
    # continuous variable mapped to size, and to colour, discrete variable
    # mapped to shape, and to colour.  The ordering of scales seems
    # upside-down, but this matches the labelling of the $y$-axis: small
    # values occur at the bottom.
    x <- 1:10
    y <- factor(letters[1:5])
    # qplot(x, x, size = x) + opts(keep = "legend_box")
    qplot(x, x, size = x) #+ theme(legend.box = 'vertical')

|image4|\ 

.. code-block:: R

    # qplot(x, x, 1:10, colour = x)# + opts(keep = "legend_box")
    # qplot(y, y, 1:10, shape = y) #+ opts(keep = "legend_box")
    # qplot(y, y, 1:10, colour = y)# + opts(keep = "legend_box")

3.6 Data structures
===================

.. code-block:: R

    # Examples of axes and grid lines for three coordinate systems:
    # Cartesian, semi-log and polar. The polar coordinate system
    # illustrates the difficulties associated with non-Cartesian
    # coordinates: it is hard to draw the axes well.
    x1 <- c(1,10)
    y1 <- c(1, 5)
    p <- qplot(x1, y1, geom="blank", xlab=NULL, ylab=NULL) + theme_bw()
    p 

|image5|\ 

.. code-block:: R

    p + coord_trans(y="log10")

|image6|\ 

.. code-block:: R

    p + coord_polar()

|image7|\ 

.. code-block:: R

    p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))
    summary(p)

::

    ## data: manufacturer, model, displ, year, cyl, trans, drv, cty, hwy,
    ##   fl, class [234x11]
    ## mapping:  colour = factor(cyl), x = displ, y = hwy
    ## faceting: facet_null() 
    ## -----------------------------------
    ## geom_point: na.rm = FALSE
    ## stat_identity: na.rm = FALSE
    ## position_identity

.. code-block:: R

    # Save plot object to disk
    save(p, file = "plot.rdata")
    # Load from disk
    load("plot.rdata")
    # Save png to disk
    ggsave("plot.png", width = 5, height = 5)

.. |image0| image:: mastery_files/figure-html/unnamed-chunk-4-1.png
.. |image1| image:: mastery_files/figure-html/unnamed-chunk-5-1.png
.. |image2| image:: mastery_files/figure-html/unnamed-chunk-5-2.png
.. |image3| image:: mastery_files/figure-html/unnamed-chunk-6-1.png
.. |image4| image:: mastery_files/figure-html/unnamed-chunk-7-1.png
.. |image5| image:: mastery_files/figure-html/unnamed-chunk-8-1.png
.. |image6| image:: mastery_files/figure-html/unnamed-chunk-8-2.png
.. |image7| image:: mastery_files/figure-html/unnamed-chunk-8-3.png
