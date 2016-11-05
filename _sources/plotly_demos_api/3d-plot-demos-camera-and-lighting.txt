#################################
3d-plot-demos-camera-and-lighting
#################################

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    import pandas as pd

3d camera controls
==================

https://plot.ly/python/3d-camera-controls/

.. code:: python

    z_data = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/api_docs/mt_bruno_elevation.csv')
    
    data = [go.Surface(z=z_data.as_matrix())]
    layout = go.Layout(title='Mt Bruno Elevation',autosize=False,width=600,height=600,
        margin=dict(l=65,r=50,b=65,t=90))
    fig = go.Figure(data=data, layout=layout)

Default parameters: eye=(x=1.25, y=1.25, z=1.25)
------------------------------------------------

The camera position is determined by three vectors: **up, center, eye**.

The **up vector** determines the up direction on the page. - The default
is ``(x=0,y=0,z=1)(x=0,y=0,z=1)``, that is, the z-axis points up.

The **center vector** determines the translation about the center of the
scene. - By default, there is no translation: the center vector is
``(x=0,y=0,z=0)(x=0,y=0,z=0)``.

The **eye vector** determines the camera view point about the origin. -
The default is ``(x=1.25,y=1.25,z=1.25)(x=1.25,y=1.25,z=1.25)``.

.. code:: python

    name = 'default'
    
    up=dict(x=0, y=0, z=1)
    center=dict(x=0, y=0, z=0)
    eye=dict(x=1.25, y=1.25, z=1.25)
    
    camera = dict(up=up,center=center,eye=eye)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1040.embed?share_key=yzH2IuqIDfQQzQarqd9PwH" height="600px" width="600px"></iframe>



Lower the View Point: eye=(x=2, y=2, z=0.1)
-------------------------------------------

.. code:: python

    # name = 'default'
    # up=dict(x=0, y=0, z=1)
    # center=dict(x=0, y=0, z=0)
    # eye=dict(x=1.25, y=1.25, z=1.25)
    eye=dict(x=2, y=2, z=0.1) #<- update!
    
    name = 'eye = (x:2, y:2, z:0.1)'
    camera = dict(up=up,center=center,eye=eye)
    
    fig['layout'].update(scene=dict(camera=camera),title=name)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1042.embed?share_key=cXI1sUW6MF4kl2kd3genVW" height="600px" width="600px"></iframe>



X-Z plane: eye=(x=0.1, y=2.5, z=0.1)
------------------------------------

.. code:: python

    eye=dict(x=0.1, y=2.5, z=0.1) #<- update!
    
    name = 'eye = (x:0.1, y:2.5, z:0.1)'
    camera = dict(up=up,center=center,eye=eye)
    
    fig['layout'].update(scene=dict(camera=camera),title=name)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1044.embed?share_key=JKfjDIrD1Lq4PCNewrBoP3" height="600px" width="600px"></iframe>



Y-Z plane: eye=(x=2.5, y=0.1, z=0.1)
------------------------------------

.. code:: python

    eye=dict(x=2.5, y=0.1, z=0.1) #<- update!
    
    name = 'eye = (x:2.5, y:0.1, z:0.1)'
    camera = dict(up=up,center=center,eye=eye)
    
    fig['layout'].update(scene=dict(camera=camera),title=name)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1046.embed?share_key=MFLmYzJ26QTpykR5rwA3FS" height="600px" width="600px"></iframe>



View from Above - eye=(x=0.1, y=0.1, z=2.5)
-------------------------------------------

.. code:: python

    eye=dict(x=0.1, y=0.1, z=2.5) #<- update!
    
    name = 'eye = (x:0.1, y:0.1, z:2.5)'
    camera = dict(up=up,center=center,eye=eye)
    
    fig['layout'].update(scene=dict(camera=camera),title=name)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1048.embed?share_key=GCrkXbzYo7VXfvlzlYell5" height="600px" width="600px"></iframe>



Zooming In: eye=(x=0.1, y=0.1, z=1)
-----------------------------------

(reduce eye vector norm)

.. code:: python

    eye=dict(x=0.1, y=0.1, z=1) #<- update!
    
    name = 'eye = (x:0.1, y:0.1, z:1)'
    camera = dict(up=up,center=center,eye=eye)
    
    fig['layout'].update(scene=dict(camera=camera),title=name)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1052.embed?share_key=Fj6gTpdLGGuVcv2IkObMwN" height="600px" width="600px"></iframe>



3d surface lighting
===================

https://plot.ly/python/3d-surface-lighting/

There are **five lighting effects** available in Plotly:

1. ambient,
2. diffuse,
3. roughness,
4. specular, and
5. fresnel.

Now, we will add some lightning effects to the above trace, one by one
and see their effects:

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls
    import numpy as np


.. code:: python

    x = np.linspace(-np.pi, np.pi, 100)
    y = np.linspace(-np.pi, np.pi, 100)
    
    Y, X = np.meshgrid(x, y)
    Z1 = np.cos(X)*np.sin(Y)
    Z2 = 2 + np.cos(X)*np.sin(Y)
    
    trace1 = go.Surface(z=Z1, colorscale='Viridis')
    
    py.iplot([trace1])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1054.embed?share_key=Ha9fntccE0zqai2IVbyeHO" height="525px" width="100%"></iframe>



Ambient
-------

Ambient stands for the default light in the room. - We can set it in a
range from 0 to 1. - If we set it to zero, the trace appears dark. - The
default Ambient value for plot is 0.8.

.. code:: python

    fig = tls.make_subplots(rows=1, cols=2,specs=[[{'is_3d': True},{'is_3d': True} ]])
    
    
    trace1 = go.Surface(z=Z1, colorscale='Viridis', lighting=dict(ambient=0.2))
    trace2 = go.Surface(z=Z2, colorscale='Viridis',showscale=False, lighting=dict(ambient=0.9))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    
    py.iplot(fig)



.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1056.embed?share_key=cQzf2tWvrVBGRJP51LbFPw" height="525px" width="100%"></iframe>



Roughness
---------

-  Roughness in a lighting plot refers to **amount of light scattered**.
-  The value of roughness can range from 0 to 1 (by default value is
   0.5).

.. code:: python

    fig = tls.make_subplots(rows=1, cols=2,specs=[[{'is_3d': True},{'is_3d': True} ]])
    trace1 = go.Surface(z=Z1, colorscale='Viridis', lighting=dict(roughness=0.1))
    trace2 = go.Surface(z=Z2, colorscale='Viridis',showscale=False, lighting=dict(roughness=0.9))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1058.embed?share_key=aY1fG1hfh1lxPyvEQ5hErm" height="525px" width="100%"></iframe>



Diffuse
-------

By using Diffuse the **light is reflected at many angles** rather than
just one angle. - The value ranges from 0 to 1 (default value is 0.8).

.. code:: python

    fig = tls.make_subplots(rows=1, cols=2,specs=[[{'is_3d': True},{'is_3d': True} ]])
    trace1 = go.Surface(z=Z1, colorscale='Viridis', lighting=dict(diffuse=0.1))
    trace2 = go.Surface(z=Z2, colorscale='Viridis',showscale=False,lighting=dict(diffuse=0.9))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    py.iplot(fig)



.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1060.embed?share_key=TWK5KDTw3oCfHCQ5zDCgCO" height="525px" width="100%"></iframe>



Fresnel
-------

Fresnel attribute is used to **wash light over area of plot**. - The
value can range from 0 to 5 (default value is 0.2).

.. code:: python

    fig = tls.make_subplots(rows=1, cols=2,specs=[[{'is_3d': True},{'is_3d': True} ]])
    trace1 = go.Surface(z=Z1, colorscale='Viridis', lighting=dict(fresnel=0.1))
    trace2 = go.Surface(z=Z2, colorscale='Viridis',showscale=False, lighting=dict(fresnel=4.5))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1062.embed?share_key=PEKyUPbrSnWscyysuH50Vk" height="525px" width="100%"></iframe>



Specular
--------

Specular attribute induces bright spots of lighting in your plot. - It's
value range from 0 to 2 (default value is 0.05).

.. code:: python

    fig = tls.make_subplots(rows=1, cols=2,specs=[[{'is_3d': True},{'is_3d': True} ]])
    trace1 = go.Surface(z=Z1, colorscale='Viridis', lighting=dict(specular=0.2))
    trace2 = go.Surface(z=Z2, colorscale='Viridis',showscale=False ,lighting=dict(specular=2))
    
    fig.append_trace(trace1, 1, 1)
    fig.append_trace(trace2, 1, 2)
    py.iplot(fig)



.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) scene1 ]  [ (1,2) scene2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1064.embed?share_key=pDcVB8DxwHaSu2Z8bMTdi4" height="525px" width="100%"></iframe>



Combined effects
================

The effects can also be added in a combined manner as follows:

.. code:: python

    lighting_effects = dict(ambient=0.4, diffuse=0.5, roughness = 0.9, specular=0.6, fresnel=0.2)
    trace = go.Surface(z=Z1, colorscale='Viridis', lighting=lighting_effects)
    
    py.iplot([trace])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1066.embed?share_key=gROc7WZLwCYZKDszDvEABI" height="525px" width="100%"></iframe>



