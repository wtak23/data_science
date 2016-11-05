############################
plotly-layout-options-axes3d
############################

https://plot.ly/python/3d-axes/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import numpy as np


Range of Axes
=============

.. code:: python

    scene = dict(xaxis = dict(nticks=4, range = [-100,100]),
                 yaxis = dict(nticks=4, range = [-50,100]),
                 zaxis = dict(nticks=4, range = [-100,100]))
    margin = dict(r=20, l=10,b=10, t=10)

.. code:: python

    N = 70
    trace1 = go.Mesh3d(x=(70*np.random.randn(N)),
                       y=(55*np.random.randn(N)),
                       z=(40*np.random.randn(N)),
                       opacity=0.5,color='rgba(244,22,100,0.6)')
    
    layout = go.Layout(scene=scene,width=700,margin=margin)
    fig = go.Figure(data=[trace1], layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1006.embed?share_key=FhoFO5mPPMbx6CZf8rIDXy" height="525px" width="700px"></iframe>



Set Axes Title
==============

.. code:: python

    N = 50
    trace1 = go.Mesh3d(x=(60*np.random.randn(N)),
                       y=(25*np.random.randn(N)),
                       z=(40*np.random.randn(N)),
                       opacity=0.5,color='yellow')
    trace2 = go.Mesh3d(x=(70*np.random.randn(N)),
                       y=(55*np.random.randn(N)),
                       z=(30*np.random.randn(N)),
                       opacity=0.5,color='pink')
    data=[trace1,trace2]
    
    scene = dict(xaxis = dict(title='X AXIS TITLE'),
                 yaxis = dict(title='Y AXIS TITLE'),
                 zaxis = dict(title='Z AXIS TITLE'))

.. code:: python

    layout = go.Layout(scene=scene,width=700,margin=dict(r=20, b=10,l=10, t=10))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1010.embed?share_key=tmauYuDiNoHDGzdqMbvjyr" height="525px" width="700px"></iframe>



Ticks Formatting
================

.. code:: python

    N = 50
    trace1 = go.Mesh3d(x=(60*np.random.randn(N)),
                       y=(25*np.random.randn(N)),
                       z=(40*np.random.randn(N)),
                       opacity=0.5,color='rgba(100,22,200,0.5)')
    
    xaxis = dict(ticktext= ['TICKS','MESH','PLOTLY','PYTHON'],tickvals= [0,50,75,-50])
    yaxis = dict(nticks=5, ticksuffix='#',
                 tickfont=dict(color='green',size=12,family='Old Standard TT, serif'))
    zaxis = dict(nticks=4, ticks='outside',tick0=0, tickwidth=4)
    
    scene = dict(xaxis=xaxis, yaxis=yaxis, zaxis=zaxis)
    
    
    layout = go.Layout(scene=scene,width=700,margin=dict(r=10, l=10,b=10, t=10))
    fig = go.Figure(data=[trace1], layout=layout)
    py.iplot(fig)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1012.embed?share_key=HXet5uGHMw1p8V5azFp0Sj" height="525px" width="700px"></iframe>



Background color and grid color
===============================

.. code:: python

    scene = dict(xaxis = dict(backgroundcolor="rgb(200, 200, 230)",
                              gridcolor="rgb(255, 255, 255)",
                              showbackground=True,
                              zerolinecolor="rgb(255, 255, 255)"),
                 yaxis = dict(backgroundcolor="rgb(230, 200,230)",
                              gridcolor="rgb(255, 255, 255)",
                              showbackground=True,
                              zerolinecolor="rgb(255, 255, 255)"),
                 zaxis = dict(backgroundcolor="rgb(230, 230,200)",
                              gridcolor="rgb(255, 255, 255)",
                              showbackground=True,
                              zerolinecolor="rgb(255, 255, 255)"))

.. code:: python

    layout = go.Layout(scene=scene,width=700,margin=dict(r=10, l=10,b=10, t=10))
    fig = go.Figure(data=[trace1], layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1014.embed?share_key=GXEF7wcNcxe65dxthE30ge" height="525px" width="700px"></iframe>


