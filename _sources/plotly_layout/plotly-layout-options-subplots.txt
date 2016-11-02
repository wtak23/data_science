##############################
plotly-layout-options-subplots
##############################

https://plot.ly/python/subplots/

.. contents:: `Contents`
   :depth: 2
   :local:


Simple subplots
===============

.. code:: python

    from plotly import tools
    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace1 = go.Scatter(
        x=[1, 2, 3],
        y=[4, 5, 6]
    )
    trace2 = go.Scatter(
        x=[20, 30, 40],
        y=[50, 60, 70],
    )
    
    fig = tools.make_subplots(rows=1, cols=2)
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    
    fig['layout'].update(height=600, width=900, title='i <3 subplots')
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/456.embed" height="600px" width="900px"></iframe>



Multiple Subplots With Titles
=============================

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3], y=[4, 5, 6])
    trace2 = go.Scatter(x=[20, 30, 40], y=[50, 60, 70])
    trace3 = go.Scatter(x=[300, 400, 500], y=[600, 700, 800])
    trace4 = go.Scatter(x=[4000, 5000, 6000], y=[7000, 8000, 9000])
    
    fig = tools.make_subplots(rows=2, cols=2, subplot_titles=('Plot 1', 'Plot 2',
                                                              'Plot 3', 'Plot 4'))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    fig.append_trace(trace3, 2, 1)
    fig.append_trace(trace4, 2, 2)
    
    fig['layout'].update(height=700, width=900, title='Multiple Subplots' +
                                                      ' with Titles')
    
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]  [ (2,2) x4,y4 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/460.embed" height="700px" width="900px"></iframe>



Customizing Subplot Axes
========================

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3], y=[4, 5, 6])
    
    trace2 = go.Scatter(x=[20, 30, 40], y=[50, 60, 70])
    
    trace3 = go.Scatter(x=[300, 400, 500], y=[600, 700, 800])
    
    trace4 = go.Scatter(x=[4000, 5000, 6000], y=[7000, 8000, 9000])
    
    fig = tools.make_subplots(rows=2, cols=2, subplot_titles=('Plot 1', 'Plot 2',
                                                              'Plot 3', 'Plot 4'))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    fig.append_trace(trace3, 2, 1)
    fig.append_trace(trace4, 2, 2)
    
    # All of the axes properties here: https://plot.ly/python/reference/#XAxis
    fig['layout']['xaxis1'].update(title='xaxis 1 title')
    fig['layout']['xaxis2'].update(title='xaxis 2 title', range=[10, 50])
    fig['layout']['xaxis3'].update(title='xaxis 3 title', showgrid=False)
    fig['layout']['xaxis4'].update(title='xaxis 4 title', type='log')
    
    # All of the axes properties here: https://plot.ly/python/reference/#YAxis
    fig['layout']['yaxis1'].update(title='yaxis 1 title')
    fig['layout']['yaxis2'].update(title='yaxis 2 title', range=[40, 80])
    fig['layout']['yaxis3'].update(title='yaxis 3 title', showgrid=False)
    fig['layout']['yaxis4'].update(title='yaxis 4 title')
    
    fig['layout'].update(title='Customizing Subplot Axes')
    
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]  [ (2,2) x4,y4 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/462.embed" height="525px" width="100%"></iframe>



Subplots with Shared Y-Axes
===========================

.. code:: python

    # Learn about API authentication here: https://plot.ly/python/getting-started
    # Find your api_key here: https://plot.ly/settings/api
    
    from plotly import tools
    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace0 = go.Scatter(
        x=[1, 2, 3],
        y=[2, 3, 4]
    )
    trace1 = go.Scatter(
        x=[20, 30, 40],
        y=[5, 5, 5],
    )
    trace2 = go.Scatter(
        x=[2, 3, 4],
        y=[600, 700, 800],
    )
    trace3 = go.Scatter(
        x=[4000, 5000, 6000],
        y=[7000, 8000, 9000],
    )
    
    fig = tools.make_subplots(rows=2, cols=2, shared_yaxes=True)
    
    fig.append_trace(trace0, 1, 1)
    fig.append_trace(trace1, 1, 2)
    fig.append_trace(trace2, 2, 1)
    fig.append_trace(trace3, 2, 2)
    
    fig['layout'].update(height=600, width=600,
                         title='Multiple Subplots with Shared Y-Axes')
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y1 ]
    [ (2,1) x3,y2 ]  [ (2,2) x4,y2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/464.embed" height="600px" width="600px"></iframe>



Stacked Subplots
================

.. code:: python

    trace1 = go.Scatter(
        x=[0, 1, 2],
        y=[10, 11, 12]
    )
    trace2 = go.Scatter(
        x=[2, 3, 4],
        y=[100, 110, 120],
    )
    trace3 = go.Scatter(
        x=[3, 4, 5],
        y=[1000, 1100, 1200],
    )
    
    fig = tools.make_subplots(rows=3, cols=1)
    
    fig.append_trace(trace3, 1, 1)
    fig.append_trace(trace2, 2, 1)
    fig.append_trace(trace1, 3, 1)
    
    
    fig['layout'].update(height=900, width=900, title='Stacked subplots')
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]
    [ (2,1) x2,y2 ]
    [ (3,1) x3,y3 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/468.embed" height="900px" width="900px"></iframe>



+++Custom Sized Subplot with Subplot Titles
===========================================

.. code:: python

    from plotly import tools
    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace0 = go.Scatter(
        x=[1, 2],
        y=[1, 2]
    )
    trace1 = go.Scatter(
        x=[1, 2],
        y=[1, 2]
    )
    trace2 = go.Scatter(
        x=[1, 2, 3],
        y=[2, 1, 2]
    )
    fig = tools.make_subplots(rows=2, cols=2, specs=[[{}, {}], [{'colspan': 2}, None]],
                              subplot_titles=('First Subplot','Second Subplot', 'Third Subplot'))
    
    fig.append_trace(trace0, 1, 1)
    fig.append_trace(trace1, 1, 2)
    fig.append_trace(trace2, 2, 1)
    
    fig['layout'].update(showlegend=False, title='Specs with Subplot Title')
    py.iplot(fig, filename='specs')


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3           -      ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/470.embed" height="525px" width="100%"></iframe>



Subplots with Shared X-Axes
===========================

.. code:: python

    trace1 = go.Scatter(
        x=[0, 1, 2],
        y=[10, 11, 12]
    )
    trace2 = go.Scatter(
        x=[2, 3, 4],
        y=[100, 110, 120],
    )
    trace3 = go.Scatter(
        x=[3, 4, 5],
        y=[1000, 1100, 1200],
    )
    fig = tools.make_subplots(rows=3, cols=1, specs=[[{}], [{}], [{}]],
                              shared_xaxes=True, shared_yaxes=True,
                              vertical_spacing=0.001)
    fig.append_trace(trace1, 3, 1)
    fig.append_trace(trace2, 2, 1)
    fig.append_trace(trace3, 1, 1)
    
    fig['layout'].update(height=600, width=600, title='Stacked Subplots with Shared X-Axes')
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]
    [ (2,1) x1,y2 ]
    [ (3,1) x1,y3 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/472.embed" height="600px" width="600px"></iframe>



Subplots with shared Axes
=========================

.. code:: python

    trace1 = go.Scatter(
        x=[1, 2, 3],
        y=[2, 3, 4]
    )
    trace2 = go.Scatter(
        x=[20, 30, 40],
        y=[5, 5, 5],
        xaxis='x2',
        yaxis='y'
    )
    trace3 = go.Scatter(
        x=[2, 3, 4],
        y=[600, 700, 800],
        xaxis='x',
        yaxis='y3'
    )
    trace4 = go.Scatter(
        x=[4000, 5000, 6000],
        y=[7000, 8000, 9000],
        xaxis='x4',
        yaxis='y4'
    )
    data = [trace1, trace2, trace3, trace4]
    layout = go.Layout(
        xaxis=dict(
            domain=[0, 0.45]
        ),
        yaxis=dict(
            domain=[0, 0.45]
        ),
        xaxis2=dict(
            domain=[0.55, 1]
        ),
        xaxis4=dict(
            domain=[0.55, 1],
            anchor='y4'
        ),
        yaxis3=dict(
            domain=[0.55, 1]
        ),
        yaxis4=dict(
            domain=[0.55, 1],
            anchor='x4'
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/478.embed" height="525px" width="100%"></iframe>



Multiple Custom Sized Subplots
==============================

.. code:: python

    trace1 = go.Scatter(x=[1, 2], y=[1, 2], name='(1,1)')
    trace2 = go.Scatter(x=[1, 2], y=[1, 2], name='(1,2)')
    trace3 = go.Scatter(x=[1, 2], y=[1, 2], name='(2,1)')
    trace4 = go.Scatter(x=[1, 2], y=[1, 2], name='(3,1)')
    trace5 = go.Scatter(x=[1, 2], y=[1, 2], name='(5,1)')
    trace6 = go.Scatter(x=[1, 2], y=[1, 2], name='(5,2)')
    
    fig = tools.make_subplots(rows=5, cols=2,
                              specs=[[{}, {'rowspan': 2}],
                                     [{}, None],
                                     [{'rowspan': 2, 'colspan': 2}, None],
                                     [None, None],
                                     [{}, {}]],
                              print_grid=True)
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    fig.append_trace(trace3, 2, 1)
    fig.append_trace(trace4, 3, 1)
    fig.append_trace(trace5, 5, 1)
    fig.append_trace(trace6, 5, 2)
    
    fig['layout'].update(height=600, width=600, title='specs examples')
    py.iplot(fig)


.. parsed-literal::

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]         |       
    [ (3,1) x4,y4           -      ]
           |                |       
    [ (5,1) x5,y5 ]  [ (5,2) x6,y6 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/474.embed" height="600px" width="600px"></iframe>



++Subplot with custom sizes
===========================

.. code:: python

    trace1 = go.Scatter(
        x=[1, 2, 3],
        y=[4, 5, 6]
    )
    trace2 = go.Scatter(
        x=[20, 30, 40],
        y=[50, 60, 70],
        xaxis='x2',
        yaxis='y2'
    )
    data = [trace1, trace2]
    layout = go.Layout(
        xaxis=dict(
            domain=[0, 0.7]
        ),
        xaxis2=dict(
            domain=[0.8, 1]
        ),
        yaxis2=dict(
            anchor='x2'
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/476.embed" height="525px" width="100%"></iframe>




