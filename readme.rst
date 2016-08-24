Skeleton for creating documentations using Sphinx.

Building this source-code yields html page like this:

- https://wtak23.github.io/sphinx_skeleton_published/

###########
generate.py
###########
I wanted sphinx's ``autosummary`` to include external modules that are loaded within modules of interest.

So modified "$HOME/.local/lib/python2.7/site-packages/sphinx/ext/autosummary/generate.py"

.. code-block:: bash

    $ subl "$HOME/.local/lib/python2.7/site-packages/sphinx/ext/autosummary/generate.py"



- ``generate.py`` - original file in ``sphinx/ext/autosummary/generate.py``
- ``generate_mod.py`` - modified version to avoid including imported function/class to be included in the autosummary (unless it's from the same module)

To see the diff, run (after installing ``sudo apt-get install colordiff``): 

.. code-block:: bash

    $ diff -y generate_mod.py generate.py | colordiff | less

    # or
    $ colordiff generate_mod.py generate.py 

**references**

  - http://stackoverflow.com/questions/25405110/sphinx-autosummary-with-toctree-also-lists-imported-members/25460763#25460763
  - https://github.com/sphinx-doc/sphinx/issues/1061

#########
templates
#########
- ``class_custom.rst`` - recursively insert methods in autosummary
- ``class_all_methods.rst`` - recursively insert methods in autosummary, including hidden methods (ones beginning with underscores, like ``__call__``
- ``module_custom.rst`` , ``module_all_methods.rst`` same idea as above
