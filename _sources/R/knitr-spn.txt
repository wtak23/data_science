knitr-spn.R
"""""""""""
The source R script available :download:`here <knitr-spn.R>`

.. contents:: `Contents`
    :depth: 2
    :local:


| Takanori Watanabe
| Nov 1, 2016
| This is a special R script which can be used to generate a report. You
  can write normal text in roxygen comments.

First we set up some options (you do not have to do this):

The report begins here.

.. code-block:: R

    # boring examples as usual
    set.seed(123)
    x = rnorm(5)
    mean(x)

::

    ## [1] 0.1935703

You can use the special syntax {{code}} to embed inline expressions,
e.g. {{mean(x) + 2}} is the mean of x plus 2. The code itself may
contain braces, but these are not checked. Thus, perfectly valid (though
very strange) R code such as ``{{2 + 3}} - {{4 - 5}}`` can lead to
errors because ``2 + 3}} - {{4 - 5`` will be treated as inline code.

Now we continue writing the report. We can draw plots as well.

.. code-block:: R

    par(mar = c(4, 4, .1, .1)); plot(x)

|image0|\ 

Actually you do not have to write chunk options, in which case knitr
will use default options. For example, the code below has no options
attached:

.. code-block:: R

    var(x)

::

    ## [1] 0.6577564

.. code-block:: R

    quantile(x)

::

    ##          0%         25%         50%         75%        100% 
    ## -0.56047565 -0.23017749  0.07050839  0.12928774  1.55870831

And you can also write two chunks successively like this:

.. code-block:: R

    sum(x^2) # chi-square distribution with df 5

::

    ## [1] 2.818373

.. code-block:: R

    sum((x - mean(x))^2) # df is 4 now

::

    ## [1] 2.631026

.. |image0| image:: figure/silk-test-b-1.png
