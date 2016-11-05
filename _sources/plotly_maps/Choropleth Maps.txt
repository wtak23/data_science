###############
Choropleth Maps
###############

https://plot.ly/python/choropleth-maps/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import pandas as pd
    from IPython.display import display

United States Choropleth Map
============================

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv')
    
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>code</th>
          <th>state</th>
          <th>category</th>
          <th>total exports</th>
          <th>beef</th>
          <th>pork</th>
          <th>poultry</th>
          <th>dairy</th>
          <th>fruits fresh</th>
          <th>fruits proc</th>
          <th>total fruits</th>
          <th>veggies fresh</th>
          <th>veggies proc</th>
          <th>total veggies</th>
          <th>corn</th>
          <th>wheat</th>
          <th>cotton</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>AL</td>
          <td>Alabama</td>
          <td>state</td>
          <td>1390.63</td>
          <td>34.4</td>
          <td>10.6</td>
          <td>481.0</td>
          <td>4.06</td>
          <td>8.0</td>
          <td>17.1</td>
          <td>25.11</td>
          <td>5.5</td>
          <td>8.9</td>
          <td>14.33</td>
          <td>34.9</td>
          <td>70.0</td>
          <td>317.61</td>
        </tr>
        <tr>
          <th>1</th>
          <td>AK</td>
          <td>Alaska</td>
          <td>state</td>
          <td>13.31</td>
          <td>0.2</td>
          <td>0.1</td>
          <td>0.0</td>
          <td>0.19</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.00</td>
          <td>0.6</td>
          <td>1.0</td>
          <td>1.56</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.00</td>
        </tr>
        <tr>
          <th>2</th>
          <td>AZ</td>
          <td>Arizona</td>
          <td>state</td>
          <td>1463.17</td>
          <td>71.3</td>
          <td>17.9</td>
          <td>0.0</td>
          <td>105.48</td>
          <td>19.3</td>
          <td>41.0</td>
          <td>60.27</td>
          <td>147.5</td>
          <td>239.4</td>
          <td>386.91</td>
          <td>7.3</td>
          <td>48.7</td>
          <td>423.95</td>
        </tr>
        <tr>
          <th>3</th>
          <td>AR</td>
          <td>Arkansas</td>
          <td>state</td>
          <td>3586.02</td>
          <td>53.2</td>
          <td>29.4</td>
          <td>562.9</td>
          <td>3.53</td>
          <td>2.2</td>
          <td>4.7</td>
          <td>6.88</td>
          <td>4.4</td>
          <td>7.1</td>
          <td>11.45</td>
          <td>69.5</td>
          <td>114.5</td>
          <td>665.44</td>
        </tr>
        <tr>
          <th>4</th>
          <td>CA</td>
          <td>California</td>
          <td>state</td>
          <td>16472.88</td>
          <td>228.7</td>
          <td>11.1</td>
          <td>225.4</td>
          <td>929.95</td>
          <td>2791.8</td>
          <td>5944.6</td>
          <td>8736.40</td>
          <td>803.2</td>
          <td>1303.5</td>
          <td>2106.79</td>
          <td>34.6</td>
          <td>249.3</td>
          <td>1064.95</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    for col in df.columns:
        df[col] = df[col].astype(str)
    
    scl = [[0.0, 'rgb(242,240,247)'],[0.2, 'rgb(218,218,235)'],[0.4, 'rgb(188,189,220)'],\
                [0.6, 'rgb(158,154,200)'],[0.8, 'rgb(117,107,177)'],[1.0, 'rgb(84,39,143)']]
    
    df['text'] = df['state'] + '<br>' +\
        'Beef '+df['beef']+' Dairy '+df['dairy']+'<br>'+\
        'Fruits '+df['total fruits']+' Veggies ' + df['total veggies']+'<br>'+\
        'Wheat '+df['wheat']+' Corn '+df['corn']
    
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>code</th>
          <th>state</th>
          <th>category</th>
          <th>total exports</th>
          <th>beef</th>
          <th>pork</th>
          <th>poultry</th>
          <th>dairy</th>
          <th>fruits fresh</th>
          <th>fruits proc</th>
          <th>total fruits</th>
          <th>veggies fresh</th>
          <th>veggies proc</th>
          <th>total veggies</th>
          <th>corn</th>
          <th>wheat</th>
          <th>cotton</th>
          <th>text</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>AL</td>
          <td>Alabama</td>
          <td>state</td>
          <td>1390.63</td>
          <td>34.4</td>
          <td>10.6</td>
          <td>481.0</td>
          <td>4.06</td>
          <td>8.0</td>
          <td>17.1</td>
          <td>25.11</td>
          <td>5.5</td>
          <td>8.9</td>
          <td>14.33</td>
          <td>34.9</td>
          <td>70.0</td>
          <td>317.61</td>
          <td>Alabama&lt;br&gt;Beef 34.4 Dairy 4.06&lt;br&gt;Fruits 25.1...</td>
        </tr>
        <tr>
          <th>1</th>
          <td>AK</td>
          <td>Alaska</td>
          <td>state</td>
          <td>13.31</td>
          <td>0.2</td>
          <td>0.1</td>
          <td>0.0</td>
          <td>0.19</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.6</td>
          <td>1.0</td>
          <td>1.56</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>Alaska&lt;br&gt;Beef 0.2 Dairy 0.19&lt;br&gt;Fruits 0.0 Ve...</td>
        </tr>
        <tr>
          <th>2</th>
          <td>AZ</td>
          <td>Arizona</td>
          <td>state</td>
          <td>1463.17</td>
          <td>71.3</td>
          <td>17.9</td>
          <td>0.0</td>
          <td>105.48</td>
          <td>19.3</td>
          <td>41.0</td>
          <td>60.27</td>
          <td>147.5</td>
          <td>239.4</td>
          <td>386.91</td>
          <td>7.3</td>
          <td>48.7</td>
          <td>423.95</td>
          <td>Arizona&lt;br&gt;Beef 71.3 Dairy 105.48&lt;br&gt;Fruits 60...</td>
        </tr>
        <tr>
          <th>3</th>
          <td>AR</td>
          <td>Arkansas</td>
          <td>state</td>
          <td>3586.02</td>
          <td>53.2</td>
          <td>29.4</td>
          <td>562.9</td>
          <td>3.53</td>
          <td>2.2</td>
          <td>4.7</td>
          <td>6.88</td>
          <td>4.4</td>
          <td>7.1</td>
          <td>11.45</td>
          <td>69.5</td>
          <td>114.5</td>
          <td>665.44</td>
          <td>Arkansas&lt;br&gt;Beef 53.2 Dairy 3.53&lt;br&gt;Fruits 6.8...</td>
        </tr>
        <tr>
          <th>4</th>
          <td>CA</td>
          <td>California</td>
          <td>state</td>
          <td>16472.88</td>
          <td>228.7</td>
          <td>11.1</td>
          <td>225.4</td>
          <td>929.95</td>
          <td>2791.8</td>
          <td>5944.6</td>
          <td>8736.4</td>
          <td>803.2</td>
          <td>1303.5</td>
          <td>2106.79</td>
          <td>34.6</td>
          <td>249.3</td>
          <td>1064.95</td>
          <td>California&lt;br&gt;Beef 228.7 Dairy 929.95&lt;br&gt;Frui...</td>
        </tr>
      </tbody>
    </table>
    </div>



Define data object
==================

.. code:: python

    trace = dict(
            type='choropleth',
            colorscale = scl,
            autocolorscale = False,
            locations = df['code'],
            z = df['total exports'].astype(float),
            locationmode = 'USA-states',
            text = df['text'],
            marker = dict(line = dict (color = 'rgb(255,255,255)',width = 2) ),
            colorbar = dict(title = "Millions USD")
    )
    data = [ trace ]

Define layout object
====================

.. code:: python

    geo = dict(scope='usa',
               projection=dict( type='albers usa' ),
               showlakes = True,
               lakecolor = 'rgb(255, 255, 255)')
    title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)'
    layout = dict(geo=geo,title = title)
        
    fig = dict( data=data, layout=layout )
    py.iplot( fig, filename='d3-cloropleth-map' )




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1141.embed?share_key=AlSxsrPvcUzqK9vlEhCeOe" height="525px" width="100%"></iframe>



World choropleth map
====================

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
    df.head(n=5)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>COUNTRY</th>
          <th>GDP (BILLIONS)</th>
          <th>CODE</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Afghanistan</td>
          <td>21.71</td>
          <td>AFG</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Albania</td>
          <td>13.40</td>
          <td>ALB</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Algeria</td>
          <td>227.80</td>
          <td>DZA</td>
        </tr>
        <tr>
          <th>3</th>
          <td>American Samoa</td>
          <td>0.75</td>
          <td>ASM</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Andorra</td>
          <td>4.80</td>
          <td>AND</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    print df.shape
    df = df.ix[101:]
    df.reset_index(drop=True,inplace=True)
    print df.shape
    df.head(n=5)


.. parsed-literal::
    :class: myliteral

    (222, 3)
    (121, 3)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>COUNTRY</th>
          <th>GDP (BILLIONS)</th>
          <th>CODE</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Japan</td>
          <td>4770.00</td>
          <td>JPN</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Jersey</td>
          <td>5.77</td>
          <td>JEY</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Jordan</td>
          <td>36.55</td>
          <td>JOR</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Kazakhstan</td>
          <td>225.60</td>
          <td>KAZ</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Kenya</td>
          <td>62.72</td>
          <td>KEN</td>
        </tr>
      </tbody>
    </table>
    </div>



Define data
===========

.. code:: python

    trace = dict(
            type = 'choropleth',
            locations = df['CODE'],
            z = df['GDP (BILLIONS)'],
            text = df['COUNTRY'],
            colorscale = [[0,"rgb(5, 10, 172)"],[0.35,"rgb(40, 60, 190)"],[0.5,"rgb(70, 100, 245)"],\
                          [0.6,"rgb(90, 120, 245)"],[0.7,"rgb(106, 137, 247)"],[1,"rgb(220, 220, 220)"]],
            autocolorscale = False,
            reversescale = True,
            marker = dict(line = dict (color = 'rgb(180,180,180)',width = 0.5) ),
            colorbar = dict(autotick = False,tickprefix = '$',title = 'GDP<br>Billions US$'),
    )
    data = [ trace ]

Define layout
=============

.. code:: python

    layout = dict(
        title = '2014 Global GDP<br>Source:\
                <a href="https://www.cia.gov/library/publications/the-world-factbook/fields/2195.html">\
                CIA World Factbook</a>',
        geo = dict(
            showframe = False,
            showcoastlines = False,
            projection = dict(type = 'Mercator')
        )
    )
    
    fig = dict( data=data, layout=layout )
    py.iplot( fig, validate=False, filename='d3-world-map' )




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1143.embed?share_key=g77iXeFPYo5e7DbsuDCxme" height="525px" width="100%"></iframe>



Choropleth Inset Map
====================

.. code:: python

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_ebola.csv')
    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Country</th>
          <th>Month</th>
          <th>Year</th>
          <th>Lat</th>
          <th>Lon</th>
          <th>Value</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Guinea</td>
          <td>3</td>
          <td>14</td>
          <td>9.95</td>
          <td>-9.7</td>
          <td>122.0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Guinea</td>
          <td>4</td>
          <td>14</td>
          <td>9.95</td>
          <td>-9.7</td>
          <td>224.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Guinea</td>
          <td>5</td>
          <td>14</td>
          <td>9.95</td>
          <td>-9.7</td>
          <td>291.0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Guinea</td>
          <td>6</td>
          <td>14</td>
          <td>9.95</td>
          <td>-9.7</td>
          <td>413.0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Guinea</td>
          <td>7</td>
          <td>14</td>
          <td>9.95</td>
          <td>-9.7</td>
          <td>460.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    cases = []
    colors = ['rgb(239,243,255)','rgb(189,215,231)','rgb(107,174,214)','rgb(33,113,181)']
    months = {6:'June',7:'July',8:'Aug',9:'Sept'}
    
    for i in range(6,10)[::-1]:
        cases.append(go.Scattergeo(
            lon = df[ df['Month'] == i ]['Lon'], #-(max(range(6,10))-i),
            lat = df[ df['Month'] == i ]['Lat'],
            text = df[ df['Month'] == i ]['Value'],
            name = months[i],
            marker = dict(
                size = df[ df['Month'] == i ]['Value']/50,
                color = colors[i-6],
                line = dict(width = 0)
            ),
        ) )
    
    cases[0]['text'] = df[ df['Month'] == 9 ]['Value'].map('{:.0f}'.format).astype(str)+' '+\
        df[ df['Month'] == 9 ]['Country']
    cases[0]['mode'] = 'markers+text'
    cases[0]['textposition'] = 'bottom center'
    
    inset = [
        go.Choropleth(
            locationmode = 'country names',
            locations = df[ df['Month'] == 9 ]['Country'],
            z = df[ df['Month'] == 9 ]['Value'],
            text = df[ df['Month'] == 9 ]['Country'],
            colorscale = [[0,'rgb(0, 0, 0)'],[1,'rgb(0, 0, 0)']],
            autocolorscale = False,
            showscale = False,
            geo = 'geo2'
        ),
        go.Scattergeo(
            lon = [21.0936],
            lat = [7.1881],
            text = ['Africa'],
            mode = 'text',
            showlegend = False,
            geo = 'geo2'
        )
    ]
    
    layout = go.Layout(
        title = 'Ebola cases reported by month in West Africa 2014<br> \
    Source: <a href="https://data.hdx.rwlabs.org/dataset/rowca-ebola-cases">\
    HDX</a>',
        geo = dict(
            resolution = 50,
            scope = 'africa',
            showframe = False,
            showcoastlines = True,
            showland = True,
            landcolor = "rgb(229, 229, 229)",
            countrycolor = "rgb(255, 255, 255)" ,
            coastlinecolor = "rgb(255, 255, 255)",
            projection = dict(
                type = 'Mercator'
            ),
            lonaxis = dict( range= [ -15.0, -5.0 ] ),
            lataxis = dict( range= [ 0.0, 12.0 ] ),
            domain = dict(
                x = [ 0, 1 ],
                y = [ 0, 1 ]
            )
        ),
        geo2 = dict(
            scope = 'africa',
            showframe = False,
            showland = True,
            landcolor = "rgb(229, 229, 229)",
            showcountries = False,
            domain = dict(
                x = [ 0, 0.6 ],
                y = [ 0, 0.6 ]
            ),
            bgcolor = 'rgba(255, 255, 255, 0.0)',
        ),
        legend = dict(
               traceorder = 'reversed'
        )
    )
    
    fig = go.Figure(layout=layout, data=cases+inset)
    py.iplot(fig, validate=False, filename='West Africa Ebola cases 2014')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1145.embed?share_key=n6Gnj8yDd3XWgEwfNNLvb6" height="525px" width="100%"></iframe>



