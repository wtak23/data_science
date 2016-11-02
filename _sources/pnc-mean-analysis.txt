#############################
Brain Connectivity - PNC Data
#############################

A quick analysis on the **PNC** (Philadelphia Neurodevelopment Cohort) dataset.

.. contents:: `Contents`
   :depth: 2
   :local:

Load relevant packages
======================
.. code:: python

    %matplotlib inline  

.. code:: python

    import seaborn as sns
    import matplotlib.pyplot as plt
    from IPython.display import display

.. code:: python

    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls

.. code:: python

    import tak as tw

Load clinical-scores (DataFrame)
================================

.. code:: python

    X,df = tw.data.pnc.load_connectome()

.. code:: python

    df.head(n=10)

.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>bblid</th>
          <th>race</th>
          <th>ethnicity</th>
          <th>sex</th>
          <th>age</th>
          <th>edu</th>
          <th>fedu</th>
          <th>medu</th>
          <th>handedness</th>
          <th>dxpmrv4_diagnosis</th>
          <th>dxpmrv4_diagnosis_num</th>
          <th>medical_rating</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>080010</td>
          <td>1</td>
          <td>2</td>
          <td>Male</td>
          <td>21.750000</td>
          <td>14.0</td>
          <td>20.0</td>
          <td>16.0</td>
          <td>1</td>
          <td>TD</td>
          <td>1</td>
          <td>2</td>
        </tr>
        <tr>
          <th>1</th>
          <td>080199</td>
          <td>5</td>
          <td>1</td>
          <td>Male</td>
          <td>20.333333</td>
          <td>12.0</td>
          <td>NaN</td>
          <td>12.0</td>
          <td>1</td>
          <td>PS-L</td>
          <td>3</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>080208</td>
          <td>2</td>
          <td>2</td>
          <td>Male</td>
          <td>20.500000</td>
          <td>11.0</td>
          <td>12.0</td>
          <td>12.0</td>
          <td>2</td>
          <td>PS-L</td>
          <td>3</td>
          <td>2</td>
        </tr>
        <tr>
          <th>3</th>
          <td>080249</td>
          <td>1</td>
          <td>2</td>
          <td>Female</td>
          <td>20.833333</td>
          <td>16.0</td>
          <td>10.0</td>
          <td>12.0</td>
          <td>1</td>
          <td>TD</td>
          <td>1</td>
          <td>2</td>
        </tr>
        <tr>
          <th>4</th>
          <td>080265</td>
          <td>2</td>
          <td>2</td>
          <td>Female</td>
          <td>20.500000</td>
          <td>12.0</td>
          <td>12.0</td>
          <td>16.0</td>
          <td>2</td>
          <td>OP</td>
          <td>2</td>
          <td>0</td>
        </tr>
        <tr>
          <th>5</th>
          <td>080425</td>
          <td>2</td>
          <td>2</td>
          <td>Female</td>
          <td>20.000000</td>
          <td>12.0</td>
          <td>14.0</td>
          <td>12.0</td>
          <td>2</td>
          <td>OP</td>
          <td>2</td>
          <td>0</td>
        </tr>
        <tr>
          <th>6</th>
          <td>080498</td>
          <td>2</td>
          <td>2</td>
          <td>Male</td>
          <td>20.916667</td>
          <td>14.0</td>
          <td>15.0</td>
          <td>16.0</td>
          <td>1</td>
          <td>PS</td>
          <td>4</td>
          <td>1</td>
        </tr>
        <tr>
          <th>7</th>
          <td>080537</td>
          <td>1</td>
          <td>2</td>
          <td>Female</td>
          <td>20.916667</td>
          <td>14.0</td>
          <td>15.0</td>
          <td>12.0</td>
          <td>1</td>
          <td>TD</td>
          <td>1</td>
          <td>2</td>
        </tr>
        <tr>
          <th>8</th>
          <td>080557</td>
          <td>2</td>
          <td>2</td>
          <td>Female</td>
          <td>21.500000</td>
          <td>15.0</td>
          <td>12.0</td>
          <td>12.0</td>
          <td>1</td>
          <td>TD</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>9</th>
          <td>080575</td>
          <td>1</td>
          <td>2</td>
          <td>Male</td>
          <td>21.750000</td>
          <td>16.0</td>
          <td>20.0</td>
          <td>20.0</td>
          <td>1</td>
          <td>OP</td>
          <td>2</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    df.isnull().sum()




.. parsed-literal::
    :class: myliteral

    bblid                     0
    race                      0
    ethnicity                 0
    sex                       0
    age                       0
    edu                       0
    fedu                     82
    medu                     11
    handedness                0
    dxpmrv4_diagnosis         0
    dxpmrv4_diagnosis_num     0
    medical_rating            0
    dtype: int64



Handle nan values
=================

.. code:: python

    # use median fill for nans
    df.fedu.fillna( df.fedu.median() ,inplace=True)
    df.medu.fillna( df.medu.median() ,inplace=True)

.. code:: python

    df.isnull().sum()




.. parsed-literal::
    :class: myliteral

    bblid                    0
    race                     0
    ethnicity                0
    sex                      0
    age                      0
    edu                      0
    fedu                     0
    medu                     0
    handedness               0
    dxpmrv4_diagnosis        0
    dxpmrv4_diagnosis_num    0
    medical_rating           0
    dtype: int64



.. code:: python

    df.columns




.. parsed-literal::
    :class: myliteral

    Index([u'bblid', u'race', u'ethnicity', u'sex', u'age', u'edu', u'fedu',
           u'medu', u'handedness', u'dxpmrv4_diagnosis', u'dxpmrv4_diagnosis_num',
           u'medical_rating'],
          dtype='object')



Create histogram of numeric scores
==================================

See if they are matched in gender

.. code:: python

    options = dict(rug=True, kde=True)
    scores = ['age','edu','fedu','medu']

.. code:: python

    # temporarily change axes style
    with sns.axes_style('darkgrid'):
        fig,axes = plt.subplots(2,2)
        axes = axes.ravel()
    
    for i, score in enumerate(scores):
        sns.distplot(df[ df['sex'] == 'Male'][score],label='Male',ax=axes[i],**options)
        sns.distplot(df[ df['sex'] == 'Female'][score],color='red',label='Female',ax=axes[i],**options)
        axes[i].legend(loc='best')



.. image:: pnc-mean-analysis_files/pnc-mean-analysis_13_0.png


Display mean connectome heatmap
===============================

.. code:: python

    X_mean = X.mean(axis=0)

Convert vectorized connectivity matrix back to square matrix form

.. code:: python

    from scipy.spatial.distance import squareform
    print X_mean.shape
    X_mean = squareform(X_mean)
    print X_mean.shape


.. parsed-literal::
    :class: myliteral

    (3655L,)
    (86L, 86L)


.. code:: python

    tw.imconnmat(X_mean)

Nice, let's repeat using plotly
===============================

-  first need to define ``colorscale`` containing list of rgb values
-  I'll choose ``seismic`` colormap from mpl (see
   http://matplotlib.org/examples/color/colormaps\_reference.html for a
   full list)
-  below, I borrowed the idea from
   http://thomas-cokelaer.info/blog/2014/09/about-matplotlib-colormap-and-how-to-get-rgb-values-of-the-map/

.. code:: python

    from matplotlib import cm

.. code:: python

    # convert to plotly readable form, which requires list containing paired values:
    # (1) value interpolating from decimal value 0 to 1
    # (2) corresponding rgb hex value
    cscale = cm.seismic
    my_cscale = []
    for i in xrange(256):
        r,g,b = cscale(i)[:3]
        my_cscale.append([i/255., '#%02x%02x%02x' %  (int(r*255+0.5), int(g*255+0.5), int(b*255+0.5))])

.. code:: python

    from pprint import pprint
    pprint(my_cscale[:5])
    print '...'
    pprint(my_cscale[-5:])


.. parsed-literal::
    :class: myliteral

    [[0.0, '#00004d'],
     [0.00392156862745098, '#00004f'],
     [0.00784313725490196, '#000052'],
     [0.011764705882352941, '#000055'],
     [0.01568627450980392, '#000058']]
    ...
    [[0.984313725490196, '#880000'],
     [0.9882352941176471, '#860000'],
     [0.9921568627450981, '#840000'],
     [0.996078431372549, '#820000'],
     [1.0, '#800000']]


Create plotly ``trace`` object
==============================

.. code:: python

    data = [go.Heatmap(
        z = X_mean,
    )]

.. code:: python

    py.iplot(data)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/217.embed" height="525px" width="100%"></iframe>



Bunch of layout objects
=======================

for personal reference

.. code:: python

    layout = go.Layout(
        xaxis=dict(
            showgrid=False,
            showline=True,
            linecolor='rgb(102, 102, 102)',
            titlefont=dict(
                color='rgb(204, 204, 204)'
            ),
            tickfont=dict(
                color='rgb(102, 102, 102)',
            ),
            autotick=False,
            dtick=10,
            ticks='outside',
            tickcolor='rgb(102, 102, 102)',
        ),
        margin=dict(
            l=140,
            r=40,
            b=50,
            t=80
        ),
        legend=dict(
            font=dict(
                size=10,
            ),
            yanchor='middle',
            xanchor='right',
        ),
        showlegend=False,
        paper_bgcolor='rgb(254, 247, 234)',
        plot_bgcolor='rgb(254, 247, 234)',
        hovermode='closest',    
    )

Nice, but we can do better by defining a ``layout`` object
==========================================================

.. code:: python

    df_nodes = tw.get_node_info86()

.. code:: python

    df_nodes.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>label</th>
          <th>name_full</th>
          <th>lobes</th>
          <th>name_short</th>
          <th>system</th>
          <th>name_short_h1</th>
          <th>name_short_h2</th>
          <th>x</th>
          <th>y</th>
          <th>z</th>
          <th>hemisphere</th>
          <th>xmni</th>
          <th>ymni</th>
          <th>zmni</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1001</td>
          <td>ctx-lh-bankssts</td>
          <td>L temporal</td>
          <td>Bank of the Superior Temporal Sulcus</td>
          <td>auditory</td>
          <td>L-Bank of the Superior Temporal Sulcus</td>
          <td>Bank of the Superior Temporal Sulcus-L</td>
          <td>178</td>
          <td>158</td>
          <td>83</td>
          <td>L</td>
          <td>-54.15</td>
          <td>-45.20</td>
          <td>9.35</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1002</td>
          <td>ctx-lh-caudalanteriorcingulate</td>
          <td>L frontal</td>
          <td>Caudal Anterior Cingulate</td>
          <td>cingulo-opercular</td>
          <td>L-Caudal Anterior Cingulate</td>
          <td>Caudal Anterior Cingulate-L</td>
          <td>130</td>
          <td>91</td>
          <td>102</td>
          <td>L</td>
          <td>-4.35</td>
          <td>17.15</td>
          <td>29.15</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1003</td>
          <td>ctx-lh-caudalmiddlefrontal</td>
          <td>L frontal</td>
          <td>Caudal Middle Frontal</td>
          <td>fronto-parietal</td>
          <td>L-Caudal Middle Frontal</td>
          <td>Caudal Middle Frontal-L</td>
          <td>158</td>
          <td>101</td>
          <td>121</td>
          <td>L</td>
          <td>-36.45</td>
          <td>10.20</td>
          <td>47.45</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1005</td>
          <td>ctx-lh-cuneus</td>
          <td>L occipital</td>
          <td>Cuneus</td>
          <td>visual</td>
          <td>L-Cuneus</td>
          <td>Cuneus-L</td>
          <td>134</td>
          <td>192</td>
          <td>86</td>
          <td>L</td>
          <td>-5.55</td>
          <td>-83.75</td>
          <td>18.40</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1006</td>
          <td>ctx-lh-entorhinal</td>
          <td>L temporal</td>
          <td>Entorhinal</td>
          <td>visual</td>
          <td>L-Entorhinal</td>
          <td>Entorhinal-L</td>
          <td>150</td>
          <td>116</td>
          <td>41</td>
          <td>L</td>
          <td>-23.85</td>
          <td>-5.90</td>
          <td>-31.95</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    trace = go.Heatmap(
        z = X_mean,
            x = df_nodes['name_full'],
            y = df_nodes['name_full'],
        colorscale=my_cscale,
    )
    data = [trace] # can define multiple trace...not necessary for this example
    
    # define my own layout
    layout = go.Layout(
        title='Mean structural connectivity',
        titlefont = dict(size=37, color='black'),
        xaxis = dict(ticks='',range=[0,85],nticks=X_mean.shape[1], title='node',gridcolor='green',
                     linecolor='green',showline=True,showgrid=True,
                     titlefont=dict(size=32),
                     tickfont=dict(size=8),
                     categoryarray=df_nodes['system'],
                    ),
        #yaxis = dict(ticks='',nticks=X_mean.shape[0], title='node'),
        yaxis = dict(ticks='',title='node',
                     #autorange='reversed', # rather use range
                     range=[85,0], nticks=86,
                     rangeselector = dict(yanchor='middle'),
                     tickfont=dict(size=9),                 
                     categoryarray=df_nodes['system'],
                ),
        scene = dict(aspectmode="manual",aspectratio=dict(x=1,y=1)),
        autosize=False,
        # sadly, no directly way to preserve aspect ratio...
        # https://github.com/plotly/plotly.py/issues/70
        # So just stick with static size for now...
        width=1000,
        height=1000,
    )
    # py.iplot([trace])
    
    #bummer...gridlines over heatmap not supported...
    #http://community.plot.ly/t/gridlines-over-heatmap/970
    
    fig = go.Figure(data=data, layout=layout)

.. code:: python

    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/325.embed" height="1000px" width="1000px"></iframe>



Try again
=========

.. code:: python

    trace = go.Heatmap(
        z = X_mean,
        x = df_nodes['name_full'],
        y = df_nodes['name_full'],
        hoverinfo=dict(flags = ['x','y','z','text','name']),
        colorscale=my_cscale,
    )
    data = [trace] # can define multiple trace...not necessary for this example
    
    # define my own layout
    layout = go.Layout(
        title='Mean structural connectivity',
        titlefont = dict(size=37, color='black'),
        xaxis = dict(ticks='',range=[0,85],nticks=X_mean.shape[1], 
                     #title='node',
                     #gridcolor='green',
                     #linecolor='green',showline=True,showgrid=True,
                     #titlefont=dict(size=32),
                     tickfont=dict(size=8),
                     categoryarray=df_nodes['system'],
                    ),
        #yaxis = dict(ticks='',nticks=X_mean.shape[0], title='node'),
        yaxis = dict(ticks='',
                     #title='node',
                     #autorange='reversed', # rather use range
                     range=[85,0], nticks=86,
                     #rangeselector = dict(yanchor='middle'),
                     tickfont=dict(size=9),
                     categoryarray=df_nodes['system'],
                ),
        width=1000,
        height=1000,
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig,filename='conn/pnc-mean')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/356.embed" height="1000px" width="1000px"></iframe>


