#####################################
Cufflinks - Pandas Like Visualization
#####################################
https://github.com/santosjorge/cufflinks

http://nbviewer.jupyter.org/gist/santosjorge/aba934a0d20023a136c2

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls
    from plotly.tools import FigureFactory as FF

.. code:: python

    import pandas as pd
    import cufflinks as cf
    import numpy as np
    from IPython.display import display,HTML

Themes
======

.. code:: python

    help(cf.set_config_file)


.. parsed-literal::
    :class: myliteral

    Help on function set_config_file in module cufflinks.auth:
    
    set_config_file(sharing=None, theme=None, colorscale=None, offline=None, offline_url=None, offline_show_link=None, offline_link_text=None, datagen_mode=None, **kwargs)
        Set the keyword-value pairs in `~/.config`.
        
        sharing : string
                        Sets the sharing level permission
                                public - anyone can see this chart
                                private - only you can see this chart
                                secret - only people with the link can see the chart
        theme : string
                        Sets the default theme
                        See cufflinks.getThemes() for available themes 
        colorscale : string
                        Sets the default colorscale
                        See cufflinks.scales()
        offline : bool
                        If true then the charts are rendered
                        locally. 
        offline_show_link : bool
                        If true then the chart will show a link to 
                        plot.ly at the bottom right of the chart 
        offline_link_text : string
                        Text to display as link at the bottom 
                        right of the chart 
        datagen_mode : string
                        Mode in which the data is generated
                        by the datagen module
                                stocks : random stock names are used for the index
                                abc : alphabet values are used for the index
        dimensions : tuple
                        Sets the default (width,height) of the chart
    


.. code:: python

    # cf.set_config_file(theme='ggplot',sharing='secret',offline=True,offline_show_link=False)
    cf.set_config_file(theme='ggplot',sharing='public',offline=False)
    cf.datagen.lines(1,1000).iplot(filename='tmp')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1239.embed" height="525px" width="100%"></iframe>



Basic line plots (time series)
==============================

The ``iplot`` method on Series and DataFrame is wrapper of Plotly's plot
method

.. code:: python

    # Cufflinks can generate random data for different shapes
    # Let's generate a single line with 1000 points
    df = cf.datagen.lines(1,1000)
    
    print type(df)
    df.head(n=5)


.. parsed-literal::
    :class: myliteral

    <class 'pandas.core.frame.DataFrame'>




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>FDS.FI</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2015-01-01</th>
          <td>-2.7793</td>
        </tr>
        <tr>
          <th>2015-01-02</th>
          <td>-2.8958</td>
        </tr>
        <tr>
          <th>2015-01-03</th>
          <td>-1.7016</td>
        </tr>
        <tr>
          <th>2015-01-04</th>
          <td>-2.5607</td>
        </tr>
        <tr>
          <th>2015-01-05</th>
          <td>-2.2126</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    (df+1).iplot()




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1241.embed" height="525px" width="100%"></iframe>



.. code:: python

    # Generating 4 timeseries 
    df=cf.datagen.lines(4,1000)
    
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>LDI.BB</th>
          <th>IOE.MD</th>
          <th>ZPB.HQ</th>
          <th>AUH.WZ</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2015-01-01</th>
          <td>-0.0267</td>
          <td>1.2532</td>
          <td>0.3214</td>
          <td>0.3146</td>
        </tr>
        <tr>
          <th>2015-01-02</th>
          <td>-0.3117</td>
          <td>1.1146</td>
          <td>0.0804</td>
          <td>-0.8827</td>
        </tr>
        <tr>
          <th>2015-01-03</th>
          <td>-1.7515</td>
          <td>1.1786</td>
          <td>0.3364</td>
          <td>-0.4043</td>
        </tr>
        <tr>
          <th>2015-01-04</th>
          <td>-1.0386</td>
          <td>1.9910</td>
          <td>1.6942</td>
          <td>-1.7081</td>
        </tr>
        <tr>
          <th>2015-01-05</th>
          <td>-0.1432</td>
          <td>0.5096</td>
          <td>2.0053</td>
          <td>-1.7756</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    cf.getThemes()




.. parsed-literal::
    :class: myliteral

    ['polar', 'space', 'ggplot', 'pearl', 'solar', 'white', 'henanigans']



.. code:: python

    df.iplot(dimensions=(1200,800))




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1243.embed" height="800px" width="1200px"></iframe>



You can plot one column versus another using the x and y keywords in
iplot

.. code:: python

    df3 = pd.DataFrame(np.random.randn(1000, 2), columns=['B', 'C']).cumsum()
    df3['A'] = pd.Series(list(range(len(df3))))
    df3.iplot(x='A', y='B')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1245.embed" height="525px" width="100%"></iframe>



Bar Plots
=========

.. code:: python

    df.iplot(kind='bar')

.. code:: python

    df.ix[3].iplot(kind='bar',bargap=.5)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1247.embed" height="525px" width="100%"></iframe>



Multiple bars
=============

.. code:: python

    df=pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
    df.iplot(kind='bar')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1249.embed" height="525px" width="100%"></iframe>



.. code:: python

    # comparison with pandas plot
    import matplotlib.pyplot as plt
    df.plot(kind='bar')
    fig = plt.gcf()
    fig.set_size_inches(10,4)



.. image:: Cufflinks%20-%20Pandas%20Like%20Visualization_files/Cufflinks%20-%20Pandas%20Like%20Visualization_18_0.png


Stacked bars
============

.. code:: python

    df.iplot(kind='bar',barmode='stack')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1251.embed" height="525px" width="100%"></iframe>



Horizontal bars (kind='barh')
=============================

.. code:: python

    df.iplot(kind='barh',barmode='stack',bargap=.1)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1253.embed" height="525px" width="100%"></iframe>



Histograms
==========

.. code:: python

    df = pd.DataFrame({'a': np.random.randn(1000) + 1, 'b': np.random.randn(1000),
                        'c': np.random.randn(1000) - 1}, columns=['a', 'b', 'c'])
    df.iplot(kind='histogram')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1255.embed" height="525px" width="100%"></iframe>



.. code:: python

    df.iplot(kind='histogram',barmode='stack',bins=20)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1257.embed" height="525px" width="100%"></iframe>



Normalized over probability
===========================

.. code:: python

    df.iplot(kind='histogram',columns=['a'],orientation='h',histnorm='probability')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1259.embed" height="525px" width="100%"></iframe>



Subplots
========

.. code:: python

    df_h=cf.datagen.histogram(4)
    df_h.iplot(kind='histogram',subplots=True,bins=50,histnorm='probability')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1261.embed" height="525px" width="100%"></iframe>



Boxplots
========

.. code:: python

    df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])
    df.iplot(kind='box')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1263.embed" height="525px" width="100%"></iframe>



Grouping values
===============

Grouping values by generating a list of figures

.. code:: python

    df = pd.DataFrame(np.random.rand(10,2), columns=['Col1', 'Col2'] )
    df['X'] = pd.Series(['A','A','A','A','A','B','B','B','B','B'])

.. code:: python

    figs=[df[df['X']==d][['Col1','Col2']].iplot(kind='box',asFigure=True) for d in pd.unique(df['X']) ]

.. code:: python

    cf.iplot(cf.subplots(figs))




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1265.embed" height="525px" width="100%"></iframe>



Grouping values and ammending the keys

.. code:: python

    def by(df,category):
        l=[]
        for cat in pd.unique(df[category]):
            _df=df[df[category]==cat]
            del _df[category]
            _df=_df.rename(columns=dict([(k,'{0}_{1}'.format(cat,k)) for k in _df.columns]))
            l.append(_df.iplot(kind='box',asFigure=True))
        return l


.. code:: python

    cf.iplot(cf.subplots(by(df,'X')))




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1267.embed" height="525px" width="100%"></iframe>



Area Plots
==========

.. code:: python

    df = pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
    df.iplot(kind='area',fill=True,opacity=1)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1269.embed" height="525px" width="100%"></iframe>



.. code:: python

    df.iplot(fill=True) # default opacity = 0.3




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1271.embed" height="525px" width="100%"></iframe>



Scatter plots
=============

.. code:: python

    df = pd.DataFrame(np.random.rand(50, 4), columns=['a', 'b', 'c', 'd'])
    df.iplot(kind='scatter',x='a',y='b',mode='markers')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1273.embed" height="525px" width="100%"></iframe>



Assign color via dict or list
=============================

Below, the y-axis is the magnitude for each column

.. code:: python

    #df = pd.DataFrame(np.random.rand(50, 4), columns=['a', 'b', 'c', 'd'])
    df.iplot(kind='scatter',mode='markers',symbol='dot',colors=['orange','teal','blue','yellow'],size=10)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1275.embed" height="525px" width="100%"></iframe>



Use size to set bubble size
===========================

.. code:: python

    size='c'

.. code:: python

    #df = pd.DataFrame(np.random.rand(50, 4), columns=['a', 'b', 'c', 'd'])
    df.iplot(kind='bubble',x='a',y='b',size='c')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1277.embed" height="525px" width="100%"></iframe>



Scattermatrix
=============

.. code:: python

    df = pd.DataFrame(np.random.randn(1000, 4), columns=['a', 'b', 'c', 'd'])
    df.scatter_matrix()




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1279.embed" height="525px" width="100%"></iframe>



.. code:: python

    cf.get_config_file()




.. parsed-literal::
    :class: myliteral

    {u'colorscale': u'dflt',
     u'datagen_mode': u'stocks',
     u'dimensions': None,
     u'offline': False,
     u'offline_link_text': u'test',
     u'offline_show_link': False,
     u'offline_url': True,
     u'sharing': u'public',
     u'theme': u'ggplot'}



Subplots
========

.. code:: python

    df.iplot(subplots=True,shape=(4,1),shared_xaxes=True,vertical_spacing=.02,fill=True)

.. code:: python

    df=cf.datagen.lines(4)

.. code:: python

    df.iplot(subplots=True,shape=(4,1),shared_xaxes=True,vertical_spacing=.02,fill=True)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1281.embed" height="525px" width="100%"></iframe>



.. code:: python

    df.iplot(subplots=True,subplot_titles=True,legend=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1283.embed" height="525px" width="100%"></iframe>



.. code:: python

    df=cf.datagen.bubble(10,50,mode='stocks')

irregular shaped subplots
=========================

.. code:: python

    figs=cf.figures(df,[dict(kind='histogram',keys='x',color='blue'),
                        dict(kind='scatter',mode='markers',x='x',y='y',size=5),
                        dict(kind='scatter',mode='markers',x='x',y='y',size=5,color='teal')],asList=True)
    figs.append(cf.datagen.lines(1).figure(bestfit=True,colors=['blue'],bestfit_colors=['pink']))
    base_layout=cf.tools.get_base_layout(figs)
    sp=cf.subplots(figs,shape=(3,2),base_layout=base_layout,vertical_spacing=.15,horizontal_spacing=.03,
                   specs=[[{'rowspan':2},{}],[None,{}],[{'colspan':2},None]],
                   subplot_titles=['Histogram','Scatter 1','Scatter 2','Bestfit Line'])
    sp['layout'].update(showlegend=False)


.. parsed-literal::
    :class: myliteral

    /home/takanori/.local/lib/python2.7/site-packages/cufflinks/plotlytools.py:164: FutureWarning:
    
    The pandas.stats.ols module is deprecated and will be removed in a future version. We refer to external packages like statsmodels, see some examples here: http://www.statsmodels.org/stable/regression.html
    


.. code:: python

    cf.iplot(sp)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1285.embed" height="525px" width="100%"></iframe>



Shapes
======

.. code:: python

    df=cf.datagen.lines(3,columns=['a','b','c'])
    df.iplot(hline=[2,4],vline=['2015-02-10'])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1287.embed" height="525px" width="100%"></iframe>



More advanced parameters can be passed in the form of a dictionary,
including width and color and dash for the line dash type.

.. code:: python

    df.iplot(hline=[dict(y=-1,color='blue',width=3),dict(y=1,color='pink',dash='dash')])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1289.embed" height="525px" width="100%"></iframe>



Shaded areas can be plotted using hspan and vspan for horizontal and
vertical areas respectively. These can be set with a list of paired
tuples (v0,v1) or a list of dictionaries with further parameters.

.. code:: python

    df.iplot(hspan=[(-1,1),(2,5)])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1291.embed" height="525px" width="100%"></iframe>



Extra parameters can be passed in the form of dictionaries, width, fill,
color, fillcolor, opacity

.. code:: python

    df.iplot(vspan={'x0':'2015-02-15','x1':'2015-03-15','color':'teal','fill':True,'opacity':.4})




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1293.embed" height="525px" width="100%"></iframe>



.. code:: python

    # Plotting resistance lines
    max_vals=df.max().values.tolist()
    resistance=[dict(kind='line',y=i,color=j,width=2) for i,j in zip(max_vals,['red','blue','pink'])]
    df.iplot(hline=resistance)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1295.embed" height="525px" width="100%"></iframe>



Different shapes can also be used with shapes and identifying the kind
which can be either line, rect or circle

.. code:: python

    # Get min to max values
    
    df_a=df['a']
    max_val=df_a.max()
    min_val=df_a.min()
    max_date=df_a[df_a==max_val].index[0].strftime('%Y-%m-%d')
    min_date=df_a[df_a==min_val].index[0].strftime('%Y-%m-%d')
    shape1=dict(kind='line',x0=max_date,y0=max_val,x1=min_date,y1=min_val,color='blue',width=2)
    shape2=dict(kind='rect',x0=max_date,x1=min_date,fill=True,color='gray',opacity=.3)
    
    df_a.iplot(shapes=[shape1,shape2])




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1297.embed" height="525px" width="100%"></iframe>



Other shapes
============

.. code:: python

    x0 = np.random.normal(2, 0.45, 300)
    y0 = np.random.normal(2, 0.45, 300)
    
    x1 = np.random.normal(6, 0.4, 200)
    y1 = np.random.normal(6, 0.4, 200)
    
    x2 = np.random.normal(4, 0.3, 200)
    y2 = np.random.normal(4, 0.3, 200)
    
    distributions = [(x0,y0),(x1,y1),(x2,y2)]
    
    dfs=[pd.DataFrame(dict(x=i,y=j)) for i,j in distributions]

.. code:: python

    d=cf.Data()
    gen=cf.colorgen(scale='ggplot')
    for df in dfs:
        d_=df.figure(kind='scatter',mode='markers',x='x',y='y',size=5,colors=gen.next())['data']
        for _ in d_:
            d.append(_)

.. code:: python

    gen=cf.colorgen(scale='ggplot')
    shapes=[cf.tools.get_shape(kind='circle',x0=min(x),x1=max(x),
             y0=min(y),y1=max(y),color=gen.next(),fill=True,
             opacity=.3,width=.4) for x,y in distributions]

.. code:: python

    fig=cf.Figure(data=d)
    fig['layout']=cf.getLayout(shapes=shapes,legend=False,title='Distribution Comparison')
    cf.iplot(fig,validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1299.embed" height="525px" width="100%"></iframe>



