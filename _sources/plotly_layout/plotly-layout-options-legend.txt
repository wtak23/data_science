############################
plotly-layout-options-legend
############################


.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls

Basic legend
============

-  just assign ``name`` in the trace attribute

.. code:: python

    trace1 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 3, 6, 4, 5, 2, 3, 5, 4],
        name='Blue Trace'
    )
    trace2 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 4, 7, 8, 3, 6, 3, 3, 4],
        name='Orange Trace'
    )
    data = [trace1, trace2]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/956.embed?share_key=eU7MpLtJUQbcSri6USlOGu" height="525px" width="100%"></iframe>



Positioning the Legend
======================

.. code:: python

    go.Layout(legend=dict(x=0.9,y=1))

.. code:: python

    layout = go.Layout(legend=dict(x=0.8,y=1))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/962.embed?share_key=8Mh4j3pEscXtEk5ChRe84G" height="525px" width="100%"></iframe>



Grouped legends
===============

Use ``legendgroup`` attribute in the trace

.. code:: python

    legendgroup='group2'

.. code:: python

     trace1a = dict(x=[1,2,3],y=[2,1,3],mode='markers',marker=dict(color='rgb(164, 194, 244)'),
                   legendgroup='group1', name= 'first legend group')
     trace1b = dict(x=[1,2,3],y=[2,2,2],mode='lines',  marker=dict(color='rgb(164, 194, 244)'),
                   legendgroup='group1',name= 'first legend group - average') 
    
     trace2a = dict(x=[1,2,3],y=[4,9,2],mode='markers',marker=dict(color='rgb(142, 124, 195)'),
                   legendgroup='group2', name= 'second legend group')
     trace2b = dict(x=[1,2,3],y=[5,5,5],mode='lines',  marker=dict(color='rgb(142, 124, 195)'),
                   legendgroup='group2',name= 'second legend group - average') 

.. code:: python

    py.iplot([trace1a,trace1b,trace2a,trace2b])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/964.embed?share_key=B4YfqmSJ728HrYrCshr2Ia" height="525px" width="100%"></iframe>



Styling and Coloring the Legend
===============================

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 3, 6, 4, 5, 2, 3, 5, 4])
    trace2 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 4, 7, 8, 3, 6, 3, 3, 4])
    data = [trace1, trace2]
    layout = go.Layout(
        legend=dict(x=0,y=1,
            traceorder='normal',
            font=dict(family='sans-serif',size=12,color='#000'),
            bgcolor='#E2E2E2',
            bordercolor='#FFFFFF',
            borderwidth=2
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/966.embed?share_key=K1TffnvX4LrWw1NaIn47au" height="525px" width="100%"></iframe>



Selectively hide legend entries
===============================

``showlegend=False``

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2],y=[1, 2, 3],name='First Trace',showlegend=False)
    trace2 = go.Scatter(x=[0, 1, 2, 3],y=[8, 4, 2, 0],name='Second Trace',showlegend=True)
    py.iplot([trace1, trace2])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/970.embed?share_key=yaHmAFKzeDP9AjAgx3GRVE" height="525px" width="100%"></iframe>



Hiding Legend Entries In Grouped Legends
========================================

same idea as above (use ``showlegend=False``). see
https://plot.ly/python/legend/#hiding-legend-entries-in-grouped-legends

Horizontal legends
==================

https://plot.ly/python/horizontal-legend/

.. code:: python

    go.Layout(legend=dict(orientation="h"))

.. code:: python

    trace1 = go.Scatter(x=np.random.randn(75),mode='markers',name="Plot1",
                    marker=dict(size=16,color='rgba(152, 0, 0, .8)'))
    trace2 = go.Scatter(x=np.random.randn(75), mode='markers',name="Plot2",
                    marker=dict(size=16,color='rgba(0, 152, 0, .8)'))
    trace3 = go.Scatter(x=np.random.randn(75), mode='markers',name="Plot3",
                    marker=dict(size=16,color='rgba(0, 0, 152, .8)'))
    
    data = [trace1, trace2, trace3]
    layout = go.Layout(legend=dict(orientation="h"))
    figure=go.Figure(data=data, layout=layout)
    
    py.iplot(figure)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/954.embed?share_key=3AkqcOk7eWAz1MJe4FUqGs" height="525px" width="100%"></iframe>


