
.. _demo_automodule:

###########################
Automodule demo
###########################
Only catch: make sure to explicitly insert ``toctree`` directive with option set at ``:hidden:``

.. toctree::
    :maxdepth: 1
    :hidden:

    generated/string
    generated/pyspark
    generated/pyspark.mllib
    generated/pyspark.mllib.classification
..    generated/pyspark.sql
..    generated/pyspark.sql.functions

.. autosummary::
   :toctree:generated/
   :template:module_custom.rst

    string
    pyspark
    pyspark.mllib
    pyspark.mllib.classification
..    pyspark.sql
..    pyspark.sql.functions