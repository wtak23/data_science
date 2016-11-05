
######################
Spark demo with Plotly
######################
From https://plot.ly/python/apache-spark/

.. contents:: `Contents`
   :depth: 2
   :local:



Check pyspark is loaded correctly
=================================

.. code:: python

    import os
    import sys
    
    spark_home = os.environ.get('SPARK_HOME', None)
    print spark_home


.. parsed-literal::
    :class: myliteral

    /home/takanori/mybin/spark-2.0.0-bin-hadoop2.7


.. code:: python

    from __future__ import print_function #python 3 support
    print(sc)


.. parsed-literal::
    :class: myliteral

    <pyspark.context.SparkContext object at 0x7f6ca3274d50>


Spark Context object loaded nicely :).

How about ``sqlcontext``?

.. code:: python

    from pyspark.sql import SQLContext
    sqlContext = SQLContext(sc)
    print(sqlContext)


.. parsed-literal::
    :class: myliteral

    <pyspark.sql.context.SQLContext object at 0x7f6c91426090>


Download bike data
==================

.. code:: python

    %%bash
    wget https://raw.githubusercontent.com/anabranch/Interactive-Graphs-with-Plotly/master/btd2.json


.. parsed-literal::
    :class: myliteral

    --2016-09-22 15:49:51--  https://raw.githubusercontent.com/anabranch/Interactive-Graphs-with-Plotly/master/btd2.json
    Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.20.133
    Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.20.133|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 41125386 (39M) [text/plain]
    Saving to: ‘btd2.json’
    
         0K .......... .......... .......... .......... ..........  0%  219M 0s
        50K .......... .......... .......... .......... ..........  0%  402M 0s
       100K .......... .......... .......... .......... ..........  0%  408M 0s
       150K .......... .......... .......... .......... ..........  0%  382M 0s
       200K .......... .......... .......... .......... ..........  0% 8.15M 1s
       250K .......... .......... .......... .......... ..........  0% 7.07M 2s
       300K .......... .......... .......... .......... ..........  0% 16.5M 2s
       350K .......... .......... .......... .......... ..........  0% 4.44M 3s
       400K .......... .......... .......... .......... ..........  1% 7.13M 3s
       450K .......... .......... .......... .......... ..........  1% 14.0M 3s
       500K .......... .......... .......... .......... ..........  1% 6.76M 3s
       550K .......... .......... .......... .......... ..........  1% 6.98M 3s
       600K .......... .......... .......... .......... ..........  1% 7.04M 4s
       650K .......... .......... .......... .......... ..........  1% 20.3M 3s
       700K .......... .......... .......... .......... ..........  1% 7.09M 4s
       750K .......... .......... .......... .......... ..........  1% 6.18M 4s
       800K .......... .......... .......... .......... ..........  2% 7.69M 4s
       850K .......... .......... .......... .......... ..........  2% 7.78M 4s
       900K .......... .......... .......... .......... ..........  2% 17.9M 4s
       950K .......... .......... .......... .......... ..........  2% 6.93M 4s
      1000K .......... .......... .......... .......... ..........  2% 6.80M 4s
      1050K .......... .......... .......... .......... ..........  2% 6.88M 4s
      1100K .......... .......... .......... .......... ..........  2% 6.87M 4s
      1150K .......... .......... .......... .......... ..........  2% 6.29M 4s
      1200K .......... .......... .......... .......... ..........  3% 67.3M 4s
      1250K .......... .......... .......... .......... ..........  3% 6.84M 4s
      1300K .......... .......... .......... .......... ..........  3% 6.09M 4s
      1350K .......... .......... .......... .......... ..........  3% 6.70M 4s
      1400K .......... .......... .......... .......... ..........  3% 54.7M 4s
      1450K .......... .......... .......... .......... ..........  3% 6.91M 4s
      1500K .......... .......... .......... .......... ..........  3% 6.87M 4s
      1550K .......... .......... .......... .......... ..........  3% 6.39M 4s
      1600K .......... .......... .......... .......... ..........  4% 6.70M 4s
      1650K .......... .......... .......... .......... ..........  4% 7.22M 4s
      1700K .......... .......... .......... .......... ..........  4% 37.6M 4s
      1750K .......... .......... .......... .......... ..........  4% 6.87M 4s
      1800K .......... .......... .......... .......... ..........  4% 6.53M 4s
      1850K .......... .......... .......... .......... ..........  4% 6.78M 4s
      1900K .......... .......... .......... .......... ..........  4% 7.13M 4s
      1950K .......... .......... .......... .......... ..........  4% 6.80M 4s
      2000K .......... .......... .......... .......... ..........  5% 40.6M 4s
      2050K .......... .......... .......... .......... ..........  5% 6.46M 4s
      2100K .......... .......... .......... .......... ..........  5% 6.77M 4s
      2150K .......... .......... .......... .......... ..........  5% 7.28M 4s
      2200K .......... .......... .......... .......... ..........  5% 37.0M 4s
      2250K .......... .......... .......... .......... ..........  5% 6.86M 4s
      2300K .......... .......... .......... .......... ..........  5% 6.85M 4s
      2350K .......... .......... .......... .......... ..........  5% 6.71M 4s
      2400K .......... .......... .......... .......... ..........  6% 8.05M 4s
      2450K .......... .......... .......... .......... ..........  6% 21.1M 4s
      2500K .......... .......... .......... .......... ..........  6% 6.76M 4s
      2550K .......... .......... .......... .......... ..........  6% 6.85M 4s
      2600K .......... .......... .......... .......... ..........  6% 6.80M 4s
      2650K .......... .......... .......... .......... ..........  6% 46.5M 4s
      2700K .......... .......... .......... .......... ..........  6% 6.40M 4s
      2750K .......... .......... .......... .......... ..........  6% 7.18M 4s
      2800K .......... .......... .......... .......... ..........  7% 7.46M 4s
      2850K .......... .......... .......... .......... ..........  7% 6.73M 4s
      2900K .......... .......... .......... .......... ..........  7% 7.66M 4s
      2950K .......... .......... .......... .......... ..........  7% 26.6M 4s
      3000K .......... .......... .......... .......... ..........  7% 6.83M 4s
      3050K .......... .......... .......... .......... ..........  7% 6.77M 4s
      3100K .......... .......... .......... .......... ..........  7% 8.92M 4s
      3150K .......... .......... .......... .......... ..........  7% 5.43M 4s
      3200K .......... .......... .......... .......... ..........  8% 57.0M 4s
      3250K .......... .......... .......... .......... ..........  8% 6.69M 4s
      3300K .......... .......... .......... .......... ..........  8% 6.77M 4s
      3350K .......... .......... .......... .......... ..........  8% 6.45M 4s
      3400K .......... .......... .......... .......... ..........  8% 66.7M 4s
      3450K .......... .......... .......... .......... ..........  8% 7.07M 4s
      3500K .......... .......... .......... .......... ..........  8% 6.26M 4s
      3550K .......... .......... .......... .......... ..........  8% 6.28M 4s
      3600K .......... .......... .......... .......... ..........  9% 2.88M 4s
      3650K .......... .......... .......... .......... ..........  9% 32.5M 4s
      3700K .......... .......... .......... .......... ..........  9% 6.80M 4s
      3750K .......... .......... .......... .......... ..........  9% 6.32M 4s
      3800K .......... .......... .......... .......... ..........  9% 7.36M 4s
      3850K .......... .......... .......... .......... ..........  9% 54.7M 4s
      3900K .......... .......... .......... .......... ..........  9% 6.66M 4s
      3950K .......... .......... .......... .......... ..........  9% 6.79M 4s
      4000K .......... .......... .......... .......... .......... 10% 6.63M 4s
      4050K .......... .......... .......... .......... .......... 10% 6.87M 4s
      4100K .......... .......... .......... .......... .......... 10% 27.6M 4s
      4150K .......... .......... .......... .......... .......... 10% 7.89M 4s
      4200K .......... .......... .......... .......... .......... 10% 5.85M 4s
      4250K .......... .......... .......... .......... .......... 10% 6.54M 4s
      4300K .......... .......... .......... .......... .......... 10% 49.3M 4s
      4350K .......... .......... .......... .......... .......... 10% 5.06M 4s
      4400K .......... .......... .......... .......... .......... 11% 6.75M 4s
      4450K .......... .......... .......... .......... .......... 11% 6.74M 4s
      4500K .......... .......... .......... .......... .......... 11% 11.4M 4s
      4550K .......... .......... .......... .......... .......... 11% 7.05M 4s
      4600K .......... .......... .......... .......... .......... 11% 12.6M 4s
      4650K .......... .......... .......... .......... .......... 11% 6.86M 4s
      4700K .......... .......... .......... .......... .......... 11% 7.81M 4s
      4750K .......... .......... .......... .......... .......... 11% 6.13M 4s
      4800K .......... .......... .......... .......... .......... 12% 9.07M 4s
      4850K .......... .......... .......... .......... .......... 12% 6.91M 4s
      4900K .......... .......... .......... .......... .......... 12% 3.98M 4s
      4950K .......... .......... .......... .......... .......... 12% 7.10M 4s
      5000K .......... .......... .......... .......... .......... 12% 13.0M 4s
      5050K .......... .......... .......... .......... .......... 12% 6.49M 4s
      5100K .......... .......... .......... .......... .......... 12% 12.4M 4s
      5150K .......... .......... .......... .......... .......... 12% 6.33M 4s
      5200K .......... .......... .......... .......... .......... 13% 6.70M 4s
      5250K .......... .......... .......... .......... .......... 13% 8.85M 4s
      5300K .......... .......... .......... .......... .......... 13% 6.77M 4s
      5350K .......... .......... .......... .......... .......... 13% 9.48M 4s
      5400K .......... .......... .......... .......... .......... 13% 9.72M 4s
      5450K .......... .......... .......... .......... .......... 13% 7.08M 4s
      5500K .......... .......... .......... .......... .......... 13% 7.86M 4s
      5550K .......... .......... .......... .......... .......... 13% 6.09M 4s
      5600K .......... .......... .......... .......... .......... 14% 7.02M 4s
      5650K .......... .......... .......... .......... .......... 14% 24.9M 4s
      5700K .......... .......... .......... .......... .......... 14% 6.75M 4s
      5750K .......... .......... .......... .......... .......... 14% 8.10M 4s
      5800K .......... .......... .......... .......... .......... 14% 6.20M 4s
      5850K .......... .......... .......... .......... .......... 14% 13.4M 4s
      5900K .......... .......... .......... .......... .......... 14% 6.57M 4s
      5950K .......... .......... .......... .......... .......... 14% 4.86M 4s
      6000K .......... .......... .......... .......... .......... 15% 22.3M 4s
      6050K .......... .......... .......... .......... .......... 15% 6.84M 4s
      6100K .......... .......... .......... .......... .......... 15% 6.42M 4s
      6150K .......... .......... .......... .......... .......... 15% 9.29M 4s
      6200K .......... .......... .......... .......... .......... 15% 5.37M 4s
      6250K .......... .......... .......... .......... .......... 15% 48.8M 4s
      6300K ........**OUTPUT MUTED**

.. code:: python

    btd = sqlContext.read.json('btd2.json')

.. code:: python

    print(type(btd))


.. parsed-literal::
    :class: myliteral

    <class 'pyspark.sql.dataframe.DataFrame'>


.. code:: python

    btd.printSchema()


.. parsed-literal::
    :class: myliteral

    root
     |-- Bike #: string (nullable = true)
     |-- Duration: string (nullable = true)
     |-- End Date: string (nullable = true)
     |-- End Station: string (nullable = true)
     |-- End Terminal: string (nullable = true)
     |-- Start Date: string (nullable = true)
     |-- Start Station: string (nullable = true)
     |-- Start Terminal: string (nullable = true)
     |-- Subscription Type: string (nullable = true)
     |-- Trip ID: string (nullable = true)
     |-- Zip Code: string (nullable = true)
    


.. code:: python

    btd.take(3)




.. parsed-literal::
    :class: myliteral

    [Row(Bike #=u'520', Duration=u'63', End Date=u'8/29/13 14:14', End Station=u'South Van Ness at Market', End Terminal=u'66', Start Date=u'8/29/13 14:13', Start Station=u'South Van Ness at Market', Start Terminal=u'66', Subscription Type=u'Subscriber', Trip ID=u'4576', Zip Code=u'94127'),
     Row(Bike #=u'661', Duration=u'70', End Date=u'8/29/13 14:43', End Station=u'San Jose City Hall', End Terminal=u'10', Start Date=u'8/29/13 14:42', Start Station=u'San Jose City Hall', Start Terminal=u'10', Subscription Type=u'Subscriber', Trip ID=u'4607', Zip Code=u'95138'),
     Row(Bike #=u'48', Duration=u'71', End Date=u'8/29/13 10:17', End Station=u'Mountain View City Hall', End Terminal=u'27', Start Date=u'8/29/13 10:16', Start Station=u'Mountain View City Hall', Start Terminal=u'27', Subscription Type=u'Subscriber', Trip ID=u'4130', Zip Code=u'97214')]



Register dataframe as table to use SQL commands!
================================================

.. code:: python

    sqlContext.registerDataFrameAsTable(btd, "bay_area_bike")

.. code:: python

    # now i can use sql commands with table named *bay_area_bike*
    df2 = sqlContext.sql("SELECT Duration as d1 from bay_area_bike where Duration < 7200")

.. code:: python

    df2.printSchema()


.. parsed-literal::
    :class: myliteral

    root
     |-- d1: string (nullable = true)
    


Now let's visualize!
====================

.. code:: python

    data = Data([Histogram(x=df2.toPandas()['d1'])])
    


.. code:: python

    py.iplot(data, filename="spark/less_2_hour_rides")


.. parsed-literal::
    :class: myliteral

    /home/takanori/.local/lib/python2.7/site-packages/plotly/plotly/plotly.py:236: UserWarning:
    
    Woah there! Look at all those points! Due to browser limitations, the Plotly SVG drawing functions have a hard time graphing more than 500k data points for line charts, or 40k points for other types of charts. Here are some suggestions:
    (1) Use the `plotly.graph_objs.Scattergl` trace object to generate a WebGl graph.
    (2) Trying using the image API to return an image instead of a graph URL
    (3) Use matplotlib
    (4) See if you can create your visualization with fewer data points
    
    If the visualization you're using aggregates points (e.g., box plot, histogram, etc.) you can disregard this warning.
    




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/189.embed" height="525px" width="100%"></iframe>



That was simple and we can see that plotly was able to handle the data
without issue. We can see that big uptick in rides that last less than
~30 minutes (2000 seconds) - so let's look at that distribution.

.. code:: python

    df3 = sqlContext.sql("SELECT Duration as d1 from bay_area_bike where Duration < 2000")
    



A great thing about Apache Spark is that you can sample easily from
large datasets, you just set the amount you would like to sample and
you're all set.

.. code:: python

    s1 = df2.sample(False, 0.05, 20)
    s2 = df3.sample(False, 0.05, 2500)

.. code:: python

    data = Data([
            Histogram(x=s1.toPandas()['d1'], name="Large Sample"),
            Histogram(x=s2.toPandas()['d1'], name="Small Sample")
        ])


Plotly converts those samples into beautifully overlayed histograms.
This is a great way to eyeball different distributions.

.. code:: python

    py.iplot(data, filename="spark/sample_rides")




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/191.embed" height="525px" width="100%"></iframe>



What's really powerful about Plotly is sharing this data is simple. I
can take the above graph and change the styling or bins visually. A
common workflow is to make a rough sketch of the graph in code, then
make a more refined version with notes to share with management like the
one below. Plotly's online interface allows you to edit graphs in other
languages as well.

.. code:: python

    import plotly.tools as tls
    tls.embed("https://plot.ly/~bill_chambers/101")




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~bill_chambers/101.embed" height="525" width="100%"></iframe>



PySpark Dataframe to Pandas Dataframe
=====================================

Now let's check out bike rentals from individual stations. We can do a
groupby with Spark DataFrames just as we might in Pandas. We've also
seen at this point how easy it is to convert a Spark DataFrame to a
pandas DataFrame.

.. code:: python

    dep_stations = btd.groupBy(btd['Start Station']).count().toPandas().sort('count', ascending=False)
    dep_stations


.. parsed-literal::
    :class: myliteral

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:1: FutureWarning:
    
    sort(columns=....) is deprecated, use sort_values(by=.....)
    




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Start Station</th>
          <th>count</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>64</th>
          <td>San Francisco Caltrain (Townsend at 4th)</td>
          <td>9838</td>
        </tr>
        <tr>
          <th>50</th>
          <td>Harry Bridges Plaza (Ferry Building)</td>
          <td>7343</td>
        </tr>
        <tr>
          <th>54</th>
          <td>Embarcadero at Sansome</td>
          <td>6545</td>
        </tr>
        <tr>
          <th>6</th>
          <td>Market at Sansome</td>
          <td>5922</td>
        </tr>
        <tr>
          <th>27</th>
          <td>Temporary Transbay Terminal (Howard at Beale)</td>
          <td>5113</td>
        </tr>
        <tr>
          <th>26</th>
          <td>Market at 4th</td>
          <td>5030</td>
        </tr>
        <tr>
          <th>66</th>
          <td>2nd at Townsend</td>
          <td>4987</td>
        </tr>
        <tr>
          <th>58</th>
          <td>San Francisco Caltrain 2 (330 Townsend)</td>
          <td>4976</td>
        </tr>
        <tr>
          <th>28</th>
          <td>Steuart at Market</td>
          <td>4913</td>
        </tr>
        <tr>
          <th>14</th>
          <td>Townsend at 7th</td>
          <td>4493</td>
        </tr>
        <tr>
          <th>61</th>
          <td>2nd at South Park</td>
          <td>4458</td>
        </tr>
        <tr>
          <th>48</th>
          <td>Grant Avenue at Columbus Avenue</td>
          <td>4004</td>
        </tr>
        <tr>
          <th>36</th>
          <td>Powell Street BART</td>
          <td>3836</td>
        </tr>
        <tr>
          <th>0</th>
          <td>2nd at Folsom</td>
          <td>3776</td>
        </tr>
        <tr>
          <th>30</th>
          <td>South Van Ness at Market</td>
          <td>3521</td>
        </tr>
        <tr>
          <th>40</th>
          <td>Market at 10th</td>
          <td>3511</td>
        </tr>
        <tr>
          <th>32</th>
          <td>Embarcadero at Bryant</td>
          <td>3497</td>
        </tr>
        <tr>
          <th>7</th>
          <td>Spear at Folsom</td>
          <td>3423</td>
        </tr>
        <tr>
          <th>60</th>
          <td>Howard at 2nd</td>
          <td>3263</td>
        </tr>
        <tr>
          <th>15</th>
          <td>Civic Center BART (7th at Market)</td>
          <td>3074</td>
        </tr>
        <tr>
          <th>44</th>
          <td>Beale at Market</td>
          <td>3057</td>
        </tr>
        <tr>
          <th>24</th>
          <td>Embarcadero at Folsom</td>
          <td>2931</td>
        </tr>
        <tr>
          <th>51</th>
          <td>Mechanics Plaza (Market at Battery)</td>
          <td>2868</td>
        </tr>
        <tr>
          <th>10</th>
          <td>Commercial at Montgomery</td>
          <td>2834</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Powell at Post (Union Square)</td>
          <td>2824</td>
        </tr>
        <tr>
          <th>65</th>
          <td>Embarcadero at Vallejo</td>
          <td>2785</td>
        </tr>
        <tr>
          <th>45</th>
          <td>5th at Howard</td>
          <td>2635</td>
        </tr>
        <tr>
          <th>19</th>
          <td>Post at Kearney</td>
          <td>2503</td>
        </tr>
        <tr>
          <th>5</th>
          <td>Yerba Buena Center of the Arts (3rd @ Howard)</td>
          <td>2487</td>
        </tr>
        <tr>
          <th>38</th>
          <td>Clay at Battery</td>
          <td>2419</td>
        </tr>
        <tr>
          <th>...</th>
          <td>...</td>
          <td>...</td>
        </tr>
        <tr>
          <th>46</th>
          <td>San Pedro Square</td>
          <td>715</td>
        </tr>
        <tr>
          <th>25</th>
          <td>Mountain View City Hall</td>
          <td>630</td>
        </tr>
        <tr>
          <th>12</th>
          <td>San Salvador at 1st</td>
          <td>597</td>
        </tr>
        <tr>
          <th>8</th>
          <td>MLK Library</td>
          <td>528</td>
        </tr>
        <tr>
          <th>9</th>
          <td>Japantown</td>
          <td>496</td>
        </tr>
        <tr>
          <th>21</th>
          <td>SJSU - San Salvador at 9th</td>
          <td>489</td>
        </tr>
        <tr>
          <th>39</th>
          <td>University and Emerson</td>
          <td>434</td>
        </tr>
        <tr>
          <th>23</th>
          <td>Palo Alto Caltrain Station</td>
          <td>431</td>
        </tr>
        <tr>
          <th>68</th>
          <td>SJSU 4th at San Carlos</td>
          <td>389</td>
        </tr>
        <tr>
          <th>33</th>
          <td>Redwood City Caltrain Station</td>
          <td>378</td>
        </tr>
        <tr>
          <th>67</th>
          <td>St James Park</td>
          <td>366</td>
        </tr>
        <tr>
          <th>63</th>
          <td>Cowper at University</td>
          <td>355</td>
        </tr>
        <tr>
          <th>18</th>
          <td>San Jose Civic Center</td>
          <td>346</td>
        </tr>
        <tr>
          <th>53</th>
          <td>Arena Green / SAP Center</td>
          <td>339</td>
        </tr>
        <tr>
          <th>42</th>
          <td>Adobe on Almaden</td>
          <td>335</td>
        </tr>
        <tr>
          <th>1</th>
          <td>California Ave Caltrain Station</td>
          <td>297</td>
        </tr>
        <tr>
          <th>13</th>
          <td>Rengstorff Avenue / California Street</td>
          <td>248</td>
        </tr>
        <tr>
          <th>31</th>
          <td>San Antonio Caltrain Station</td>
          <td>238</td>
        </tr>
        <tr>
          <th>37</th>
          <td>Evelyn Park and Ride</td>
          <td>218</td>
        </tr>
        <tr>
          <th>43</th>
          <td>Broadway St at Battery St</td>
          <td>201</td>
        </tr>
        <tr>
          <th>59</th>
          <td>Park at Olive</td>
          <td>189</td>
        </tr>
        <tr>
          <th>56</th>
          <td>Castro Street and El Camino Real</td>
          <td>132</td>
        </tr>
        <tr>
          <th>47</th>
          <td>Redwood City Medical Center</td>
          <td>123</td>
        </tr>
        <tr>
          <th>57</th>
          <td>San Antonio Shopping Center</td>
          <td>108</td>
        </tr>
        <tr>
          <th>49</th>
          <td>San Mateo County Center</td>
          <td>101</td>
        </tr>
        <tr>
          <th>62</th>
          <td>Franklin at Maple</td>
          <td>99</td>
        </tr>
        <tr>
          <th>17</th>
          <td>Broadway at Main</td>
          <td>45</td>
        </tr>
        <tr>
          <th>41</th>
          <td>Redwood City Public Library</td>
          <td>44</td>
        </tr>
        <tr>
          <th>22</th>
          <td>San Jose Government Center</td>
          <td>23</td>
        </tr>
        <tr>
          <th>20</th>
          <td>Mezes Park</td>
          <td>3</td>
        </tr>
      </tbody>
    </table>
    <p>69 rows × 2 columns</p>
    </div>



Now that we've got a better sense of which stations might be interesting
to look at, let's graph out, the number of trips leaving from the top
two stations over time.

.. code:: python

    dep_stations['Start Station'][:3] # top 3 stations




.. parsed-literal::
    :class: myliteral

    64    San Francisco Caltrain (Townsend at 4th)
    50        Harry Bridges Plaza (Ferry Building)
    54                      Embarcadero at Sansome
    Name: Start Station, dtype: object



.. code:: python

    def transform_df(df):
        df['counts'] = 1
        df['Start Date'] = df['Start Date'].apply(pd.to_datetime)
        return df.set_index('Start Date').resample('D', how='sum')

.. code:: python

    pop_stations = [] # being popular stations - we could easily extend this to more stations
    for station in dep_stations['Start Station'][:3]:
        temp = transform_df(btd.where(btd['Start Station'] == station).select("Start Date").toPandas())
        pop_stations.append(
            Scatter(
            x=temp.index,
            y=temp.counts,
            name=station
            )
        )


.. parsed-literal::
    :class: myliteral

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:4: FutureWarning:
    
    how in .resample() is deprecated
    the new syntax is .resample(...).sum()
    


.. code:: python

    
    
    data = Data(pop_stations)
    py.iplot(data, filename="spark/over_time")
    





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/193.embed" height="525px" width="100%"></iframe>



