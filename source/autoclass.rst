.. _autoclass:

..  Multiline comment
    Include reference before heading, so i can cross-reference them in the module files.
    http://www.sphinx-doc.org/en/stable/markup/inline.html#role-ref

#################
Class autosummary
#################

Cross reference: :ref:`automodule`

***********
pandas demo
***********
.. code-block:: rst

    .. currentmodule:: pandas

    .. autosummary::
       :toctree: generated/

       read_excel
       ExcelFile.parse

.. currentmodule:: pandas

.. autosummary::
   :toctree: generated/

   read_excel
   ExcelFile.parse

***************
sklearn.cluster
***************
Few examples from scikit classes:

.. code-block:: rst

    .. currentmodule:: sklearn

    .. autosummary::
       :toctree: generated/
       :template: class_tak.rst

       cluster.AgglomerativeClustering
       cluster.Birch
       cluster.FeatureAgglomeration
       cluster.KMeans

.. currentmodule:: sklearn

.. autosummary::
   :toctree: generated/
   :template: class_tak.rst

   cluster.AgglomerativeClustering
   cluster.Birch
   cluster.FeatureAgglomeration
   cluster.KMeans

