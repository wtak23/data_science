.. Documentation master file, created by
   sphinx-quickstart on Wed Aug  3 13:00:32 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

PROJECT_NAME
=============
Skeleton for creating my doc. Use of sphinx ``autosummary`` saved my life.

.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents

   demo_autoclass.rst
   demo_automodule.rst


.. note:: 

    Minor change made in Sphinx source code ``generate.py``
    
    (located at ``$HOME/.local/lib/python2.7/site-packages/sphinx/ext/autosummary/generate.py``)

    .. literalinclude:: generate_mod.py
       :diff: generate.py