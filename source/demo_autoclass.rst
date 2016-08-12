
.. _demo_autoclass:

###########################
Demo of autodoc'ing classes
###########################

TOCTREE comment

- Need to include `toctree` directive here to enture the class of interest will
be contained in the TOC.
- I first thought I had the include the toctree in ``index.rst``, but doing so
  would disrupt the hierarchy of the global TOC structure

Here cross reference with hyperlink: :ref:`demo_automodule`

See:

- http://www.sphinx-doc.org/en/stable/tutorial.html#defining-document-structure
- http://www.sphinx-doc.org/en/stable/markup/toctree.html

.. rubric:: rst-code used

.. toctree::
    :maxdepth: 1
    :caption: Table of Contents
    :hidden:

    generated/sklearn.linear_model.Lasso
    generated/sklearn.cluster.AgglomerativeClustering

.. autosummary::
   :toctree:generated/
   :template:class_custom.rst

    sklearn.linear_model.Lasso
    sklearn.cluster.AgglomerativeClustering