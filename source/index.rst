Sphinx Skeleton
===============
Skeleton for creating my doc. Use of sphinx ``autosummary`` saved my life.

.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents

   demo_autoclass.rst
   demo_automodule.rst


.. note:: 

    Minor change made in Sphinx source code ``generate.py`` to avoid adding `autodoc` to imported member functions/classes

    (located at ``$HOME/.local/lib/python2.7/site-packages/sphinx/ext/autosummary/generate.py``)

    Unlike the overflow threads below, I decided to allow the imported function to be included in the ``autosummary`` if it comes from the same package

    So suppose I'm applying ``sphinx.ext.autosummary`` on a package called ``mypackage.submodule1``.

    - if this package imports a function from ``mypackage.submodule2``, that'll be included in the `autodoc` since it comes from the same package.
    - but if ``mypackage.submodule1`` imports ``pandas.DataFrame``, this will be ignored from `autodoc` since it comes from external package (so skip documenting codes that I didn't author)

    .. rubric:: References

    - http://stackoverflow.com/questions/25405110/sphinx-autosummary-with-toctree-also-lists-imported-members/25460763#25460763
    - https://github.com/sphinx-doc/sphinx/issues/1061

    .. literalinclude:: generate_mod.py
       :diff: generate.py