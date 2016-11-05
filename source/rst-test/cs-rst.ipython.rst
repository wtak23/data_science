Demo runs of ipython sphinx extensions (``cs-rst.ipython.rst``)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
http://matplotlib.org/sampledoc/ipython_directive.html

.. warning:: 
  
  For the image to get copied under the appropriate ``build`` folder, it appears like I need to run ``make html`` twice after doing ``make clean``...

.. ipython:: python
    :okwarning:

    import statsmodels.api as sm
    from statsmodels.formula.api import ols

    moore = sm.datasets.get_rdataset("Moore", "car",
                                     cache=True) # load data
    data = moore.data
    data = data.rename(columns={"partner.status":
                                "partner_status"}) # make name pythonic
    moore_lm = ols('conformity ~ C(fcategory, Sum)*C(partner_status, Sum)',
                    data=data).fit()

    table = sm.stats.anova_lm(moore_lm, typ=2) # Type 2 ANOVA DataFrame
    print(table)


.. ipython:: python
   :okwarning:
    
   import matplotlib.pyplot as plt
   np.random.seed(0)

   @savefig plot_simple.png width=4in
   plt.plot([1,2,3]);

   # use a semicolon to suppress the output
   @savefig hist_simple.png width=4in
   plt.hist(np.random.randn(10000), 100);



In a subsequent session, we can update the current figure with some
text, and then resave


.. note:: rst-source code for below
    
    Note the use of decorator ``@savefig``
    (go `here <http://matplotlib.org/sampledoc/ipython_directive.html#pseudo-decorators>`__ for more info on ipython decorators)

    - ``@savefig OUTFILE [IMAGE_OPTIONS]``
    - ``@verbatim``
    - ``@suppress``
    - ``@doctest``

    For image option, see http://docutils.sourceforge.net/docs/ref/rst/directives.html#image

    .. code-block:: rst

        .. ipython::

           # neat to see the numbers get updated when rendered 
           #([151] in the sourcefile becomes [12] in html)
           In [151]: plt.ylabel('number')

           In [152]: plt.title('normal distribution')

           @savefig hist_with_text.png width=4in
           In [153]: plt.grid(True)

.. ipython::

   # neat to see the numbers get updated when rendered 
   #([151] in the sourcefile becomes [12] in html)
   In [151]: plt.ylabel('number')

   In [152]: plt.title('normal distribution')

   @savefig hist_with_text.png width=4in
   In [153]: plt.grid(True)