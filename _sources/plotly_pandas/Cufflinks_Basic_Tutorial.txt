########################
Cufflinks_Basic_Tutorial
########################

.. contents:: `Contents`
   :depth: 2
   :local:


http://nbviewer.jupyter.org/gist/santosjorge/f3b07b2be8094deea8c6

This library binds the power of `plotly <http://www.plot.ly>`__ with the
flexibility of `pandas <http://pandas.pydata.org/>`__ for easy plotting.

This library is available on https://github.com/santosjorge/cufflinks

This tutorial assumes that the plotly user credentials have already been
configured as stated on the `getting
started <https://plot.ly/python/getting-started/>`__ guide.

.. code:: python

    import pandas as pd
    import cufflinks as cf
    import numpy as np
    
    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls

.. code:: python

    %reload_ext autoreload
    %autoreload 2

We make all charts public and set a global theme

.. code:: python

    cf.set_config_file(world_readable=True,theme='pearl')

We create a set of timeseries

.. code:: python

    df=pd.DataFrame(np.random.randn(100,5),index=pd.date_range('1/1/15',periods=100),
                    columns=['IBM','MSFT','GOOG','VERZ','APPL'])
    df=df.cumsum()

**iplot** can be used on any DataFrame to plot on a plotly chart. If no
filename is specified then a generic *Plotly Playground* file is
created.

All the charts are created as private by default. To make them public
you can use **world\_readable=True**

.. code:: python

    df.iplot(filename='Tutorial 1')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/717.embed" height="525px" width="100%"></iframe>



Customizing Themes
==================

We can pass a **theme** to the **iplot** function. 3 themes are
available, but you can create your own \* Solar \* Pearl (Default) \*
White

.. code:: python

    df[['APPL','IBM','VERZ']].iplot(theme='white',filename='Tutorial White')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/719.embed" height="525px" width="100%"></iframe>



We can also pass common metadata for the chart

.. code:: python

    df.iplot(theme='pearl',filename='Tutorial Metadata',title='Stock Returns',xTitle='Dates',yTitle='Returns')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/721.embed" height="525px" width="100%"></iframe>



Bestfit Lines
=============

We can easily add a bestfit line to any Series

This will automatically add a best fit approximation and the equation as
the legend.

.. code:: python

    df['IBM'].iplot(filename='IBM Returns',bestfit=True)


.. parsed-literal::

    /home/takanori/.local/lib/python2.7/site-packages/cufflinks/plotlytools.py:164: FutureWarning:
    
    The pandas.stats.ols module is deprecated and will be removed in a future version. We refer to external packages like statsmodels, see some examples here: http://www.statsmodels.org/stable/regression.html
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/723.embed" height="525px" width="100%"></iframe>



Customizing Colors
==================

We can pass any color (either by Hex, RGB or Text \*)

\*Text values are specified in the cufflinks.colors modules

.. code:: python

    df['IBM'].iplot(filename='IBM Returns - colors',bestfit=True,colors=['pink'],bestfit_colors=['blue'])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/725.embed" height="525px" width="100%"></iframe>



Filled Traces
=============

We can add a fill to a trace with **fill=True**

.. code:: python

    df['IBM'].iplot(filename='Tutorial Microsoft',fill=True,colors=['green'])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/727.embed" height="525px" width="100%"></iframe>



Bar Charts
==========

We can easily create a bar chart with the parameter **kind**

.. code:: python

    df.sum().iplot(kind='bar',filename='Tutorial Barchart')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/729.embed" height="525px" width="100%"></iframe>



Bars can also be stacked by a given dimension

.. code:: python

    tmp = df.resample('M').iplot(kind='bar',barmode='stacked',filename='Tutorial Bar Stacked')
    print tmp
    print tmp.url
    tmp


.. parsed-literal::

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:1: FutureWarning:
    
    
    .resample() is now a deferred operation
    You called iplot(...) on this deferred object which materialized it into a dataframe
    by implicitly taking the mean.  Use .resample(...).mean() instead
    


.. parsed-literal::

    <plotly.tools.PlotlyDisplay object>
    None




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/731.embed" height="525px" width="100%"></iframe>



Spread and Ratio charts
=======================

We can also create spread and ratio charts on the fly with
**kind='spread'** and **kind='ratio'**

.. code:: python

    df[['VERZ','IBM']].iplot(filename='Tutorial Spread',kind='spread')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/733.embed" height="525px" width="100%"></iframe>



.. code:: python

    (df[['GOOG','MSFT']]+20).iplot(filename='Tutorial Ratio',kind='ratio',colors=['green','red'])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/735.embed" height="525px" width="100%"></iframe>



Annotations
===========

Annotations can be added to the chart and these are automatically
positioned correctly.

**Annotations** should be specified in a dictionary form

.. code:: python

    annotations={'2015-01-15':'Dividends','2015-03-31':'Split Announced'}
    df['MSFT'].iplot(filename='Tutorial Annotations',annotations=annotations)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/737.embed" height="525px" width="100%"></iframe>



Output as Image
===============

The output of a chart can be in an image mode as well.

For this we can use **asImage=True**

We can also set the dimensions (optional) with
**dimensions=(width,height)**

.. code:: python

    df[['VERZ','MSFT']].iplot(filename='Tutorial Image',theme='white',colors=['pink','blue'],asImage=True,dimensions=(800,500))



.. image:: Cufflinks_Basic_Tutorial_files/Cufflinks_Basic_Tutorial_30_0.png


++Advanced Use
==============

Get figure object
-----------------

It is also possible to get the Plotly Figure as an output to tweak it
manually

We can achieve this with **asFigure=True**

Or with ``df.figure()``

.. code:: python

    fig = df['GOOG'].iplot(asFigure=True)
    print fig.keys()
    print df.figure().keys()
    py.iplot(fig)



.. parsed-literal::

    ['layout', 'data']
    ['layout', 'data']




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/743.embed" height="525px" width="100%"></iframe>



Get Data object
===============

.. code:: python

    df.to_iplot()

We can also get the **Data** object directly

.. code:: python

    data=df.to_iplot()

.. code:: python

    data[0]['name']='My Custom Name'

And pass this directly to **iplot**

.. code:: python

    df.iplot(data=data,filename='Tutorial Custom Name')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/741.embed" height="525px" width="100%"></iframe>



Get Layout object
=================

.. code:: python

    df.layout()




.. parsed-literal::

    {'legend': {'bgcolor': '#F5F6F9', 'font': {'color': '#4D5663'}},
     'paper_bgcolor': '#F5F6F9',
     'plot_bgcolor': '#F5F6F9',
     'titlefont': {'color': '#4D5663'},
     'xaxis1': {'gridcolor': '#E1E5ED',
      'showgrid': True,
      'tickfont': {'color': '#4D5663'},
      'title': '',
      'titlefont': {'color': '#4D5663'},
      'zerolinecolor': '#E1E5ED'},
     'yaxis1': {'gridcolor': '#E1E5ED',
      'showgrid': True,
      'tickfont': {'color': '#4D5663'},
      'title': '',
      'titlefont': {'color': '#4D5663'},
      'zerolinecolor': '#E1E5ED'}}


