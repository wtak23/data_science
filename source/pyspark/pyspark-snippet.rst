``pyspark-snippet.rst``
"""""""""""""""""""""""
Just bunch of handy snippets for using pyspark in databricks.

.. contents:: `Contents`
   :depth: 2
   :local:


################################################
Data from *Application Examples* on DB Workspace
################################################
Link also at https://docs.cloud.databricks.com/docs/latest/sample_applications/index.html#01%20Introduction%20%28Readme%29.html

In Databricks, files are available on S3 via ``dbfs`` or the Databricks file system. Access the data at ``/databricks-datasets`` directory which is a repository of public, Databricks-hosted datasets that is available on all Databricks accounts.

*****************************
List out datasets (Important)
*****************************
From 1 Gentle Intro - 2 Spark for Data Engineers


.. code-block:: bash

    %fs ls dbfs:/databricks-datasets/

.. image:: /_static/img/dbfs_datasets_snip.png
    :align: center
    :scale: 100 %

Then read in one of the textfile as RDD

.. code-block:: python

    >>> log_files = "/databricks-datasets/sample_logs"
    >>> raw_log_files = sc.textFile(log_files)
    >>> raw_log_files.count()
    Out[4]: 100000

Register as table (convert to ``DF``, then create Table)

.. code-block:: python

    >>> parsed_log_files.toDF().registerTempTable("log_data")

Run sql commands::

    %sql select * from log_data

Then read in as a table

.. code-block:: python

    # important that we registered "log_data" as table above
    >>> logData = sqlContext.table("log_data")
    >>> print logData.count()
    100000
    >>> logData.show(n=5,truncate=False)
    +------------+-----------+--------------------------+-------------+---------+------+--------+------------+------+
    |clientIdentd|contentSize|dateTime                  |endpoint     |ipAddress|method|protocol|responseCode|userId|
    +------------+-----------+--------------------------+-------------+---------+------+--------+------------+------+
    |-           |21         |21/Jun/2014:10:00:00 -0700|/endpoint_27 |3.3.3.3  |GET   |HTTP/1.1|200         |user1 |
    |-           |435        |21/Feb/2014:10:00:00 -0300|/endpoint_988|4.4.4.4  |GET   |HTTP/1.1|200         |user2 |
    |-           |11         |21/Jan/2014:10:00:00 -0200|/endpoint_271|3.3.3.3  |GET   |HTTP/1.1|200         |user2 |
    |-           |182        |21/Mar/2014:10:00:00 -0400|/endpoint_906|4.4.4.4  |POST  |HTTP/1.1|401         |user1 |
    |-           |208        |21/May/2014:10:00:00 -0600|/endpoint_381|3.3.3.3  |GET   |HTTP/1.1|500         |-     |
    +------------+-----------+--------------------------+-------------+---------+------+--------+------------+------+
    only showing top 5 rows



***********************
Create sample JSON file
***********************
.. code-block:: python

    dbutils.fs.put("/home/tmp/datasets/person.json",
    """
    {"name":"Elaine Benes","email":"elaine@acme.com","iq":145}
    {"name":"George Costanza","email":"george@acme.com","iq":85}
    """, true)
    spark.read.json("/home/tmp/datasets/person.json").write.mode("overwrite").saveAsTable("person")

    dbutils.fs.put("/home/tmp/datasets/smart.json",
    """
    {"name":"Elaine Benes","email":"elaine@acme.com","iq":145}
    """, true)
    spark.read.json("/home/tmp/datasets/smart.json").write.mode("overwrite").saveAsTable("smart")

    // then read!
    val jsonData = spark.read.json("/home/tmp/datasets/person.json")
    jsonData.show()
    +---------------+---+---------------+
    |          email| iq|           name|
    +---------------+---+---------------+
    |elaine@acme.com|145|   Elaine Benes|
    |george@acme.com| 85|George Costanza|
    +---------------+---+---------------+

******
Tables
******
From `Application Examples --- Spark Session 2.0 <https://docs.cloud.databricks.com/docs/latest/sample_applications/index.html#04%20Apache%20Spark%202.0%20Examples/01%20SparkSession.html>`__

.. code-block:: scala

    // To get a list of tables in the current database
    val tables = spark.catalog.listTables()
    
    tables.show(truncate=false)
    +---------------------------+--------+-----------+---------+-----------+
    |name                       |database|description|tableType|isTemporary|
    +---------------------------+--------+-----------+---------+-----------+
    |cleaned_taxes              |default |null       |MANAGED  |false      |
    |ny_baby_names              |default |null       |MANAGED  |false      |
    |pageviews_by_second_example|default |null       |EXTERNAL |false      |
    |person                     |default |null       |MANAGED  |false      |
    |power_plant_predictions    |default |null       |MANAGED  |false      |
    |smart                      |default |null       |MANAGED  |false      |
    +---------------------------+--------+-----------+---------+-----------+

**************
Random data-io
**************
https://docs.cloud.databricks.com/docs/latest/sample_applications/index.html#03%20Quick%20Start/Quick%20Start%20Apache%20Spark%20and%20RDDs.html

.. code-block:: scala

    val textFile = sc.textFile("/databricks-datasets/SPARK_README.md")
    textFile.count() // Number of items in this RDD

    // convert to DataFrame
    val clickstreamDF = sqlContext.read.format(dataFormat)
      .option("header", "true") // first line is the header
      .option("delimiter", "\\t") // tab delimiter
      .option("mode", "PERMISSIVE")
      .option("inferSchema", "true") // infer data types (e.g., int, string) from values
      .load("dbfs:///databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed")


********
Diamonds
********
From 1 Gentle Intro - 1 Spark on Databricks

.. code-block:: python

    >>> dataPath = "/databricks-datasets/Rdatasets/data-001/csv/ggplot2/diamonds.csv"
    >>> diamonds = sqlContext.read.format("com.databricks.spark.csv")\
    >>>   .option("header","true")\
    >>>   .option("inferSchema", "true")\
    >>>   .load(dataPath)
    >>> diamonds.show(n=8,truncate=False)
    +---+-----+---------+-----+-------+-----+-----+-----+----+----+----+
    |_c0|carat|cut      |color|clarity|depth|table|price|x   |y   |z   |
    +---+-----+---------+-----+-------+-----+-----+-----+----+----+----+
    |1  |0.23 |Ideal    |E    |SI2    |61.5 |55.0 |326  |3.95|3.98|2.43|
    |2  |0.21 |Premium  |E    |SI1    |59.8 |61.0 |326  |3.89|3.84|2.31|
    |3  |0.23 |Good     |E    |VS1    |56.9 |65.0 |327  |4.05|4.07|2.31|
    |4  |0.29 |Premium  |I    |VS2    |62.4 |58.0 |334  |4.2 |4.23|2.63|
    |5  |0.31 |Good     |J    |SI2    |63.3 |58.0 |335  |4.34|4.35|2.75|
    |6  |0.24 |Very Good|J    |VVS2   |62.8 |57.0 |336  |3.94|3.96|2.48|
    |7  |0.24 |Very Good|I    |VVS1   |62.3 |57.0 |336  |3.95|3.98|2.47|
    |8  |0.26 |Very Good|H    |SI1    |61.9 |55.0 |337  |4.07|4.11|2.53|
    +---+-----+---------+-----+-------+-----+-----+-----+----+----+----+


************************************************
February 2015 English Wikipedia Clickstream data
************************************************
Available here: http://datahub.io/dataset/wikipedia-clickstream/resource/be85cc68-d1e6-4134-804a-fd36b94dbb82.

The data is approximately 1.2GB and it is hosted in the following Databricks file: 
``/databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed``


https://docs.cloud.databricks.com/docs/latest/sample_applications/index.html#03%20Quick%20Start/Quick%20Start%20DataFrames.html

.. code-block:: python

    val clickstreamText = sc.textFile("dbfs:///databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed")

###
DBF
###

>>> dbutils.fs.ls('dbfs:/')
Out[12]: 
[FileInfo(path=u'dbfs:/FileStore/', name=u'FileStore/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/', name=u'databricks-datasets/', size=0L),
 FileInfo(path=u'dbfs:/databricks-results/', name=u'databricks-results/', size=0L),
 FileInfo(path=u'dbfs:/datasets/', name=u'datasets/', size=0L),
 FileInfo(path=u'dbfs:/tmp/', name=u'tmp/', size=0L),
 FileInfo(path=u'dbfs:/user/', name=u'user/', size=0L)]


>>> dbutils.fs.ls('dbfs:/databricks-datasets/')
Out[18]: 
[FileInfo(path=u'dbfs:/databricks-datasets/README.md', name=u'README.md', size=976L),
 FileInfo(path=u'dbfs:/databricks-datasets/Rdatasets/', name=u'Rdatasets/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/SPARK_README.md', name=u'SPARK_README.md', size=3359L),
 FileInfo(path=u'dbfs:/databricks-datasets/adult/', name=u'adult/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/airlines/', name=u'airlines/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/amazon/', name=u'amazon/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/asa/', name=u'asa/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/bikeSharing/', name=u'bikeSharing/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/cs100/', name=u'cs100/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/', name=u'cs110x/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/cs190/', name=u'cs190/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/data.gov/', name=u'data.gov/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/flights/', name=u'flights/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/learning-spark/', name=u'learning-spark/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/mnist-digits/', name=u'mnist-digits/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/news20.binary/', name=u'news20.binary/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/online_retail/', name=u'online_retail/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/power-plant/', name=u'power-plant/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/sample_logs/', name=u'sample_logs/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/samples/', name=u'samples/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/sfo_customer_survey/', name=u'sfo_customer_survey/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/sms_spam_collection/', name=u'sms_spam_collection/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/songs/', name=u'songs/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/structured-streaming/', name=u'structured-streaming/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/tpch/', name=u'tpch/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/wiki/', name=u'wiki/', size=0L),
 FileInfo(path=u'dbfs:/databricks-datasets/wikipedia-datasets/', name=u'wikipedia-datasets/', size=0L)]


#######
Modules
#######
.. code-block:: python

    >>> from pyspark import sql
    >>> from pyspark.sql import functions as F
    >>> from pprint import pprint
    >>> import os
    >>> import re
    >>> import datetime
    >>> print 'This was last run on: {0}'.format(datetime.datetime.now())
    This was last run on: 2016-09-05 03:53:21.809269

#############################################
spark_notebook_helpers library for Databricks
#############################################
- From :ref:`cs105_lab2`, :ref:`cs105_lab2.3c`
- to make more adjustments, use ``matplotlib``
- Here let's use a set of helper functions from the ``spark_notebook_helpers`` library. 


.. code-block:: python

    >>> # np is just an alias for numpy.
    >>> # cm and plt are aliases for matplotlib.cm (for "color map") and matplotlib.pyplot, respectively.
    >>> # prepareSubplot is a helper.
    >>> from spark_notebook_helpers import prepareSubplot, np, plt, cm
    >>> help(prepareSubplot)
    Help on function prepareSubplot in module spark_notebook_helpers:

    prepareSubplot(xticks, yticks, figsize=(10.5, 6), hideLabels=False, gridColor='#999999', gridWidth=1.0, subplots=(1, 1))
        Template for generating the plot layout.

##################
Create toy dataset
##################
.. code-block:: python

    >>> from faker import Factory
    >>> fake = Factory.create()
    >>> fake.seed(4321)

    >>> # Each entry consists of last_name, first_name, ssn, job, and age (at least 1)
    >>> from pyspark.sql import Row
    >>> def fake_entry():
    >>>   name = fake.name().split()
    >>>   return (name[1], name[0], fake.ssn(), fake.job(), abs(2016 - fake.date_time().year) + 1)

    >>> # Create a helper function to call a function repeatedly
    >>> def repeat(times, func, *args, **kwargs):
    >>>     for _ in xrange(times):
    >>>         yield func(*args, **kwargs)
    
    >>> data = list(repeat(10000, fake_entry))

    >>> data[0]
    Out[15]: (u'Harvey', u'Tracey', u'160-37-9051', 'Agricultural engineer', 39)
    >>> len(data)
    Out[16]: 10000

##################
Print RDD per item
##################
Directly printing the ``list`` returned from ``take`` yields ugly print-out...
so print one item from the list at a time

.. code-block:: python

    def print_rdd(RDD,n=5):
      """ Directly printing the ``list`` returned from ``take`` yields ugly print-out...
         so print one item from the list at a time
      """
      for i,item in enumerate(RDD.take(n)):
        print i,item

############################################################
Databrick helper function displaying all DFs in the notebook
############################################################
Happend in lab 1

.. code-block:: python

  >>> from spark_notebook_helpers import printDataFrames
  ​>>> 
  >>> #This function returns all the DataFrames in the notebook and their corresponding column names.
  >>> printDataFrames(True)
  testPunctDF: ['_1']
  shakespeareDF: ['sentence']
  pluralLengthsDF: ['length_of_word']
  df: ['s', 'd']
  shakeWordsDF: ['word']
  sentenceDF: ['sentence']
  tmp: ['sentence']
  pluralDF: ['word']
  wordsDF: ['word']
  wordsDF2: ['word', 'tmp']
  wordCountsDF: ['word', 'count']

#######################################
Get shape of DF (gotta be a better way)
#######################################
.. code-block:: python
    
    # for ncol, take the length of the 1st row (head) 
    # for nrow, use built-in method ``count``
    print 'ncol = {},nrow = {}'.format(len(df.head()), df.count())


###############
Random snippets
###############

***********************************************
print dataframes in my workspace (super-ad-hoc)
***********************************************

>>> #assuming i have 'df' in my varname for DataFrames, print out what i got in my workspace
>>> filter(lambda _varname: 'df' in _varname,dir())
Out[59]: 
['bad_content_size_df',
 'bad_rows_df',
 'base_df',
 'cleaned_df',
 'paths_df',
 'split_df',
 'status_to_count_df',
 'throwaway_df',
 'udf']

*************
Rename column
*************
.. code-block:: python

    >>> # http://stackoverflow.com/questions/34077353/how-to-change-dataframe-column-names-in-pyspark
    >>> # Want to rename column 'count' (since i wanna join them first)
    >>> daily_hosts_df.show(n=3)
    +---+-----+
    |day|count|
    +---+-----+
    |  1| 2582|
    |  3| 3222|
    |  4| 4190|
    +---+-----+
    >>> # https://wtak23.github.io/pyspark/generated/generated/sql.DataFrame.withColumnRenamed.html
    >>> daily_hosts_df.withColumnRenamed('count','uniq_count').show(n=3)
    +---+----------+
    |day|uniq_count|
    +---+----------+
    |  1|      2582|
    |  3|      3222|
    |  4|      4190|
    +---+----------+


#######
dbutils
#######
Built-in helper for Databricks (from :ref:`cs110_lab1`)

.. code-block:: python

    >>> display(dbutils.fs.ls("/databricks-datasets/power-plant/data"))

    >>> print dbutils.fs.head("/databricks-datasets/power-plant/data/Sheet1.tsv")
    [Truncated to first 65536 bytes]
    AT  V AP  RH  PE
    14.96 41.76 1024.07 73.17 463.26
    25.18 62.96 1020.04 59.08 444.37
    5.11  39.4  1012.16 92.14 488.56
    20.86 57.32 1010.24 76.64 446.48
    10.82 37.5  1009.23 96.62 473.9
    26.27 59.44 1012.23 58.77 443.67
    15.89 43.96 1014.02 75.24 467.35
    9.48  44.71 1019.12 66.43 478.42
    14.64 45  1021.78 41.25 475.98
    11.74 43.56 1015.14 70.72 477.5
    17.99 43.72 1008.64 75.04 453.02
    20.14 46.93 1014.66 64.22 453.99
    24.34 73.5  1011.31 84.15 440.29
    25.71 58.59 1012.77 61.83 451.28
    26.19 69.34 1009.48 87.59 433.99
    21.42 43.79 1015.76 43.08 462.19
    18.21 45  1022.86 48.84 467.54
    11.04 41.74 1022.6  77.51 477.2
    14.45 52.75 1023.97 63.59 459.85

    >>> dbutils.fs.help()
    dbutils.fs provides utilities for working with FileSystems. Most methods in this package can take either a DBFS path (e.g., "/foo"), an S3 URI ("s3n://bucket/"), or another Hadoop FileSystem URI. For more info about a method, use dbutils.fs.help("methodName"). In notebooks, you can also use the %fs shorthand to access DBFS. The %fs shorthand maps straightforwardly onto dbutils calls. For example, "%fs head --maxBytes=10000 /file/path" translates into "dbutils.fs.head("/file/path", maxBytes = 10000)".
    fsutils
    cp(from: String, to: String, recurse: boolean = false): boolean -> Copies a file or directory, possibly across FileSystems
    head(file: String, maxBytes: int = 65536): String -> Returns up to the first 'maxBytes' bytes of the given file as a String encoded in UTF-8
    ls(dir: String): SchemaSeq -> Lists the contents of a directory
    mkdirs(dir: String): boolean -> Creates the given directory if it does not exist, also creating any necessary parent directories
    mv(from: String, to: String, recurse: boolean = false): boolean -> Moves a file or directory, possibly across FileSystems
    put(file: String, contents: String, overwrite: boolean = false): boolean -> Writes the given String out to a file, encoded in UTF-8
    rm(dir: String, recurse: boolean = false): boolean -> Removes a file or directory

    cache
    cacheFiles(files: Seq): boolean -> Caches a set of files on the local SSDs of this cluster
    cacheTable(tableName: String): boolean -> Caches the contents of the given table on the local SSDs of this cluster
    uncacheFiles(files: Seq): boolean -> Removes the cached version of the files
    uncacheTable(tableName: String): boolean -> Removes the cached version of the given table from SSDs

    mount
    chmod(path: String, user: String, permission: String): void -> Modifies the permissions of a mount point
    grants(path: String): SchemaSeq -> Lists the permissions associated with a mount point
    mount(source: String, mountPoint: String, encryptionType: String = "", owner: String = null): boolean -> Mounts the given source directory into DBFS at the given mount point
    mounts: SchemaSeq -> Displays information about what is mounted within DBFS
    refreshMounts: boolean -> Forces all machines in this cluster to refresh their mount cache, ensuring they receive the most recent information
    unmount(mountPoint: String): boolean -> Deletes a DBFS mount point

################################################
Random from Spark Essentials (Spark Summit 2016)
################################################
.. code-block:: python

    # create new DF that contains only the *young* users
    young_df = users_df.filter(users_df['age'] < 21)

    # equivalent but with pandas like syntax (I like this better)
    young_df = users_df[users_df['age'] < 21]

    # increment everyone's age by 1
    young_df.select(young_df['name'], young_df['age']+1)

    # count the number of young by gender
    young_df.groupBy('gender').count()

    # join young users with another DF, log_df
    young_df.join(log_df, log_df['userId'] == users_df['userId'], 'left_couter')

    young_df.registerTempTable('young')
    sqlContext.sql('SELECT count(*) FROM young')

#########################
Spark for Data Scientists
#########################
From **1 - Gentle Intro - 3 Spark for Data Scientists**
(initially was going to make a snippet, but turned out this was very informative)

********
Tax Data
********
http://catalog.data.gov/dataset/zip-code-data

**SOI Tax Stats** - Individual Income Tax Statistics - ZIP Code Data (SOI). 

This study provides detailed tabulations of individual income tax return data at the state and ZIP code level and is provided by the IRS. This repository only has a sample of the data: 2013 and includes "**AGI**" (adjusted gross income).

The ZIP Code data show selected income and tax items classified by State, ZIP Code, and size of adjusted gross income. Data are based on individual income tax returns filed with the IRS and are available for Tax Years 1998, 2001, 2004 through 2013. 

The data include items, such as:

- Number of returns, which approximates the number of households
- Number of personal exemptions, which approximates the population
- Adjusted gross income
- Wages and salaries
- Dividends before exclusion

.. code-block:: python

    >>> # Spark 1.6
    >>> taxes2013 = (sqlContext
    >>>   .read.format("com.databricks.spark.csv")
    >>>   .option("header", "true")
    >>>   .load("dbfs:/databricks-datasets/data.gov/irs_zip_code_data/data-001/2013_soi_zipcode_agi.csv")
    >>> )
    >>> 
    >>> # Spark 2.X
    >>> taxes2013 = (spark.read
    >>>   .option("header", "true")
    >>>   .csv("dbfs:/databricks-datasets/data.gov/irs_zip_code_data/data-001/2013_soi_zipcode_agi.csv")
    >>> )
    >>> print 'ncol = {},nrow = {}'.format(len(taxes2013.head()), taxes2013.count())
    ncol = 114,nrow = 166740

    >>> # register as template table (Spark 2.0 method ``createOrReplaceTempView``, replaces ``registerTempTable``)
    >>> taxes2013.createOrReplaceTempView("taxes2013")

********************
Farmer's market data
********************
http://catalog.data.gov/dataset/farmers-markets-geographic-data/resource/cca1cc8a-9670-4a27-a8c7-0c0180459bef

**Farmers Markets Directory and Geographic Data.** 

This dataset contains information on the longitude and latitude, state, address, name, and zip code of Farmers Markets in the United States (updated Dec 1, 2015). 

.. code-block:: python

    >>> # in Spark 1.6
    >>> markets = (sqlContext
    >>>   .read.format("com.databricks.spark.csv")
    >>>   .option("header", "true")
    >>>   .load("dbfs:/databricks-datasets/data.gov/farmers_markets_geographic_data/data-001/market_data.csv")
    >>> )


    >>> # in Apache Spark 2.0
    >>> print type(spark)
    <class 'pyspark.sql.session.SparkSession'>

    >>> markets = (spark.read
    >>>   .option("header", "true")
    >>>   .csv("dbfs:/databricks-datasets/data.gov/farmers_markets_geographic_data/data-001/market_data.csv")
    >>> )
    >>> print 'ncol = {},nrow = {}'.format(len(markets.head()), markets.count())
    ncol = 59,nrow = 8518
    >>> markets.registerTempTable("markets")

Registering as table

.. code-block:: python

    >>> # old version
    >>> markets.registerTempTable("markets")

    >>> # for spark 2.X
    >>> markets.createOrReplaceTempView("markets")

Now you can run bunch of SQL commands using ``%sql`` Databricks magic.

.. code-block:: sql

    -- show whatcha got
    show tables

.. image:: /_static/img/databricks_showtable_snip.png
    :align: center
    :scale: 100 %

.. code-block:: sql

    -- this is equivalent to display(tax2013)
    SELECT * FROM taxes2013

***************************
Run some sql, create tables
***************************
.. code-block:: sql

    DROP TABLE IF EXISTS cleaned_taxes;

    CREATE TABLE cleaned_taxes AS
    SELECT state, int(zipcode / 10) as zipcode, 
      int(mars1) as single_returns, 
      int(mars2) as joint_returns, 
      int(numdep) as numdep, 
      double(A02650) as total_income_amount,
      double(A00300) as taxable_interest_amount,
      double(a01000) as net_capital_gains,
      double(a00900) as biz_net_income
    FROM taxes2013


Create Dataframe from table created in SQL:

.. code-block:: python

    >>> # creating a DataFrame from the table
    >>> cleanedTaxes = sqlContext.sql("SELECT * FROM cleaned_taxes") 
    >>> cleanedTaxes.show(5)
    (1) Spark Jobs
    +-----+-------+--------------+-------------+------+-------------------+-----------------------+-----------------+--------------+
    |state|zipcode|single_returns|joint_returns|numdep|total_income_amount|taxable_interest_amount|net_capital_gains|biz_net_income|
    +-----+-------+--------------+-------------+------+-------------------+-----------------------+-----------------+--------------+
    |   AL|      0|        488030|       122290|571240|        1.1444868E7|                77952.0|          23583.0|      824487.0|
    |   AL|      0|        195840|       155230|383240|        1.7810952E7|                81216.0|          54639.0|      252768.0|
    |   AL|      0|         72710|       146880|189340|        1.6070153E7|                80627.0|          84137.0|      259836.0|
    |   AL|      0|         24860|       126480|134370|        1.4288572E7|                71086.0|         105947.0|      214668.0|
    |   AL|      0|         16930|       168170|177800|         2.605392E7|               149150.0|         404166.0|      567439.0|
    +-----+-------+--------------+-------------+------+-------------------+-----------------------+-----------------+--------------+

    >>> cleanedTaxes.groupBy("state").avg("total_income_amount").show(5)
    (2) Spark Jobs
    +-----+------------------------+
    |state|avg(total_income_amount)|
    +-----+------------------------+
    |   AZ|       184981.2064590542|
    |   SC|       96920.34577777778|
    |   LA|       83006.56901615272|
    |   MN|       74854.02570585757|
    |   NJ|       209996.5740402194|
    +-----+------------------------+

********************************
cache table in SQL or sqlContext
********************************
Consider the following from the ``explain`` method:

.. code-block:: python

    >>> sqlContext.sql("""
    >>>   SELECT zipcode, 
    >>>     SUM(biz_net_income) as net_income, 
    >>>     SUM(net_capital_gains) as cap_gains, 
    >>>     SUM(net_capital_gains) + SUM(biz_net_income) as combo
    >>>   FROM cleaned_taxes 
    >>>   WHERE NOT (zipcode = 0000 OR zipcode = 9999)
    >>>   GROUP BY zipcode
    >>>   ORDER BY combo desc
    >>>   limit 50""").explain
    == Physical Plan ==
    TakeOrderedAndProject(limit=50, orderBy=[combo#4007 DESC], output=[zipcode#3128,net_income#4005,cap_gains#4006,combo#4007])
    +- *HashAggregate(keys=[zipcode#3128], functions=[sum(biz_net_income#3135), sum(net_capital_gains#3134), sum(net_capital_gains#3134), sum(biz_net_income#3135)])
       +- Exchange hashpartitioning(zipcode#3128, 200)
          +- *HashAggregate(keys=[zipcode#3128], functions=[partial_sum(biz_net_income#3135), partial_sum(net_capital_gains#3134), partial_sum(net_capital_gains#3134), partial_sum(biz_net_income#3135)])
             +- *Project [zipcode#3128, net_capital_gains#3134, biz_net_income#3135]
                +- *Filter ((isnotnull(zipcode#3128) && NOT (zipcode#3128 = 0)) && NOT (zipcode#3128 = 9999))
                   +- *BatchedScan parquet default.cleaned_taxes[zipcode#3128,net_capital_gains#3134,biz_net_income#3135] Format: ParquetFormat, InputPaths: dbfs:/user/hive/warehouse/cleaned_taxes, PartitionFilters: [], PushedFilters: [IsNotNull(zipcode), Not(EqualTo(zipcode,0)), Not(EqualTo(zipcode,9999))], ReadSchema: struct<zipcode:int,net_capital_gains:double,biz_net_income:double>
The SQL queries on our temp SQL VIEWS are reading data from disk (fetched from ``dbfs:/user/hive/warehouse/cleaned_taxes`` which is where the data is stored when we registered it as a temporary table)


Let's cache data in memory for speed.

You can do either:

.. code-block:: python

    sqlContext.cacheTable("cleaned_taxes")

    %sql CACHE TABLE cleaned_taxes

Now our query will read data cached in memory, so will be much faster to this:

.. code-block:: sql

    SELECT zipcode, 
      SUM(biz_net_income) as net_income, 
      SUM(net_capital_gains) as cap_gains, 
      SUM(net_capital_gains) + SUM(biz_net_income) as combo
    FROM cleaned_taxes 
      WHERE NOT (zipcode = 0000 OR zipcode = 9999)
    GROUP BY zipcode
    ORDER BY combo desc
    limit 50

Now let's see query plan again (this is equivalent to ``df.explain`` we did above):

.. code-block:: sql

    EXPLAIN 
      SELECT zipcode, 
        SUM(biz_net_income) as net_income, 
        SUM(net_capital_gains) as cap_gains, 
        SUM(net_capital_gains) + SUM(biz_net_income) as combo
      FROM cleaned_taxes 
      WHERE NOT (zipcode = 0000 OR zipcode = 9999)
      GROUP BY zipcode
      ORDER BY combo desc
      limit 50

    == Physical Plan == TakeOrderedAndProject(limit=50, orderBy=[combo#4303 DESC], output=[zipcode#3128,net_income#4301,cap_gains#4302,combo#4303]) +- *HashAggregate(keys=[zipcode#3128], functions=[sum(biz_net_income#3135), sum(net_capital_gains#3134), sum(net_capital_gains#3134), sum(biz_net_income#3135)]) +- Exchange hashpartitioning(zipcode#3128, 200) +- *HashAggregate(keys=[zipcode#3128], functions=[partial_sum(biz_net_income#3135), partial_sum(net_capital_gains#3134), partial_sum(net_capital_gains#3134), partial_sum(biz_net_income#3135)]) +- *Filter ((isnotnull(zipcode#3128) && NOT (zipcode#3128 = 0)) && NOT (zipcode#3128 = 9999)) +- InMemoryTableScan [zipcode#3128, net_capital_gains#3134, biz_net_income#3135], [isnotnull(zipcode#3128), NOT (zipcode#3128 = 0), NOT (zipcode#3128 = 9999)] +- InMemoryRelation [state#3127, zipcode#3128, single_returns#3129, joint_returns#3130, numdep#3131, total_income_amount#3132, taxable_interest_amount#31...