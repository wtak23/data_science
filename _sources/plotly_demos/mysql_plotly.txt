#################
MySQL with Plotly
#################

.. contents:: `Contents`
   :depth: 2
   :local:


Demo based on these:

-  https://plot.ly/python/graph-data-from-mysql-database-in-python/
-  http://moderndata.plot.ly/graph-data-from-mysql-database-in-python/
-  http://moderndata.plot.ly/widgets-in-ipython-notebook-and-plotly/

First download the world database
=================================

http://dev.mysql.com/doc/index-other.html

.. code:: python

    %%sh
    wget http://downloads.mysql.com/docs/world.sql.gz


.. parsed-literal::
    :class: myliteral

    --2016-09-22 13:08:55--  http://downloads.mysql.com/docs/world.sql.gz
    Resolving downloads.mysql.com (downloads.mysql.com)... 137.254.60.14
    Connecting to downloads.mysql.com (downloads.mysql.com)|137.254.60.14|:80... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 92094 (90K) [application/x-gzip]
    Saving to: ‘world.sql.gz’
    
         0K .......... .......... .......... .......... .......... 55%  205K 0s
        50K .......... .......... .......... .........            100%  490K=0.3s
    
    2016-09-22 13:08:56 (277 KB/s) - ‘world.sql.gz’ saved [92094/92094]
    


.. code:: python

    %%sh
    # aboute 90KB
    ls -lh world*


.. parsed-literal::
    :class: myliteral

    -rw-r--r-- 1 takanori takanori 90K Sep 22 12:27 world.sql.gz


.. code:: python

    %%sh
    # unzip
    gunzip world.sql.gz

.. code:: python

    # now we have world.sql file
    ls -lh world*


.. parsed-literal::
    :class: myliteral

    -rw-r--r-- 1 takanori takanori 389K Sep 22 12:27 world.sql


.. code:: python

    %%sh
    head -30 world.sql


.. parsed-literal::
    :class: myliteral

    -- MySQL dump 10.13  Distrib 5.1.51, for pc-linux-gnu (i686)
    --
    -- Host: 127.0.0.1    Database: world
    -- ------------------------------------------------------
    -- Server version       5.1.51-debug-log
    
    /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
    /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
    /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
    /*!40101 SET NAMES latin1 */;
    /*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
    /*!40103 SET TIME_ZONE='+00:00' */;
    /*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
    /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
    /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
    /*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
    
    DROP SCHEMA IF EXISTS world;
    CREATE SCHEMA world;
    USE world;
    SET AUTOCOMMIT=0;
    
    --
    -- Table structure for table `city`
    --
    
    DROP TABLE IF EXISTS `city`;
    /*!40101 SET @saved_cs_client     = @@character_set_client */;
    /*!40101 SET character_set_client = utf8 */;
    CREATE TABLE `city` (


Install database in mysql
=========================

https://dev.mysql.com/doc/world-setup/en/world-setup-installation.html

.. code:: sql

    $ mysql -u root -p
    mysql> source world.sql;
    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | TUTORIALS          |
    | mysql              |
    | performance_schema |
    | tutorial           |
    | world              |
    +--------------------+
    6 rows in set (0.01 sec)

.. code:: python

    %%sh
    # sourced the sql file to create database
    
    tail -4 ~/.mysql_history


.. parsed-literal::
    :class: myliteral

    show databases;
    system ls
    \#
    source world.sql;


For this demo, create user with all privileges to this ``world`` database
=========================================================================

.. code:: bash

    mysql> CREATE USER 'tak'@'localhost' IDENTIFIED BY 'nori';
    Query OK, 0 rows affected (0.16 sec)

    mysql> USE world;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    mysql> GRANT ALL ON world.* TO 'tak'@'localhost';
    Query OK, 0 rows affected (0.02 sec)

Alright, we are in business. Let's analyze this database!
=========================================================

.. code:: python

    import MySQLdb
    import pandas as pd
    import plotly.plotly as py
    from plotly.graph_objs import *

.. code:: python

    # use credential i create above to connect to the world-database
    conn = MySQLdb.connect(host="localhost", user="tak", passwd="nori", db="world")
    cursor = conn.cursor()

.. code:: python

    # show names of the table in the database
    cursor.execute('show tables')
    cursor.fetchall()




.. parsed-literal::
    :class: myliteral

    (('city',), ('country',), ('countrylanguage',))



.. code:: python

    # ugly format, but print schema for the country table
    cursor.execute('describe country')
    cursor.fetchall()




.. parsed-literal::
    :class: myliteral

    (('Code', 'char(3)', 'NO', 'PRI', '', ''),
     ('Name', 'char(52)', 'NO', '', '', ''),
     ('Continent',
      "enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')",
      'NO',
      '',
      'Asia',
      ''),
     ('Region', 'char(26)', 'NO', '', '', ''),
     ('SurfaceArea', 'float(10,2)', 'NO', '', '0.00', ''),
     ('IndepYear', 'smallint(6)', 'YES', '', None, ''),
     ('Population', 'int(11)', 'NO', '', '0', ''),
     ('LifeExpectancy', 'float(3,1)', 'YES', '', None, ''),
     ('GNP', 'float(10,2)', 'YES', '', None, ''),
     ('GNPOld', 'float(10,2)', 'YES', '', None, ''),
     ('LocalName', 'char(45)', 'NO', '', '', ''),
     ('GovernmentForm', 'char(45)', 'NO', '', '', ''),
     ('HeadOfState', 'char(60)', 'YES', '', None, ''),
     ('Capital', 'int(11)', 'YES', '', None, ''),
     ('Code2', 'char(2)', 'NO', '', '', ''))



.. code:: python

    cursor.execute('select Name, Continent, Population, LifeExpectancy, GNP from Country')


::


    ---------------------------------------------------------------------------

    ProgrammingError                          Traceback (most recent call last)

    <ipython-input-49-baabbac42de6> in <module>()
    ----> 1 cursor.execute('select Name, Continent, Population, LifeExpectancy, GNP from Country')
    

    /home/takanori/.local/lib/python2.7/site-packages/MySQLdb/cursors.pyc in execute(self, query, args)
        203             del tb
        204             self.messages.append((exc, value))
    --> 205             self.errorhandler(self, exc, value)
        206         self._executed = query
        207         if not self._defer_warnings: self._warning_check()


    /home/takanori/.local/lib/python2.7/site-packages/MySQLdb/connections.pyc in defaulterrorhandler(***failed resolving arguments***)
         34     del cursor
         35     del connection
    ---> 36     raise errorclass, errorvalue
         37 
         38 re_numeric_part = re.compile(r"^(\d+)")


    ProgrammingError: (1146, "Table 'world.Country' doesn't exist")


**HMMM, mysqldb appears to be case-sensitive in python** - so extra
attention is required, i suppose

.. code:: python

    # above threw an exception cuz *Country* needed to be in lower case...
    # see below
    cursor.execute('show tables')
    cursor.fetchall()




.. parsed-literal::
    :class: myliteral

    (('city',), ('country',), ('countrylanguage',))



.. code:: python

    # this should work
    cursor.execute('select Name, Continent, Population, LifeExpectancy, GNP from country')




.. parsed-literal::
    :class: myliteral

    239L



.. code:: python

    rows = cursor.fetchall()

.. code:: python

    len(rows)




.. parsed-literal::
    :class: myliteral

    239



.. code:: python

    str(rows)[0:300]




.. parsed-literal::
    :class: myliteral

    "(('Aruba', 'North America', 103000L, 78.4, 828.0), ('Afghanistan', 'Asia', 22720000L, 45.9, 5976.0), ('Angola', 'Africa', 12878000L, 38.3, 6648.0), ('Anguilla', 'North America', 8000L, 76.1, 63.2), ('Albania', 'Europe', 3401200L, 71.6, 3205.0), ('Andorra', 'Europe', 78000L, 83.5, 1630.0), ('Netherla"



create pandas DataFrame
=======================

.. code:: python

    df = pd.DataFrame( [[ij for ij in i] for i in rows] )
    df.rename(columns={0: 'Name', 1: 'Continent', 2: 'Population', 3: 'LifeExpectancy', 4:'GNP'}, inplace=True);
    df = df.sort(['LifeExpectancy'], ascending=[1]);


.. parsed-literal::
    :class: myliteral

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:3: FutureWarning:
    
    sort(columns=....) is deprecated, use sort_values(by=.....)
    


.. code:: python

    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Name</th>
          <th>Continent</th>
          <th>Population</th>
          <th>LifeExpectancy</th>
          <th>GNP</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>237</th>
          <td>Zambia</td>
          <td>Africa</td>
          <td>9169000</td>
          <td>37.2</td>
          <td>3377.0</td>
        </tr>
        <tr>
          <th>143</th>
          <td>Mozambique</td>
          <td>Africa</td>
          <td>19680000</td>
          <td>37.5</td>
          <td>2891.0</td>
        </tr>
        <tr>
          <th>148</th>
          <td>Malawi</td>
          <td>Africa</td>
          <td>10925000</td>
          <td>37.6</td>
          <td>1687.0</td>
        </tr>
        <tr>
          <th>238</th>
          <td>Zimbabwe</td>
          <td>Africa</td>
          <td>11669000</td>
          <td>37.8</td>
          <td>5951.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Angola</td>
          <td>Africa</td>
          <td>12878000</td>
          <td>38.3</td>
          <td>6648.0</td>
        </tr>
      </tbody>
    </table>
    </div>



A bit of data cleansing
=======================

-  above, some country names cause serialization errors in early
   versions of Plotly's Python client.
-  The code block below takes care of this.

.. code:: python

    country_names = df['Name']
    for i in range(len(country_names)):
        try:
            country_names[i] = str(country_names[i]).decode('utf-8')
        except:
            country_names[i] = 'Country name decode error'


.. parsed-literal::
    :class: myliteral

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:4: SettingWithCopyWarning:
    
    
    A value is trying to be set on a copy of a slice from a DataFrame
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy
    
    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:6: SettingWithCopyWarning:
    
    
    A value is trying to be set on a copy of a slice from a DataFrame
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy
    


Plot interactive scatterplots!
==============================

.. code:: python

    trace1 = Scatter(
        x=df['GNP'],
        y=df['LifeExpectancy'],
        text=country_names,
        mode='markers'
    )
    layout = Layout(
        title='Life expectancy vs GNP from MySQL world database',
        xaxis=XAxis( type='log', title='GNP' ),
        yaxis=YAxis( title='Life expectancy' ),
    )
    data = Data([trace1])
    fig = Figure(data=data, layout=layout)
    py.iplot(fig, filename='plotly-demo/world GNP vs life expectancy')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/180.embed" height="525px" width="100%"></iframe>



prettify the above :)
=====================

.. code:: python

    # (!) Set 'size' values to be proportional to rendered area,
    #     instead of diameter. This makes the range of bubble sizes smaller
    sizemode='area'       
    
    # (!) Set a reference for 'size' values (i.e. a population-to-pixel scaling).
    #     Here the max bubble area will be on the order of 100 pixels
    sizeref=df['Population'].max()/1e2**2
    
    colors = {
        'Asia':"rgb(255,65,54)", 
        'Europe':"rgb(133,20,75)",
        'Africa':"rgb(0,116,217)",
        'North America':"rgb(255,133,27)",
        'South America':"rgb(23,190,207)",
        'Antarctica':"rgb(61,153,112)",
        'Oceania':"rgb(255,220,0)",
    }
    
    # Define a hover-text generating function (returns a list of strings)
    def make_text(X):
        return 'Country: %s\
        <br>Life Expectancy: %s years\
        <br>Population: %s million'\
        % (X['Name'], X['LifeExpectancy'], X['Population']/1e6)  
    
    # Define a trace-generating function (returns a Scatter object)
    def make_trace(X, continent, sizes, color):  
        return Scatter(
            x=X['GNP'],  # GDP on the x-xaxis
            y=X['LifeExpectancy'],    # life Exp on th y-axis
            name=continent,    # label continent names on hover
            mode='markers',    # (!) point markers only on this plot
            text=X.apply(make_text, axis=1).tolist(),
            marker= Marker(
                color=color,           # marker color
                size=sizes,            # (!) marker sizes (sizes is a list)
                sizeref=sizeref,       # link sizeref
                sizemode=sizemode,     # link sizemode
                opacity=0.6,           # (!) partly transparent markers
                line= Line(width=3,color="white")  # marker borders
            )
        )
    
    # Initialize data object 
    data = Data()
    
    # Group data frame by continent sub-dataframe (named X), 
    #   make one trace object per continent and append to data object
    for continent, X in df.groupby('Continent'):
        
        sizes = X['Population']                 # get population array 
        color = colors[continent]               # get bubble color
        
        data.append(
            make_trace(X, continent, sizes, color)  # append trace to data object
        ) 
    
        # Set plot and axis titles
    title = "Life expectancy vs GNP from MySQL world database (bubble chart)"
    x_title = "Gross National Product"
    y_title = "Life Expectancy [in years]"
    
    # Define a dictionary of axis style options
    axis_style = dict(  
        type='log',
        zeroline=False,       # remove thick zero line
        gridcolor='#FFFFFF',  # white grid lines
        ticks='outside',      # draw ticks outside axes 
        ticklen=8,            # tick length
        tickwidth=1.5         #   and width
    )
    
    # Make layout object
    layout = Layout(
        title=title,             # set plot title
        plot_bgcolor='#EFECEA',  # set plot color to grey
        hovermode="closest",
        xaxis=XAxis(
            axis_style,      # add axis style dictionary
            title=x_title,   # x-axis title
            range=[2.0,7.2], # log of min and max x limits
        ),
        yaxis=YAxis(
            axis_style,      # add axis style dictionary
            title=y_title,   # y-axis title
        )
    )
    
    # Make Figure object
    fig = Figure(data=data, layout=layout)
    
    # (@) Send to Plotly and show in notebook
    py.iplot(fig, filename='plotly-demo/s3_life-gdp')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/186.embed" height="525px" width="100%"></iframe>


