#############
3d-plot-demos
#############

Bunch of 3d stuffs

.. contents:: `Contents`
   :depth: 2
   :local:


3D Surface Subplots
===================

https://plot.ly/python/3d-subplots/

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    from plotly import tools
    
    import numpy as np
    
    x = np.linspace(-5, 80, 10)
    y = np.linspace(-5, 60, 10)
    xGrid, yGrid = np.meshgrid(y, x)
    z = xGrid ** 3 + yGrid ** 3
    
    scene = dict(
        xaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        ),
        yaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        ),
        zaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        )
    )
    
    fig = tools.make_subplots(rows=2, cols=2,
                              specs=[[{'is_3d': True}, {'is_3d': True}],
                                     [{'is_3d': True}, {'is_3d': True}]])


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    [ (2,1) scene3 ]  [ (2,2) scene4 ]
    


.. code:: python

    # adding surfaces to subplots.
    fig.append_trace(dict(type='surface', x=x, y=y, z=z, colorscale='Viridis',
                          scene='scene1', showscale=False), 1, 1)
    fig.append_trace(dict(type='surface', x=x, y=y, z=z, colorscale='RdBu',
                          scene='scene2', showscale=False), 1, 2)
    fig.append_trace(dict(type='surface', x=x, y=y, z=z, colorscale='YIOrRd',
                          scene='scene3', showscale=False), 2, 1)
    fig.append_trace(dict(type='surface', x=x, y=y, z=z, colorscale='YIGnBu',
                          scene='scene4', showscale=False), 2, 2)
    
    # configure layout
    fig['layout'].update(title='subplots with different colorscales',
                         height=800, width=800)
    fig['layout']['scene1'].update(scene)
    fig['layout']['scene2'].update(scene)
    fig['layout']['scene3'].update(scene)
    fig['layout']['scene4'].update(scene)
    
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/516.embed" height="800px" width="800px"></iframe>



3D Surface Coloring (subplots too!)
===================================

https://plot.ly/python/3d-surface-coloring/

.. code:: python

    import copy
    import json
    import math
    import plotly.plotly as py
    from plotly import tools
    import urllib2
    
    # data related to the ring cyclide is loaded
    
    response = urllib2.urlopen('https://plot.ly/~empet/2381.json')
    data_file = response.read()
    fig = json.loads(data_file)
    
    # data related to the ring cyclide is loaded
    
    
    data_original = fig['data'][0]     # this will be trace0
    
    data = copy.deepcopy(fig['data'])[0]        # trace1
    
    lx = len(data['z'])
    ly = len(data['z'][0])
    
    out = []
    
    
    def dist_origin(x, y, z):
    
        return math.sqrt((1.0 * x)**2 + (1.0 * y)**2 + (1.0 * z)**2)
    
    for i in xrange(lx):
        temp = []
        for j in xrange(ly):
            temp.append(
                dist_origin(data['x'][i][j], data['y'][i][j], data['z'][i][j]))
        out.append(temp)
    
    data['surfacecolor'] = out     # sets surface-color to distance from the origin
    
    # This section deals with the layout of the plot
    
    scene = dict(
        xaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        ),
        yaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        ),
        zaxis=dict(
            gridcolor='rgb(255, 255, 255)',
            zerolinecolor='rgb(255, 255, 255)',
            showbackground=True,
            backgroundcolor='rgb(230, 230,230)'
        ),
        cameraposition=[[0.2, 0.5, 0.5, 0.2], [0, 0, 0], 4.8]
    )
    
    fig = tools.make_subplots(rows=1, cols=2,
                              specs=[[{'is_3d': True}, {'is_3d': True}]])
    
    # adding surfaces to subplots.
    data_original['scene'] = 'scene1'
    data_original['colorbar'] = dict(x=-0.07)
    
    data['scene'] = 'scene2'
    fig.append_trace(data_original, 1, 1)
    fig.append_trace(data, 1, 2)
    
    
    fig['layout'].update(title='Ring Cyclide',
                         height=800, width=950)
    fig['layout']['scene1'].update(scene)
    fig['layout']['scene2'].update(scene)
    fig['layout']['annotations'] = [
        dict(
            x=0.1859205,
            y=0.95,       # 0.9395833,
            xref='x',
            yref='y',
            text='4th Dim Prop. to z',
            showarrow=False
        ),
        dict(
            x=0.858,
            y=0.95,
            xref='x',
            yref='y',
            text='4th Dim Prop. to Distance from Origin',
            showarrow=False
        )
    ]
    
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1034.embed?share_key=7fpBM9579vvPw4AEtwfrHs" height="800px" width="950px"></iframe>



3d point clustering
===================

https://plot.ly/python/3d-point-clustering/

.. code:: python

    import plotly.plotly as py
    import pandas as pd
    
    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/alpha_shape.csv')
    df.head()
    
    scatter = dict(
        mode = "markers",
        name = "y",
        type = "scatter3d",    
        x = df['x'], y = df['y'], z = df['z'],
        marker = dict( size=2, color="rgb(23, 190, 207)" )
    )
    clusters = dict(
        alphahull = 7,
        name = "y",
        opacity = 0.1,
        type = "mesh3d",    
        x = df['x'], y = df['y'], z = df['z']
    )
    layout = dict(
        title = '3d point clustering',
        scene = dict(
            xaxis = dict( zeroline=False ),
            yaxis = dict( zeroline=False ),
            zaxis = dict( zeroline=False ),
        )
    )
    fig = dict( data=[scatter, clusters], layout=layout )
    # Use py.iplot() for IPython notebook
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/518.embed" height="525px" width="100%"></iframe>



3d network graph
================

https://plot.ly/python/3d-network-graph/

The correct version of igraph is this http://igraph.org/python/

.. code:: python

    %%bash
    pip install python-igraph --user


.. parsed-literal::
    :class: myliteral

    Requirement already satisfied (use --upgrade to upgrade): python-igraph in /home/takanori/.local/lib/python2.7/site-packages


.. code:: python

    import igraph as ig


.. code:: python

    import json
    import urllib2
    
    data = []
    req = urllib2.Request("https://raw.githubusercontent.com/plotly/datasets/master/miserables.json")
    opener = urllib2.build_opener()
    f = opener.open(req)
    data = json.loads(f.read())
    
    print data.keys()


.. parsed-literal::
    :class: myliteral

    [u'nodes', u'links']


.. code:: python

    # number of nodes
    N=len(data['nodes'])
    
    # define list of edges and graph object from edges
    L=len(data['links'])
    Edges=[(data['links'][k]['source'], data['links'][k]['target']) for k in range(L)]
    
    G=ig.Graph(Edges, directed=False)
    
    print data['nodes'][0]
    
    labels=[]
    group=[]
    for node in data['nodes']:
        labels.append(node['name'])
        group.append(node['group'])


.. parsed-literal::
    :class: myliteral

    {u'group': 1, u'name': u'Myriel'}


Assign node posibion
--------------------

Get the node positions, set by the Kamada-Kawai layout for 3D graphs:

.. code:: python

    layt=G.layout('kk', dim=3)
    
    # layt is a list of three elements lists (the coordinates of nodes):
    print layt[0]
    print len(layt)


.. parsed-literal::
    :class: myliteral

    [7.217459422374638, 2.377425916869016, -1.942537513857466]
    77


Set data for the Plotly plot of the graph:
------------------------------------------

.. code:: python

    Xn=[layt[k][0] for k in range(N)]# x-coordinates of nodes
    Yn=[layt[k][1] for k in range(N)]# y-coordinates
    Zn=[layt[k][2] for k in range(N)]# z-coordinates
    Xe=[]
    Ye=[]
    Ze=[]
    for e in Edges:
        Xe+=[layt[e[0]][0],layt[e[1]][0], None]# x-coordinates of edge ends
        Ye+=[layt[e[0]][1],layt[e[1]][1], None]
        Ze+=[layt[e[0]][2],layt[e[1]][2], None]

Define trace objects
--------------------

.. code:: python

    import plotly.graph_objs as go
    
    trace1=go.Scatter3d(x=Xe,
                   y=Ye,
                   z=Ze,
                   mode='lines',
                   line=go.Line(color='rgb(125,125,125)', width=1),
                   hoverinfo='none'
                   )
    trace2=go.Scatter3d(x=Xn,
                   y=Yn,
                   z=Zn,
                   mode='markers',
                   name='actors',
                   marker=go.Marker(symbol='dot',
                                 size=6,
                                 color=group,
                                 colorscale='Viridis',
                                 line=go.Line(color='rgb(50,50,50)', width=0.5)
                                 ),
                   text=labels,
                   hoverinfo='text'
                   )


Define layout object
--------------------

.. code:: python

    axis=dict(showbackground=False,
              showline=False,
              zeroline=False,
              showgrid=False,
              showticklabels=False,
              title=''
              )
    
    layout = go.Layout(
             title="Network of coappearances of characters in Victor Hugo's novel<br> Les Miserables (3D visualization)",
             width=1000,
             height=1000,
             showlegend=False,
             scene=go.Scene(
             xaxis=go.XAxis(axis),
             yaxis=go.YAxis(axis),
             zaxis=go.ZAxis(axis),
            ),
         margin=go.Margin(
            t=100
        ),
        hovermode='closest',
        annotations=go.Annotations([
               go.Annotation(
               showarrow=False,
                text="Data source: <a href='http://bost.ocks.org/mike/miserables/miserables.json'>[1]</a>",
                xref='paper',
                yref='paper',
                x=0,
                y=0.1,
                xanchor='left',
                yanchor='bottom',
                font=go.Font(
                size=14
                )
                )
            ]),    )


Plot!
-----

.. code:: python

    data=go.Data([trace1, trace2])
    fig=go.Figure(data=data, layout=layout)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/520.embed" height="1000px" width="1000px"></iframe>



3d filled line plots
====================

https://plot.ly/python/3d-filled-line-plots/

.. code:: python

    import plotly.plotly as py
    import pandas as pd
    
    # The datasets' url. Thanks Jennifer Bryan!
    url_csv = 'http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt'
    
    df = pd.read_csv(url_csv, sep='\t')
    df.head()
    
    countries = ['China', 'India', 'United States', 'Bangladesh', 'South Africa']
    fill_colors = ['#66c2a5', '#fc8d62', '#8da0cb', '#e78ac3', '#a6d854']
    gf = df.groupby('country')
    
    data = []
    
    for country, fill_color in zip(countries[::-1], fill_colors):
        group = gf.get_group(country)
        years = group['year'].tolist()
        length = len(years)
        country_coords = [country] * length
        pop = group['pop'].tolist()
        zeros = [0] * length
        
        data.append(dict(
            type='scatter3d',
            mode='lines',
            x=years + years[::-1] + [years[0]],  # year loop: in incr. order then in decr. order then years[0]
            y=country_coords * 2 + [country_coords[0]],
            z=pop + zeros + [pop[0]],
            name='',
            surfaceaxis=1, # add a surface axis ('1' refers to axes[1] i.e. the y-axis)
            surfacecolor=fill_color,
            line=dict(
                color='black',
                width=4
            ),
        ))
    
    layout = dict(
        title='Population from 1957 to 2007 [Gapminder]',
        showlegend=False,
        scene=dict(
            xaxis=dict(title=''),
            yaxis=dict(title=''),
            zaxis=dict(title=''),
            camera=dict(
                eye=dict(x=-1.7, y=-1.7, z=0.5)
            )
        )
    )
    
    fig = dict(data=data, layout=layout)
    
    # IPython notebook
    # py.iplot(fig, filename='filled-3d-lines')
    
    py.iplot(fig)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/522.embed" height="525px" width="100%"></iframe>



3d scatter plots
================

https://plot.ly/python/3d-scatter-plots/ ## Basic 3D Scatter Plot

.. code:: python

    import numpy as np
    x, y, z = np.random.multivariate_normal(np.array([0,0,0]), np.eye(3), 200).transpose()
    trace1 = go.Scatter3d(
        x=x,y=y,z=z,
        mode='markers',
        marker=dict(size=12,
                    opacity=0.8,
                    line=dict(
                        color='rgba(217, 217, 217, 0.14)',
                        width=0.5),)
    )
    
    x2, y2, z2 = np.random.multivariate_normal(np.array([0,0,0]), np.eye(3), 200).transpose()
    trace2 = go.Scatter3d(
        x=x2,    y=y2,    z=z2,
        mode='markers',
        marker=dict(color='rgb(127, 127, 127)',
                    size=12,
                    opacity=0.9,
                    symbol='circle',
                    line=dict(
                        color='rgb(204, 204, 204)',
                        width=1),
        )
    )
    
    data = [trace1, trace2]
    layout = go.Layout(margin=dict(l=0,r=0,b=0,t=0))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/524.embed" height="525px" width="100%"></iframe>



3D Scatter Plot with Colorscaling
---------------------------------

.. code:: python

    x, y, z = np.random.multivariate_normal(np.array([0,0,0]), np.eye(3), 400).transpose()
    
    trace1 = go.Scatter3d(
        x=x,
        y=y,
        z=z,
        mode='markers',
        marker=dict(
            size=12,
            color=z,                # set color to an array/list of desired values
            colorscale='Viridis',   # choose a colorscale
            opacity=0.8
        )
    )
    
    data = [trace1]
    layout = go.Layout(margin=dict(l=0,r=0,b=0,t=0))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/526.embed" height="525px" width="100%"></iframe>



Projection of 3D surface
========================

https://plot.ly/python/2d-projection-of-3d-surface/

Set trace
---------

.. code:: python

    xx=np.linspace(-3.5, 3.5, 100)
    yy=np.linspace(-3.5, 3.5, 100)
    x,y=np.meshgrid(xx, yy)
    z=np.exp(-(x-1)**2-y**2)-10*(x**3+y**4-x/5)*np.exp(-(x**2+y**2))
    
    colorscale=[[0.0, 'rgb(20,29,67)'],
               [0.1, 'rgb(28,76,96)'],
               [0.2, 'rgb(16,125,121)'],
               [0.3, 'rgb(92,166,133)'],
               [0.4, 'rgb(182,202,175)'],
               [0.5, 'rgb(253,245,243)'],
               [0.6, 'rgb(230,183,162)'],
               [0.7, 'rgb(211,118,105)'],
               [0.8, 'rgb(174,63,95)'],
               [0.9, 'rgb(116,25,93)'],
               [1.0, 'rgb(51,13,53)']]
    
    # hover text for surface
    textz=[['x: '+'{:0.5f}'.format(x[i][j])+'<br>y: '+'{:0.5f}'.format(y[i][j])+
            '<br>z: '+'{:0.5f}'.format(z[i][j]) for j in range(z.shape[1])] for i in range(z.shape[0])]
    
    trace1= go.Surface(x=x, y=y, z=z,
                    colorscale=colorscale,
                    text=textz,
                    hoverinfo='text',
                    )


set layout
----------

.. code:: python

    axis = dict(showbackground=True, 
                backgroundcolor="rgb(230, 230,230)", 
                showgrid=False,    
                zeroline=False,  
                showline=False)
    
    ztickvals=range(-6,4)
    layout = go.Layout(title="Projections of a surface onto coordinate planes" , 
                    autosize=False,
                    width=700,
                    height=600,
                    scene=go.Scene(xaxis=go.XAxis(axis, range=[-3.5, 3.5]),
                                   yaxis=go.YAxis(axis, range=[-3.5, 3.5]),
                                   zaxis=go.ZAxis(axis , tickvals=ztickvals),
                                   aspectratio=dict(x=1,y=1,z=0.95)
                               )
    )


Discretization of each Plane
----------------------------

The surface projections will be plotted in the planes of equations
Z=np.min(z)-2, X=np.min(xx), respectively Y=np.min(yy).

.. code:: python

    z_offset=(np.min(z)-2)*np.ones(z.shape)#
    x_offset=np.min(xx)*np.ones(z.shape)
    y_offset=np.min(yy)*np.ones(z.shape)
    


Define color for each xyz plane
-------------------------------

Define the color functions and the color numpy arrays, C\_z, C\_x, C\_y,
corresponding to each plane: Define the 3-tuples of coordinates to be
displayed at hovering the mouse over the projections. The first two
coordinates give the position in the projection plane, whereas the third
one is used for assigning the color, just in the same way the coordinate
z is used for the z-direction projection.

.. code:: python

    proj_z=lambda x, y, z: z#projection in the z-direction
    colorsurfz=proj_z(x,y,z)
    proj_x=lambda x, y, z: x
    colorsurfx=proj_z(x,y,z)
    proj_y=lambda x, y, z: y
    colorsurfy=proj_z(x,y,z)
    
    textx=[['y: '+'{:0.5f}'.format(y[i][j])+'<br>z: '+'{:0.5f}'.format(z[i][j])+
            '<br>x: '+'{:0.5f}'.format(x[i][j]) for j in range(z.shape[1])]  for i in range(z.shape[0])]
    texty=[['x: '+'{:0.5f}'.format(x[i][j])+'<br>z: '+'{:0.5f}'.format(z[i][j]) +
            '<br>y: '+'{:0.5f}'.format(y[i][j]) for j in range(z.shape[1])] for i in range(z.shape[0])]  
    
    tracex = go.Surface(z=z,
                    x=x_offset,
                    y=y,
                    colorscale=colorscale,
                    showlegend=False,
                    showscale=False,
                    surfacecolor=colorsurfx,
                    text=textx,
                    hoverinfo='text'
                   )
    tracey = go.Surface(z=z,
                    x=x,
                    y=y_offset,
                    colorscale=colorscale,
                    showlegend=False,
                    showscale=False,
                    surfacecolor=colorsurfy,
                    text=texty,
                    hoverinfo='text'
                   )
    tracez = go.Surface(z=z_offset,
                    x=x,
                    y=y,
                    colorscale=colorscale,
                    showlegend=False,
                    showscale=False,
                    surfacecolor=colorsurfx,
                    text=textz,
                    hoverinfo='text'
                   )

finally, plot
-------------

.. code:: python

    data=go.Data([trace1, tracex, tracey, tracez])
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/528.embed" height="600px" width="700px"></iframe>



3d mesh
=======

https://plot.ly/python/3d-mesh/

Simple 3D Mesh example
----------------------

.. code:: python

    %%bash
    rm dataset.txt
    wget https://raw.githubusercontent.com/plotly/documentation/source-design-merge/_posts/python/3d-mesh/dataset.txt


.. parsed-literal::
    :class: myliteral

    --2016-09-29 01:01:40--  https://raw.githubusercontent.com/plotly/documentation/source-design-merge/_posts/python/3d-mesh/dataset.txt
    Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.32.133
    Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.32.133|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 2831 (2.8K) [text/plain]
    Saving to: ‘dataset.txt’
    
         0K ..                                                    100% 52.8M=0s
    
    2016-09-29 01:01:40 (52.8 MB/s) - ‘dataset.txt’ saved [2831/2831]
    


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import numpy as np
    
    pts=np.loadtxt('dataset.txt')
    x,y,z=zip(*pts)
    
    trace = go.Mesh3d(x=x,y=y,z=z,color='90EE90',opacity=0.50)
    py.iplot([trace])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1016.embed?share_key=v12dYfV5BFHupfhby8kB8a" height="525px" width="100%"></iframe>



3D Mesh example with Alphahull
------------------------------

Alphahull sets shape of mesh. If the value is -1 then Delaunay
triangulation is used. If >0 then the alpha-shape algorithm is used. The
default value is -1.

.. code:: python

    pts=np.loadtxt('dataset.txt')
    x,y,z=zip(*pts)
    
    trace = go.Mesh3d(x=x,y=y,z=z,
                       alphahull=5,
                       opacity=0.4,
                       color='00FFFF')
    py.iplot([trace])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1018.embed?share_key=x3AwCpnB1AH7nx3d0quzS6" height="525px" width="100%"></iframe>



Mesh Tetrahedron
----------------

.. code:: python

    data = go.Data([
        go.Mesh3d(x = [0, 1, 2, 0],y = [0, 0, 1, 2],z = [0, 2, 0, 1],
            colorbar = go.ColorBar(title='z'),
            colorscale = [['0', 'rgb(255, 0, 0)'], ['0.5', 'rgb(0, 255, 0)'], ['1', 'rgb(0, 0, 255)']],
            intensity = [0, 0.33, 0.66, 1],
            i = [0, 0, 0, 1],
            j = [1, 2, 3, 2],
            k = [2, 3, 1, 3],
            name = 'y',
            showscale = True
        )
    ])
    layout = go.Layout(xaxis=go.XAxis(title='x'),yaxis=go.YAxis(title='y'))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1020.embed?share_key=XWPnxX57HoLugvg5ODd6oF" height="525px" width="100%"></iframe>



Mesh Cube
---------

.. code:: python

    data = go.Data([
        go.Mesh3d(
            x = [0, 0, 1, 1, 0, 0, 1, 1],
            y = [0, 1, 1, 0, 0, 1, 1, 0],
            z = [0, 0, 0, 0, 1, 1, 1, 1],
            colorbar = go.ColorBar(title='z'),
            colorscale = [['0', 'rgb(255, 0, 255)'], ['0.5', 'rgb(0, 255, 0)'], ['1', 'rgb(0, 0, 255)']],
            intensity = [0, 0.142857142857143, 0.285714285714286, 0.428571428571429, 0.571428571428571, 0.714285714285714, 0.857142857142857, 1],
            i = [7, 0, 0, 0, 4, 4, 6, 6, 4, 0, 3, 2],
            j = [3, 4, 1, 2, 5, 6, 5, 2, 0, 1, 6, 3],
            k = [0, 7, 2, 3, 6, 7, 1, 1, 5, 5, 7, 6],
            name='y',
            showscale=True
        )
    ])
    layout = go.Layout(xaxis=go.XAxis(title='x'),yaxis=go.YAxis(title='y'))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1022.embed?share_key=8z9QD8YWiPkOkt3ztzF7pL" height="525px" width="100%"></iframe>



3d-wireframe plot
=================

https://plot.ly/python/3d-wireframe-plots/

.. code:: python

    # Creating the data
    x = np.linspace(-5, 5, 50)
    y = np.linspace(-5, 5, 50)
    xGrid, yGrid = np.meshgrid(y, x)
    R = np.sqrt(xGrid ** 2 + yGrid ** 2)
    z = np.sin(R)
    
    # Creating the plot
    lines = []
    line_marker = dict(color='#0066FF', width=2)
    for i, j, k in zip(xGrid, yGrid, z):
        lines.append(go.Scatter3d(x=i, y=j, z=k, mode='lines', line=line_marker))
    
    layout = go.Layout(
        title='Wireframe Plot',
        scene=dict(
            xaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            yaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            zaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            )
        ),
        showlegend=False,
    )
    fig = go.Figure(data=lines, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1024.embed?share_key=9Bi2wmZyKEQ8zuF7SFeS23" height="525px" width="100%"></iframe>



3d-surface plots
================

https://plot.ly/python/3d-surface-plots/

Topographical 3D Surface Plot
-----------------------------

.. code:: python

    import pandas as pd
    
    # Read data from a csv
    z_data = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/api_docs/mt_bruno_elevation.csv')
    print z_data.shape
    z_data.head(n=5)


.. parsed-literal::
    :class: myliteral

    (25, 25)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Unnamed: 0</th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
          <th>21</th>
          <th>22</th>
          <th>23</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0</td>
          <td>27.8099</td>
          <td>49.6194</td>
          <td>83.0807</td>
          <td>116.6632</td>
          <td>130.4140</td>
          <td>150.7206</td>
          <td>220.1871</td>
          <td>156.1536</td>
          <td>148.6416</td>
          <td>203.7845</td>
          <td>206.0386</td>
          <td>107.1618</td>
          <td>68.3697</td>
          <td>45.3359</td>
          <td>49.9614</td>
          <td>21.8928</td>
          <td>17.0255</td>
          <td>11.7432</td>
          <td>14.7523</td>
          <td>13.6671</td>
          <td>5.6776</td>
          <td>3.3123</td>
          <td>1.1565</td>
          <td>-0.1477</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1</td>
          <td>27.7197</td>
          <td>48.5502</td>
          <td>65.2137</td>
          <td>95.2767</td>
          <td>116.9964</td>
          <td>133.9056</td>
          <td>152.3412</td>
          <td>151.9340</td>
          <td>160.1139</td>
          <td>179.5327</td>
          <td>147.6184</td>
          <td>170.3943</td>
          <td>121.8194</td>
          <td>52.5854</td>
          <td>33.0887</td>
          <td>38.4097</td>
          <td>44.2484</td>
          <td>69.5786</td>
          <td>4.0194</td>
          <td>3.0500</td>
          <td>3.0397</td>
          <td>2.9961</td>
          <td>2.9680</td>
          <td>1.9996</td>
        </tr>
        <tr>
          <th>2</th>
          <td>2</td>
          <td>30.4267</td>
          <td>33.4775</td>
          <td>44.8095</td>
          <td>62.4749</td>
          <td>77.4352</td>
          <td>104.2153</td>
          <td>102.7393</td>
          <td>137.0004</td>
          <td>186.0706</td>
          <td>219.3173</td>
          <td>181.7615</td>
          <td>120.9154</td>
          <td>143.1835</td>
          <td>82.4050</td>
          <td>48.4713</td>
          <td>74.7146</td>
          <td>60.0909</td>
          <td>7.0735</td>
          <td>6.0899</td>
          <td>6.5374</td>
          <td>6.6661</td>
          <td>7.3070</td>
          <td>5.7368</td>
          <td>3.6256</td>
        </tr>
        <tr>
          <th>3</th>
          <td>3</td>
          <td>16.6655</td>
          <td>30.1086</td>
          <td>39.9695</td>
          <td>44.1223</td>
          <td>59.5751</td>
          <td>77.5693</td>
          <td>106.8925</td>
          <td>166.5539</td>
          <td>175.2381</td>
          <td>185.2815</td>
          <td>154.5056</td>
          <td>83.0433</td>
          <td>62.6173</td>
          <td>62.3317</td>
          <td>60.5592</td>
          <td>55.9212</td>
          <td>15.1728</td>
          <td>8.2483</td>
          <td>36.6809</td>
          <td>61.9341</td>
          <td>20.2687</td>
          <td>68.5882</td>
          <td>46.4981</td>
          <td>0.2360</td>
        </tr>
        <tr>
          <th>4</th>
          <td>4</td>
          <td>8.8156</td>
          <td>18.3516</td>
          <td>8.6583</td>
          <td>27.5859</td>
          <td>48.6269</td>
          <td>60.1801</td>
          <td>91.3286</td>
          <td>145.7109</td>
          <td>116.0653</td>
          <td>106.2662</td>
          <td>68.6945</td>
          <td>53.1060</td>
          <td>37.9280</td>
          <td>47.9594</td>
          <td>47.4269</td>
          <td>69.2073</td>
          <td>44.9547</td>
          <td>29.1720</td>
          <td>17.9167</td>
          <td>16.2552</td>
          <td>14.6556</td>
          <td>17.2605</td>
          <td>31.2224</td>
          <td>46.7170</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    data = [go.Surface(z=z_data.as_matrix())]
    layout = go.Layout(title='Mt Bruno Elevation',autosize=False,
                       width=500,height=500,margin=dict(l=65,r=50,b=65,t=90))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1026.embed?share_key=Ylco4LpkRrSybuUA4n23gF" height="500px" width="500px"></iframe>



Multiple 3D Surface Plots
-------------------------

.. code:: python

    # from plotly.graph_objs import Surface #<- could also go this route
    z1 = [
        [8.83,8.89,8.81,8.87,8.9,8.87],
        [8.89,8.94,8.85,8.94,8.96,8.92],
        [8.84,8.9,8.82,8.92,8.93,8.91],
        [8.79,8.85,8.79,8.9,8.94,8.92],
        [8.79,8.88,8.81,8.9,8.95,8.92],
        [8.8,8.82,8.78,8.91,8.94,8.92],
        [8.75,8.78,8.77,8.91,8.95,8.92],
        [8.8,8.8,8.77,8.91,8.95,8.94],
        [8.74,8.81,8.76,8.93,8.98,8.99],
        [8.89,8.99,8.92,9.1,9.13,9.11],
        [8.97,8.97,8.91,9.09,9.11,9.11],
        [9.04,9.08,9.05,9.25,9.28,9.27],
        [9,9.01,9,9.2,9.23,9.2],
        [8.99,8.99,8.98,9.18,9.2,9.19],
        [8.93,8.97,8.97,9.18,9.2,9.18]
    ]
    
    z2 = [[zij+1 for zij in zi] for zi in z1]
    z3 = [[zij-1 for zij in zi] for zi in z1]
    
    data = [dict(z=z1, type='surface'),
            dict(z=z2, showscale=False, opacity=0.9, type='surface'),
            dict(z=z3, showscale=False, opacity=0.9, type='surface')]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1028.embed?share_key=SGuwOrUZOpWLlc3DbByz4r" height="525px" width="100%"></iframe>



3d Parametric plots
===================

https://plot.ly/python/3d-parametric-plots/

Basic parametric plot
---------------------

.. code:: python

    s = np.linspace(0, 2 * np.pi, 240)
    t = np.linspace(0, np.pi, 240)
    tGrid, sGrid = np.meshgrid(s, t)
    
    r = 2 + np.sin(7 * sGrid + 5 * tGrid)  # r = 2 + sin(7s+5t)
    x = r * np.cos(sGrid) * np.sin(tGrid)  # x = r*cos(s)*sin(t)
    y = r * np.sin(sGrid) * np.sin(tGrid)  # y = r*sin(s)*sin(t)
    z = r * np.cos(tGrid)                  # z = r*cos(t)
    
    surface = go.Surface(x=x, y=y, z=z)
    data = [surface]
    
    layout = go.Layout(
        title='Parametric Plot',
        scene=dict(
            xaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            yaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            zaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            )
        )
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1030.embed?share_key=rhTIw6w7xrhkj0AjgBxFCZ" height="525px" width="100%"></iframe>



Parameteric Plot with Colorscale
--------------------------------

.. code:: python

    dphi, dtheta = np.pi / 250.0, np.pi / 250.0
    [phi, theta] = np.mgrid[0:np.pi + dphi * 1.5:dphi, 0:2 * np.pi +
                            dtheta * 1.5:dtheta]
    m0 = 4; m1 = 3; m2 = 2; m3 = 3; m4 = 6; m5 = 2; m6 = 6; m7 = 4;
    
    # Applying the parametric equation..
    r = (np.sin(m0 * phi) ** m1 + np.cos(m2 * phi) ** m3 +
         np.sin(m4 * theta) ** m5 + np.cos(m6 * theta) ** m7)
    x = r * np.sin(phi) * np.cos(theta)
    y = r * np.cos(phi)
    z = r * np.sin(phi) * np.sin(theta)
    
    
    surface = go.Surface(x=x, y=y, z=z, colorscale='Viridis')
    data = [surface]
    layout = go.Layout(
        title='Another Parametric Plot',
        scene=dict(
            xaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            yaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            ),
            zaxis=dict(
                gridcolor='rgb(255, 255, 255)',
                zerolinecolor='rgb(255, 255, 255)',
                showbackground=True,
                backgroundcolor='rgb(230, 230,230)'
            )
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1032.embed?share_key=LVW4THLUw5Ko5keNKo63ZV" height="525px" width="100%"></iframe>



Ribbon plots
============

https://plot.ly/python/ribbon-plots/

.. code:: python

    import urllib
    
    url = "https://raw.githubusercontent.com/plotly/datasets/master/spectral.csv"
    f = urllib.urlopen(url)
    spectra=np.loadtxt(f, delimiter=',')
    
    traces = []
    y_raw = spectra[:, 0] # wavelength
    sample_size = spectra.shape[1]-1 
    for i in range(1, sample_size):
        z_raw = spectra[:, i]
        x = []
        y = []
        z = []
        ci = int(255/sample_size*i) # ci = "color index"
        for j in range(0, len(z_raw)):
            z.append([z_raw[j], z_raw[j]])
            y.append([y_raw[j], y_raw[j]])
            x.append([i*2, i*2+1])
        traces.append(dict(
            z=z,x=x,y=y,showscale=False,type='surface',
            colorscale=[ [i, 'rgb(%d,%d,255)'%(ci, ci)] for i in np.arange(0,1.1,0.1) ],
        ))
    
    fig = { 'data':traces, 'layout':{'title':'Ribbon Plot'} }
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1036.embed?share_key=4Qr42w0CeE2bkbsKzfxnbH" height="525px" width="100%"></iframe>



