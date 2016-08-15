Skeleton for creating documentations using Sphinx.

- ``generate.py`` - original file in ``sphinx/ext/autosummary/generate.py``
- ``generate_mod.py`` - modified version to avoid including imported function/class to be included in the autosummary (unless it's from the same module)
- references

  - http://stackoverflow.com/questions/25405110/sphinx-autosummary-with-toctree-also-lists-imported-members/25460763#25460763
  - https://github.com/sphinx-doc/sphinx/issues/1061

#########
templates
#########
- ``class_custom.rst`` - recursively insert methods in autosummary
- ``class_all_methods.rst`` - recursively insert methods in autosummary, including hidden methods (ones beginning with underscores, like ``__call__``
- ``module_custom.rst`` , ``module_all_methods.rst`` same idea as above
