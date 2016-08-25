Sphinx Skeleton
===============
Skeleton for creating my doc. Use of sphinx ``autosummary`` saved my life.

.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents

   demo_autoclass.rst
   demo_automodule.rst
   demo_copybutton.rst

These substitutions are predefined in Sphinx

- ``|version|`` = |version|
- ``|release|`` = |release|
- ``|today|`` = |today|

All modules for which code is available (`link <./_modules/index.html>`_)

.. todo:: Just checking if the ``todo`` extension is loaded

.. note:: 

    Finally got the ``copybutton.js`` to work... Sphinx 1.4.5 didn't render it correctly (rolled back to 1.3.5)...that was a soul-crushing experience...

    I also tried the latest Sphinx v1.5a0...also same issue...stick with v1.3.5 for a while.

    >>> a = 1
    1



.. warning::

    **Actually wait, after rolling back to Sphinx 1.3.5, the default ``generate.py`` seems to work fine...I'll keep below for my own sake of learning**

    Appears that it'll still create autodoc for external **functions**, but would ignore external **class**...I think I'm fine with that... (`see here to see what got *auto-doc'ed* <./_modules/index.html>`_)

    File at: ``${HOME}/anaconda2/lib/python2.7/site-packages/Sphinx-1.3.5-py2.7.egg/sphinx/ext/autosummary/generate.py``

    In Sphinx v.1.4.5, it Autodoc'ed external classes, which made compilation time soooooo much longer (for example, when my module loaded ``from pandas import DataFrame, Series``, it rendered bunch of things I didn't want to document)


.. note:: **(note: now obsolete 25 August 2016 (Thursday) after i rolled back sphinx to v1.3.5). just keeping it here since i found below informative in learning the internals of sphinx**

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