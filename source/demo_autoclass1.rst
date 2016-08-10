..  Multiline comment
    Include reference before heading, so i can cross-reference them in the module files.
    http://www.sphinx-doc.org/en/stable/markup/inline.html#role-ref

.. _autoclass:

#################
Class autosummary
#################

Demonstration of creating **recursive autodoc** for python class.

Cross reference: :ref:`automodule`


***********
pandas demo
***********
This will create a table, but won't create subpages... (hence not hyperlinked)

.. autosummary::
   :toctree: generated/

   read_excel
   ExcelFile.parse


**********************************
pandas demo with my template files
**********************************
Use my template class:

.. code-block:: rst

    .. autosummary::
       :toctree: generated/
       :template: class_custom.rst

       sklearn.SpectralClustering


.. autosummary::
   :toctree: generated/
   :template: class_custom.rst

   sklearn.linear_model.RandomizedLasso

***************
sklearn.cluster
***************
Few examples from scikit classes:

.. currentmodule:: sklearn

.. autosummary::
   :toctree: generated/
   :template: class_custom.rst

   sklearn.cluster.Birch
   sklearn.cluster.KMeans

