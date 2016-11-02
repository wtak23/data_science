######
tables
######

https://plot.ly/python/table/

.. contents:: `Contents`
   :depth: 2
   :local:


Simple table
============

.. code:: python

    import plotly.plotly as py
    from plotly.tools import FigureFactory as FF 
    
    data_matrix = [['Country', 'Year', 'Population'],
                   ['United States', 2000, 282200000],
                   ['Canada', 2000, 27790000],
                   ['United States', 2005, 295500000],
                   ['Canada', 2005, 32310000],
                   ['United States', 2010, 309000000],
                   ['Canada', 2010, 34000000]]
    
    from pprint import pprint
    pprint(data_matrix)
    table = FF.create_table(data_matrix)
    py.iplot(table)


.. parsed-literal::

    [['Country', 'Year', 'Population'],
     ['United States', 2000, 282200000],
     ['Canada', 2000, 27790000],
     ['United States', 2005, 295500000],
     ['Canada', 2005, 32310000],
     ['United States', 2010, 309000000],
     ['Canada', 2010, 34000000]]




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/430.embed" height="260px" width="100%"></iframe>



Add Links
=========

.. code:: python

    data_matrix = [['User', 'Language', 'Chart Type', '# of Views'],
                   ['<a href="https://plot.ly/~empet/folder/home">empet</a>',
                    '<a href="https://plot.ly/python/">Python</a>',
                    '<a href="https://plot.ly/~empet/8614/">Network Graph</a>',
                    298],
                   ['<a href="https://plot.ly/~Grondo/folder/home">Grondo</a>',
                    '<a href="https://plot.ly/matlab/">Matlab</a>',
                    '<a href="https://plot.ly/~Grondo/42/">Subplots</a>',
                    356],
                   ['<a href="https://plot.ly/~Dreamshot/folder/home">Dreamshot</a>',
                    '<a href="https://help.plot.ly/tutorials/">Web App</a>',
                    '<a href="https://plot.ly/~Dreamshot/6575/_2014-us-city-populations/">Bubble Map</a>',
                    262],
                   ['<a href="https://plot.ly/~FiveThirtyEight/folder/home">FiveThirtyEight</a>',
                    '<a href="https://help.plot.ly/tutorials/">Web App</a>',
                    '<a href="https://plot.ly/~FiveThirtyEight/30/">Scatter</a>',
                    692],
                   ['<a href="https://plot.ly/~cpsievert/folder/home">cpsievert</a>',
                    '<a href="https://plot.ly/r/">R</a>',
                    '<a href="https://plot.ly/~cpsievert/1130/">Surface</a>',
                    302]]
    
    pprint(data_matrix)
    table = FF.create_table(data_matrix)
    py.iplot(table, filename='linked_table')


.. parsed-literal::

    [['User', 'Language', 'Chart Type', '# of Views'],
     ['<a href="https://plot.ly/~empet/folder/home">empet</a>',
      '<a href="https://plot.ly/python/">Python</a>',
      '<a href="https://plot.ly/~empet/8614/">Network Graph</a>',
      298],
     ['<a href="https://plot.ly/~Grondo/folder/home">Grondo</a>',
      '<a href="https://plot.ly/matlab/">Matlab</a>',
      '<a href="https://plot.ly/~Grondo/42/">Subplots</a>',
      356],
     ['<a href="https://plot.ly/~Dreamshot/folder/home">Dreamshot</a>',
      '<a href="https://help.plot.ly/tutorials/">Web App</a>',
      '<a href="https://plot.ly/~Dreamshot/6575/_2014-us-city-populations/">Bubble Map</a>',
      262],
     ['<a href="https://plot.ly/~FiveThirtyEight/folder/home">FiveThirtyEight</a>',
      '<a href="https://help.plot.ly/tutorials/">Web App</a>',
      '<a href="https://plot.ly/~FiveThirtyEight/30/">Scatter</a>',
      692],
     ['<a href="https://plot.ly/~cpsievert/folder/home">cpsievert</a>',
      '<a href="https://plot.ly/r/">R</a>',
      '<a href="https://plot.ly/~cpsievert/1130/">Surface</a>',
      302]]




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/432.embed" height="230px" width="100%"></iframe>



Use LaTeX
=========

.. code:: python

    data_matrix = [['Name', 'Equation'],
                   ['Pythagorean Theorem', '$a^{2}+b^{2}=c^{2}$'],
                   ['Euler\'s Formula', '$F-E+V=2$'],
                   ['The Origin of Complex Numbers', '$i^{2}=-1$'],
                   ['Einstein\'s Theory of Relativity', '$E=m c^{2}$']]
    
    table = FF.create_table(data_matrix)
    py.iplot(table, filename='latex_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/434.embed" height="200px" width="100%"></iframe>



Use a Panda's Dataframe
=======================

.. code:: python

    import pandas as pd
    
    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv')
    df_sample = df[100:120]
    
    table = FF.create_table(df_sample)
    py.iplot(table, filename='pandas_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/436.embed" height="680px" width="100%"></iframe>



Include and Index Column
========================

.. code:: python

    from datetime import date
    # import pandas.io.data as web
    from pandas_datareader import data as web
    di = web.DataReader("aapl", 'yahoo', date(2009, 1, 1), date(2009, 3, 1))
    
    # Converting timestamp to date 
    di["Date1"] = di.index.date
    di.set_index("Date1", drop=True, inplace=True)
    
    table = FF.create_table(di, index=True, index_title='Date')
    py.iplot(table, filename='index_table_pd')



.. parsed-literal::

    /home/takanori/.local/lib/python2.7/site-packages/pandas_datareader/base.py:47: FutureWarning:
    
    pandas.core.common.is_number is deprecated. import from the public API: pandas.api.types.is_number instead
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/438.embed" height="1250px" width="100%"></iframe>



Custom Table Colors
===================

A custom colorscale should be a ``list[list]:``
``[[0, 'Header_Color'],[.5, 'Odd_Row_Color'],[1, 'Even_Row_Color']]``

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv')
    df_sample = df[400:410]
    
    colorscale = [[0, '#4d004c'],[.5, '#f2e5ff'],[1, '#ffffff']]
    
    table = FF.create_table(df_sample, colorscale=colorscale)
    py.iplot(table, filename='color_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/440.embed" height="380px" width="100%"></iframe>



Custom Font Colors
==================

.. code:: python

    text = [['Team', 'Rank'], ['A', 1], ['B', 2], ['C', 3], ['D', 4], ['E', 5], ['F', 6]]
    
    colorscale = [[0, '#272D31'],[.5, '#ffffff'],[1, '#ffffff']]
    font=['#FCFCFC', '#00EE00', '#008B00', '#004F00', '#660000', '#CD0000', '#FF3030']
    
    table = FF.create_table(text, colorscale=colorscale, font_colors=font)
    table.layout.width=250
    py.iplot(table, filename='font_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/442.embed" height="260px" width="250px"></iframe>



Change Font Size
================

.. code:: python

    data_matrix = [['Country', 'Year', 'Population'],
                   ['United States', 2000, 282200000],
                   ['Canada', 2000, 27790000],
                   ['United States', 2005, 295500000],
                   ['Canada', 2005, 32310000],
                   ['United States', 2010, 309000000],
                   ['Canada', 2010, 34000000]]
    
    table = FF.create_table(data_matrix, index=True)
    
    # Make text size larger
    for i in range(len(table.layout.annotations)):
        table.layout.annotations[i].font.size = 20
    
    py.iplot(table, filename='index_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/444.embed" height="260px" width="100%"></iframe>



Tables with Graphs
==================

Horizontal subplots
===================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    from plotly.tools import FigureFactory as FF
    
    # Add table data
    table_data = [['Team', 'Wins', 'Losses', 'Ties'],
                  ['Montréal<br>Canadiens', 18, 4, 0],
                  ['Dallas Stars', 18, 5, 0],
                  ['NY Rangers', 16, 5, 0], 
                  ['Boston<br>Bruins', 13, 8, 0],
                  ['Chicago<br>Blackhawks', 13, 8, 0],
                  ['LA Kings', 13, 8, 0],
                  ['Ottawa<br>Senators', 12, 5, 0]]
    # Initialize a figure with FF.create_table(table_data)
    figure = FF.create_table(table_data, height_constant=60)
    
    # Add graph data
    teams = ['Montréal Canadiens', 'Dallas Stars', 'NY Rangers',
             'Boston Bruins', 'Chicago Blackhawks', 'LA Kings', 'Ottawa Senators']
    GFPG = [3.54, 3.48, 3.0, 3.27, 2.83, 2.45, 3.18]
    GAPG = [2.17, 2.57, 2.0, 2.91, 2.57, 2.14, 2.77]
    # Make traces for graph
    trace1 = go.Scatter(x=teams, y=GFPG,
                        marker=dict(color='#0099ff'),
                        name='Goals For<br>Per Game',
                        xaxis='x2', yaxis='y2')
    trace2 = go.Scatter(x=teams, y=GAPG,
                        marker=dict(color='#404040'),
                        name='Goals Against<br>Per Game',
                        xaxis='x2', yaxis='y2')
    
    # Add trace data to figure
    figure['data'].extend(go.Data([trace1, trace2]))
    
    # Edit layout for subplots
    figure.layout.xaxis.update({'domain': [0, .5]})
    figure.layout.xaxis2.update({'domain': [0.6, 1.]})
    # The graph's yaxis MUST BE anchored to the graph's xaxis
    figure.layout.yaxis2.update({'anchor': 'x2'})
    figure.layout.yaxis2.update({'title': 'Goals'})
    # Update the margins to add a title and see graph x-labels. 
    figure.layout.margin.update({'t':50, 'b':100})
    figure.layout.update({'title': '2016 Hockey Stats'})
    
    # Plot!
    py.iplot(figure, filename='subplot_table')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/446.embed" height="530px" width="100%"></iframe>



Vertical subplots
=================

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    from plotly.tools import FigureFactory as FF
    
    # Add table data
    table_data = [['Team', 'Wins', 'Losses', 'Ties'],
                  ['Montréal<br>Canadiens', 18, 4, 0],
                  ['Dallas Stars', 18, 5, 0],
                  ['NY Rangers', 16, 5, 0], 
                  ['Boston<br>Bruins', 13, 8, 0],
                  ['Chicago<br>Blackhawks', 13, 8, 0],
                  ['Ottawa<br>Senators', 12, 5, 0]]
    # Initialize a figure with FF.create_table(table_data)
    figure = FF.create_table(table_data, height_constant=60)
    
    # Add graph data
    teams = ['Montréal Canadiens', 'Dallas Stars', 'NY Rangers',
             'Boston Bruins', 'Chicago Blackhawks', 'Ottawa Senators']
    GFPG = [3.54, 3.48, 3.0, 3.27, 2.83, 3.18]
    GAPG = [2.17, 2.57, 2.0, 2.91, 2.57, 2.77]
    # Make traces for graph
    trace1 = go.Bar(x=teams, y=GFPG, xaxis='x2', yaxis='y2',
                    marker=dict(color='#0099ff'),
                    name='Goals For<br>Per Game')
    trace2 = go.Bar(x=teams, y=GAPG, xaxis='x2', yaxis='y2',
                    marker=dict(color='#404040'),
                    name='Goals Against<br>Per Game')
    
    # Add trace data to figure
    figure['data'].extend(go.Data([trace1, trace2]))
    
    # Edit layout for subplots
    figure.layout.yaxis.update({'domain': [0, .45]})
    figure.layout.yaxis2.update({'domain': [.6, 1]})
    # The graph's yaxis2 MUST BE anchored to the graph's xaxis2 and vice versa
    figure.layout.yaxis2.update({'anchor': 'x2'})
    figure.layout.xaxis2.update({'anchor': 'y2'})
    figure.layout.yaxis2.update({'title': 'Goals'})
    # Update the margins to add a title and see graph x-labels. 
    figure.layout.margin.update({'t':75, 'l':50})
    figure.layout.update({'title': '2016 Hockey Stats'})
    # Update the height because adding a graph vertically will interact with
    # the plot height calculated for the table
    figure.layout.update({'height':800})
    
    # Plot!
    py.iplot(figure, filename='subplot_table_vertical')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/448.embed" height="800px" width="100%"></iframe>



