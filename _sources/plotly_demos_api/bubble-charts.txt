#############
bubble-charts
#############

https://plot.ly/python/bubble-charts/

.. contents:: `Contents`
   :depth: 2
   :local:


note
====

-  mostly a practice with ``go.Scatter`` object
-  layer.marker takes most of the space in the go.Scatter object
-  I like the use of background color in the last example

.. code:: python

    layout go.Layout(
        paper_bgcolor='rgb(243, 243, 243)',
        plot_bgcolor='rgb(243, 243, 243)',
    )

Simple bubblecharts
===================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    
    trace0 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[10, 11, 12, 13],
        mode='markers',
        marker=dict(
            size=[40, 60, 80, 100],
        )
    )
    
    data = [trace0]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/376.embed" height="525px" width="100%"></iframe>



Setting Marker Size and Color
=============================

.. code:: python

    trace0 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[10, 11, 12, 13],
        mode='markers',
        marker=dict(
            color=['rgb(93, 164, 214)', 'rgb(255, 144, 14)',
                   'rgb(44, 160, 101)', 'rgb(255, 65, 54)'],
            opacity=[1, 0.8, 0.6, 0.4],
            size=[40, 60, 80, 100],
        )
    )
    
    data = [trace0]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/378.embed" height="525px" width="100%"></iframe>



Hover Text with Bubble Charts
=============================

.. code:: python

    trace0 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[10, 11, 12, 13],
        text=['A<br>size: 40', 'B<br>size: 60', 'C<br>size: 80', 'D<br>size: 100'],
        mode='markers',
        marker=dict(
            color=['rgb(93, 164, 214)', 'rgb(255, 144, 14)',  'rgb(44, 160, 101)', 'rgb(255, 65, 54)'],
            size=[40, 60, 80, 100],
        )
    )
    
    data = [trace0]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/382.embed" height="525px" width="100%"></iframe>



Scaling the Size of Bubble Charts
=================================

.. code:: python

    trace0 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[10, 11, 12, 13],
        text=['A</br>size: 40</br>default', 'B</br>size: 60</br>default', 'C</br>size: 80</br>default', 'D</br>size: 100</br>default'],
        mode='markers',
        marker=dict(
            size=[400, 600, 800, 1000],
            sizemode='area',
        )
    )
    trace1 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[14, 15, 16, 17],
        text=['A</br>size: 40</br>sixeref: 0.2', 'B</br>size: 60</br>sixeref: 0.2', 'C</br>size: 80</br>sixeref: 0.2', 'D</br>size: 100</br>sixeref: 0.2'],
        mode='markers',
        marker=dict(
            size=[400, 600, 800, 1000],
            sizeref=2,
            sizemode='area',
        )
    )
    trace2 = go.Scatter(
        x=[1, 2, 3, 4],
        y=[20, 21, 22, 23],
        text=['A</br>size: 40</br>sixeref: 2', 
              'B</br>size: 60</br>sixeref: 2', 
              'C</br>size: 80</br>sixeref: 2', 
              'D</br>size: 100</br>sixeref: 2'],
        mode='markers',
        marker=dict(
            size=[400, 600, 800, 1000],
            sizeref=0.2,
            sizemode='area',
        )
    )
    
    data = [trace0, trace1, trace2]
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/384.embed" height="525px" width="100%"></iframe>



Bubble Charts with Colorscale
=============================

.. code:: python

    data = [
        {
            'x': [1, 3.2, 5.4, 7.6, 9.8, 12.5],
            'y': [1, 3.2, 5.4, 7.6, 9.8, 12.5],
            'mode': 'markers',
            'marker': {
                'color': [120, 125, 130, 135, 140, 145],
                'size': [15, 30, 55, 70, 90, 110],
                'showscale': True
            }
        }
    ]
    
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/388.embed" height="525px" width="100%"></iframe>



Categorical Bubble Charts
=========================

.. code:: python

    import pandas as pd
    import math
    
    data = pd.read_csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")
    df_2007 = data[data['year']==2007]
    df_2007 = df_2007.sort_values(['continent', 'country'])
    slope = 2.666051223553066e-05
    hover_text = []
    bubble_size = []
    
    for index, row in df_2007.iterrows():
        hover_text.append(('Country: {country}<br>'+
                          'Life Expectancy: {lifeExp}<br>'+
                          'GDP per capita: {gdp}<br>'+
                          'Population: {pop}<br>'+
                          'Year: {year}').format(country=row['country'],
                                                lifeExp=row['lifeExp'],
                                                gdp=row['gdpPercap'],
                                                pop=row['pop'],
                                                year=row['year']))
        bubble_size.append(math.sqrt(row['pop']*slope))
    
    df_2007['text'] = hover_text
    df_2007['size'] = bubble_size
    
    trace0 = go.Scatter(
        x=df_2007['gdpPercap'][df_2007['continent'] == 'Africa'],
        y=df_2007['lifeExp'][df_2007['continent'] == 'Africa'],
        mode='markers',
        name='Africa',
        text=df_2007['text'][df_2007['continent'] == 'Africa'],
        marker=dict(
            symbol='circle',
            sizemode='diameter',
            sizeref=0.85,
            size=df_2007['size'][df_2007['continent'] == 'Africa'],
            line=dict(
                width=2
            ),
        )
    )
    trace1 = go.Scatter(
        x=df_2007['gdpPercap'][df_2007['continent'] == 'Americas'],
        y=df_2007['lifeExp'][df_2007['continent'] == 'Americas'],
        mode='markers',
        name='Americas',
        text=df_2007['text'][df_2007['continent'] == 'Americas'],
        marker=dict(
            sizemode='diameter',
            sizeref=0.85,
            size=df_2007['size'][df_2007['continent'] == 'Americas'],
            line=dict(
                width=2
            ),
        )
    )
    trace2 = go.Scatter(
        x=df_2007['gdpPercap'][df_2007['continent'] == 'Asia'],
        y=df_2007['lifeExp'][df_2007['continent'] == 'Asia'],
        mode='markers',
        name='Asia',
        text=df_2007['text'][df_2007['continent'] == 'Asia'],
        marker=dict(
            sizemode='diameter',
            sizeref=0.85,
            size=df_2007['size'][df_2007['continent'] == 'Asia'],
            line=dict(
                width=2
            ),
        )
    )
    trace3 = go.Scatter(
        x=df_2007['gdpPercap'][df_2007['continent'] == 'Europe'],
        y=df_2007['lifeExp'][df_2007['continent'] == 'Europe'],
        mode='markers',
        name='Europe',
        text=df_2007['text'][df_2007['continent'] == 'Europe'],
        marker=dict(
            sizemode='diameter',
            sizeref=0.85,
            size=df_2007['size'][df_2007['continent'] == 'Europe'],
            line=dict(
                width=2
            ),
        )
    )
    trace4 = go.Scatter(
        x=df_2007['gdpPercap'][df_2007['continent'] == 'Oceania'],
        y=df_2007['lifeExp'][df_2007['continent'] == 'Oceania'],
        mode='markers',
        name='Oceania',
        text=df_2007['text'][df_2007['continent'] == 'Oceania'],
        marker=dict(
            sizemode='diameter',
            sizeref=0.85,
            size=df_2007['size'][df_2007['continent'] == 'Oceania'],
            line=dict(
                width=2
            ),
        )
    )
    
    data = [trace0, trace1, trace2, trace3, trace4]
    layout = go.Layout(
        title='Life Expectancy v. Per Capita GDP, 2007',
        xaxis=dict(
            title='GDP per capita (2000 dollars)',
            gridcolor='rgb(255, 255, 255)',
            range=[2.003297660701705, 5.191505530708712],
            type='log',
            zerolinewidth=1,
            ticklen=5,
            gridwidth=2,
        ),
        yaxis=dict(
            title='Life Expectancy (years)',
            gridcolor='rgb(255, 255, 255)',
            range=[36.12621671352166, 91.72921793264332],
            zerolinewidth=1,
            ticklen=5,
            gridwidth=2,
        ),
        paper_bgcolor='rgb(243, 243, 243)',
        plot_bgcolor='rgb(243, 243, 243)',
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/390.embed" height="525px" width="100%"></iframe>



