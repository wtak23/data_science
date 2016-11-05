#############
scatter-plots
#############

https://plot.ly/python/line-and-scatter/

.. contents:: `Contents`
   :depth: 2
   :local:


Simple scatter plot
===================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    # Create random data with numpy
    import numpy as np
    
    N = 1000
    random_x = np.random.randn(N)
    random_y = np.random.randn(N)
    
    # Create a trace
    trace = go.Scatter(
        x = random_x,
        y = random_y,
        mode = 'markers'
    )
    
    data = [trace]
    
    # Plot and embed in ipython notebook!
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/364.embed" height="525px" width="100%"></iframe>



Line and Scatter Plots
======================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    # Create random data with numpy
    import numpy as np
    
    N = 100
    random_x = np.linspace(0, 1, N)
    random_y0 = np.random.randn(N)+5
    random_y1 = np.random.randn(N)
    random_y2 = np.random.randn(N)-5
    
    # Create traces
    trace0 = go.Scatter(
        x = random_x,
        y = random_y0,
        mode = 'markers',
        name = 'markers'
    )
    trace1 = go.Scatter(
        x = random_x,
        y = random_y1,
        mode = 'lines+markers',
        name = 'lines+markers'
    )
    trace2 = go.Scatter(
        x = random_x,
        y = random_y2,
        mode = 'lines',
        name = 'lines'
    )
    
    data = [trace0, trace1, trace2]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/368.embed" height="525px" width="100%"></iframe>



Style Scatter Plots
===================

.. code:: python

    N = 500
    
    trace0 = go.Scatter(
        x = np.random.randn(N),
        y = np.random.randn(N)+2,
        name = 'Female',
        mode = 'markers',
        marker = dict(
            size = 10,
            color = 'rgba(152, 0, 0, .8)',
            line = dict(
                width = 2,
                color = 'rgb(0, 0, 0)'
            )
        )
    )
    
    trace1 = go.Scatter(
        x = np.random.randn(N),
        y = np.random.randn(N)-2,
        name = 'Male',
        mode = 'markers',
        marker = dict(
            size = 10,
            color = 'rgba(0, 0, 255, .5)',
            line = dict(
                width = 2,
            )
        )
    )
    
    data = [trace0, trace1]
    
    layout = dict(title = 'Styled Scatter',
                  yaxis = dict(zeroline = False),
                  xaxis = dict(zeroline = False)
                 )
    
    fig = dict(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/374.embed" height="525px" width="100%"></iframe>


