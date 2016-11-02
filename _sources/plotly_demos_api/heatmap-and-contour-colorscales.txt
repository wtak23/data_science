###############################
heatmap-and-contour-colorscales
###############################

https://plot.ly/python/heatmap-and-contour-colorscales/

.. contents:: `Contents`
   :depth: 2
   :local:


Custom Discretized Heatmap Colorscale
=====================================

.. code:: python

    colorscale = [
            # Let first 10% (0.1) of the values have color rgb(0, 0, 0)
            [0, 'rgb(0, 0, 0)'],
            [0.1, 'rgb(0, 0, 0)'],
    
            # Let values between 10-20% of the min and max of z
            # have color rgb(20, 20, 20)
            [0.1, 'rgb(20, 20, 20)'],
            [0.2, 'rgb(20, 20, 20)'],
    
            # Values between 20-30% of the min and max of z
            # have color rgb(40, 40, 40)
            [0.2, 'rgb(40, 40, 40)'],
            [0.3, 'rgb(40, 40, 40)'],
    
            [0.3, 'rgb(60, 60, 60)'],
            [0.4, 'rgb(60, 60, 60)'],
    
            [0.4, 'rgb(80, 80, 80)'],
            [0.5, 'rgb(80, 80, 80)'],
    
            [0.5, 'rgb(100, 100, 100)'],
            [0.6, 'rgb(100, 100, 100)'],
    
            [0.6, 'rgb(120, 120, 120)'],
            [0.7, 'rgb(120, 120, 120)'],
    
            [0.7, 'rgb(140, 140, 140)'],
            [0.8, 'rgb(140, 140, 140)'],
    
            [0.8, 'rgb(160, 160, 160)'],
            [0.9, 'rgb(160, 160, 160)'],
    
            [0.9, 'rgb(180, 180, 180)'],
            [1.0, 'rgb(180, 180, 180)']
        ]

.. code:: python

    import plotly.plotly as py
    
    py.iplot([{
        'z': [
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        ],
        'type': 'heatmap',
        'colorscale': colorscale,
        'colorbar': {
            'tick0': 0,
            'dtick': 1
        }
    }])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/591.embed" height="525px" width="100%"></iframe>



Colorscale for Scatter Plots
============================

.. code:: python

    import plotly.graph_objs as go
    data = go.Data([
        go.Scatter(
            y=[5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
            marker=go.Marker(
                size=16,
                cmax=39,
                cmin=0,
                color=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
                colorbar=go.ColorBar(
                    title='Colorbar'
                ),
                colorscale='Viridis'
            ),
            mode='markers')
    ])
    
    fig = go.Figure(data=data)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/593.embed" height="525px" width="100%"></iframe>



Colorscale for Contour Plot
===========================

Pre-defined color scales -
``'pairs' | 'Greys' | 'Greens' | 'Bluered' | 'Hot' | 'Picnic' | 'Portland' | 'Jet' | 'RdBu' | 'Blackbody' | 'Earth' | 'Electric' | 'YIOrRd' | 'YIGnBu'``

.. code:: python

    data = [
        go.Contour(
            z=[[10, 10.625, 12.5, 15.625, 20],
               [5.625, 6.25, 8.125, 11.25, 15.625],
               [2.5, 3.125, 5., 8.125, 12.5],
               [0.625, 1.25, 3.125, 6.25, 10.625],
               [0, 0.625, 2.5, 5.625, 10]],
            colorscale='Jet',
        )
    ]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/595.embed" height="525px" width="100%"></iframe>



Custom Heatmap Colorscale
=========================

.. code:: python

    import six.moves.urllib
    import json
    response = six.moves.urllib.request.urlopen('https://raw.githubusercontent.com/plotly/datasets/master/custom_heatmap_colorscale.json')
    dataset = json.load(response)
    
    data = [
        go.Heatmap(
            z=dataset['z'],
            colorscale=[[0.0, 'rgb(165,0,38)'], [0.1111111111111111, 'rgb(215,48,39)'], 
                        [0.2222222222222222, 'rgb(244,109,67)'], [0.3333333333333333, 'rgb(253,174,97)'], 
                        [0.4444444444444444, 'rgb(254,224,144)'], [0.5555555555555556, 'rgb(224,243,248)'], 
                        [0.6666666666666666, 'rgb(171,217,233)'], [0.7777777777777778, 'rgb(116,173,209)'], 
                        [0.8888888888888888, 'rgb(69,117,180)'], [1.0, 'rgb(49,54,149)']]
        )
    ]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/597.embed" height="525px" width="100%"></iframe>



Custom Contour Plot Colorscale
==============================

.. code:: python

    data = [
        go.Contour(
            z=[[10, 10.625, 12.5, 15.625, 20],
               [5.625, 6.25, 8.125, 11.25, 15.625],
               [2.5, 3.125, 5., 8.125, 12.5],
               [0.625, 1.25, 3.125, 6.25, 10.625],
               [0, 0.625, 2.5, 5.625, 10]],
            colorscale=[[0, 'rgb(166,206,227)'], [0.25, 'rgb(31,120,180)'], 
                        [0.45, 'rgb(178,223,138)'], [0.65, 'rgb(51,160,44)'], 
                        [0.85, 'rgb(251,154,153)'], [1, 'rgb(227,26,28)']],
        )
    ]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/601.embed" height="525px" width="100%"></iframe>



