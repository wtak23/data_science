R notes (``ds-R.rst``)
""""""""""""""""""""""
The notes here are created using ``knitr``, ``RMarkDown``, ``pandoc``, ``sed``, and ``Sphinx``

.. toctree::
    :maxdepth: 1
    :numbered:
    :caption: Table of Contents
    :name: ds-R

    control_var
    control_var2

.. rubric:: How the notebooks are created

#. convert ``*.R`` script into a markdown file ``*.md`` using ``knitr`` and ``rmarkdown``
#. apply the bash function below to convert ``*.md`` to ``*.rst`` file 
#. the resulting ``rst`` file can be fed into Sphinx:

.. code-block:: bash

    md_knit_to_rst(){
      # strip-off file extension
      filename="${1%.*}"

      # echo "${filename}.rst  ${filename}.md"
      pandoc --from=markdown --to=rst --output="${filename}.rst" "${filename}.md"

      # === use sed to add stylistic changes of my taste to the rst output ===
      # replace "code:: r" => "code-block:: R" for proper syntax highlighting
      sed -i 's/code:: r/code-block:: R/' ${filename}.rst

      # change the header level for the first line (replace "=" with double-quotes)
      sed -i '2s/=/"/g' ${filename}.rst

      # insert download link to the source R script
      sed -i "3i The source R script available :download:\`here <${filename}\.R>\`\n" ${filename}.rst

      # insert TOC at 5th line
      sed -i '5i .. contents:: `Contents`\n    :depth: 2\n    :local:\n' ${filename}.rst
    }