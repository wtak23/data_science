Figure Factory Demos (a-o)
""""""""""""""""""""""""""
Created looking at docstring from ``plotly.tools.FigureFactory``

.. contents:: `Contents`
   :depth: 2
   :local:

###################
create\_2D\_density
###################

Simple 2D Density plot
======================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    
    # Make data points
    t = np.linspace(-1,1.2,2000)
    x = (t**3)+(0.3*np.random.randn(2000))
    y = (t**6)+(0.3*np.random.randn(2000))
    
    # Create a figure
    fig = FF.create_2D_density(x, y)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/747.embed" height="600px" width="600px"></iframe>



Using Parameters
================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    
    # Make data points
    t = np.linspace(-1,1.2,2000)
    x = (t**3)+(0.3*np.random.randn(2000))
    y = (t**6)+(0.3*np.random.randn(2000))
    
    # Create custom colorscale
    colorscale = ['#7A4579', '#D56073', 'rgb(236,158,105)',
                  (1, 1, 0.2), (0.98,0.98,0.98)]
    
    # Create a figure
    fig = FF.create_2D_density(
        x, y, colorscale=colorscale,
        hist_color='rgb(255, 237, 222)', point_size=3)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/749.embed" height="600px" width="600px"></iframe>



##########################
create\_annotated\_heatmap
##########################

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    z = [[0.300000, 0.00000, 0.65, 0.300000],
         [1, 0.100005, 0.45, 0.4300],
         [0.300000, 0.00000, 0.65, 0.300000],
         [1, 0.100005, 0.45, 0.00000]]
    
    figure = FF.create_annotated_heatmap(z)
    py.iplot(figure)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/751.embed" height="525px" width="100%"></iframe>



###################
create\_candlestick
###################

Simple candlestick chart from a Pandas DataFrame
================================================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    from datetime import datetime
    
    from pandas_datareader import data
    
    df = data.DataReader("aapl", 'yahoo', datetime(2007, 10, 1), datetime(2009, 4, 1))
    fig = FF.create_candlestick(df.Open, df.High, df.Low, df.Close, dates=df.index)
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    /home/takanori/.local/lib/python2.7/site-packages/pandas_datareader/base.py:47: FutureWarning:
    
    pandas.core.common.is_number is deprecated. import from the public API: pandas.api.types.is_number instead
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/753.embed" height="525px" width="100%"></iframe>



Add text and annotations to the candlestick chart
=================================================

.. code:: python

    fig = FF.create_candlestick(df.Open, df.High, df.Low, df.Close, dates=df.index)
    # Update the fig - all options here: https://plot.ly/python/reference/#Layout
    fig['layout'].update({
        'title': 'The Great Recession',
        'yaxis': {'title': 'AAPL Stock'},
        'shapes': [{
            'x0': '2007-12-01', 'x1': '2007-12-01',
            'y0': 0, 'y1': 1, 'xref': 'x', 'yref': 'paper',
            'line': {'color': 'rgb(30,30,30)', 'width': 1}
        }],
        'annotations': [{
            'x': '2007-12-01', 'y': 0.05, 'xref': 'x', 'yref': 'paper',
            'showarrow': False, 'xanchor': 'left',
            'text': 'Official start of the recession'
        }]
    })
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/755.embed" height="525px" width="100%"></iframe>



Customize the candlestick colors
================================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    from plotly.graph_objs import Line, Marker
    from datetime import datetime
    
    df = data.DataReader("aapl", 'yahoo', datetime(2008, 1, 1), datetime(2009, 4, 1))
    
    # Make increasing candlesticks and customize their color and name
    fig_increasing = FF.create_candlestick(df.Open, df.High, df.Low, df.Close, dates=df.index,
        direction='increasing', name='AAPL',
        marker=Marker(color='rgb(150, 200, 250)'),
        line=Line(color='rgb(150, 200, 250)'))
    
    # Make decreasing candlesticks and customize their color and name
    fig_decreasing = FF.create_candlestick(df.Open, df.High, df.Low, df.Close, dates=df.index,
        direction='decreasing',
        marker=Marker(color='rgb(128, 128, 128)'),
        line=Line(color='rgb(128, 128, 128)'))
    
    # Initialize the figure
    fig = fig_increasing
    
    # Add decreasing data with .extend()
    fig['data'].extend(fig_decreasing['data'])
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/758.embed" height="525px" width="100%"></iframe>



Candlestick chart with datetime objects
=======================================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    from datetime import datetime
    
    # Add data
    open_data = [33.0, 33.3, 33.5, 33.0, 34.1]
    high_data = [33.1, 33.3, 33.6, 33.2, 34.8]
    low_data = [32.7, 32.7, 32.8, 32.6, 32.8]
    close_data = [33.0, 32.9, 33.3, 33.1, 33.1]
    dates = [datetime(year=2013, month=10, day=10),
             datetime(year=2013, month=11, day=10),
             datetime(year=2013, month=12, day=10),
             datetime(year=2014, month=1, day=10),
             datetime(year=2014, month=2, day=10)]
    
    # Create ohlc
    fig = FF.create_candlestick(open_data, high_data,
        low_data, close_data, dates=dates)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/760.embed" height="525px" width="100%"></iframe>



##################
create\_dendrogram
##################

Simple bottom oriented dendrogram
=================================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    
    X = np.random.rand(10,10)
    dendro = FF.create_dendrogram(X)
    dendro['layout'].update({'width':700, 'height':500})
    
    py.iplot(dendro)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/768.embed" height="500px" width="700px"></iframe>



Dendrogram to put on the left of the heatmap
============================================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    
    X = np.random.rand(5,5)
    names = ['Jack', 'Oxana', 'John', 'Chelsea', 'Mark']
    dendro = FF.create_dendrogram(X, orientation='right', labels=names)
    dendro['layout'].update({'width':700, 'height':500})
    
    py.iplot(dendro)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/766.embed" height="500px" width="700px"></iframe>



Dendrogram with Pandas
======================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    import pandas as pd
    
    Index= ['A','B','C','D','E','F','G','H','I','J']
    df = pd.DataFrame(abs(np.random.randn(10, 10)), index=Index)
    fig = FF.create_dendrogram(df, labels=Index)
    fig['layout'].update({'width':700, 'height':500})
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/772.embed" height="500px" width="700px"></iframe>



################
create\_distplot
################

Simple distplot of 1 dataset
============================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    
    hist_data = [[1.1, 1.1, 2.5, 3.0, 3.5,
                  3.5, 4.1, 4.4, 4.5, 4.5,
                  5.0, 5.0, 5.2, 5.5, 5.5,
                  5.5, 5.5, 5.5, 6.1, 7.0]]
    
    group_labels = ['distplot example']
    
    fig = FF.create_distplot(hist_data, group_labels)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/774.embed" height="525px" width="100%"></iframe>



Two data sets and added rug text
================================

.. code:: python

    # Add histogram data
    hist1_x = [0.8, 1.2, 0.2, 0.6, 1.6,
               -0.9, -0.07, 1.95, 0.9, -0.2,
               -0.5, 0.3, 0.4, -0.37, 0.6]
    hist2_x = [0.8, 1.5, 1.5, 0.6, 0.59,
               1.0, 0.8, 1.7, 0.5, 0.8,
               -0.3, 1.2, 0.56, 0.3, 2.2]
    
    # Group data together
    hist_data = [hist1_x, hist2_x]
    
    group_labels = ['2012', '2013']
    
    # Add text
    rug_text_1 = ['a1', 'b1', 'c1', 'd1', 'e1',
          'f1', 'g1', 'h1', 'i1', 'j1',
          'k1', 'l1', 'm1', 'n1', 'o1']
    
    rug_text_2 = ['a2', 'b2', 'c2', 'd2', 'e2',
          'f2', 'g2', 'h2', 'i2', 'j2',
          'k2', 'l2', 'm2', 'n2', 'o2']
    
    # Group text together
    rug_text_all = [rug_text_1, rug_text_2]
    
    # Create distplot
    fig = FF.create_distplot(
        hist_data, group_labels, rug_text=rug_text_all, bin_size=.2)
    
    # Add title
    fig['layout'].update(title='Dist Plot')
    
    # Plot!
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/776.embed" height="525px" width="100%"></iframe>



Plot with normal curve and hide rug plot
========================================

.. code:: python

    x1 = np.random.randn(190)
    x2 = np.random.randn(200)+1
    x3 = np.random.randn(200)-1
    x4 = np.random.randn(210)+2
    
    hist_data = [x1, x2, x3, x4]
    group_labels = ['2012', '2013', '2014', '2015']
    
    fig = FF.create_distplot(
        hist_data, group_labels, curve_type='normal',
        show_rug=False, bin_size=.4)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/778.embed" height="525px" width="100%"></iframe>



Distplot with pandas
====================

.. code:: python

    import pandas as pd
    
    df = pd.DataFrame({'2012': np.random.randn(200),
                       '2013': np.random.randn(200)+1})
    py.iplot(FF.create_distplot([df[c] for c in df.columns], df.columns))




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/780.embed" height="525px" width="100%"></iframe>



#############
create\_gantt
#############

Simple Gantt Chart
==================

.. code:: python

    # Make data for chart
    df = [dict(Task="Job A", Start='2009-01-01', Finish='2009-02-30'),
          dict(Task="Job B", Start='2009-03-05', Finish='2009-04-15'),
          dict(Task="Job C", Start='2009-02-20', Finish='2009-05-30')]
    
    # Create a figure
    fig = FF.create_gantt(df)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/782.embed" height="600px" width="900px"></iframe>



Index by Column with Numerical Entries
======================================

.. code:: python

    # Make data for chart
    df = [dict(Task="Job A", Start='2009-01-01',
               Finish='2009-02-30', Complete=10),
          dict(Task="Job B", Start='2009-03-05',
               Finish='2009-04-15', Complete=60),
          dict(Task="Job C", Start='2009-02-20',
               Finish='2009-05-30', Complete=95)]
    
    # Create a figure with Plotly colorscale
    fig = FF.create_gantt(df, colors='Blues', index_col='Complete',
                          show_colorbar=True, bar_width=0.5,
                          showgrid_x=True, showgrid_y=True)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/784.embed" height="600px" width="900px"></iframe>



Index by Column with String Entries
===================================

.. code:: python

    # Make data for chart
    df = [dict(Task="Job A", Start='2009-01-01',
               Finish='2009-02-30', Resource='Apple'),
          dict(Task="Job B", Start='2009-03-05',
               Finish='2009-04-15', Resource='Grape'),
          dict(Task="Job C", Start='2009-02-20',
               Finish='2009-05-30', Resource='Banana')]
    
    # Create a figure with Plotly colorscale
    fig = FF.create_gantt(df, colors=['rgb(200, 50, 25)',
                                      (1, 0, 1),
                                      '#6c4774'],
                          index_col='Resource',
                          reverse_colors=True,
                          show_colorbar=True)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/786.embed" height="600px" width="900px"></iframe>



Use a dictionary for colors
===========================

.. code:: python

    # Make data for chart
    df = [dict(Task="Job A", Start='2009-01-01',
               Finish='2009-02-30', Resource='Apple'),
          dict(Task="Job B", Start='2009-03-05',
               Finish='2009-04-15', Resource='Grape'),
          dict(Task="Job C", Start='2009-02-20',
               Finish='2009-05-30', Resource='Banana')]
    
    # Make a dictionary of colors
    colors = {'Apple': 'rgb(255, 0, 0)',
              'Grape': 'rgb(170, 14, 200)',
              'Banana': (1, 1, 0.2)}
    
    # Create a figure with Plotly colorscale
    fig = FF.create_gantt(df, colors=colors,
                          index_col='Resource',
                          show_colorbar=True)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/788.embed" height="600px" width="900px"></iframe>



Use a pandas dataframe
======================

.. code:: python

    # Make data as a dataframe
    df = pd.DataFrame([['Run', '2010-01-01', '2011-02-02', 10],
                       ['Fast', '2011-01-01', '2012-06-05', 55],
                       ['Eat', '2012-01-05', '2013-07-05', 94]],
                      columns=['Task', 'Start', 'Finish', 'Complete'])
    
    # Create a figure with Plotly colorscale
    fig = FF.create_gantt(df, colors='Blues', index_col='Complete',
                          show_colorbar=True, bar_width=0.5,
                          showgrid_x=True, showgrid_y=True)
    
    # Plot the data
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/790.embed" height="600px" width="900px"></iframe>



############
create\_ohlc
############

Simple OHLC chart from a Pandas DataFrame
=========================================

.. code:: python

    df = data.DataReader("aapl", 'yahoo', datetime(2008, 8, 15), datetime(2008, 10, 15))
    fig = FF.create_ohlc(df.Open, df.High, df.Low, df.Close, dates=df.index)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/792.embed" height="525px" width="100%"></iframe>



Add text and annotations to the OHLC chart
==========================================

.. code:: python

    df = data.DataReader("aapl", 'yahoo', datetime(2008, 8, 15), datetime(2008, 10, 15))
    fig = FF.create_ohlc(df.Open, df.High, df.Low, df.Close, dates=df.index)
    
    # Update the fig - all options here: https://plot.ly/python/reference/#Layout
    fig['layout'].update({
        'title': 'The Great Recession',
        'yaxis': {'title': 'AAPL Stock'},
        'shapes': [{
            'x0': '2008-09-15', 'x1': '2008-09-15', 'type': 'line',
            'y0': 0, 'y1': 1, 'xref': 'x', 'yref': 'paper',
            'line': {'color': 'rgb(40,40,40)', 'width': 0.5}
        }],
        'annotations': [{
            'text': "the fall of Lehman Brothers",
            'x': '2008-09-15', 'y': 1.02,
            'xref': 'x', 'yref': 'paper',
            'showarrow': False, 'xanchor': 'left'
        }]
    })
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/794.embed" height="525px" width="100%"></iframe>



Customize the OHLC colors
=========================

.. code:: python

    df = data.DataReader("aapl", 'yahoo', datetime(2008, 1, 1), datetime(2009, 4, 1))
    
    # Make increasing ohlc sticks and customize their color and name
    fig_increasing = FF.create_ohlc(df.Open, df.High, df.Low, df.Close, dates=df.index,
        direction='increasing', name='AAPL',
        line=Line(color='rgb(150, 200, 250)'))
    
    # Make decreasing ohlc sticks and customize their color and name
    fig_decreasing = FF.create_ohlc(df.Open, df.High, df.Low, df.Close, dates=df.index,
        direction='decreasing',
        line=Line(color='rgb(128, 128, 128)'))
    
    # Initialize the figure
    fig = fig_increasing
    
    # Add decreasing data with .extend()
    fig['data'].extend(fig_decreasing['data'])
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/796.embed" height="525px" width="100%"></iframe>



OHLC chart with datetime objects
================================

.. code:: python

    # Add data
    open_data = [33.0, 33.3, 33.5, 33.0, 34.1]
    high_data = [33.1, 33.3, 33.6, 33.2, 34.8]
    low_data = [32.7, 32.7, 32.8, 32.6, 32.8]
    close_data = [33.0, 32.9, 33.3, 33.1, 33.1]
    dates = [datetime(year=2013, month=10, day=10),
             datetime(year=2013, month=11, day=10),
             datetime(year=2013, month=12, day=10),
             datetime(year=2014, month=1, day=10),
             datetime(year=2014, month=2, day=10)]
    
    # Create ohlc
    fig = FF.create_ohlc(open_data, high_data,
        low_data, close_data, dates=dates)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/798.embed" height="525px" width="100%"></iframe>




