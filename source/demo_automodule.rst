
.. _demo_automodule:

###########################
Automodule demo
###########################
Only catch: make sure to explicitly insert ``toctree`` directive with option set at ``:hidden:`` (with subdir ``generated/`` indicated)

.. rubric:: rst-code used

.. code-block:: rst

    .. toctree::
        :maxdepth: 1
        :hidden:

        generated/string
        generated/pyspark
        generated/pyspark.mllib
        generated/pyspark.mllib.classification
        generated/sklearn.covariance

    .. autosummary::
       :toctree:generated/
       :template:module_custom.rst

        string
        pyspark
        pyspark.mllib
        pyspark.mllib.classification
        sklearn.covariance

.. toctree::
    :maxdepth: 1
    :hidden:

    generated/string
    generated/pyspark
    generated/pyspark.mllib
    generated/pyspark.mllib.classification
    generated/sklearn.covariance

.. autosummary::
   :toctree:generated/
   :template:module_custom.rst

    string
    pyspark
    pyspark.mllib
    pyspark.mllib.classification
    sklearn.covariance