##########
bar-charts
##########

https://plot.ly/python/bar-charts/

.. contents:: `Contents`
   :depth: 2
   :local:


Basic bar charts
================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    data = [go.Bar(
                x=['giraffes', 'orangutans', 'monkeys'],
                y=[20, 14, 23]
        )]
    
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/408.embed" height="525px" width="100%"></iframe>



Grouped bar charts
==================

Set barmode=group in layout
---------------------------

.. code:: python

    trace1 = go.Bar(
        x=['giraffes', 'orangutans', 'monkeys'],
        y=[20, 14, 23],
        name='SF Zoo'
    )
    trace2 = go.Bar(
        x=['giraffes', 'orangutans', 'monkeys'],
        y=[12, 18, 29],
        name='LA Zoo'
    )
    
    data = [trace1, trace2]
    layout = go.Layout(
        barmode='group'
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='grouped-bar')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/410.embed" height="525px" width="100%"></iframe>



Stacked Bar Chart
=================

Set ``barmode=stack`` in layout
-------------------------------

.. code:: python

    trace1 = go.Bar(
        x=['giraffes', 'orangutans', 'monkeys'],
        y=[20, 14, 23],
        name='SF Zoo'
    )
    trace2 = go.Bar(
        x=['giraffes', 'orangutans', 'monkeys'],
        y=[12, 18, 29],
        name='LA Zoo'
    )
    
    data = [trace1, trace2]
    layout = go.Layout(
        barmode='stack'
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='stacked-bar')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/412.embed" height="525px" width="100%"></iframe>



Styled Bar Chart with Direct Labels
===================================

.. code:: python

    x = ['Product A', 'Product B', 'Product C']
    y = [20, 14, 23]
    
    data = [go.Bar(
                x=x,y=y,
                marker=dict(
                    color='rgb(158,202,225)',
                    line=dict(
                        color='rgb(8,48,107)',
                        width=1.5),
                ),
                opacity=0.6
            )]
    
    layout = go.Layout(
        annotations=[
            dict(x=xi,y=yi,
                 text=str(yi),
                 xanchor='center',
                 yanchor='bottom',
                 showarrow=False,
            ) for xi, yi in zip(x, y)]
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='bar-direct-labels')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/416.embed" height="525px" width="100%"></iframe>



.. code:: python

    # compare without the annotation
    fig = go.Figure(data=data)
    py.iplot(fig, filename='bar-direct-labels')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/416.embed" height="525px" width="100%"></iframe>



Rotated Bar Chart Labels
========================

xaxis=dict(tickangle=-45)
-------------------------

.. code:: python

    trace0 = go.Bar(
        x=['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        y=[20, 14, 25, 16, 18, 22, 19, 15, 12, 16, 14, 17],
        name='Primary Product',
        marker=dict(
            color='rgb(49,130,189)'
        )
    )
    trace1 = go.Bar(
        x=['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        y=[19, 14, 22, 14, 16, 19, 15, 14, 10, 12, 12, 16],
        name='Secondary Product',
        marker=dict(
            color='rgb(204,204,204)',
        )
    )
    
    data = [trace0, trace1]
    layout = go.Layout(
        xaxis=dict(tickangle=-45), # <- tickangle
        barmode='group', # <- like section2 "Grouped bar charts"
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/418.embed" height="525px" width="100%"></iframe>



Customizing Individual Bar Colors
=================================

.. code:: python

    trace0 = go.Bar(
        x=['Feature A', 'Feature B', 'Feature C',
           'Feature D', 'Feature E'],
        y=[20, 14, 23, 25, 22],
        marker=dict(
            color=['rgba(204,204,204,1)', 'rgba(222,45,38,0.8)',
                   'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
                   'rgba(204,204,204,1)']),
    )
    
    data = [trace0]
    layout = go.Layout(
        title='Least Used Feature',
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/420.embed" height="525px" width="100%"></iframe>



Bar chart with hover text
=========================

.. code:: python

    trace0 = go.Bar(
        x=['Product A', 'Product B', 'Product C'],
        y=[20, 14, 23],
        text=['27% market share', '24% market share', '19% market share'],
        marker=dict(
            color='rgb(158,202,225)',
            line=dict(
                color='rgb(8,48,107)',
                width=1.5,
            )
        ),
        opacity=0.6
    )
    
    data = [trace0]
    layout = go.Layout(
        title='January 2013 Sales Report',
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/414.embed" height="525px" width="100%"></iframe>



# Colored and styled plots

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace1 = go.Bar(
        x=[1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
           2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
        y=[219, 146, 112, 127, 124, 180, 236, 207, 236, 263,
           350, 430, 474, 526, 488, 537, 500, 439],
        name='Rest of world',
        marker=dict(color='rgb(55, 83, 109)')
    )
    trace2 = go.Bar(
        x=[1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
           2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
        y=[16, 13, 10, 11, 28, 37, 43, 55, 56, 88, 105, 156, 270,
           299, 340, 403, 549, 499],
        name='China',
        marker=dict(color='rgb(26, 118, 255)')
    )
    data = [trace1, trace2]
    layout = go.Layout(
        title='US Export of Plastic Scrap',
        xaxis=dict(tickfont=dict(size=14,color='rgb(107, 107, 107)')),
        yaxis=dict(
            title='USD (millions)',
            titlefont=dict(size=16,color='rgb(107, 107, 107)'),
            tickfont=dict(size=14,color='rgb(107, 107, 107)')
        ),
        legend=dict(x=0,y=1.0,
            bgcolor='rgba(255, 255, 255, 0)',
            bordercolor='rgba(255, 255, 255, 0)'
        ),
        barmode='group',
        bargap=0.15,
        bargroupgap=0.1
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='style-bar')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/422.embed" height="525px" width="100%"></iframe>



Waterfall Bar Chart
===================

.. code:: python

    x_data = ['Product<br>Revenue', 'Services<br>Revenue',
              'Total<br>Revenue', 'Fixed<br>Costs',
              'Variable<br>Costs', 'Total<br>Costs', 'Total']
    y_data = [400, 660, 660, 590, 400, 400, 340]
    text = ['$430K', '$260K', '$690K', '$-120K', '$-200K', '$-320K', '$370K']
    
    # Base
    trace0 = go.Bar(
        x=x_data,
        y=[0, 430, 0, 570, 370, 370, 0],
        marker=dict(
            color='rgba(1,1,1, 0.0)',
        )
    )
    # Revenue
    trace1 = go.Bar(
        x=x_data,
        y=[430, 260, 690, 0, 0, 0, 0],
        marker=dict(
            color='rgba(55, 128, 191, 0.7)',
            line=dict(
                color='rgba(55, 128, 191, 1.0)',
                width=2,
            )
        )
    )
    # Costs
    trace2 = go.Bar(
        x=x_data,
        y=[0, 0, 0, 120, 200, 320, 0],
        marker=dict(
            color='rgba(219, 64, 82, 0.7)',
            line=dict(
                color='rgba(219, 64, 82, 1.0)',
                width=2,
            )
        )
    )
    # Profit
    trace3 = go.Bar(
        x=x_data,
        y=[0, 0, 0, 0, 0, 0, 370],
        marker=dict(
            color='rgba(50, 171, 96, 0.7)',
            line=dict(
                color='rgba(50, 171, 96, 1.0)',
                width=2,
            )
        )
    )
    data = [trace0, trace1, trace2, trace3]
    layout = go.Layout(
        title='Annual Profit- 2015',
        barmode='stack',
        paper_bgcolor='rgba(245, 246, 249, 1)',
        plot_bgcolor='rgba(245, 246, 249, 1)',
        showlegend=False
    )
    
    annotations = []
    
    for i in range(0, 7):
        annotations.append(dict(x=x_data[i], y=y_data[i], text=text[i],
                                      font=dict(family='Arial', size=14,
                                      color='rgba(245, 246, 249, 1)'),
                                      showarrow=False,))
        layout['annotations'] = annotations
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='waterfall-bar-profit')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/424.embed" height="525px" width="100%"></iframe>



Bar Chart with Relative Barmode
===============================

.. code:: python

    x = [1, 2, 3, 4]
    
    trace1 = {
      'x': x,
      'y': [1, 4, 9, 16],
      'name': 'Trace1',
      'type': 'bar'
    };
    trace2 = {
      'x': x,
      'y': [6, -8, -4.5, 8],
      'name': 'Trace2',
      'type': 'bar'
    };
    trace3 = {
      'x': x,
      'y': [-15, -3, 4.5, -8],
      'name': 'Trace3',
      'type': 'bar'
     }
     
    trace4 = {
      'x': x,
      'y': [-1, 3, -3, -4],
      'name': 'Trace4',
      'type': 'bar'
     }
     
    data = [trace1, trace2, trace3, trace4];
    layout = {
      'xaxis': {'title': 'X axis'},
      'yaxis': {'title': 'Y axis'},
      'barmode': 'relative',
      'title': 'Relative Barmode'
    };
    py.iplot({'data': data, 'layout': layout}, filename='barmode-relative')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/426.embed" height="525px" width="100%"></iframe>



