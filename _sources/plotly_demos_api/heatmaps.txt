########
heatmaps
########

https://plot.ly/python/heatmaps/

.. contents:: `Contents`
   :depth: 2
   :local:


Basic heatmaps
==============

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    data = [
        go.Heatmap(
            z=[[1, 20, 30],
               [20, 1, 60],
               [30, 60, 1]]
        )
    ]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/490.embed" height="525px" width="100%"></iframe>



Heatmap with Categorical Axis Labels
====================================

.. code:: python

    data = [
        go.Heatmap(
            z=[[1, 20, 30, 50, 1], [20, 1, 60, 80, 30], [30, 60, 1, -10, 20]],
            x=['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
            y=['Morning', 'Afternoon', 'Evening']
        )
    ]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/492.embed" height="525px" width="100%"></iframe>



Annotated Heatmap
=================

.. code:: python

    x = ['A', 'B', 'C', 'D', 'E']
    y = ['W', 'X', 'Y', 'Z']
    
    #       x0    x1    x2    x3    x4
    z = [[0.00, 0.00, 0.75, 0.75, 0.00],  # y0
         [0.00, 0.00, 0.75, 0.75, 0.00],  # y1
         [0.75, 0.75, 0.75, 0.75, 0.75],  # y2
         [0.00, 0.00, 0.00, 0.75, 0.00]]  # y3
    
    annotations = []
    for n, row in enumerate(z):
        for m, val in enumerate(row):
            var = z[n][m]
            annotations.append(
                dict(
                    text=str(val),
                    x=x[m], y=y[n],
                    xref='x1', yref='y1',
                    font=dict(color='white' if val > 0.5 else 'black'),
                    showarrow=False)
                )
    
    colorscale = [[0, '#3D9970'], [1, '#001f3f']]  # custom colorscale
    trace = go.Heatmap(x=x, y=y, z=z, colorscale=colorscale, showscale=False)
    
    fig = go.Figure(data=[trace])
    fig['layout'].update(
        title="Annotated Heatmap",
        annotations=annotations,
        xaxis=dict(ticks='', side='top'),
        # ticksuffix is a workaround to add a bit of padding
        yaxis=dict(ticks='', ticksuffix='  '),
        width=700,
        height=700,
        autosize=False
    )
    py.iplot(fig, height=750)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/494.embed" height="700px" width="700px"></iframe>



Heatmap with Unequal Block Sizes
================================

.. code:: python

    import numpy as np
    # Golden spiral with fibonacci rectangles
    
    ## Build the spiral
    def spiral(th):
        a = 1.120529
        b = 0.306349
        r = a*np.exp(-b*th)
        return (r*np.cos(th), r*np.sin(th))
    
    nspiral = 2 # number of spiral loops
    
    th = np.linspace(-np.pi/13,2*np.pi*nspiral,1000); # angle
    (x,y) = spiral(th)
    
    # shift the spiral north so that it is centered
    yshift = (1.6 - (max(y)-min(y)))/2
    
    s = dict(x= -x+x[0], y= y-y[0]+yshift,
         line =dict(color='white',width=3))  # spiral
    
    # Build the rectangles as a heatmap
    # specify the edges of the heatmap squares
    phi = ( 1+np.sqrt(5) )/2.
    xe = [0, 1, 1+(1/(phi**4)), 1+(1/(phi**3)), phi]
    ye = [0, 1/(phi**3),1/phi**3+1/phi**4,1/(phi**2),1]
    
    z = [ [13,3,3,5],
          [13,2,1,5],
          [13,10,11,12],
          [13,8,8,8]
        ]
    
    hm = dict(x = np.sort(xe),
              y = np.sort(ye)+yshift,
              z = z,
              type = 'heatmap',
              colorscale = 'Viridis')
    
    axis_template = dict(range = [0,1.6], autorange = False,
                 showgrid = False, zeroline = False,
                 linecolor = 'black', showticklabels = False,
                 ticks = '' )
    
    layout = dict( margin = dict(t=200,r=200,b=200,l=200),
        xaxis = axis_template,
        yaxis = axis_template,
        showlegend = False,
        width = 700, height = 700,
        autosize = False )
    
    figure = dict(data=[s, hm],layout=layout)
    
    py.iplot(figure, height=750)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/496.embed" height="700px" width="700px"></iframe>



Heatmap with Datetime Axis
==========================

.. code:: python

    import datetime
    
    programmers = ['Alex','Nicole','Sara','Etienne','Chelsea','Jody','Marianne']
    
    base = datetime.datetime.today()
    date_list = [base - datetime.timedelta(days=x) for x in range(0, 180)]
    
    z = []
    
    for prgmr in programmers:
        new_row = []
        for date in date_list:
            new_row.append( np.random.poisson() )
        z.append(list(new_row))
    
    data = [
        go.Heatmap(
            z=z,
            x=date_list,
            y=programmers,
            colorscale='Viridis',
        )
    ]
    
    layout = go.Layout(
        title='GitHub commits per day',
        xaxis = dict(ticks='', nticks=36),
        yaxis = dict(ticks='' )
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/498.embed" height="525px" width="100%"></iframe>


