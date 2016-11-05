Test runs on RST directives (``cs-rst.directive-test.rst``)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
See `this <http://www.sphinx-doc.org/en/stable/rest.html#directives>`__ for a nice run-through on the available directives.

.. important:: Not sure why, but the above link says:

  - "Do not use the directives ``sectnum``, ``header`` and ``footer``."
  - Directives added by Sphinx are described in `Sphinx Markup Constructs <http://www.sphinx-doc.org/en/stable/markup/index.html#sphinxmarkup>`__.

.. caution:: 

  I tweaked bunch of stuffs in the ``my_theme.css`` file (`github <https://github.com/wtak23/snippets/blob/master/source/_static/css/my_theme.css>`__)

  Thus, the html built here may not agree with what you'll get *out-of-the-box* with Sphinx.


.. contents:: `Contents`
   :depth: 1
   :local:


###########
Admonitions
###########
.. admonition:: here i can have whateva text on the title part

  Body text

.. seealso:: seealso

  Body text

.. note:: note

  Body text

.. todo:: todo

  Body text

.. attention:: attention

  Body text

.. caution:: caution

  Body text

.. warning:: warning

  Body text


.. danger:: danger

  Body text

.. error:: error

  Body text

.. hint:: hint

  Body text

.. important:: important

  Body text

.. tip:: tip

  Body text




######
Images
######
*****
Image
*****

.. code-block:: rst

    .. image:: ./_static/img/sparse-brain.png
       :width: 155 px
       :alt: alternate text
       :align: right

.. image:: ./_static/img/sparse-brain.png
   :width: 155 px
   :alt: alternate text
   :align: right

******
figure
******
figure (an image with caption and optional legend)

http://docutils.sourceforge.net/docs/ref/rst/directives.html#figure

.. code-block:: rst

    .. figure:: ./_static/img/sparse-brain.png
       :scale: 50 %
       :alt: map to buried treasure
       :align: center

       This is the caption of the figure (a simple paragraph).

       The legend consists of all elements after the caption.  In this
       case, the legend consists of this paragraph and the following
       table:


.. figure:: ./_static/img/sparse-brain.png
   :scale: 50 %
   :alt: map to buried treasure
   :align: center

   This is the caption of the figure (a simple paragraph).

   The legend consists of all elements after the caption.  In this
   case, the legend consists of this paragraph and the following
   table:

########################
Additional body elements
########################
********
contents
********
- contents (a local, i.e. for the current file only, table of contents)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#table-of-contents

.. code-block:: rst

    .. contents:: `Contents`
       :depth: 2
       :local:


*********
container
*********
- container (a container with a custom class, useful to generate an outer ``<div>`` in HTML)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#container

.. code-block:: rst

    .. container:: custom

       This paragraph might be rendered in a custom way.

 

Parsing the above results in the following pseudo-XML:

.. code-block:: xml
      
    <container classes="custom">
        <paragraph>
            This paragraph might be rendered in a custom way.

******
rubric
******
- rubric (a heading without relation to the document sectioning)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#rubric

.. code-block:: rst

    .. rubric:: TEST TEST

    Hello world.

.. rubric:: TEST TEST

Hello world.

******
topics
******
- topic (special highlighted body elements)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#topic

.. code-block:: rst

    .. topic:: Topic Title

        Subsequent indented lines comprise
        the body of the topic, and are
        interpreted as body elements.

.. topic:: Topic Title

    Subsequent indented lines comprise
    the body of the topic, and are
    interpreted as body elements.

*******
sidebar
*******
- sidebar (special highlighted body elements)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#sidebar

.. code-block:: rst

    .. sidebar:: Sidebar Title
       :subtitle: Optional Sidebar Subtitle

       Subsequent indented lines comprise
       the body of the sidebar, and are
       interpreted as body elements.

.. sidebar:: Sidebar Title
   :subtitle: Optional Sidebar Subtitle

   Subsequent indented lines comprise
   the body of the sidebar, and are
   interpreted as body elements.

**************
parsed-literal
**************
- parsed-literal (literal block that supports inline markup)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#parsed-literal

.. code-block:: rst

    .. parsed-literal::

       ( (title_, subtitle_?)?,
         decoration_?,
         (docinfo_, transition_?)?,
         `%structure.model;`_ )

     

********
epigraph
********
.. code-block:: rst

  .. epigraph::

     No matter where you go, there you are.

     -- Buckaroo Banzai

     
.. epigraph::

   No matter where you go, there you are.

   -- Buckaroo Banzai

**********
highlights
**********
- highlights (block quotes with their own class attribute)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#highlights
- Highlights summarize the main points of a document or section, often consisting of a list.
- The "highlights" directive produces a "highlights"-class block quote. 
- See Epigraph above for an analogous example.

.. code-block:: rst

  .. highlights::

     - No matter where you go, there you are.
     - No matter where you go, there you are.
     - No matter where you go, there you are.
     - No matter where you go, there you are.

     
.. highlights::

   - No matter where you go, there you are.
   - No matter where you go, there you are.
   - No matter where you go, there you are.
   - No matter where you go, there you are.

**********
pull-quote
**********
- pull-quote (block quotes with their own class attribute)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#pull-quote
- A pull-quote is a small selection of text "pulled out and quoted", typically in a larger typeface. 
- Pull-quotes are used to attract attention, especially in long articles.
- The "pull-quote" directive produces a "pull-quote"-class block quote. 
- See Epigraph above for an analogous example.

.. code-block:: rst

  .. pull-quote::

     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

     
.. pull-quote::

   Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

********
compound
********
- compound (a compound paragraph)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#compound-paragraph

.. note::
  
  The "compound" directive is used to create a compound paragraph, which is a single logical paragraph containing multiple physical body elements such as simple paragraphs, literal blocks, tables, lists, etc., instead of directly containing text and inline elements.

.. code-block:: rst

    .. compound::

       The 'rm' command is very dangerous.  If you are logged
       in as root and enter ::

           cd /
           rm -rf *

       you will erase the entire contents of your file system.

.. compound::

   The 'rm' command is very dangerous.  If you are logged
   in as root and enter ::

       cd /
       rm -rf *

   you will erase the entire contents of your file system.       

##############
Special tables
##############


*****
table
*****


*********
csv-table
*********


**********
list-table
**********
http://docutils.sourceforge.net/docs/ref/rst/directives.html#list-table

.. note:: create sublime snippets via ``list-table<TAB>``

.. code-block:: rst

    .. list-table:: 
        :header-rows: 1
        :widths: 20,70

        * - HEADER1
          - HEADER2

        * - row1/col1
          - row1/col2

        * - row2/col1
          - row2/col2

.. list-table:: 
    :header-rows: 1
    :widths: 20,70

    * - HEADER1
      - HEADER2

    * - row1/col1
      - row1/col2

    * - row2/col1
      - row2/col2

##################
Special directives
##################
***
raw
***
- raw (include raw target-format markup)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#raw-data-pass-through

.. note:: The "raw" directive indicates non-reStructuredText data that is to be passed untouched to the Writer. The names of the output formats are given in the directive arguments. The interpretation of the raw data is up to the Writer. A Writer may ignore any raw output not matching its format.


For example, the following input would be passed untouched by an HTML Writer:

.. code-block:: rst

    .. raw:: html

       <hr width=50 size=10>

.. raw:: html

   <hr width=50 size=10>

A LaTeX Writer could insert the following raw content into its output stream:

.. code-block:: rst

    .. raw:: latex

       \setlength{\parindent}{0pt}


Raw data can also be read from an external file, specified in a directive option. In this case, the content block must be empty. For example:

.. code-block:: rst

  .. raw:: html
     :file: inclusion.html




.. warning:: The "raw" directive represents a potential security hole. It can be disabled with the "raw_enabled" or "file_insertion_enabled" runtime settings.

.. caution:: 

  The "raw" directive is a stop-gap measure allowing the author to bypass reStructuredText's markup. It is a "power-user" feature that should not be overused or abused. The use of "raw" ties documents to specific output formats and makes them less portable.

  If you often need to use the "raw" directive or a "raw"-derived interpreted text role, that is a sign either of overuse/abuse or that functionality may be missing from reStructuredText. Please describe your situation in a message to the Docutils-users mailing list.


*******
include
*******
- include (include reStructuredText from another file) – in Sphinx, when given an absolute include file path, this directive takes it as relative to the source directory
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#include

.. warning:: The "include" directive represents a potential security hole. It can be disabled with the "file_insertion_enabled" runtime setting.

*****
class
*****
- class (assign a class attribute to the next element) [1]_
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#class

.. [1] When the default domain contains a :rst:dir:`class` directive, this
       directive will be shadowed.  Therefore, Sphinx re-exports it as
       :rst:dir:`rst-class`.

.. rubric:: Example

.. code-block:: rst

    .. class:: special

    This is a "special" paragraph.

    .. class:: exceptional remarkable

    An Exceptional Section
    ======================

    This is an ordinary paragraph.

    .. class:: multiple

       First paragraph.

       Second paragraph.

The text above is parsed and transformed into this doctree fragment:

.. code-block:: html
    
    <paragraph classes="special">
        This is a "special" paragraph.
    <section classes="exceptional remarkable">
        <title>
            An Exceptional Section
        <paragraph>
            This is an ordinary paragraph.
        <paragraph classes="multiple">
            First paragraph.
        <paragraph classes="multiple">
            Second paragraph.


##############
HTML specifics
##############
****
meta
****
- meta (generation of HTML ``<meta>`` tags)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#meta

.. code-block:: rst

    .. meta::
       :description: The reStructuredText plaintext markup language
       :keywords: plaintext, markup language

Above gets converted to the following HTML

.. code-block:: html
    
    <meta name="description"
        content="The reStructuredText plaintext markup language">
    <meta name="keywords" content="plaintext, markup language">

*****
title
*****
- title (override document title)
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#metadata-document-title

.. note:: The "title" directive specifies the document title as metadata, which does not become part of the document body. It overrides a document-supplied title. For example, in HTML output the metadata document title appears in the title bar of the browser window.

.. code-block:: rst

    .. title:: This over-rides the HTML title!

.. title:: This over-rides the HTML title!

#################################
Influencing Markup (i rarely use)
#################################

*************************************
default-role (set a new default role)
*************************************
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#default-role

.. note:: 

  The "default-role" directive sets the default interpreted text role, the role that is used for interpreted text without an explicit role. For example, after setting the default role like this:

  .. code-block:: rst

      .. default-role:: subscript

  any subsequent use of implicit-role interpreted text in the document will use the "subscript" role:

  .. code-block:: rst
  
      An example of a `default` role.

  This will be parsed into the following document tree fragment:

  .. code-block:: html
  
      <paragraph>
          An example of a
          <subscript>
              default
           role.

  Custom roles may be used (see the "role" directive above), but it must have been declared in a document before it can be set as the default role. See the reStructuredText Interpreted Text Roles document for details of built-in roles.

  The directive may be used without an argument to restore the initial default interpreted text role, which is application-dependent. The initial default interpreted text role of the standard reStructuredText parser is "title-reference".

************************
role (create a new role)
************************
- http://docutils.sourceforge.net/docs/ref/rst/directives.html#role

.. important:: There's more than what I wrote down below. Checkout the link above for more.

.. code-block:: rst

    .. role:: custom

    An example of using :custom:`interpreted text`

Above gets parsed as:

.. code-block:: html

    <paragraph>
        An example of using
        <inline classes="custom">
            interpreted text

####################################
Foot-notes, citations, substitutions
####################################

*********
footnotes
*********
- http://www.sphinx-doc.org/en/stable/rest.html#footnotes
- http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#footnotes

.. code-block:: rst

    Lorem ipsum [#f1]_ dolor sit amet ... [#f2]_

    .. rubric:: Footnotes

    .. [#f1] Text of the first footnote.
    .. [#f2] Text of the second footnote.

Lorem ipsum [#f1]_ dolor sit amet ... [#f2]_

.. rubric:: Footnotes

.. [#f1] Text of the first footnote.
.. [#f2] Text of the second footnote.

You can also explicitly number the footnotes (``[1]_``) or use auto-numbered footnotes without names (``[#]_``).

*********
citations
*********
- http://www.sphinx-doc.org/en/stable/rest.html#citations
- http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#citations
- Citation usage is similar to footnote usage, but with a label that is not numeric or begins with ``#``.

.. important::

  Standard reST citations (ref) are supported, with the additional feature that they are **“global”**, i.e. all citations can be referenced from all files. 

.. code-block:: rst

    Lorem ipsum [Ref]_ dolor sit amet.

    .. [Ref] Book or article reference, URL or whatever.

Lorem ipsum [Ref]_ dolor sit amet.

.. [Ref] Book or article reference, URL or whatever.

*************
substitutions
*************
- http://www.sphinx-doc.org/en/stable/rest.html#substitutions
- http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#substitution-definitions

.. note::

  If you want to use some substitutions for all documents, put them into `rst_prolog <http://www.sphinx-doc.org/en/stable/config.html#confval-rst_prolog>`__ or put them into a separate file and include it into all documents you want to use them in, using the include directive. (Be sure to give the include file a file name extension differing from that of other source files, to avoid Sphinx finding it as a standalone document.)

  Sphinx defines some default substitutions, see `Substitutions <http://www.sphinx-doc.org/en/stable/markup/inline.html#default-substitutions>`__.

.. code-block:: rst

    .. |name| replace:: **I AM A REPLACEMENT STRING** ``HIHI``

    .. |caution| image:: ./_static/img/blockm.gif
       :alt: Warning!

    - |name| <- the content1
    - |caution| <- the content2

.. |name| replace:: **I AM A REPLACEMENT STRING** ``HIHI``

.. |caution| image:: ./_static/img/blockm.gif
   :alt: Warning!                 

- |name| <- the content1
- |caution| <- the content2

