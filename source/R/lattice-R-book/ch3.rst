Ch3 - Displaying Univariate Distributions
"""""""""""""""""""""""""""""""""""""""""
The source R script available :download:`here <ch3.R>`

.. contents:: `Contents`
    :depth: 2
    :local:

.. include:: /table-template-knitr.rst


From http://lmdvr.r-forge.r-project.org/figures/figures.html

.. code-block:: R

    library(lattice)
    library("latticeExtra")

::

    ## Loading required package: RColorBrewer

.. code-block:: R

    library(xtable)

Datasets used in this Chapter
=============================

faithful
--------

.. code-block:: R

    str(faithful)

::

    ## 'data.frame':    272 obs. of  2 variables:
    ##  $ eruptions: num  3.6 1.8 3.33 2.28 4.53 ...
    ##  $ waiting  : num  79 54 74 62 85 55 88 85 51 85 ...

.. code-block:: R

    print(xtable(head(faithful,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:35 2016 -->

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

eruptions

.. raw:: html

   </th>

.. raw:: html

   <th>

waiting

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

   <td align="right">

3.60

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

79.00

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

   <td align="right">

1.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

54.00

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

   <td align="right">

3.33

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

74.00

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

   <td align="right">

2.28

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

62.00

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

   <td align="right">

4.53

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

85.00

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

gvhd10
------

.. code-block:: R

    data(gvhd10)
    str(gvhd10)

::

    ## 'data.frame':    113896 obs. of  8 variables:
    ##  $ FSC.H: num  548 213 205 119 474 198 267 60 69 552 ...
    ##  $ SSC.H: num  536 33 38 45 904 45 177 82 8 544 ...
    ##  $ FL1.H: num  1 2.13 4.11 1.55 170.86 ...
    ##  $ FL2.H: num  20 104 141 630 2203 ...
    ##  $ FL3.H: num  1 7.93 5.95 4.79 84.66 ...
    ##  $ FL2.A: num  8 23 30 148 812 28 29 105 12 5 ...
    ##  $ FL4.H: num  2.09 1 1 1.26 37.99 ...
    ##  $ Days : Factor w/ 7 levels "-6","0","6","13",..: 1 1 1 1 1 1 1 1 1 1 ...

.. code-block:: R

    print(xtable(head(gvhd10,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:35 2016 -->

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

FSC.H

.. raw:: html

   </th>

.. raw:: html

   <th>

SSC.H

.. raw:: html

   </th>

.. raw:: html

   <th>

FL1.H

.. raw:: html

   </th>

.. raw:: html

   <th>

FL2.H

.. raw:: html

   </th>

.. raw:: html

   <th>

FL3.H

.. raw:: html

   </th>

.. raw:: html

   <th>

FL2.A

.. raw:: html

   </th>

.. raw:: html

   <th>

FL4.H

.. raw:: html

   </th>

.. raw:: html

   <th>

Days

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

   <td align="right">

548.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

536.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

20.05

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

8.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.09

.. raw:: html

   </td>

.. raw:: html

   <td>

-6

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

   <td align="right">

213.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

33.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2.13

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

104.13

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.93

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

23.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.00

.. raw:: html

   </td>

.. raw:: html

   <td>

-6

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

   <td align="right">

205.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

38.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.11

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

141.43

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

5.95

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

30.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.00

.. raw:: html

   </td>

.. raw:: html

   <td>

-6

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

   <td align="right">

119.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

45.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.55

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

630.39

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.79

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

148.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.26

.. raw:: html

   </td>

.. raw:: html

   <td>

-6

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

   <td align="right">

474.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

904.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

170.86

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

2203.48

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

84.66

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

812.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

37.99

.. raw:: html

   </td>

.. raw:: html

   <td>

-6

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

Chem97
------

.. code-block:: R

    data(Chem97, package = "mlmRev")
    str(Chem97)

::

    ## 'data.frame':    31022 obs. of  8 variables:
    ##  $ lea      : Factor w/ 131 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ school   : Factor w/ 2410 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ student  : Factor w/ 31022 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ score    : num  4 10 10 10 8 10 6 8 4 10 ...
    ##  $ gender   : Factor w/ 2 levels "M","F": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ age      : num  3 -3 -4 -2 -1 4 1 4 3 0 ...
    ##  $ gcsescore: num  6.62 7.62 7.25 7.5 6.44 ...
    ##  $ gcsecnt  : num  0.339 1.339 0.964 1.214 0.158 ...

.. code-block:: R

    print(xtable(head(Chem97,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:36 2016 -->

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

lea

.. raw:: html

   </th>

.. raw:: html

   <th>

school

.. raw:: html

   </th>

.. raw:: html

   <th>

student

.. raw:: html

   </th>

.. raw:: html

   <th>

score

.. raw:: html

   </th>

.. raw:: html

   <th>

gender

.. raw:: html

   </th>

.. raw:: html

   <th>

age

.. raw:: html

   </th>

.. raw:: html

   <th>

gcsescore

.. raw:: html

   </th>

.. raw:: html

   <th>

gcsecnt

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

3.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.34

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

2

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-3.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.34

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

3

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-4.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.25

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.96

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-2.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.50

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.21

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

5

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

8.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-1.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6.44

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.16

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

quakes
------

.. code-block:: R

    str(quakes)

::

    ## 'data.frame':    1000 obs. of  5 variables:
    ##  $ lat     : num  -20.4 -20.6 -26 -18 -20.4 ...
    ##  $ long    : num  182 181 184 182 182 ...
    ##  $ depth   : int  562 650 42 626 649 195 82 194 211 622 ...
    ##  $ mag     : num  4.8 4.2 5.4 4.1 4 4 4.8 4.4 4.7 4.3 ...
    ##  $ stations: int  41 15 43 19 11 12 43 15 35 19 ...

.. code-block:: R

    print(xtable(head(quakes,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:36 2016 -->

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

lat

.. raw:: html

   </th>

.. raw:: html

   <th>

long

.. raw:: html

   </th>

.. raw:: html

   <th>

depth

.. raw:: html

   </th>

.. raw:: html

   <th>

mag

.. raw:: html

   </th>

.. raw:: html

   <th>

stations

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

   <td align="right">

-20.42

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

181.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

562

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.80

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

41

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

   <td align="right">

-20.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

181.03

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

650

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.20

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

15

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

   <td align="right">

-26.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

184.10

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

42

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

5.40

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

43

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

   <td align="right">

-17.97

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

181.66

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

626

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.10

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

19

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

   <td align="right">

-20.42

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

181.96

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

649

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

11

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

barley
------

.. code-block:: R

    str(barley)

::

    ## 'data.frame':    120 obs. of  4 variables:
    ##  $ yield  : num  27 48.9 27.4 39.9 33 ...
    ##  $ variety: Factor w/ 10 levels "Svansota","No. 462",..: 3 3 3 3 3 3 7 7 7 7 ...
    ##  $ year   : Factor w/ 2 levels "1932","1931": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ site   : Factor w/ 6 levels "Grand Rapids",..: 3 6 4 5 1 2 3 6 4 5 ...

.. code-block:: R

    print(xtable(head(barley,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:36 2016 -->

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

yield

.. raw:: html

   </th>

.. raw:: html

   <th>

variety

.. raw:: html

   </th>

.. raw:: html

   <th>

year

.. raw:: html

   </th>

.. raw:: html

   <th>

site

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

   <td align="right">

27.00

.. raw:: html

   </td>

.. raw:: html

   <td>

Manchuria

.. raw:: html

   </td>

.. raw:: html

   <td>

1931

.. raw:: html

   </td>

.. raw:: html

   <td>

University Farm

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

   <td align="right">

48.87

.. raw:: html

   </td>

.. raw:: html

   <td>

Manchuria

.. raw:: html

   </td>

.. raw:: html

   <td>

1931

.. raw:: html

   </td>

.. raw:: html

   <td>

Waseca

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

   <td align="right">

27.43

.. raw:: html

   </td>

.. raw:: html

   <td>

Manchuria

.. raw:: html

   </td>

.. raw:: html

   <td>

1931

.. raw:: html

   </td>

.. raw:: html

   <td>

Morris

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

   <td align="right">

39.93

.. raw:: html

   </td>

.. raw:: html

   <td>

Manchuria

.. raw:: html

   </td>

.. raw:: html

   <td>

1931

.. raw:: html

   </td>

.. raw:: html

   <td>

Crookston

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

   <td align="right">

32.97

.. raw:: html

   </td>

.. raw:: html

   <td>

Manchuria

.. raw:: html

   </td>

.. raw:: html

   <td>

1931

.. raw:: html

   </td>

.. raw:: html

   <td>

Grand Rapids

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

Density plot
============

Figure 3.1
----------

.. code-block:: R

    densityplot(~ eruptions, data = faithful)

|image0|\ 

Figure 3.2
----------

.. code-block:: R

    densityplot(~ eruptions, data = faithful, 
                kernel = "rect", bw = 0.2, plot.points = "rug", n = 200)

|image1|\ 

Figure 3.3
----------

.. code-block:: R

    densityplot(~log(FSC.H) | Days, data = gvhd10, 
                plot.points = FALSE, ref = TRUE, layout = c(2, 4))

|image2|\ 

Histograms
==========

Figure 3.4
----------

.. code-block:: R

    histogram(~log2(FSC.H) | Days, gvhd10, xlab = "log Forward Scatter",
              type = "density", nint = 50, layout = c(2, 4))

|image3|\ 

Normal QQ Plots
===============

Figure 3.5
----------

.. code-block:: R

    qqmath(~ gcsescore | factor(score), data = Chem97, 
           f.value = ppoints(100))

|image4|\ 

Figure 3.6
----------

.. code-block:: R

    qqmath(~ gcsescore | gender, Chem97, groups = score, aspect = "xy", 
           f.value = ppoints(100), auto.key = list(space = "right"),
           xlab = "Standard Normal Quantiles", 
           ylab = "Average GCSE Score")

|image5|\ 

.. code-block:: R

    Chem97.mod <- transform(Chem97, gcsescore.trans = gcsescore^2.34)

.. code-block:: R

    str(Chem97.mod)

'data.frame': 31022 obs. of 9 variables: $ lea : Factor w/ 131 levels
"1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ... $ school : Factor w/ 2410
levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ... $ student : Factor w/
31022 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ... $ score : num
4 10 10 10 8 10 6 8 4 10 ... $ gender : Factor w/ 2 levels "M","F": 2 2
2 2 2 2 2 2 2 2 ... $ age : num 3 -3 -4 -2 -1 4 1 4 3 0 ... $ gcsescore
: num 6.62 7.62 7.25 7.5 6.44 ... $ gcsecnt : num 0.339 1.339 0.964
1.214 0.158 ... $ gcsescore.trans: num 83.5 116 103.1 111.6 78.2 ...

.. code-block:: R

    print(xtable(head(Chem97.mod,n=5)), type='html')

.. raw:: html

   <!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->

.. raw:: html

   <!-- Thu Nov  3 20:17:37 2016 -->

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

lea

.. raw:: html

   </th>

.. raw:: html

   <th>

school

.. raw:: html

   </th>

.. raw:: html

   <th>

student

.. raw:: html

   </th>

.. raw:: html

   <th>

score

.. raw:: html

   </th>

.. raw:: html

   <th>

gender

.. raw:: html

   </th>

.. raw:: html

   <th>

age

.. raw:: html

   </th>

.. raw:: html

   <th>

gcsescore

.. raw:: html

   </th>

.. raw:: html

   <th>

gcsecnt

.. raw:: html

   </th>

.. raw:: html

   <th>

gcsescore.trans

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

4.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

3.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.34

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

83.48

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

2

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-3.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.62

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.34

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

116.00

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

3

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-4.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.25

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.96

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

103.08

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

4

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

10.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-2.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

7.50

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

1.21

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

111.59

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

1

.. raw:: html

   </td>

.. raw:: html

   <td>

1

.. raw:: html

   </td>

.. raw:: html

   <td>

5

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

8.00

.. raw:: html

   </td>

.. raw:: html

   <td>

F

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

-1.00

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

6.44

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

0.16

.. raw:: html

   </td>

.. raw:: html

   <td align="right">

78.24

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

Figure 3.7
----------

.. code-block:: R

    qqmath(~ gcsescore.trans | gender, Chem97.mod, groups = score,
           f.value = ppoints(100), aspect = "xy",
           auto.key = list(space = "right", title = "score"), 
           xlab = "Standard Normal Quantiles", 
           ylab = "Transformed GCSE Score")

|image6|\ 

.. code-block:: R

    library("latticeExtra")

The empirical CDF
=================

Figure 3.8
----------

.. code-block:: R

    ecdfplot(~ gcsescore | factor(score), data = Chem97, 
             groups = gender, auto.key = list(columns = 2),
             subset = gcsescore > 0, xlab = "Average GCSE Score")

|image7|\ 

Two-sample QQ-plots
===================

Figure 3.9
----------

.. code-block:: R

    qqmath(~ gcsescore | factor(score), data = Chem97, groups = gender, 
           auto.key = list(points = FALSE, lines = TRUE, columns = 2),
           subset = gcsescore > 0, type = "l", distribution = qunif, 
           prepanel = prepanel.qqmathline, aspect = "xy",
           xlab = "Standard Normal Quantiles", 
           ylab = "Average GCSE Score")

|image8|\ 

Figure 3.10
-----------

.. code-block:: R

    qq(gender ~ gcsescore | factor(score), Chem97, 
       f.value = ppoints(100), aspect = 1)

|image9|\ 

Box-and-whisker plots
=====================

Figure 3.11
-----------

.. code-block:: R

    bwplot(factor(score) ~ gcsescore | gender, data = Chem97, 
           xlab = "Average GCSE Score")

|image10|\ 

Figure 3.12
-----------

.. code-block:: R

    bwplot(gcsescore^2.34 ~ gender | factor(score), Chem97, 
           varwidth = TRUE, layout = c(6, 1),
           ylab = "Transformed GCSE score")

|image11|\ 

Figure 3.13
-----------

.. code-block:: R

    bwplot(Days ~ log(FSC.H), data = gvhd10, 
           xlab = "log(Forward Scatter)", ylab = "Days Past Transplant")

|image12|\ 

Figure 3.14
-----------

.. code-block:: R

    bwplot(Days ~ log(FSC.H), gvhd10, 
           panel = panel.violin, box.ratio = 3,
           xlab = "log(Forward Scatter)", 
           ylab = "Days Past Transplant")

|image13|\ 

Strip plot
==========

Figure 3.15
-----------

.. code-block:: R

    stripplot(factor(mag) ~ depth, quakes)

|image14|\ 

Figure 3.16
-----------

.. code-block:: R

    stripplot(depth ~ factor(mag), quakes, 
              jitter.data = TRUE, alpha = 0.6,
              xlab = "Magnitude (Richter)", ylab = "Depth (km)")

|image15|\ 

Figure 3.17
-----------

.. code-block:: R

    stripplot(sqrt(abs(residuals(lm(yield~variety+year+site)))) ~ site, 
              data = barley, groups = year, jitter.data = TRUE,
              auto.key = list(points = TRUE, lines = TRUE, columns = 2),
              type = c("p", "a"), fun = median,
              ylab = expression(abs("Residual Barley Yield")^{1 / 2}))

|image16|\ 

.. |image0| image:: ch3_files/figure-html/unnamed-chunk-13-1.png
.. |image1| image:: ch3_files/figure-html/unnamed-chunk-14-1.png
.. |image2| image:: ch3_files/figure-html/unnamed-chunk-15-1.png
.. |image3| image:: ch3_files/figure-html/unnamed-chunk-16-1.png
.. |image4| image:: ch3_files/figure-html/unnamed-chunk-17-1.png
.. |image5| image:: ch3_files/figure-html/unnamed-chunk-18-1.png
.. |image6| image:: ch3_files/figure-html/unnamed-chunk-20-1.png
.. |image7| image:: ch3_files/figure-html/unnamed-chunk-21-1.png
.. |image8| image:: ch3_files/figure-html/unnamed-chunk-22-1.png
.. |image9| image:: ch3_files/figure-html/unnamed-chunk-23-1.png
.. |image10| image:: ch3_files/figure-html/unnamed-chunk-24-1.png
.. |image11| image:: ch3_files/figure-html/unnamed-chunk-25-1.png
.. |image12| image:: ch3_files/figure-html/unnamed-chunk-26-1.png
.. |image13| image:: ch3_files/figure-html/unnamed-chunk-27-1.png
.. |image14| image:: ch3_files/figure-html/unnamed-chunk-28-1.png
.. |image15| image:: ch3_files/figure-html/unnamed-chunk-29-1.png
.. |image16| image:: ch3_files/figure-html/unnamed-chunk-30-1.png
