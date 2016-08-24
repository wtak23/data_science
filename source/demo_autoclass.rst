
.. _demo_autoclass:

###########################
Demo of autodoc'ing classes
###########################

.. rubric:: No template used

Here no template used (so no recursive html files are created for class methods)

.. toctree::
    :maxdepth: 1

    generated/statsmodels.api.GLS

.. autosummary::
   :toctree:generated/

    statsmodels.api.GLS


.. rubric:: Template class_custom.rst used

.. toctree::
    :maxdepth: 1

    generated/statsmodels.api.WLS

.. autosummary::
   :toctree:generated/
   :template:class_custom.rst

    statsmodels.api.WLS

.. rubric:: Template class_all_methods.rst used

Here even the **hidden** class methods are shown (methods of the form ``__new__``)
.. rubric:: Below I've used my template for including hidden methods

.. toctree::
    :maxdepth: 1

    generated/statsmodels.api.OLS

.. autosummary::
   :toctree:generated/
   :template:class_all_methods.rst

    statsmodels.api.OLS