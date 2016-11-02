################################
plotly-pandas-statistical-charts
################################

.. contents:: `Contents`
   :depth: 2
   :local:


2d density plots
================

https://plot.ly/pandas/2d-density-plots/

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import pandas as pd
    import numpy as np
    import colorlover as cl
    from scipy.stats import gaussian_kde
    
    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/iris.csv')
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>SepalLength</th>
          <th>SepalWidth</th>
          <th>PetalLength</th>
          <th>PetalWidth</th>
          <th>Name</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>5.1</td>
          <td>3.5</td>
          <td>1.4</td>
          <td>0.2</td>
          <td>Iris-setosa</td>
        </tr>
        <tr>
          <th>1</th>
          <td>4.9</td>
          <td>3.0</td>
          <td>1.4</td>
          <td>0.2</td>
          <td>Iris-setosa</td>
        </tr>
        <tr>
          <th>2</th>
          <td>4.7</td>
          <td>3.2</td>
          <td>1.3</td>
          <td>0.2</td>
          <td>Iris-setosa</td>
        </tr>
        <tr>
          <th>3</th>
          <td>4.6</td>
          <td>3.1</td>
          <td>1.5</td>
          <td>0.2</td>
          <td>Iris-setosa</td>
        </tr>
        <tr>
          <th>4</th>
          <td>5.0</td>
          <td>3.6</td>
          <td>1.4</td>
          <td>0.2</td>
          <td>Iris-setosa</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    scl = cl.scales['9']['seq']['Blues']
    colorscale = [ [ float(i)/float(len(scl)-1), scl[i] ] for i in range(len(scl)) ]
    colorscale
    
    def kde_scipy(x, x_grid, bandwidth=0.2 ):
        kde = gaussian_kde(x, bw_method=bandwidth / x.std(ddof=1) )
        return kde.evaluate(x_grid)
    
    x_grid = np.linspace(df['SepalWidth'].min(), df['SepalWidth'].max(), 100)
    y_grid = np.linspace(df['PetalLength'].min(), df['PetalLength'].max(), 100)

.. code:: python

    trace1 = go.Histogram2dContour(
        x=df['SepalWidth'],y=df['PetalLength'],
        name='density',
        ncontours=20,
        colorscale=colorscale,
        showscale=False
    )
    trace2 = go.Histogram(
        x=df['SepalWidth'],
        name='x density',
        yaxis='y2',
        histnorm='probability density',
        marker=dict(color='rgb(217, 217, 217)'),
        nbinsx=25
    )
    trace2s = go.Scatter(
        x=x_grid,
        y=kde_scipy( df['SepalWidth'].as_matrix(), x_grid ),
        yaxis='y2',
        line = dict( color='rgb(31, 119, 180)' ),
        fill='tonexty',
    )
    trace3 = go.Histogram(
        y=df['PetalLength'],
        name='y density',
        xaxis='x2',
        histnorm='probability density',
        marker=dict(color='rgb(217, 217, 217)'),
        nbinsy=50
    )
    trace3s = go.Scatter(
        y=y_grid,
        x=kde_scipy( df['PetalLength'].as_matrix(), y_grid ),
        xaxis='x2',
        line = dict( color='rgb(31, 119, 180)' ),
        fill='tonextx',
    )
    
    data = [trace1, trace2, trace2s, trace3, trace3s]

.. code:: python

    layout = go.Layout(
        showlegend=False,
        autosize=False,
        width=700,
        height=700,
        hovermode='closest',
        bargap=0,
        xaxis=dict(domain=[0, 0.746], linewidth=2, linecolor='#444', title='SepalWidth',
                   showgrid=False, zeroline=False, ticks='', showline=True, mirror=True),
        yaxis=dict(domain=[0, 0.746],linewidth=2,linecolor='#444', title='PetalLength',
                   showgrid=False, zeroline=False, ticks='', showline=True, mirror=True),
        xaxis2=dict(domain=[0.75, 1], showgrid=False, zeroline=False, ticks='',
                    showticklabels=False ),
        yaxis2=dict(domain=[0.75, 1], showgrid=False, zeroline=False, ticks='',
                    showticklabels=False ),
    )
    
    fig = go.Figure(data=data, layout=layout)
    
    # IPython notebook
    # py.iplot(fig, filename='pandas-2d-density-plot', height=700)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1163.embed?share_key=vYevLfD8XnVeqcrhvSSKV1" height="700px" width="700px"></iframe>



2D Histogram
============

https://plot.ly/pandas/2D-Histogram/

.. code:: python

    import pandas as pd
    import numpy as np
    import plotly.plotly as py
    import colorlover as cl
    import plotly.graph_objs as go
    
    scl = cl.scales['9']['seq']['Blues']
    colorscale = [ [ float(i)/float(len(scl)-1), scl[i] ] for i in range(len(scl)) ]
    colorscale
    
    N = 500
    mean, cov = [0, 2], [(1, .5), (.5, 1)]
    x, y = np.random.multivariate_normal(mean, cov, size=50).T
    df = pd.DataFrame({'x': x, 'y': y})
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>x</th>
          <th>y</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.4034</td>
          <td>2.3244</td>
        </tr>
        <tr>
          <th>1</th>
          <td>-0.3997</td>
          <td>0.7038</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.9448</td>
          <td>0.8596</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1.8877</td>
          <td>2.5425</td>
        </tr>
        <tr>
          <th>4</th>
          <td>-0.0036</td>
          <td>2.0887</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    trace = go.Histogram2dContour(x=df['x'], y=df['y'],colorscale=colorscale,
                                  line=go.Line(width=0))
    data = [trace]

.. code:: python

    axis_template = dict(
        ticks='',
        showgrid=False,
        zeroline=False,
        showline=True,
        mirror=True,
        linewidth=2,
        linecolor='#444',
    )
    
    layout=go.Layout(xaxis=axis_template,
                     yaxis=axis_template,
                     width=700,
                     height=750,
                     autosize=False,
                     hovermode='closest',
                     title='2d Histogram in Pandas')
    
    fig = go.Figure(data=data, layout=layout)
    
    # IPython notebook
    # py.iplot(fig, filename='pandas-2d-histogram', height=750)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1165.embed?share_key=5nxmpJZznuCtI7y2E21jQR" height="750px" width="700px"></iframe>



Histograms
==========

https://plot.ly/pandas/histograms/

Basic Histogram in Pandas
-------------------------

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import pandas as pd
    import numpy as np # for generating random data
    
    N = 500
    x = np.linspace(0, 1, N)
    y = np.random.randn(N)
    df = pd.DataFrame({'x': x, 'y': y})
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>x</th>
          <th>y</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.000</td>
          <td>1.0367</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.002</td>
          <td>0.2627</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.004</td>
          <td>-1.1100</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.006</td>
          <td>0.7940</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.008</td>
          <td>-0.8815</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    data = [go.Histogram(y=df['y'])]
    
    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1167.embed?share_key=njRIqU61JGffxCDr3a6Jzq" height="525px" width="100%"></iframe>



Multiple histograms in Pandas (cufflinks)
=========================================

.. code:: python

    import plotly.plotly as py
    import cufflinks as cf
    import pandas as pd
    import numpy as np
    
    cf.set_config_file(offline=False, world_readable=True, theme='pearl')
    
    df = pd.DataFrame({'a': np.random.randn(1000) + 1,
                       'b': np.random.randn(1000),
                       'c': np.random.randn(1000) - 1})
    df.head(2)
    
    df.iplot(kind='histogram', filename='cufflinks/multiple-histograms')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1169.embed" height="525px" width="100%"></iframe>



Histograms binning and normalization in Pandas
==============================================

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='pearl')
    
    df = pd.DataFrame({'a': np.random.randn(1000) + 1,
                       'b': np.random.randn(1000),
                       'c': np.random.randn(1000) - 1})
    df.head(2)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>a</th>
          <th>b</th>
          <th>c</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.2845</td>
          <td>0.4508</td>
          <td>-3.9424</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.4592</td>
          <td>-0.8170</td>
          <td>-0.8843</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    df.iplot(kind='histogram', barmode='stack', bins=100, histnorm='probability', filename='cufflinks/histogram-binning')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1171.embed" height="525px" width="100%"></iframe>



Histograms subplots in Pandas
=============================

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='pearl')
    
    df = pd.DataFrame({'a': np.random.randn(1000) + 1,
                       'b': np.random.randn(1000),
                       'c': np.random.randn(1000) - 1})
    df.iplot(kind='histogram', subplots=True, shape=(3, 1), filename='cufflinks/histogram-subplots')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1173.embed" height="525px" width="100%"></iframe>



Box-plots
=========

https://plot.ly/pandas/box-plots/

Basic Box Plot
==============

.. code:: python

    import string
    N = 100
    y_vals = {}
    for letter in list(string.ascii_uppercase):
         y_vals[letter] = np.random.randn(N)+(3*np.random.randn())
            
    df = pd.DataFrame(y_vals)
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>A</th>
          <th>B</th>
          <th>C</th>
          <th>D</th>
          <th>E</th>
          <th>F</th>
          <th>G</th>
          <th>H</th>
          <th>I</th>
          <th>J</th>
          <th>K</th>
          <th>L</th>
          <th>M</th>
          <th>N</th>
          <th>O</th>
          <th>P</th>
          <th>Q</th>
          <th>R</th>
          <th>S</th>
          <th>T</th>
          <th>U</th>
          <th>V</th>
          <th>W</th>
          <th>X</th>
          <th>Y</th>
          <th>Z</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>-5.0425</td>
          <td>-3.3699</td>
          <td>6.8538</td>
          <td>-1.6171</td>
          <td>2.3114</td>
          <td>-1.7960</td>
          <td>-0.8201</td>
          <td>-0.5109</td>
          <td>-1.1053</td>
          <td>-1.9840</td>
          <td>1.2007</td>
          <td>1.4807</td>
          <td>5.8134</td>
          <td>1.1985</td>
          <td>1.0682</td>
          <td>4.6990</td>
          <td>2.3529</td>
          <td>3.9780</td>
          <td>-0.6910</td>
          <td>-1.2608</td>
          <td>7.4461</td>
          <td>-0.4487</td>
          <td>-6.1362</td>
          <td>0.2122</td>
          <td>0.5586</td>
          <td>-0.3180</td>
        </tr>
        <tr>
          <th>1</th>
          <td>-6.1272</td>
          <td>-4.5187</td>
          <td>4.3415</td>
          <td>-1.2513</td>
          <td>3.3162</td>
          <td>-2.9938</td>
          <td>-1.7715</td>
          <td>0.1643</td>
          <td>-0.0869</td>
          <td>0.1496</td>
          <td>1.1740</td>
          <td>2.7700</td>
          <td>4.7558</td>
          <td>1.2114</td>
          <td>-0.9190</td>
          <td>4.4184</td>
          <td>2.0542</td>
          <td>3.0037</td>
          <td>-1.1659</td>
          <td>-0.1671</td>
          <td>8.8519</td>
          <td>0.3663</td>
          <td>-2.2363</td>
          <td>-0.6336</td>
          <td>1.2677</td>
          <td>0.7169</td>
        </tr>
        <tr>
          <th>2</th>
          <td>-5.2781</td>
          <td>-3.7951</td>
          <td>5.0198</td>
          <td>-2.3342</td>
          <td>-0.0082</td>
          <td>-2.4174</td>
          <td>-1.2025</td>
          <td>1.6470</td>
          <td>-1.4537</td>
          <td>2.5710</td>
          <td>3.2047</td>
          <td>1.5570</td>
          <td>3.6528</td>
          <td>1.8075</td>
          <td>2.5396</td>
          <td>2.4110</td>
          <td>1.6519</td>
          <td>4.0454</td>
          <td>-1.5429</td>
          <td>1.0027</td>
          <td>8.7016</td>
          <td>1.1991</td>
          <td>-3.2211</td>
          <td>-1.6636</td>
          <td>0.2411</td>
          <td>0.5025</td>
        </tr>
        <tr>
          <th>3</th>
          <td>-7.2169</td>
          <td>-3.1105</td>
          <td>6.7607</td>
          <td>-1.6218</td>
          <td>0.9417</td>
          <td>-2.4659</td>
          <td>-1.6418</td>
          <td>1.9088</td>
          <td>-0.6713</td>
          <td>-0.9763</td>
          <td>2.6385</td>
          <td>3.0004</td>
          <td>4.8361</td>
          <td>0.5799</td>
          <td>2.0742</td>
          <td>3.7853</td>
          <td>1.4448</td>
          <td>3.0956</td>
          <td>-2.6838</td>
          <td>0.0165</td>
          <td>8.8431</td>
          <td>-0.6923</td>
          <td>-3.3014</td>
          <td>-2.6403</td>
          <td>1.8809</td>
          <td>0.3870</td>
        </tr>
        <tr>
          <th>4</th>
          <td>-6.8792</td>
          <td>-2.4280</td>
          <td>4.9365</td>
          <td>-0.9765</td>
          <td>2.2800</td>
          <td>-3.4812</td>
          <td>-1.8046</td>
          <td>0.7628</td>
          <td>0.9362</td>
          <td>-0.5460</td>
          <td>1.7721</td>
          <td>1.1082</td>
          <td>4.4289</td>
          <td>1.1012</td>
          <td>1.5376</td>
          <td>5.1927</td>
          <td>3.1119</td>
          <td>2.9087</td>
          <td>-0.1830</td>
          <td>-0.5429</td>
          <td>7.3782</td>
          <td>-0.4956</td>
          <td>-3.6373</td>
          <td>-0.6911</td>
          <td>0.7708</td>
          <td>-0.8772</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    data = []
    
    for col in df.columns:
        print col,
        data.append(  go.Box( y=df[col], name=col, showlegend=False ) )
    
    # add line connecting each mean
    data.append( go.Scatter( x = df.columns, y = df.mean(), mode='lines', name='mean' ) )
    
    # IPython notebook
    py.iplot(data, filename='pandas-box-plot')


.. parsed-literal::

    A B C D E F G H I J K L M N O P Q R S T U V W X Y Z



.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1086.embed?share_key=PThoG37kcSfh8A7f3hhxrX" height="525px" width="100%"></iframe>



.. parsed-literal::

    


Use cufflinks
=============

.. code:: python

    cf.set_config_file(offline=False, world_readable=True, theme='ggplot')
    
    df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])
    df.iplot(kind='box', filename='cufflinks/box-plots')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1175.embed" height="525px" width="100%"></iframe>



Error bars
==========

https://plot.ly/pandas/error-bars/

Discrete, fixed error bars
--------------------------

Assign ``error_y`` in the ``Scatter`` object

.. code:: python

    error_y=dict(
        type='percent',
        value=df['10 Min Sampled Avg'].std(),
        thickness=1,
        width=0,
        color='#444',
        opacity=0.8
    )
    data = [go.Scatter(x=df['Time'],y=df['10 Min Sampled Avg'],mode='lines',error_y=error_y)]

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/wind_speed_laurel_nebraska.csv')
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>10 Min Std Dev</th>
          <th>Time</th>
          <th>10 Min Sampled Avg</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2.73</td>
          <td>2001-06-11 11:00</td>
          <td>22.3</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1.98</td>
          <td>2001-06-11 11:10</td>
          <td>23.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1.87</td>
          <td>2001-06-11 11:20</td>
          <td>23.3</td>
        </tr>
        <tr>
          <th>3</th>
          <td>2.03</td>
          <td>2001-06-11 11:30</td>
          <td>22.0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>3.10</td>
          <td>2001-06-11 11:40</td>
          <td>20.5</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    error_y=dict(
        type='percent',
        value=df['10 Min Sampled Avg'].std(),
        thickness=1,
        width=0,
        color='#444',
        opacity=0.8
    )

.. code:: python

    trace = go.Scatter(x=df['Time'],y=df['10 Min Sampled Avg'],mode='lines',error_y=error_y)
    data = [trace]
    layout = go.Layout(
        yaxis=dict(title='Wind speed (m/s)'),
        title='Discrete, fixed value error bars</br>Notice the hover text!')
        

.. code:: python

    fig = go.Figure(data=data, layout=layout)
    
    # IPython notebook
    py.iplot(fig, filename='pandas-fixed-error-bars')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1088.embed?share_key=9CcXujyo8n0eiwhKp3nHw0" height="525px" width="100%"></iframe>



Discrete, variable error bars
=============================

instead of ``value``, pass ``array`` to ``error_y``

.. code:: python

    # from part 1
    # error_y=dict(type='percent',value=df['10 Min Sampled Avg'].std(),
    #              thickness=1,width=0,color='#444',opacity=0.8)
    error_y=dict(type='percent',array=df['10 Min Std Dev'],
                 thickness=1,width=0,color='#444',opacity=0.8)
    
    # below is same as part1
    trace = go.Scatter(x=df['Time'],y=df['10 Min Sampled Avg'],mode='lines',error_y=error_y)
    data = [trace]
    
    layout.update({'title':'Discrete, variable value error bars</br>Notice the hover text!'})
    fig = go.Figure(data=data, layout=layout)
    
    # IPython notebook
    py.iplot(fig, filename='pandas-variable-error-bars')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1090.embed?share_key=hZVnSmTc8zJUDK9avc1oLL" height="525px" width="100%"></iframe>



Asymmetric Error Bars with a Constant Offset
============================================

.. code:: python

    upper_bound = go.Scatter(
        name='Upper Bound',
        x=df['Time'],
        y=df['10 Min Sampled Avg']+2.5*df['10 Min Std Dev'],
        mode='lines',
        marker=dict(color="444"),
        line=dict(width=0),
        fillcolor='rgba(68, 68, 68, 0.3)',
        fill='tonexty')
    
    trace = go.Scatter(
        name='Measurement',
        x=df['Time'],
        y=df['10 Min Sampled Avg'],
        mode='lines',
        line=dict(color='rgb(31, 119, 180)'),
        fillcolor='rgba(68, 68, 68, 0.3)',
        fill='tonexty')
    
    lower_bound = go.Scatter(
        name='Lower Bound',
        x=df['Time'],
        y=df['10 Min Sampled Avg']-df['10 Min Std Dev'],
        marker=dict(color="444"),
        line=dict(width=0),
        mode='lines')
    
    # Trace order can be important
    # with continuous error bars
    data = [lower_bound, trace, upper_bound]
    
    layout = go.Layout(yaxis=dict(title='Wind speed (m/s)'),showlegend = False,
        title='Continuous, variable value error bars</br>Notice the hover text!')
    fig = go.Figure(data=data, layout=layout)
    
    # IPython notebook
    py.iplot(fig, filename='pandas-continuous-error-bars')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1092.embed?share_key=jWjWFaFClHiwi5GyOI1In3" height="525px" width="100%"></iframe>



Bar Chart with Error Bars
=========================

.. code:: python

    from IPython.display import display

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/tooth_growth_csv')
    display(df.head(n=5))
    df2=df.groupby(['dose','supp']).describe()
    df2.head()



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>len</th>
          <th>supp</th>
          <th>dose</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>4.2</td>
          <td>VC</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>1</th>
          <td>11.5</td>
          <td>VC</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>2</th>
          <td>7.3</td>
          <td>VC</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>3</th>
          <td>5.8</td>
          <td>VC</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>4</th>
          <td>6.4</td>
          <td>VC</td>
          <td>0.5</td>
        </tr>
      </tbody>
    </table>
    </div>




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th></th>
          <th></th>
          <th>len</th>
        </tr>
        <tr>
          <th>dose</th>
          <th>supp</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th rowspan="5" valign="top">0.5</th>
          <th rowspan="5" valign="top">OJ</th>
          <th>count</th>
          <td>10.0000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>13.2300</td>
        </tr>
        <tr>
          <th>std</th>
          <td>4.4597</td>
        </tr>
        <tr>
          <th>min</th>
          <td>8.2000</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>9.7000</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    supplements = tuple(df2.index.get_level_values('supp').unique())
    doses = tuple(df2.index.get_level_values('dose').unique())
    print supplements,doses


.. parsed-literal::

    ('OJ', 'VC') (0.5, 1.0, 2.0)


.. code:: python

    data = []
    
    for supp in supplements:
        _bar = go.Bar(x = doses,y = df2.loc[doses,supp,'mean']['len'],name = supp,
                error_y=dict(type='data',array=df2.loc[doses,supp,'std']['len']))
        data.append(_bar)

.. code:: python

    data




.. parsed-literal::

    [{'error_y': {'array': dose  supp     
       0.5   OJ    std    4.4597
       1.0   OJ    std    3.9110
       2.0   OJ    std    2.6551
       Name: len, dtype: float64, 'type': 'data'},
      'name': 'OJ',
      'type': 'bar',
      'x': (0.5, 1.0, 2.0),
      'y': dose  supp      
      0.5   OJ    mean    13.23
      1.0   OJ    mean    22.70
      2.0   OJ    mean    26.06
      Name: len, dtype: float64},
     {'error_y': {'array': dose  supp     
       0.5   VC    std    2.7466
       1.0   VC    std    2.5153
       2.0   VC    std    4.7977
       Name: len, dtype: float64, 'type': 'data'},
      'name': 'VC',
      'type': 'bar',
      'x': (0.5, 1.0, 2.0),
      'y': dose  supp      
      0.5   VC    mean     7.98
      1.0   VC    mean    16.77
      2.0   VC    mean    26.14
      Name: len, dtype: float64}]



.. code:: python

    layout = go.Layout( xaxis=go.XAxis(type='category') )
    fig = go.Figure( data=data, layout=layout )
    
    # IPython notebook
    py.iplot(fig, filename='pandas-error-bars-bar-chart')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1094.embed?share_key=Stbb6sHeLzpypxRVwS6xKb" height="525px" width="100%"></iframe>



