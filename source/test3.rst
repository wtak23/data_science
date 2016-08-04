.. Comment out below. This demonstrates autodoc for ENTIRE module, so may be 
   time-consuming to completely render

Demo of compiling docstring for entire module
(hmmm, this string doesn't appear .... i guess i need it under some header to 
fall in the doctree)

But i guess i can use this section as a comment then.

So below i automodule two modules. they each receive its own top-toc-tree level
(so ch3 = statsmodel, ch4 = sklearn.covariance)

.. autosummary::
   :toctree: generated/
   :template: module_custom.rst

   statsmodels


.. autosummary::
   :toctree: generated/
   :template: module_custom.rst

   sklearn.covariance