Figure Factory -- my favorites!
""""""""""""""""""""""""""""""""
My favorite usecase of ``plotly.tools.FigureFactory``

.. contents:: `Contents`
   :depth: 2
   :local:

.. code:: python

    import plotly
    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls
    
    from plotly.tools import FigureFactory as FF
    
    import numpy as np
    import pandas as pd

###################
create\_2D\_density
###################



Simple 2d Density
=================

.. code:: python

    # Make data points
    t = np.linspace(-1,1.2,2000)
    x = (t**3)+(0.3*np.random.randn(2000))
    y = (t**6)+(0.3*np.random.randn(2000))
    
    fig = FF.create_2D_density(x, y)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/840.embed?share_key=a0dbKqJvi07nE5pEKbJOn6" height="600px" width="600px"></iframe>



add colorscale
==============

.. code:: python

    # Create custom colorscale
    colorscale = ['#7A4579', '#D56073', 'rgb(236,158,105)',
                  (1, 1, 0.2), (0.98,0.98,0.98)]
    
    fig = FF.create_2D_density(x, y, colorscale=colorscale,
        hist_color='rgb(255, 237, 222)', point_size=3)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/842.embed?share_key=faUjzaWNXCsaevALeWxf99" height="600px" width="600px"></iframe>



##################
create\_dendrogram
##################

Simple bottom oriented dendrogram
=================================

.. code:: python

    X = np.random.rand(10,10)
    dendro = FF.create_dendrogram(X)
    dendro['layout'].update({'width':700, 'height':500})
    
    py.iplot(dendro)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/844.embed?share_key=yfBhotOFD5cuzmAU3vp2dp" height="500px" width="700px"></iframe>



Dendrogram to put on the left of the heatmap
============================================

.. code:: python

    X = np.random.rand(5,5)
    names = ['Jack', 'Oxana', 'John', 'Chelsea', 'Mark']
    dendro = FF.create_dendrogram(X, orientation='right', labels=names)
    dendro['layout'].update({'width':800, 'height':500})
    
    py.iplot(dendro)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/848.embed?share_key=EsfxefFj9RZOdKP2lClBop" height="500px" width="800px"></iframe>



Dendrogram with Pandas
======================

.. code:: python

    Index= ['A','B','C','D','E','F','G','H','I','J']
    df = pd.DataFrame(abs(np.random.randn(10, 10)), index=Index)
    fig = FF.create_dendrogram(df, labels=Index)
    fig['layout'].update({'width':700, 'height':500})
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/850.embed?share_key=RovRg1dLEj21AfqE9IPwyk" height="500px" width="700px"></iframe>



With heatmap
============

https://plot.ly/python/dendrogram/

https://wtak23.github.io/plotly\_api/generated/generated/plotly.tools.FigureFactory.create\_dendrogram.html

.. code:: python

    from scipy.spatial.distance import pdist, squareform
    
    # get data
    data = np.genfromtxt("http://files.figshare.com/2133304/ExpRawData_E_TABM_84_A_AFFY_44.tab",
                         names=True,usecols=tuple(range(1,30)),dtype=float, delimiter="\t")
    data_array = data.view((np.float, len(data.dtype.names)))
    data_array = data_array.transpose()
    labels = data.dtype.names

Create dendrogram part

.. code:: python

    # create uppder dendrogram
    figure = FF.create_dendrogram(data_array, orientation='bottom', labels=labels)
    
    for i in range(len(figure['data'])):
        figure['data'][i]['yaxis'] = 'y2'
    
    # Create Side Dendrogram
    dendro_side = FF.create_dendrogram(data_array, orientation='right')
    for i in range(len(dendro_side['data'])):
        dendro_side['data'][i]['xaxis'] = 'x2'
    
    # Add Side Dendrogram Data to Figure
    figure['data'].extend(dendro_side['data'])

.. code:: python

    print dendro_side['data'].__len__()
    print figure['data'].__len__()


.. parsed-literal::
    :class: myliteral

    28
    56


Create heatmap

.. code:: python

    # Create Heatmap
    dendro_leaves = dendro_side['layout']['yaxis']['ticktext']
    print dendro_leaves
    
    dendro_leaves = list(map(int, dendro_leaves))
    print dendro_leaves
    
    data_dist = pdist(data_array)
    heat_data = squareform(data_dist)
    print 'heat_data.shape = ',heat_data.shape
    heat_data = heat_data[dendro_leaves,:]
    heat_data = heat_data[:,dendro_leaves]
    
    print 'data_array.shape = ',data_array.shape
    print 'data_dist.shape = ',data_dist.shape
    print 'heat_data.shape = ',heat_data.shape


.. parsed-literal::
    :class: myliteral

    ['19' '16' '3' '20' '0' '6' '28' '10' '14' '9' '26' '5' '8' '1' '23' '25'
     '2' '4' '7' '11' '12' '13' '18' '27' '21' '24' '17' '15' '22']
    [19, 16, 3, 20, 0, 6, 28, 10, 14, 9, 26, 5, 8, 1, 23, 25, 2, 4, 7, 11, 12, 13, 18, 27, 21, 24, 17, 15, 22]
    heat_data.shape =  (29, 29)
    data_array.shape =  (29, 54674)
    data_dist.shape =  (406,)
    heat_data.shape =  (29, 29)


.. code:: python

    heatmap = go.Data([
        go.Heatmap(
            x = dendro_leaves, 
            y = dendro_leaves,
            z = heat_data,    
            colorscale = 'YIGnBu'
        )
    ])
    heatmap.__len__()




.. parsed-literal::
    :class: myliteral

    1



.. code:: python

    print figure['layout']['xaxis']['tickvals']
    print dendro_side['layout']['yaxis']['tickvals']


.. parsed-literal::
    :class: myliteral

    [5.0, 15.0, 25.0, 35.0, 45.0, 55.0, 65.0, 75.0, 85.0, 95.0, 105.0, 115.0, 125.0, 135.0, 145.0, 155.0, 165.0, 175.0, 185.0, 195.0, 205.0, 215.0, 225.0, 235.0, 245.0, 255.0, 265.0, 275.0, 285.0]
    [5.0, 15.0, 25.0, 35.0, 45.0, 55.0, 65.0, 75.0, 85.0, 95.0, 105.0, 115.0, 125.0, 135.0, 145.0, 155.0, 165.0, 175.0, 185.0, 195.0, 205.0, 215.0, 225.0, 235.0, 245.0, 255.0, 265.0, 275.0, 285.0]


.. code:: python

    heatmap[0]['x'] = figure['layout']['xaxis']['tickvals']
    heatmap[0]['y'] = dendro_side['layout']['yaxis']['tickvals']
                                                     
    # Add Heatmap Data to Figure
    figure['data'].extend(go.Data(heatmap))

Edit layout

.. code:: python

    figure['layout'].update({'width':800, 'height':800,'showlegend':False, 'hovermode': 'closest',})
    
    #http://stackoverflow.com/questions/38987/how-to-merge-two-python-dictionaries-in-a-single-expression
    setup_shared = dict(mirror=False,showgrid=False,showline=False,zeroline=False,ticks="")
    
    # Edit xaxis
    figure['layout']['xaxis'].update(dict(domain=[0.15,1], **setup_shared))
    figure['layout'].update({'xaxis2':dict(domain=[0,0.15], showticklabels=False,**setup_shared)})
    
    # Edit yaxis
    figure['layout']['yaxis'].update(dict(domain=[0,0.85], **setup_shared))
    figure['layout'].update({'yaxis2':dict(domain=[0.825,0.975],showticklabels=False, **setup_shared)})

.. code:: python

    py.iplot(figure)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/858.embed?share_key=uY2Yo0TkSy05UCLqXG6VWJ" height="800px" width="800px"></iframe>



################
create\_distplot
################

simple distplot
===============

.. code:: python

    hist_data = [[1.1, 1.1, 2.5, 3.0, 3.5,
                  3.5, 4.1, 4.4, 4.5, 4.5,
                  5.0, 5.0, 5.2, 5.5, 5.5,
                  5.5, 5.5, 5.5, 6.1, 7.0]]
    
    group_labels = ['distplot example']
    fig = FF.create_distplot(hist_data, group_labels)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/860.embed?share_key=VQD7Pb4xPpkiws0J7EKvVI" height="525px" width="100%"></iframe>



Two data sets and added rug text
================================

.. code:: python

    # Add histogram data
    hist1_x = [0.8, 1.2, 0.2, 0.6, 1.6,
               -0.9, -0.07, 1.95, 0.9, -0.2,
               -0.5, 0.3, 0.4, -0.37, 0.6]
    hist2_x = [0.8, 1.5, 1.5, 0.6, 0.59,
               1.0, 0.8, 1.7, 0.5, 0.8,
               -0.3, 1.2, 0.56, 0.3, 2.2]
    
    # Group data together
    hist_data = [hist1_x, hist2_x]
    
    # Add text
    rug_text_1 = ['a1', 'b1', 'c1', 'd1', 'e1',
          'f1', 'g1', 'h1', 'i1', 'j1',
          'k1', 'l1', 'm1', 'n1', 'o1']
    
    rug_text_2 = ['a2', 'b2', 'c2', 'd2', 'e2',
          'f2', 'g2', 'h2', 'i2', 'j2',
          'k2', 'l2', 'm2', 'n2', 'o2']
    
    # Group text together
    rug_text_all = [rug_text_1, rug_text_2]
    
    # Create distplot
    fig = FF.create_distplot(hist_data, group_labels = ['2012', '2013'], 
                             rug_text=rug_text_all, bin_size=.2)
    
    # Add title
    fig['layout'].update(title='Dist Plot')
    
    # Plot!
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/862.embed?share_key=0GFD3QDMe4GDsJ4trhPzEn" height="525px" width="100%"></iframe>



normal distribution plot with no rug
====================================

.. code:: python

    x1 = np.random.randn(190)
    x2 = np.random.randn(200)+1
    x3 = np.random.randn(200)-1
    x4 = np.random.randn(210)+2
    
    hist_data = [x1, x2, x3, x4]
    group_labels = ['2012', '2013', '2014', '2015']
    
    fig = FF.create_distplot(
        hist_data, group_labels, curve_type='normal',#'kde' or 'normal'
        show_rug=False, bin_size=.4)
    
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/864.embed?share_key=OtoO3zGA0uosSmPZdsehmo" height="525px" width="100%"></iframe>



Distplot with pandas
====================

Note the clever use of list-comprehension below

.. code:: python

    df = pd.DataFrame({'2012': np.random.randn(200),
                       '2013': np.random.randn(200)+1})
    py.iplot(FF.create_distplot([df[c] for c in df.columns], df.columns))




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/866.embed?share_key=Juf3w3aQExndcADaEPHH8G" height="525px" width="100%"></iframe>



#########################
create\_scatterplotmatrix
#########################

vanilla scatterplotmatrix
-------------------------

.. code:: python

    df = pd.DataFrame(np.random.randn(10, 2),columns=['Column 1', 'Column 2'])
    fig = FF.create_scatterplotmatrix(df)
    fig['layout'].update(dict(width=600,height=600))
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]  [ (2,2) x4,y4 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/872.embed?share_key=dOyax1VyTNryrJGhm98f9g" height="600px" width="600px"></iframe>



Diagonal boxplots
=================

``index`` is like ``hue`` in seaborn

.. code:: python

    df = pd.DataFrame(np.random.randn(10, 4),columns=['A', 'B', 'C', 'D'])
    
    # Add another column of strings to the dataframe
    df['Fruit'] = pd.Series(['apple', 'apple', 'grape', 'apple', 'apple',
                             'grape', 'pear', 'pear', 'apple', 'pear'])
    
    fig = FF.create_scatterplotmatrix(df, diag='box', index='Fruit',height=1000, width=1000)
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]    [ (1,2) x2,y2 ]    [ (1,3) x3,y3 ]    [ (1,4) x4,y4 ]  
    [ (2,1) x5,y5 ]    [ (2,2) x6,y6 ]    [ (2,3) x7,y7 ]    [ (2,4) x8,y8 ]  
    [ (3,1) x9,y9 ]    [ (3,2) x10,y10 ]  [ (3,3) x11,y11 ]  [ (3,4) x12,y12 ]
    [ (4,1) x13,y13 ]  [ (4,2) x14,y14 ]  [ (4,3) x15,y15 ]  [ (4,4) x16,y16 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/874.embed?share_key=1xgVdyQ3ZNY2NknOhZz8V7" height="1000px" width="1000px"></iframe>



Use a Theme to Style the Subplots
=================================

.. code:: python

    # Create dataframe with random data
    df = pd.DataFrame(np.random.randn(100, 3),columns=['A', 'B', 'C'])
    
    # Create scatterplot matrix using a built-in
    # Plotly palette scale and indexing column 'A'
    fig = FF.create_scatterplotmatrix(df, diag='histogram',index='A', colormap='Blues',
                                      height=800, width=800)
    
    # Plot
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]  [ (2,2) x4,y4 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/880.embed?share_key=lPomrdIEbk6Z6UofHenrhq" height="800px" width="800px"></iframe>



Example 4 with Interval Factoring
=================================

.. code:: python

    # Create dataframe with random data
    df = pd.DataFrame(np.random.randn(100, 3),columns=['A', 'B', 'C'])
    
    # Create scatterplot matrix using a list of 2 rgb tuples
    # and endpoints at -1, 0 and 1
    fig = FF.create_scatterplotmatrix(df, diag='box', index='A',
        colormap=['rgb(140, 255, 50)','rgb(170, 60, 115)','#6c4774',(0.5, 0.1, 0.8)],
        endpts=[-1, 0, 1],height=800, width=800)
    
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]
    [ (2,1) x3,y3 ]  [ (2,2) x4,y4 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/884.embed?share_key=Fc22GJfhFaRSZp247KsNd4" height="800px" width="800px"></iframe>



Using the colormap as a Dictionary
==================================

.. code:: python

    import random
    
    # Create dataframe with random data
    df = pd.DataFrame(np.random.randn(100, 3),
                       columns=['Column A','Column B','Column C'])
    
    # Add new color column to dataframe
    new_column = []
    strange_colors = ['turquoise', 'limegreen', 'goldenrod']
    
    for j in range(100):
        new_column.append(random.choice(strange_colors))
    df['Colors'] = pd.Series(new_column, index=df.index)
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Column A</th>
          <th>Column B</th>
          <th>Column C</th>
          <th>Colors</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.0408</td>
          <td>-0.3364</td>
          <td>-2.2249</td>
          <td>turquoise</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.6119</td>
          <td>-0.1273</td>
          <td>-0.6556</td>
          <td>turquoise</td>
        </tr>
        <tr>
          <th>2</th>
          <td>-0.5556</td>
          <td>-1.3014</td>
          <td>0.0922</td>
          <td>turquoise</td>
        </tr>
        <tr>
          <th>3</th>
          <td>-0.8998</td>
          <td>-0.4567</td>
          <td>-1.5237</td>
          <td>turquoise</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.4909</td>
          <td>0.1176</td>
          <td>0.3163</td>
          <td>turquoise</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    # Create scatterplot matrix using a dictionary of hex color values
    # which correspond to actual color names in 'Colors' column
    fig = FF.create_scatterplotmatrix(
        df, diag='box', index='Colors', # index is kinda like hue in seaborn
        colormap= dict(
            turquoise = '#00F5FF',
            limegreen = '#32CD32',
            goldenrod = '#DAA520'
        ),
        colormap_type='cat',
        height=800, width=800
    )
    # Plot
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y2 ]  [ (1,3) x3,y3 ]
    [ (2,1) x4,y4 ]  [ (2,2) x5,y5 ]  [ (2,3) x6,y6 ]
    [ (3,1) x7,y7 ]  [ (3,2) x8,y8 ]  [ (3,3) x9,y9 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/886.embed?share_key=X5QeWJAIjRNf0BuZc1NfyL" height="800px" width="800px"></iframe>



#############
create\_table
#############

Simple Plotly Table
===================

.. code:: python

    text = [['Country', 'Year', 'Population'],
            ['US', 2000, 282200000],
            ['Canada', 2000, 27790000],
            ['US', 2010, 309000000],
            ['Canada', 2010, 34000000]]
    
    table = FF.create_table(text)
    py.iplot(table)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/890.embed?share_key=sVTvrrDOjFqFDDDlZMPDtW" height="200px" width="100%"></iframe>



Table with Custom Coloring
==========================

.. code:: python

    table = FF.create_table(text,
          colorscale=[[0, '#000000'],[.5, '#80beff'],[1, '#cce5ff']],
          font_colors=['#ffffff', '#000000','#000000'])
    py.iplot(table)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/892.embed?share_key=iXeevPK1bzyyKxn0mBPiUF" height="200px" width="100%"></iframe>



Using pandas
============

.. code:: python

    df = pd.read_csv('http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt', 
                     sep='\t')
    df_p = df[0:6]
    
    table_simple = FF.create_table(df_p)
    py.iplot(table_simple)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/888.embed?share_key=HVERW7i2MmMewe3aUNE6Ti" height="260px" width="100%"></iframe>



##############
create\_violin
##############

Single violin plot
------------------

.. code:: python

    # create list of random values
    data_list = np.random.randn(100)
    # data_list.tolist()
    
    # create violin fig
    fig = FF.create_violin(data_list, colors='#604d9e')
    
    # plot
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/894.embed?share_key=ZcW4gSweznbDUf0WXZ7Cb8" height="450px" width="600px"></iframe>



Multiple Violin Plots with Qualitative Coloring
===============================================

.. code:: python

    # create dataframe
    np.random.seed(619517)
    Nr=250
    y = np.random.randn(Nr)
    gr = np.random.choice(list("ABCDE"), Nr)
    norm_params=[(0, 1.2), (0.7, 1), (-0.5, 1.4), (0.3, 1), (0.8, 0.9)]
    
    for i, letter in enumerate("ABCDE"):
        y[gr == letter] *=norm_params[i][1]+ norm_params[i][0]
    df = pd.DataFrame(dict(Score=y, Group=gr))
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Group</th>
          <th>Score</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>B</td>
          <td>1.6562</td>
        </tr>
        <tr>
          <th>1</th>
          <td>C</td>
          <td>-1.3793</td>
        </tr>
        <tr>
          <th>2</th>
          <td>C</td>
          <td>1.5677</td>
        </tr>
        <tr>
          <th>3</th>
          <td>B</td>
          <td>1.4846</td>
        </tr>
        <tr>
          <th>4</th>
          <td>E</td>
          <td>0.4106</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    # create violin fig
    fig = FF.create_violin(df, data_header='Score', group_header='Group',
                           height=600, width=1000)
    
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y1 ]  [ (1,3) x3,y1 ]  [ (1,4) x4,y1 ]  [ (1,5) x5,y1 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/896.embed?share_key=MQpYShdA8mAK6KtAFydYRv" height="600px" width="1000px"></iframe>



Violin Plots with Colorscale
============================

.. code:: python

    # define header params
    data_header = 'Score'
    group_header = 'Group'
    
    # make groupby object with pandas
    group_stats = {}
    groupby_data = df.groupby([group_header])
    
    for group in "ABCDE":
        data_from_group = groupby_data.get_group(group)[data_header]
        # take median of the grouped data
        group_stats[group] = np.median(data_from_group)
        
    group_stats




.. parsed-literal::
    :class: myliteral

    {'A': -0.58132987295885585,
     'B': 0.13909523462167314,
     'C': -0.16978685879501004,
     'D': -0.21956036692836567,
     'E': -0.0043455060692985173}



.. code:: python

    fig = FF.create_violin(df, data_header='Score', group_header='Group',
                           height=600, width=1000, use_colorscale=True,
                           group_stats=group_stats)
    py.iplot(fig)


.. parsed-literal::
    :class: myliteral

    This is the format of your plot grid:
    [ (1,1) x1,y1 ]  [ (1,2) x2,y1 ]  [ (1,3) x3,y1 ]  [ (1,4) x4,y1 ]  [ (1,5) x5,y1 ]
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/898.embed?share_key=1wyFoVGcg77bwpEt0YUnog" height="600px" width="1000px"></iframe>



