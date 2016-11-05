##########
pie-charts
##########

https://plot.ly/python/pie-charts/

.. contents:: `Contents`
   :depth: 2
   :local:


Basic pie chart
===============

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    fig = {
        'data': [{'labels': ['Residential', 'Non-Residential', 'Utility'],
                  'values': [19, 26, 55],
                  'type': 'pie'}],
        'layout': {'title': 'Forcasted 2014 U.S. PV Installations by Market Segment'}
         }
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/536.embed" height="525px" width="100%"></iframe>



Pie Chart using Pie object
==========================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    labels=['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen']
    values=[4500,2500,1053,500]
    
    trace=go.Pie(labels=labels,values=values)
    
    py.iplot([trace])





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/538.embed" height="525px" width="100%"></iframe>



Donut Chart
===========

.. code:: python

    labels = [
            "US",
            "China",
            "European Union",
            "Russian Federation",
            "Brazil",
            "India",
            "Rest of World"
          ]

.. code:: python

    fig['data'] = [
        {
          "values": [16, 15, 12, 6, 5, 4, 42],
          "labels":labels,
          "domain": {"x": [0, .48]},
          "name": "GHG Emissions",
          "hoverinfo":"label+percent+name",
          "hole": .4,
          "type": "pie"
        },     
        {
          "values": [27, 11, 25, 8, 1, 3, 25],
          "labels": labels,
          "text":"CO2",
          "textposition":"inside",
          "domain": {"x": [.52, 1]},
          "name": "CO2 Emissions",
          "hoverinfo":"label+percent+name",
          "hole": .4,
          "type": "pie"
        }]

.. code:: python

    fig['layout'] = {
            "title":"Global Emissions 1990-2011",
            "annotations": [
                {
                    "font": {"size": 20},
                    "showarrow": False,
                    "text": "GHG",
                    "x": 0.20,
                    "y": 0.5
                },
                {
                    "font": {"size": 20},
                    "showarrow": False,
                    "text": "CO2",
                    "x": 0.8,
                    "y": 0.5
                }
            ]
        }

.. code:: python

    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/546.embed" height="525px" width="100%"></iframe>



Pie Chart Subplots
==================

.. code:: python

    trace1 = {
                'labels': ['1st', '2nd', '3rd', '4th', '5th'],
                'values': [38, 27, 18, 10, 7],
                'type': 'pie',
                'name': 'Starry Night',
                'marker': {'colors': ['rgb(56, 75, 126)',
                                      'rgb(18, 36, 37)',
                                      'rgb(34, 53, 101)',
                                      'rgb(36, 55, 57)',
                                      'rgb(6, 4, 4)']},
                'domain': {'x': [0, .48],
                           'y': [0, .49]},
                'hoverinfo':'label+percent+name',
                'textinfo':'none'
    }
    
    trace2 = {
                'labels': ['1st', '2nd', '3rd', '4th', '5th'],
                'values': [28, 26, 21, 15, 10],
                'marker': {'colors': ['rgb(177, 127, 38)',
                                      'rgb(205, 152, 36)',
                                      'rgb(99, 79, 37)',
                                      'rgb(129, 180, 179)',
                                      'rgb(124, 103, 37)']},
                'type': 'pie',
                'name': 'Sunflowers',
                'domain': {'x': [.52, 1],
                           'y': [0, .49]},
                'hoverinfo':'label+percent+name',
                'textinfo':'none'
    
    }
    
    trace3 = {
                'labels': ['1st', '2nd', '3rd', '4th', '5th'],
                'values': [38, 19, 16, 14, 13],
                'marker': {'colors': ['rgb(33, 75, 99)',
                                      'rgb(79, 129, 102)',
                                      'rgb(151, 179, 100)',
                                      'rgb(175, 49, 35)',
                                      'rgb(36, 73, 147)']},
                'type': 'pie',
                'name': 'Irises',
                'domain': {'x': [0, .48],
                           'y': [.51, 1]},
                'hoverinfo':'label+percent+name',
                'textinfo':'none'
            }
    trace4 = {
                'labels': ['1st', '2nd', '3rd', '4th', '5th'],
                'values': [31, 24, 19, 18, 8],
                'marker': {'colors': ['rgb(146, 123, 21)',
                                      'rgb(177, 180, 34)',
                                      'rgb(206, 206, 40)',
                                      'rgb(175, 51, 21)',
                                      'rgb(35, 36, 21)']},
                'type': 'pie',
                'name':'The Night Café',
                'domain': {'x': [.52, 1],
                           'y': [.51, 1]},
                'hoverinfo':'label+percent+name',
                'textinfo':'none'
            }


.. code:: python

    fig = {
        'data': [trace1,trace2,trace3,trace4],
        'layout': {'title': 'Van Gogh: 5 Most Prominent Colors Shown Proportionally',
                   'showlegend': False}
    }
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/550.embed" height="525px" width="100%"></iframe>


