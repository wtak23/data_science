#################
filled-area-plots
#################
https://plot.ly/python/filled-area-plots/

.. contents:: `Contents`
   :depth: 2
   :local:


Basic Overlaid Area Chart
=========================

.. code:: python

    fill='tozeroy'
    fill='tonexty'

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace1 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[0, 2, 3, 5],
        fill='tozeroy'
    )
    trace2 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[3, 5, 1, 7],
        fill='tonexty'
    )
    
    data = [trace1, trace2]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/560.embed" height="525px" width="100%"></iframe>



Overlaid Area Chart Without Boundary Lines
==========================================

.. code:: python

    mode= 'none'

.. code:: python

    trace1 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[0, 2, 3, 5],
        fill='tozeroy',
        mode= 'none'
    )
    trace2 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[3, 5, 1, 7],
        fill='tonexty',
        mode= 'none'
    )
    
    data = [trace1, trace2]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/562.embed" height="525px" width="100%"></iframe>



Interior Filling for Area Chart
===============================

.. code:: python

    trace0 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[3, 4, 8, 3],
        fill= None,
        mode='lines',
        line=dict(
            color='rgb(143, 19, 131)',
        )
    )
    trace1 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[1, 6, 2, 6],
        fill='tonexty',
        mode='lines',
        line=dict(
            color='rgb(143, 19, 131)',
        )
    )
    
    data = [trace0, trace1]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/564.embed" height="525px" width="100%"></iframe>



Stacked Area Chart with Cumulative Values
=========================================

.. code:: python

    trace0 = go.Scatter(
        x=['Winter', 'Spring', 'Summer', 'Fall'],
        y=['40', '20', '30', '40'],
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(184, 247, 212)'),
        fill='tonexty'
    )
    trace1 = go.Scatter(
        x=['Winter', 'Spring', 'Summer', 'Fall'],
        y=['50', '70', '40', '60'],
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(111, 231, 219)'),
        fill='tonexty'
    )
    trace2 = go.Scatter(
        x=['Winter', 'Spring', 'Summer', 'Fall'],
        y=['70', '80', '60', '70'],
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(127, 166, 238)'),
        fill='tonexty'
    )
    trace3 = go.Scatter(
        x=['Winter', 'Spring', 'Summer', 'Fall'],
        y=['100', '100', '100', '100'],
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(131, 90, 241)'),
        fill='tonexty'
    )
    data = [trace0, trace1, trace2, trace3]
    layout = go.Layout(
        showlegend=True,
        xaxis=dict(
            type='category',
        ),
        yaxis=dict(
            type='linear',
            range=[1, 100],
            dtick=20,
            ticksuffix='%'
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/566.embed" height="525px" width="100%"></iframe>



Stacked Area Chart with Original Values
=======================================

.. code:: python

    # Add original data
    x=['Winter', 'Spring', 'Summer', 'Fall']
    
    y0_org=[40, 60, 40, 10]
    y1_org=[20, 10, 10, 60]
    y2_org=[40, 30, 50, 30]
    
    # Add data to create cumulative stacked values
    y0_stck=y0_org
    y1_stck=[y0+y1 for y0, y1 in zip(y0_org, y1_org)]
    y2_stck=[y0+y1+y2 for y0, y1, y2 in zip(y0_org, y1_org, y2_org)]
    
    # Make original values strings and add % for hover text
    y0_txt=[str(y0)+'%' for y0 in y0_org]
    y1_txt=[str(y1)+'%' for y1 in y1_org]
    y2_txt=[str(y2)+'%' for y2 in y2_org]
    
    trace0 = go.Scatter(
        x=x,
        y=y0_stck,
        text=y0_txt,
        hoverinfo='x+text',
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(131, 90, 241)'),
        fill='tonexty'
    )
    trace1 = go.Scatter(
        x=x,
        y=y1_stck,
        text=y1_txt,
        hoverinfo='x+text',
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(111, 231, 219)'),
        fill='tonexty'
    )
    trace2 = go.Scatter(
        x=x,
        y=y2_stck,
        text=y2_txt,
        hoverinfo='x+text',
        mode='lines',
        line=dict(width=0.5,
                  color='rgb(184, 247, 212)'),
        fill='tonexty'
    )
    data = [trace0, trace1, trace2]
    
    fig = go.Figure(data=data)
    py.iplot(fig, filename='stacked-area-plot-hover')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/568.embed" height="525px" width="100%"></iframe>



