##########################################
plotly-layout-options-text-and-annotations
##########################################

https://plot.ly/python/text-and-annotations/

.. contents:: `Contents`
   :depth: 2
   :local:


Adding Text to Data in Line and Scatter Plots
=============================================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace1 = go.Scatter(x=[0, 1, 2],y=[1, 1, 1],
        mode='lines+markers+text',
        name='Lines, Markers and Text',
        text=['Text A', 'Text B', 'Text C'],
        textposition='top'
    )
    trace2 = go.Scatter(x=[0, 1, 2],y=[2, 2, 2],
        mode='markers+text',
        name='Markers and Text',
        text=['Text D', 'Text E', 'Text F'],
        textposition='bottom'
    )
    trace3 = go.Scatter(x=[0, 1, 2],y=[3, 3, 3],
        mode='lines+text',
        name='Lines and Text',
        text=['Text G', 'Text H', 'Text I'],
        textposition='bottom'
    )
    data = [trace1, trace2, trace3]
    layout = go.Layout(
        showlegend=False
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='text-chart-basic')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1123.embed?share_key=BBCySvKyu0LGfO0RlHVdBd" height="525px" width="100%"></iframe>



Adding Hover Text to Data in Line and Scatter Plots
===================================================

.. code:: python

    trace = go.Scatter(x=[0, 1, 2],y=[1, 3, 2],mode='markers',text=['Text A', 'Text B', 'Text C'])
    layout = go.Layout(title='Hover over the points to see the text')
    fig = go.Figure(data=[trace], layout=layout)
    py.iplot(fig, filename='hover-chart-basic')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1125.embed?share_key=roUXKJu9Ai3eV4AcQrA6Q3" height="525px" width="100%"></iframe>



Simple Annotation
=================

.. code:: python

    trace1 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 1, 3, 2, 4, 3, 4, 6, 5]
    )
    trace2 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 4, 5, 1, 2, 2, 3, 4, 2]
    )
    data = [trace1, trace2]

.. code:: python

    annotations=[
        dict(
            x=2,
            y=5,
            xref='x',
            yref='y',
            text='dict Text',
            showarrow=True,
            arrowhead=7,
            ax=0,
            ay=-80
        )
    ]

.. code:: python

    layout = go.Layout(annotations=annotations,showlegend=False)
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='simple-annotation')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1127.embed?share_key=fPSdMZKNfmB26nzwynt48R" height="525px" width="100%"></iframe>



Multiple Annotations
====================

.. code:: python

    trace1 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 1, 3, 2, 4, 3, 4, 6, 5]
    )
    trace2 = go.Scatter(
        x=[0, 1, 2, 3, 4, 5, 6, 7, 8],
        y=[0, 4, 5, 1, 2, 2, 3, 4, 2]
    )
    data = [trace1, trace2]

.. code:: python

    annot1= dict(
                x=2,
                y=5,
                xref='x',
                yref='y',
                text='dict Text',
                showarrow=True,
                arrowhead=7,
                ax=0,
                ay=-40
            )
    annot2 = dict(
                x=4,
                y=4,
                xref='x',
                yref='y',
                text='dict Text 2',
                showarrow=True,
                arrowhead=7,
                ax=0,
                ay=-40
            )
    layout = go.Layout(showlegend=False,annotations=[annot1,annot2])

.. code:: python

    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='multiple-annotation')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1129.embed?share_key=02AqA4Ijl07BYofoo2EEyQ" height="525px" width="100%"></iframe>



Custom Text Color and Styling
=============================

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2],y=[1, 1, 1],
        mode='lines+markers+text',
        name='Lines, Markers and Text',
        text=['Text A', 'Text B', 'Text C'],
        textposition='top right',
        textfont=dict(family='sans serif',size=18,color='#1f77b4')
    )
    trace2 = go.Scatter(x=[0, 1, 2],y=[2, 2, 2],
        mode='lines+markers+text',
        name='Lines and Text',
        text=['Text G', 'Text H', 'Text I'],
        textposition='bottom',
        textfont=dict(family='sans serif',size=18,color='#ff7f0e')
    )
    data = [trace1, trace2]
    layout = go.Layout(showlegend=False)
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='text-chart-styling')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1131.embed?share_key=0nTxApIqKfl6rdPaY2EdBY" height="525px" width="100%"></iframe>



Disabling Hover Text
====================

.. code:: python

    trace = dict(x=[1, 2, 3,],y=[10, 30, 15],type='scatter',name='first trace',
        hoverinfo='none')
    
    py.iplot([trace], filename='hoverinfo=none')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1133.embed?share_key=EGjzNq0vmmRkqMNODxOKJ2" height="525px" width="100%"></iframe>



Styling and Coloring Annotations
================================

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 1, 3, 2, 4, 3, 4, 6, 5])
    trace2 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 4, 5, 1, 2, 2, 3, 4, 2])
    data = [trace1, trace2]
    
    layout = go.Layout(
        showlegend=False,
        annotations=[
            dict(
                x=2,
                y=5,
                xref='x',
                yref='y',
                text='max=5',
                showarrow=True,
                font=dict(
                    family='Courier New, monospace',
                    size=16,
                    color='#ffffff'
                ),
                align='center',
                arrowhead=2,
                arrowsize=1,
                arrowwidth=2,
                arrowcolor='#636363',
                ax=20,
                ay=-30,
                bordercolor='#c7c7c7',
                borderwidth=2,
                borderpad=4,
                bgcolor='#ff7f0e',
                opacity=0.8
            )
        ]
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='style-annotation')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1135.embed?share_key=iK3yJHv8gSmW495UWAZISQ" height="525px" width="100%"></iframe>



Text Font as an Array - Styling Each Text Element
=================================================

.. code:: python

    trace = go.Scattergeo(
        lat=[45.5,43.4,49.13,51.1,53.34,45.24,44.64,48.25,49.89,50.45],
        lon=[-73.57,-79.24,-123.06,-114.1,-113.28,-75.43,-63.57,-123.21,-97.13,-104.6],
        marker={"color": ["#bebada","#fdb462","#fb8072","#d9d9d9","#bc80bd",
                          "#b3de69","#8dd3c7","#80b1d3","#fccde5","#ffffb3"],
                "line": {"width": 1},
                "size": 10
        },
        mode="markers+text",
        name="",
        text=["Montreal","Toronto","Vancouver","Calgary","Edmonton",
              "Ottawa","Halifax","Victoria","Winnepeg","Regina"],
        textfont={
            "color": ["#bebada","#fdb462","#fb8072","#d9d9d9","#bc80bd",
                      "#b3de69","#8dd3c7","#80b1d3","#fccde5","#ffffb3"],
            "family": ["Arial, sans-serif","Balto, sans-serif",
                       "Courier New, monospace","Droid Sans, sans-serif",
                       "Droid Serif, serif","Droid Sans Mono, sans-serif",
                       "Gravitas One, cursive","Old Standard TT, serif",
                       "Open Sans, sans-serif","PT Sans Narrow, sans-serif",
                       "Raleway, sans-serif","Times New Roman, Times, serif"],
            "size": [22,21,20,19,18,17,16,15,14,13]
        },
        textposition=["top center","middle left","top center","bottom center","top right",
                      "middle left","bottom right","bottom left","top right","top right"]
    )

.. code:: python

    layout={"title": "Canadian cities",
            "geo": {"lataxis": {"range": [40, 70]},
                    "lonaxis": {"range": [-130, -55]},
                    "scope": "north america"
        }
    }

.. code:: python

    fig = go.Figure(data=[trace],layout=layout)
    py.iplot(fig, filename='Canadian Cities')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1137.embed?share_key=PFWhtuGrtGACAmQ8NDawnb" height="525px" width="100%"></iframe>



Adding Annotations with xref and yref as Paper
==============================================

.. code:: python

    data = go.Data([go.Scatter(x=[1, 2, 3],y=[1, 2, 3],name='y')])

.. code:: python

    layout = go.Layout(
        height=550,width=1137,
        annotations=go.Annotations([
            go.Annotation(
                x=0.5004254919715793,
                y=-0.16191064079952971,
                showarrow=False,
                text='Custom x-axis title',
                xref='paper',
                yref='paper'
            ),
            go.Annotation(
                x=-0.04944728761514841,
                y=0.4714285714285711,
                showarrow=False,
                text='Custom y-axis title',
                textangle=-90,
                xref='paper',
                yref='paper'
            )
        ]),
        autosize=True,
        margin=go.Margin(b=100),
        title='Plot Title',
        xaxis=go.XAxis(autorange=False,type='linear',
            range=[-0.05674507980728292, -0.0527310420933204]),
        yaxis=go.YAxis(autorange=False,type='linear',
            range=[1.2876210047544652, 1.2977732997811402]),
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1139.embed?share_key=yyXyGAcxfTVPwDtFekESxG" height="550px" width="1137px"></iframe>



