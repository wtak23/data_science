###########
dendrograms
###########

https://plot.ly/python/dendrogram/


.. contents:: `Contents`
   :depth: 2
   :local:


Basic Dendrogram
================

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF
    import plotly.graph_objs as go
    
    import numpy as np
    
    X = np.random.rand(15, 15)
    dendro = FF.create_dendrogram(X)
    dendro['layout'].update({'width':800, 'height':500})
    py.iplot(dendro)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/486.embed" height="500px" width="800px"></iframe>



Set orientation and add labels
------------------------------

.. code:: python

    X = np.random.rand(10, 10)
    names = ['Jack', 'Oxana', 'John', 'Chelsea', 'Mark', 'Alice', 'Charlie', 'Rob', 'Lisa', 'Lily']
    fig = FF.create_dendrogram(X, orientation='left', labels=names)
    fig['layout'].update({'width':800, 'height':800})
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/484.embed" height="800px" width="800px"></iframe>



Plot a Dendrogram with a Heatmap
================================

get data
--------

.. code:: python

    import numpy as np
    from scipy.spatial.distance import pdist, squareform
    
    
    # get data
    data = np.genfromtxt("http://files.figshare.com/2133304/ExpRawData_E_TABM_84_A_AFFY_44.tab",
                         names=True,usecols=tuple(range(1,30)),dtype=float, delimiter="\t")
    data_array = data.view((np.float, len(data.dtype.names)))
    data_array = data_array.transpose()
    labels = data.dtype.names

.. code:: python

    print data_array
    print data_array.shape
    print labels


.. parsed-literal::
    :class: myliteral

    [[  6.3739767   5.986182    7.468118  ...,  11.745089   13.277803
       13.067169 ]
     [  6.4981704   4.861167    6.9479957 ...,  11.33983    13.031992
       12.7244425]
     [  6.271771    5.5666986   6.9435835 ...,  11.840397   13.332481
       13.051369 ]
     ..., 
     [  6.112102    5.0324726   6.93343   ...,  11.411251   13.084589
       12.768577 ]
     [  6.359853    6.12955     8.460821  ...,  10.814936   12.888793
       12.673793 ]
     [  6.010906    5.4538217   6.8208113 ...,  11.467866   13.08952    12.792053 ]]
    (29, 54674)
    ('r14', 'h45', 'c11', 'r11', 'c07', 'h42', 'r15', 'c01', 'h29', 'h17', 'h62', 'c15', 'c14', 'ol5', 'h18', 'oh1', 'r06', 'ob1', 'ol3', 'r07', 'r08', 'ol1', 'oh2', 'h39', 'ol2', 'h36', 'h32', 'ol4', 'h43')


Initialize figure by creating upper dendrogram
----------------------------------------------

.. code:: python

    figure = FF.create_dendrogram(data_array, orientation='bottom', labels=labels)
    
    for i in range(len(figure['data'])):
        figure['data'][i]['yaxis'] = 'y2'
    
    # Create Side Dendrogram
    dendro_side = FF.create_dendrogram(data_array, orientation='right')
    for i in range(len(dendro_side['data'])):
        dendro_side['data'][i]['xaxis'] = 'x2'
    
    # Add Side Dendrogram Data to Figure
    figure['data'].extend(dendro_side['data'])

.. code:: python

    print len(figure)
    print figure.keys()
    print figure['data'].__len__()
    print figure['layout'].__len__()


.. parsed-literal::
    :class: myliteral

    2
    ['data', 'layout']
    56
    7


.. code:: python

    from pprint import pprint
    pprint(figure['data'][:2])
    print "="*80
    pprint(figure['layout'])


.. parsed-literal::
    :class: myliteral

    [{'marker': {'color': 'rgb(61,153,112)'},
      'mode': 'lines',
      'type': 'scatter',
      'x': array([ 25.,  25.,  35.,  35.]),
      'xaxis': 'x',
      'y': array([  0.        ,  87.13411549,  87.13411549,   0.        ]),
      'yaxis': 'y2'},
     {'marker': {'color': 'rgb(61,153,112)'},
      'mode': 'lines',
      'type': 'scatter',
      'x': array([ 45.,  45.,  55.,  55.]),
      'xaxis': 'x',
      'y': array([  0.        ,  88.00085053,  88.00085053,   0.        ]),
      'yaxis': 'y2'}]
    ================================================================================
    {'autosize': False,
     'height': '100%',
     'hovermode': 'closest',
     'showlegend': False,
     'width': '100%',
     'xaxis': {'mirror': 'allticks',
               'rangemode': 'tozero',
               'showgrid': False,
               'showline': True,
               'showticklabels': True,
               'tickmode': 'array',
               'ticks': 'outside',
               'ticktext': array(['r07', 'r06', 'r11', 'r08', 'r14', 'r15', 'h43', 'h62', 'h18',
           'h17', 'h32', 'h42', 'h29', 'h45', 'h39', 'h36', 'c11', 'c07',
           'c01', 'c15', 'c14', 'ol5', 'ol3', 'ol4', 'ol1', 'ol2', 'ob1',
           'oh1', 'oh2'], 
          dtype='|S3'),
               'tickvals': [5.0,
                            15.0,
                            25.0,
                            35.0,
                            45.0,
                            55.0,
                            65.0,
                            75.0,
                            85.0,
                            95.0,
                            105.0,
                            115.0,
                            125.0,
                            135.0,
                            145.0,
                            155.0,
                            165.0,
                            175.0,
                            185.0,
                            195.0,
                            205.0,
                            215.0,
                            225.0,
                            235.0,
                            245.0,
                            255.0,
                            265.0,
                            275.0,
                            285.0],
               'type': 'linear',
               'zeroline': False},
     'yaxis': {'mirror': 'allticks',
               'rangemode': 'tozero',
               'showgrid': False,
               'showline': True,
               'showticklabels': True,
               'ticks': 'outside',
               'type': 'linear',
               'zeroline': False}}


Create heatmap
--------------

.. code:: python

    # Create Heatmap
    dendro_leaves = dendro_side['layout']['yaxis']['ticktext']
    dendro_leaves = list(map(int, dendro_leaves))
    data_dist = pdist(data_array)
    heat_data = squareform(data_dist)
    heat_data = heat_data[dendro_leaves,:]
    heat_data = heat_data[:,dendro_leaves]
    
    heatmap = go.Data([
        go.Heatmap(
            x = dendro_leaves, 
            y = dendro_leaves,
            z = heat_data,    
            colorscale = 'YIGnBu'
        )
    ])
    
    heatmap[0]['x'] = figure['layout']['xaxis']['tickvals']
    heatmap[0]['y'] = dendro_side['layout']['yaxis']['tickvals']
                                                     
    # Add Heatmap Data to Figure
    figure['data'].extend(go.Data(heatmap))

Edit layout
-----------

.. code:: python

    figure['layout'].update({'width':800, 'height':800,
                             'showlegend':False, 'hovermode': 'closest',
                             })
    # Edit xaxis
    figure['layout']['xaxis'].update({'domain': [.15, 1],
                                      'mirror': False,
                                      'showgrid': False,
                                      'showline': False,
                                      'zeroline': False,
                                      'ticks':""})
    # Edit xaxis2
    figure['layout'].update({'xaxis2': {'domain': [0, .15],
                                       'mirror': False,
                                       'showgrid': False,
                                       'showline': False,
                                       'zeroline': False,
                                       'showticklabels': False,
                                       'ticks':""}})
    
    # Edit yaxis
    figure['layout']['yaxis'].update({'domain': [0, .85],
                                      'mirror': False,
                                      'showgrid': False,
                                      'showline': False,
                                      'zeroline': False,
                                      'showticklabels': False,
                                      'ticks': ""})
    # Edit yaxis2
    figure['layout'].update({'yaxis2':{'domain':[.825, .975],
                                       'mirror': False,
                                       'showgrid': False,
                                       'showline': False,
                                       'zeroline': False,
                                       'showticklabels': False,
                                       'ticks':""}})

Plot!
-----

.. code:: python

    # Plot!
    py.iplot(figure)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/488.embed" height="800px" width="800px"></iframe>



