#####################
plotly-layout-options
#####################

https://plot.ly/python/#layout-options

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls

Adding logos
============

https://plot.ly/python/logos/

Touch ``layout['images']`` attribute

.. code:: python

    fig = py.get_figure('https://plot.ly/~Dreamshot/8152/')
    fig.layout.images = [dict(
            source="https://raw.githubusercontent.com/cldougl/plot_images/add_r_img/accuweather.jpeg",
            #source="http://mgoblog.com/sites/mgoblog.com/files/mgoharbaugh.png",
            xref="paper", yref="paper",
            x=0.1, y=1.05,
            sizex=0.4, sizey=0.4,
            xanchor="center", yanchor="bottom"
          )]
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/910.embed?share_key=djYaKTDcNcsBkD4w5eavru" height="600px" width="800px"></iframe>



.. code:: python

    fig = py.get_figure('https://plot.ly/~Dreamshot/8160/')
    fig.layout.images = [dict(
            #source="https://raw.githubusercontent.com/cldougl/plot_images/add_r_img/bleacherreport.png",
            #source="http://mgoblog.com/sites/mgoblog.com/files/mgoharbaugh.png",
            source="http://wtak23.github.io/img/sparse-brain.png",
            xref="paper", yref="paper",
            x=1.125, y=0.65,
            sizex=0.5, sizey=0.5,
            xanchor="center", yanchor="top"
          )]
    fig.layout.update(dict(width=800,height=500))
    py.iplot(fig)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/946.embed?share_key=8VVelHTv2ZwHyK2HtOTJoP" height="500px" width="800px"></iframe>



Add background image
====================

control ``opacity`` in ``layout['image']`` attribute

https://plot.ly/python/images/

.. code:: python

    import numpy as np
    trace1= go.Scatter(x=[0,0.5,1,2,2.2],y=[1.23,2.5,0.42,3,1])
    layout= go.Layout(images= [dict(
                      source= "https://images.plot.ly/language-icons/api-home/python-logo.png",
                      xref= "x",yref= "y",
                      x= 0,y= 3,
                      sizex= 2,sizey= 2,
                      sizing= "stretch",
                      opacity= 0.5,
                      layer= "below")])
    fig=go.Figure(data=[trace1],layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/950.embed?share_key=c9kEcP0AaqPFlyndTxts96" height="525px" width="100%"></iframe>



.. code:: python

    trace1= go.Scatter(x=[0,0.5,1,2,2.2],y=[1.23,2.5,0.42,3,1])
    layout= go.Layout( images= [
          dict(
            source= "https://images.plot.ly/language-icons/api-home/python-logo.png",
            xref= "paper",yref= "paper",x= 0,y= 1,sizex= 0.2,sizey= 0.2,
            xanchor= "right",yanchor= "bottom"
          ),
          dict(
            source= "https://images.plot.ly/language-icons/api-home/js-logo.png",
            xref="x",yref= "y",x= 1.5,y= 2,sizex= 1,sizey= 1,
            xanchor= "right",yanchor= "bottom"
          ),
          dict(
            source= "https://images.plot.ly/language-icons/api-home/r-logo.png",
            xref= "x",yref= "y",x= 2,y= 1,sizex= 0.3,sizey= 0.5,
            sizing= "stretch",opacity= 0.4,layer= "below"
            ),
          dict(
            source= "https://images.plot.ly/language-icons/api-home/matlab-logo.png",
            xref= "x",yref= "paper",x= 3,y= 0,sizex= 0.5,sizey= 1,
            opacity= 1,xanchor= "right",yanchor="middle"
          )])
    fig=go.Figure(data=[trace1],layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/952.embed?share_key=LlL82je4SAenm8iuh4EIbO" height="525px" width="100%"></iframe>



Latex
=====

https://plot.ly/python/LaTeX/

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3, 4],y=[1, 4, 9, 16],
        name='$\\alpha_{1c} = 352 \\pm 11 \\text{ km s}^{-1}$')
    trace2 = go.Scatter(x=[1, 2, 3, 4],y=[0.5, 2, 4.5, 8],
        name='$\\beta_{1c} = 25 \\pm 11 \\text{ km s}^{-1}$')
    data = [trace1, trace2]
    layout = go.Layout(
        xaxis=dict(title='$\\sqrt{(n_\\text{c}(t|{T_\\text{early}}))}$'),
        yaxis=dict(title='$d, r \\text{ (solar radius)}$')
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/972.embed?share_key=lsP3HFHQxOQurKfTrgBZj5" height="525px" width="100%"></iframe>



Text and Font Styling (global font properties)
==============================================

https://plot.ly/python/font/

The ``layout.font`` property (dict)

.. code:: python

    font=dict(family='Courier New, monospace', size=18, color='#7f7f7f')

.. code:: python

    data = [go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 1, 2, 3, 4, 5, 6, 7, 8])]
    layout = go.Layout(
        title='Global Font',
        font=dict(family='Courier New, monospace', size=18, color='#7f7f7f')
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/974.embed?share_key=TiQIzSFQPkhNWrX6alsj3G" height="525px" width="100%"></iframe>



Setting graph size
==================

https://plot.ly/python/setting-graph-size/

Control ``layout.margin`` and ``layout.width, layout.height`` properties

.. code:: python

    layout = go.Layout(
        autosize=False,width=500,height=500,
        margin=go.Margin(l=50,r=50,b=100,t=100,pad=4),
        paper_bgcolor='#7f7f7f',
        plot_bgcolor='#c7c7c7'
    )

.. code:: python

    data = [go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 1, 2, 3, 4, 5, 6, 7, 8])]
    layout = go.Layout(
        autosize=False,width=500,height=500,
        margin=go.Margin(l=50,r=50,b=100,t=100,pad=4),
        paper_bgcolor='#7f7f7f',
        plot_bgcolor='#c7c7c7'
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/976.embed?share_key=aP20FcrJENYYesbGEYto1s" height="500px" width="500px"></iframe>



Setting the Title, Legend Entries, and Axis Titles
==================================================

https://plot.ly/python/figure-labels/

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 1, 2, 3, 4, 5, 6, 7, 8],name='Name of Trace 1')
    trace2 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[1, 0, 3, 2, 5, 4, 7, 6, 8],name='Name of Trace 2')
    data = [trace1, trace2]
    layout = go.Layout(title='Plot Title',
        xaxis=dict(title='x Axis',
                   titlefont=dict(family='Courier New, monospace',size=18,color='#7f7f7f')),
        yaxis=dict(title='y Axis',
                   titlefont=dict(family='Courier New, monospace',size=18,color='#7f7f7f'))
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/978.embed?share_key=khgSS9Ur4OLvaGkoFNV1Zm" height="525px" width="100%"></iframe>



Multiple Axes
=============

https://plot.ly/python/multiple-axes/

Two y-axes
==========

``layout['yaxis2]'`` attribute

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3],y=[40, 50, 60],name='yaxis data')
    trace2 = go.Scatter(x=[2, 3, 4],y=[4, 5, 6],name='yaxis2 data',yaxis='y2')
    data = [trace1, trace2]
    layout = go.Layout(
        title='Double Y Axis Example',
        yaxis=dict(title='yaxis title'),
        yaxis2=dict(title='yaxis2 title',titlefont=dict(color='rgb(148, 103, 189)'),
                    tickfont=dict(color='rgb(148, 103, 189)'),overlaying='y',side='right')
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/980.embed?share_key=suOZ9P6mANTYnDibxVq4vR" height="525px" width="100%"></iframe>



Multiple y-axes
===============

Keep adding more and more ``layout['yaxis_i]'`` attribute

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3],y=[4, 5, 6],name='yaxis1 data')
    trace2 = go.Scatter(x=[2, 3, 4],y=[40, 50, 60],name='yaxis2 data',yaxis='y2')
    trace3 = go.Scatter(x=[4, 5, 6],y=[40000, 50000, 60000],name='yaxis3 data',yaxis='y3')
    trace4 = go.Scatter(x=[5, 6, 7],y=[400000, 500000, 600000],name='yaxis4 data',yaxis='y4')
    data = [trace1, trace2, trace3, trace4]
    
    layout = go.Layout(
        title='multiple y-axes example',width=800,
        xaxis=dict(domain=[0.3, 0.7]),
        yaxis=dict(title='yaxis title',titlefont=dict(color='#1f77b4'),
                   tickfont=dict(color='#1f77b4')),
        yaxis2=dict(title='yaxis2 title',titlefont=dict(color='#ff7f0e'),
            tickfont=dict(color='#ff7f0e'),anchor='free',overlaying='y',
            side='left',position=0.15),
        yaxis3=dict(title='yaxis4 title',titlefont=dict(color='#d62728'),
            tickfont=dict(color='#d62728'),anchor='x',
            overlaying='y',side='right'),
        yaxis4=dict(title='yaxis5 title',titlefont=dict(color='#9467bd'),
            tickfont=dict(color='#9467bd'),anchor='free',
            overlaying='y',side='right',position=0.85
        )
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/982.embed?share_key=Hlux45Sr0HwFUsfJw8Q4NK" height="525px" width="800px"></iframe>



Inset Plots
===========

https://plot.ly/python/insets/

.. code:: python

    trace1 = go.Scatter(x=[1, 2, 3],y=[4, 3, 2])
    trace2 = go.Scatter(x=[20, 30, 40],y=[30, 40, 50],xaxis='x2',yaxis='y2')
    data = [trace1, trace2]
    
    layout = go.Layout(xaxis2=dict(domain=[0.6, 0.95],anchor='y2'),
                       yaxis2=dict(domain=[0.6, 0.95],anchor='x2'))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/984.embed?share_key=pn2vgdNRZ9n6hUEB8x0bKf" height="525px" width="100%"></iframe>



