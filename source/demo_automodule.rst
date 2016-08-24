
.. _demo_automodule:

###############
Automodule demo
###############
Only catch: make sure to explicitly insert ``toctree`` directive with option set at ``:hidden:`` (with subdir ``generated/`` indicated)

Here cross reference with hyperlink: :ref:`demo_autoclass`

.. rubric:: Include all functions/methods using ``module_custom.rst`` template

.. toctree::
    :maxdepth: 1

    generated/statsmodels.discrete.discrete_margins

.. autosummary::
   :toctree:generated/
   :template:module_custom.rst

    statsmodels.discrete.discrete_margins

.. rubric:: Same as above, but also include hidden methods using ``module_all_methods.rst`` template

**hidden functions** = methods starting with underscore, like ``__all__``

.. toctree::
    :maxdepth: 1

    generated/statsmodels.distributions

.. autosummary::
   :toctree:generated/
   :template:module_all_methods.rst

    statsmodels.distributions
