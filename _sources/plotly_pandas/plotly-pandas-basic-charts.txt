##########################
plotly-pandas-basic-charts
##########################

Bunch of snippets from https://plot.ly/pandas/#basic-charts

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls
    from plotly.tools import FigureFactory as FF
    
    import cufflinks as cf
    from IPython.display import display

Pandas subplots
===============

https://plot.ly/pandas/subplots/

.. code:: python

    df=cf.datagen.lines(4,mode='abc')
    df[['c','d']]=df[['c','d']]*100
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>a</th>
          <th>b</th>
          <th>c</th>
          <th>d</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2015-01-01</th>
          <td>1.4185</td>
          <td>-0.8590</td>
          <td>-95.6941</td>
          <td>159.3834</td>
        </tr>
        <tr>
          <th>2015-01-02</th>
          <td>-0.0061</td>
          <td>0.4254</td>
          <td>-138.6309</td>
          <td>141.6736</td>
        </tr>
        <tr>
          <th>2015-01-03</th>
          <td>-1.3282</td>
          <td>1.2859</td>
          <td>-40.7113</td>
          <td>253.1951</td>
        </tr>
        <tr>
          <th>2015-01-04</th>
          <td>-0.5791</td>
          <td>1.2572</td>
          <td>2.6178</td>
          <td>138.7539</td>
        </tr>
        <tr>
          <th>2015-01-05</th>
          <td>-1.3365</td>
          <td>2.7184</td>
          <td>-65.2699</td>
          <td>319.4935</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    df.iplot(subplots=True, filename='pandas/cufflinks-subplots')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1097.embed" height="525px" width="100%"></iframe>



.. code:: python

    df.iplot(subplots=True, shape=(4, 1), filename='pandas/cufflinks-subplot rows')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1099.embed" height="525px" width="100%"></iframe>



Overlaying trace should be done in python
=========================================

Combining multiple traces into a single subplot, or mixing and matching
chart types, isn't as easy with cufflinks.

Subplots are entirely customizable with Plotly's native Python syntax:

.. code:: python

    fig = tls.make_subplots(rows=2, cols=1, shared_xaxes=True)
    
    for col in ['a', 'b']:
        fig.append_trace({'x': df.index, 'y': df[col], 'type': 'scatter', 'name': col}, 1, 1)
    
    for col in ['c', 'd']:
        fig.append_trace({'x': df.index, 'y': df[col], 'type': 'bar', 'name': col}, 2, 1)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]
    [ (2,1) x1,y2 ]
    


.. code:: python

    py.iplot(fig, filename='pandas/mixed-type subplots')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1101.embed?share_key=s2l2QipEvZ7iUTjFA2BlXI" height="525px" width="100%"></iframe>



Sync hover text
===============

This secondary subplot decouples the hover text from the charts in the
top pane and the charts in the bottom pane.

You can always customize your hover text, so that all four values are
always present:

.. code:: python

    hover_text = df.apply(lambda r: '<br>'.join(['{}: {}'.format(c, r[c]) 
                                                for c in df.columns]), axis=1)
    
    fig = tls.make_subplots(rows=2, cols=1, shared_xaxes=True)
    
    for col in ['a', 'b']:
        fig.append_trace({'x': df.index, 'y': df[col], 'type': 'scatter', 
                          'name': col, 'text': hover_text}, 1, 1)
    
    for col in ['c', 'd']:
        fig.append_trace({'x': df.index, 'y': df[col], 'type': 'bar', 
                          'name': col, 'text': hover_text}, 2, 1)
        
    py.iplot(fig, filename='pandas/mixed-type subplots with custom hover text')


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]
    [ (2,1) x1,y2 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1103.embed?share_key=CJSj5xR7Vtpj9ajgFd5FJt" height="525px" width="100%"></iframe>



Bubble charts pandas
====================

https://plot.ly/pandas/bubble-charts/

.. code:: python

    from IPython.display import display

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='pearl')
    
    url_path = 'http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt'
    df = pd.read_csv(url_path, sep='\t')
    df2007 = df[df.year==2007]
    display(df.head(2))
    
    df2007.iplot(kind='bubble', x='gdpPercap', y='lifeExp', size='pop', text='country',
                 xTitle='GDP per Capita', yTitle='Life Expectancy',
                 filename='cufflinks/simple-bubble-chart')



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>country</th>
          <th>year</th>
          <th>pop</th>
          <th>continent</th>
          <th>lifeExp</th>
          <th>gdpPercap</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Afghanistan</td>
          <td>1952</td>
          <td>8425333.0</td>
          <td>Asia</td>
          <td>28.801</td>
          <td>779.4453</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Afghanistan</td>
          <td>1957</td>
          <td>9240934.0</td>
          <td>Asia</td>
          <td>30.332</td>
          <td>820.8530</td>
        </tr>
      </tbody>
    </table>
    </div>




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/575.embed" height="525px" width="100%"></iframe>



Multiple axes
=============

https://plot.ly/pandas/multiple-axes/

Use secondary\_y
================

df.iplot(secondary\_y=['c', 'd'])

.. code:: python

    df=cf.datagen.lines(4,mode='abc')
    df[['c','d']]=df[['c','d']]*100
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>a</th>
          <th>b</th>
          <th>c</th>
          <th>d</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2015-01-01</th>
          <td>-1.0072</td>
          <td>-0.7349</td>
          <td>-100.1037</td>
          <td>-201.0138</td>
        </tr>
        <tr>
          <th>2015-01-02</th>
          <td>-2.0103</td>
          <td>-0.2378</td>
          <td>-260.8787</td>
          <td>-108.1904</td>
        </tr>
        <tr>
          <th>2015-01-03</th>
          <td>-1.9385</td>
          <td>-1.1977</td>
          <td>-226.2158</td>
          <td>69.1207</td>
        </tr>
        <tr>
          <th>2015-01-04</th>
          <td>-2.0443</td>
          <td>-2.0786</td>
          <td>-340.6845</td>
          <td>-32.9095</td>
        </tr>
        <tr>
          <th>2015-01-05</th>
          <td>-2.2652</td>
          <td>-2.6750</td>
          <td>-412.4810</td>
          <td>-123.8037</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    df.iplot(secondary_y=['c', 'd'], filename='pandas/secondary y')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1105.embed" height="525px" width="100%"></iframe>



SECONDARY Y AXIS WITH MULTIPLE CHART TYPES
==========================================

.. code:: python

    fig1 = df.iplot(columns=['a', 'b'], asFigure=True)
    fig2 = df.iplot(columns=['c', 'd'], kind='bar', secondary_y=['c', 'd'], asFigure=True)
    fig2['data'].extend(fig1['data'])
    py.iplot(fig2)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1107.embed?share_key=Jd1hl9e8n9YQ7Zei6hj2kC" height="525px" width="100%"></iframe>



Line-charts
===========

https://plot.ly/pandas/line-charts/

Cufflinks demo
==============

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='ggplot')
    
    df = cf.datagen.lines()
    
    df.iplot(kind='scatter', filename='cufflinks/cf-simple-line')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1109.embed" height="525px" width="100%"></iframe>



+++Set Line Color and Style in Cufflinks
========================================

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='ggplot')
    
    
    # Create a simple dataframe..
    df = cf.datagen.lines(3)
    
    colors = ['red', 'blue', 'black'] # Individual Line Color
    dashes = ['solid', 'dash', 'dashdot'] # Individual Line Style
    widths = [2, 4, 6] # Individual Line Width
    
    df.iplot(kind='scatter', mode='lines', colors=colors, dash=dashes, filename='cufflinks/line-style-and-color')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1113.embed" height="525px" width="100%"></iframe>



Updating cufflinks plots
========================

.. code:: python

    df=cf.datagen.lines(3,columns=['a','b','c'])
    
    figure = df.iplot(kind='scatter', asFigure=True)
    print figure.to_string()
    
    figure['layout']['yaxis1'].update({'title': 'Price', 'tickprefix': '$'})
    for i, trace in enumerate(figure['data']):
        trace['name'] = 'Trace {}'.format(i)
        
    py.iplot(figure, filename='cufflinks/customized-chart')


.. parsed-literal::
    :class: myliteral

    Figure(
        data=Data([
            Scatter(
                x=['2015-01-01', '2015-01-02', '2015-01-03', '2015-01-04', '..'  ],
                y=array([  0.24983679,  -0.52933995,   0.96435285,   2.31024654,..,
                line=Line(
                    color='rgba(226, 74, 51, 1.0)',
                    dash='solid',
                    width=1.3
                ),
                mode='lines',
                name='a',
                text=''
            ),
            Scatter(
                x=['2015-01-01', '2015-01-02', '2015-01-03', '2015-01-04', '..'  ],
                y=array([ -1.11044965,  -1.47619255,  -1.12161243,  -2.99457867,..,
                line=Line(
                    color='rgba(62, 111, 176, 1.0)',
                    dash='solid',
                    width=1.3
                ),
                mode='lines',
                name='b',
                text=''
            ),
            Scatter(
                x=['2015-01-01', '2015-01-02', '2015-01-03', '2015-01-04', '..'  ],
                y=array([-2.36339101, -2.9494829 , -3.58362241, -5.54814001, -4...,
                line=Line(
                    color='rgba(132, 118, 202, 1.0)',
                    dash='solid',
                    width=1.3
                ),
                mode='lines',
                name='c',
                text=''
            )
        ]),
        layout=Layout(
            legend=Legend(
                bgcolor='#FFFFFF',
                font=Font(
                    color='#666666'
                )
            ),
            paper_bgcolor='#FFFFFF',
            plot_bgcolor='#E5E5E5',
            titlefont=dict(
                color='#151516'
            ),
            xaxis1=XAxis(
                gridcolor='#F6F6F6',
                showgrid=True,
                tickfont=dict(
                    color='#666666'
                ),
                title='',
                titlefont=dict(
                    color='#666666'
                ),
                zerolinecolor='#F6F6F6'
            ),
            yaxis1=YAxis(
                gridcolor='#F6F6F6',
                showgrid=True,
                tickfont=dict(
                    color='#666666'
                ),
                title='',
                titlefont=dict(
                    color='#666666'
                ),
                zerolinecolor='#F6F6F6'
            )
        )
    )




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1115.embed?share_key=FMGOtBpQHvyilvaau9tWM8" height="525px" width="100%"></iframe>



Time series
===========

https://plot.ly/pandas/time-series/

Demo1
=====

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='ggplot')
    
    df = cf.datagen.lines()
    display(df.head())
    df.iplot(kind='scatter', filename='cufflinks/index-as-date')



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>WZL.UN</th>
          <th>FKX.JY</th>
          <th>KGR.NJ</th>
          <th>MPL.LG</th>
          <th>HHJ.ON</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2015-01-01</th>
          <td>0.9244</td>
          <td>-1.4351</td>
          <td>-0.2417</td>
          <td>-0.7722</td>
          <td>-0.8401</td>
        </tr>
        <tr>
          <th>2015-01-02</th>
          <td>0.9963</td>
          <td>-1.9634</td>
          <td>1.4587</td>
          <td>-1.4575</td>
          <td>0.2357</td>
        </tr>
        <tr>
          <th>2015-01-03</th>
          <td>1.4990</td>
          <td>-3.1501</td>
          <td>0.9024</td>
          <td>-3.3678</td>
          <td>0.0339</td>
        </tr>
        <tr>
          <th>2015-01-04</th>
          <td>2.1132</td>
          <td>-2.9164</td>
          <td>1.3444</td>
          <td>-2.1368</td>
          <td>-0.6079</td>
        </tr>
        <tr>
          <th>2015-01-05</th>
          <td>2.0338</td>
          <td>-2.8659</td>
          <td>0.2322</td>
          <td>-3.4510</td>
          <td>-1.5337</td>
        </tr>
      </tbody>
    </table>
    </div>




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1117.embed" height="525px" width="100%"></iframe>



Subplots
========

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='pearl')
    
    df=cf.datagen.lines(4)
    df.iplot(subplots=True, shape=(4,1), shared_xaxes=True, fill=True, filename='cufflinks/simple-subplots')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1119.embed" height="525px" width="100%"></iframe>



