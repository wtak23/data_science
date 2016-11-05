.. _cs110_lab1:

cs110 - Power Plant Machine Learning Pipeline Application
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
https://raw.githubusercontent.com/spark-mooc/mooc-setup/master/cs110_lab1_power_plant_ml_pipeline.py

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 1
   :local:

.. rubric:: During this lab we will cover:

#. Load Your Data
#. Explore Your Data
#. Visualize Your Data
#. Data Preparation
#. Data Modeling
#. Tuning and Evaluation

This notebook is an end-to-end exercise of performing **Extract-Transform-Load** and **Exploratory Data Analysis** on a real-world dataset, and then applying several different machine learning algorithms to solve a **supervised regression problem** on the dataset.

#############################
Part1: Business Understanding
#############################

.. admonition:: Predicted demand vs Actual demand
   
   .. image:: http://content.caiso.com/outlook/SP/ems_small.gif
      :align: center
      :scale: 100 %

   .. image:: http://www.caiso.com/PublishingImages/LoadGraphKey.gif
      :align: center
      :scale: 100 %

   From http://www.caiso.com/Pages/TodaysOutlook.aspx

*******************************
Background --- power generation
*******************************
- **Power generation** is a complex process
- understanding and **predicting power output** is an important element in managing a plant and its connection to the **power grid**. 
- The **operators** of a regional power grid create ``predictions of power demand`` based on **historical information** and **environmental factors** (e.g., temperature). 
- They then compare the **predictions against available resources** (e.g., coal, natural gas, nuclear, solar, wind, hydro power plants). 
- Power generation technologies such as solar and wind are highly dependent on **environmental conditions**, and all generation technologies are subject to **planned and unplanned maintenance**.

**********************************
Challenge for power grid operation
**********************************
The challenge for a power grid operator is **how to handle a shortfall in available ``resources`` versus actual ``demand``**. 

There are three solutions to a power shortfall: 

1. **build more base load power plants** (this process can take many years to decades of planning and construction), 
2. **buy and import power** from other regional power grids (this choice can be very expensive and is limited by the power transmission interconnects between grids and the excess power available from other grids), or 
3. **turn on small Peaker** or Peaking Power Plants. 

Because grid operators need to respond quickly to a power shortfall to avoid a power outage, **grid operators rely on a combination of the last two choices**. 

.. note:: In this exercise, we'll focus on the last choice.

********************
The business problem
********************
- https://en.wikipedia.org/wiki/Peaking_power_plant
- https://en.wikipedia.org/wiki/Base_load_power_plant

- Because they supply power only occasionally, the power supplied by a **peaker power plant** commands a much higher price per kilowatt hour than power from a power grid's base power plants.

  - A **peaker plant** may operate many hours a day, or it may operate only a few hours per year, depending on the condition of the region's electrical grid. 
- Because of the cost of building an efficient power plant, if a **peaker plant** is only going to be run for a short or highly variable time it does not make economic sense to make it as efficient as a **base load power plant**.
- In addition, the equipment and fuels used in **base load plants** are often unsuitable for use in **peaker plants** because the fluctuating conditions would severely strain the equipment.

.. admonition:: The Business Problem
   
  The power output of a peaker power plant varies depending on environmental conditions, so the **business problem** is predicting the power output of a peaker power plant as a function of the environmental conditions -- since this would enable the grid operator to make economic tradeoffs about the number of peaker plants to turn on (or whether to buy expensive power from another grid).

- Given this business problem, we need to first perform **Exploratory Data Analysis** to understand the data and then translate the business problem (predicting power output as a function of envionmental conditions) into a **Machine Learning task**. 
- In this instance, the **ML task is regression** since the label (or target) we are trying to predict is numeric. 
- We will use an Apache Spark ML Pipeline to perform the regression.

The real-world data we are using in this notebook consists of 9,568 data points, each with 4 environmental attributes collected from a Combined Cycle Power Plant over 6 years (2006-2011), and is provided by the UCI dataset.

Our schema definition from UCI appears below:

- AT = Atmospheric Temperature in C
- V = Exhaust Vacuum Speed
- AP = Atmospheric Pressure
- RH = Relative Humidity
- PE = Power Output (regression target)

**********************
Business Understanding
**********************
The first step in any machine learning task is to understand the business need.

As described in the overview we are trying to predict power output given a set of readings from various sensors in a gas-fired power generation plant.

The problem is a regression problem since the label (or target) we are trying to predict is numeric.

#############################################
Part2: Extract-Transform-Load (ETL) Your Data
#############################################
Our data is available on Amazon s3 at the following path:
``dbfs:/databricks-datasets/power-plant/data``

.. code-block:: python

    >>> # show data on Amazon s3 at path dbfs:/databricks-datasets/power-plant/data
    >>> display(dbutils.fs.ls("/databricks-datasets/power-plant/data"))


.. image:: /_static/img/cs110_pic1.png
    :align: center
    :scale: 100 %

.. code-block:: python

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

***********
Exercise 2a
***********
To use the spark-csv packag, we use the ``sqlContext.read.format()`` method (`link <https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.format.html>`__)to specify the input data source format: ``'com.databricks.spark.csv'``

- https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.csv.html

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-2a>`__)

.. code-block:: python

    >>> # TODO: Load the data and print the first five lines.
    >>> rawTextRdd = <FILL_IN>
    AT  V AP  RH  PE
    14.96 41.76 1024.07 73.17 463.26
    25.18 62.96 1020.04 59.08 444.37
    5.11  39.4  1012.16 92.14 488.56
    20.86 57.32 1010.24 76.64 446.48


.. admonition:: Observations for the ETL process

  - The data is a set of .tsv (Tab Seperated Values) files
  - There is a **header row**, which is the name of the columns
  - It looks like the *type of the data in each column is consistent* 

***********
Exercise 2b
***********
- The `SparkSession.read <https://wtak23.github.io/pyspark/generated/generated/sql.SparkSession.read.html>`__ contains the ``sql.DataFrameReader`` object
  
  - https://wtak23.github.io/pyspark/generated/generated/sql.SparkSession.read.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.format.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.load.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.options.html

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-2b>`__)

.. code-block:: python

    >>> powerPlantDF = sqlContext.read.format(<FILL_IN>).options(<FILL_IN>).load(<FILL_IN>)

    >>> print powerPlantDF.head()
    Row(AT=14.96, V=41.76, AP=1024.07, RH=73.17, PE=463.26)
    
    >>> powerPlantDF.show(n=5)
    +-----+-----+-------+-----+------+
    |   AT|    V|     AP|   RH|    PE|
    +-----+-----+-------+-----+------+
    |14.96|41.76|1024.07|73.17|463.26|
    |25.18|62.96|1020.04|59.08|444.37|
    | 5.11| 39.4|1012.16|92.14|488.56|
    |20.86|57.32|1010.24|76.64|446.48|
    |10.82| 37.5|1009.23|96.62| 473.9|
    +-----+-----+-------+-----+------+

    >>> print powerPlantDF.dtypes
    [('AT', 'double'), ('V', 'double'), ('AP', 'double'), ('RH', 'double'), ('PE', 'double')]

############################################
Part 2: Alternative Method to Load your Data
############################################
- Above we relied on **schema-inference** to infer the type of the columns.
- Let's **explicitly provide the schema** using:

  - ``StructType(fields=None)`` = list of ``StructField``
  - ``StructField(name, dataType, nullable=True, metadata=None)``
  - (The third parameter signifies if the column is nullable.)
- For our data, we will use ``DoubleType()``
- You can find a list of types in the ``pyspark.sql.types module``
- Relevant links

  - https://wtak23.github.io/pyspark/generated/sql.types.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.types.StructField.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.types.StructType.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.types.DoubleType.html


>>> f1=StructField("AT", DoubleType(), True)
>>> f2=StructField("V", DoubleType(), True)
>>> StructType([f1,f2])
Out[11]: StructType(List(StructField(AT,DoubleType,true),StructField(V,DoubleType,true)))


***********
Exercise 2c
***********
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-2c>`__)

.. code-block:: python

    # TO DO: Fill in the custom schema.
    from pyspark.sql.types import *

    # Custom Schema for Power Plant
    customSchema = StructType([ \
        <FILL_IN>, \
        <FILL_IN>, \
        <FILL_IN>, \
        <FILL_IN>, \
        <FILL_IN> \
                              ])

***********
Exercise 2d
***********
- Now, let's use the schema to read the data by modifying the earlier sqlContext.read.format step.

  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrameReader.format.html
- **We can specify the schema by**:

  - Adding ``schema = customSchema`` to the load method (use a comma and add it after the file name)
  - Removing the ``inferschema='true``'option because we are explicitly specifying the schema
- https://piazza.com/class/irr6t4dfpjp4um?cid=141

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-2d>`__)

.. code-block:: python

    >>> # TODO: Use the schema you created above to load the data again.
    >>> altPowerPlantDF = sqlContext.read.format(<FILL_IN>).options(<FILL_IN>).load(<FILL_IN>)

    >>> print altPowerPlantDF.dtypes
    [('AT', 'double'), ('V', 'double'), ('AP', 'double'), ('RH', 'double'), ('PE', 'double')]

    >>> altPowerPlantDF.show(n=4)
    +-----+-----+-------+-----+------+
    |   AT|    V|     AP|   RH|    PE|
    +-----+-----+-------+-----+------+
    |14.96|41.76|1024.07|73.17|463.26|
    |25.18|62.96|1020.04|59.08|444.37|
    | 5.11| 39.4|1012.16|92.14|488.56|
    |20.86|57.32|1010.24|76.64|446.48|
    +-----+-----+-------+-----+------+

    >>> altPowerPlantDF.printSchema()
    root
     |-- AT: double (nullable = true)
     |-- V: double (nullable = true)
     |-- AP: double (nullable = true)
     |-- RH: double (nullable = true)
     |-- PE: double (nullable = true)


#########################
Part 3: Explore Your Data
#########################

First, let's **register** our DataFrame as an **SQL table** named ``power_plant``. 

- Because you may run this lab multiple times, we'll take the precaution of removing any existing tables first.
- We can delete any existing ``power_plant`` SQL table using the SQL command: ``DROP TABLE IF EXISTS power_plant`` (we also need to to delete any Hive data associated with the table, which we can do with a Databricks file system operation).
- Once any prior table is removed, we can register our DataFrame as a SQL table using ``sqlContext.registerDataFrameAsTable()``.

.. _cs110_lab1_3a:

*****************************************************
3a - **register** the DataFrame (to use sql commands)
*****************************************************

- https://wtak23.github.io/pyspark/generated/generated/sql.SparkSession.table.html
- https://wtak23.github.io/pyspark/generated/generated/sql.SQLContext.registerDataFrameAsTable.html

.. code-block:: python

    # remove any existing tables if it exists
    sqlContext.sql("DROP TABLE IF EXISTS power_plant")
    dbutils.fs.rm("dbfs:/user/hive/warehouse/power_plant", True)
    sqlContext.registerDataFrameAsTable(powerPlantDF, "power_plant")

*******************************************************
3b - read data using ``%sql`` command (DataBricks only)
*******************************************************
- ``%sql`` is a Databricks-only command. 
  
  - It calls ``sqlContext.sql()`` and passes the results to the Databricks-only ``display()`` function. 

These two statements are equivalent::

    %sql SELECT * FROM power_plant
    display(sqlContext.sql("SELECT * FROM power_plant"))

::

  %sql
  -- We can use %sql to query the rows
  SELECT * FROM power_plant

  %sql
  desc power_plant

.. code-block:: python
  
  df = sqlContext.table("power_plant")
  display(df.describe())

.. image:: /_static/img/cs110_3b.png
    :align: center
    :scale: 100 %

****************************************************
3c - use SQL ``desc`` command to describe the schema
****************************************************
.. code-block:: sql

    %sql
    desc power_plant

.. image:: /_static/img/cs110_3c.png
    :align: center
    :scale: 100 %

.. _cs110_lab1_df:

*****************************
DataFrame ``describe`` method
*****************************
Here we get the **DataFrame** associated with a **SQL table** by using the ``sqlContext.table()`` and passing in the name of the SQL table.

- https://wtak23.github.io/pyspark/generated/generated/sql.SparkSession.table.html
- https://wtak23.github.io/pyspark/generated/generated/sql.SQLContext.registerDataFrameAsTable.html

>>> df = sqlContext.table("power_plant") # <- Returns the specified table as a DataFrame
>>> df.describe().show()
+-------+------------------+------------------+------------------+------------------+------------------+
|summary|                AT|                 V|                AP|                RH|                PE|
+-------+------------------+------------------+------------------+------------------+------------------+
|  count|             47840|             47840|             47840|             47840|             47840|
|   mean|19.651231187290996| 54.30580372073594|1013.2590781772572| 73.30897784280918|454.36500940635506|
| stddev| 7.452161658340004|12.707361709685806| 5.938535418520816|14.599658352081477| 17.06628146683769|
|    min|              1.81|             25.36|            992.89|             25.56|            420.26|
|    max|             37.11|             81.56|            1033.3|            100.16|            495.76|
+-------+------------------+------------------+------------------+------------------+------------------+

###########################
Part 4: Visualize your data
###########################
>>> # reminder on what we have
>>> df.show(n=5)
+-----+-----+-------+-----+------+
|   AT|    V|     AP|   RH|    PE|
+-----+-----+-------+-----+------+
|14.96|41.76|1024.07|73.17|463.26|
|25.18|62.96|1020.04|59.08|444.37|
| 5.11| 39.4|1012.16|92.14|488.56|
|20.86|57.32|1010.24|76.64|446.48|
|10.82| 37.5|1009.23|96.62| 473.9|
+-----+-----+-------+-----+------+

***********
Exercise 4a
***********
.. code-block:: sql

  %sql
  select AT as Temperature, PE as Power from power_plant

.. image:: /_static/img/110_lab1_4a.png
    :align: center
    :scale: 66 %

****************
Exercise 4b (hw)
****************
Use SQL to create a scatter plot of Power(PE) as a function of ExhaustVacuum (V). Name the y-axis "Power" and the x-axis "ExhaustVacuum"

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-4b>`__)

.. code-block:: sql

  %sql
  -- TO DO: Replace <FILL_IN> with the appropriate SQL command.
  <FILL_IN>

.. image:: /_static/img/110_lab1_4b.png
    :align: center
    :scale: 66 %
****************
Exercise 4c (hw)
****************
Use SQL to create a scatter plot of Power(PE) as a function of Pressure (AP).
Name the y-axis "Power" and the x-axis "Pressure"

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-4c>`__)

:: 

  %sql
  -- TO DO: Replace <FILL_IN> with the appropriate SQL command.
  <FILL_IN>

.. image:: /_static/img/110_lab1_4c.png
    :align: center
    :scale: 66 %
****************
Exercise 4d (hw)
****************
Use SQL to create a scatter plot of Power(PE) as a function of Humidity (RH). Name the y-axis "Power" and the x-axis "Humidity"


(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-4d>`__)

:: 

  %sql
  -- TO DO: Replace <FILL_IN> with the appropriate SQL command.
  <FILL_IN>

.. image:: /_static/img/110_lab1_4d.png
    :align: center
    :scale: 66 %

########################
Part 5: Data Preparation
########################
Let's prepare the data for ML Pipeline.

- The first step in building our **ML pipeline** is to convert the predictor features from ``DataFrame`` columns to **Feature Vectors** using ``pyspark.ml.feature.VectorAssembler()``

  - ``VectorAssembler`` = **transformer** that combines a given list of columns into a single vector column. 
  - It is useful for combining **raw features** and features generated by different feature transformers into a single feature vector, in order to train ML models like logistic regression and decision trees. 
- ``VectorAssembler`` takes a **list of input column names** (each is a string) and the **name of the output column** (as a string). 

https://wtak23.github.io/pyspark/generated/generated/ml.feature.VectorAssembler.html

*************
Exercise 5(a)
*************
- Convert the ``power_plant`` SQL table into a DataFrame named ``datasetDF``
- Set the ``vectorizer``'s input columns to a list of the four columns of the input DataFrame: ``["AT", "V", "AP", "RH"]``
- Set the ``vectorizer``'s output column name to ``"features"``

See  and  on inter-operating with SQL and DF in PySpark.

- https://wtak23.github.io/pyspark/generated/generated/sql.SQLContext.registerDataFrameAsTable.html
- https://wtak23.github.io/pyspark/generated/generated/sql.SparkSession.table.html

.. admonition:: Refresher

  Below was ran at :ref:`cs110_lab1_3a`

  .. code-block:: python

      # sec 3a: remove any existing tables if it exists
      sqlContext.sql("DROP TABLE IF EXISTS power_plant")
      dbutils.fs.rm("dbfs:/user/hive/warehouse/power_plant", True)
      sqlContext.registerDataFrameAsTable(powerPlantDF, "power_plant")

  Below was ran at :ref:`cs110_lab1_df`

  .. code-block:: python
  
      df = sqlContext.table("power_plant") # <- Returns the specified table as a DataFrame


(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-5-a>`__)

.. code-block:: python

    # TODO: Replace <FILL_IN> with the appropriate code
    from pyspark.ml.feature import VectorAssembler

    datasetDF = <FILL_IN>

    vectorizer = VectorAssembler()
    vectorizer.setInputCols(<FILL_IN>)
    vectorizer.setOutputCol(<FILL_IN>)

#####################
Part 6: Data Modeling
#####################
Now let's model our data to predict what the **power output** will be given a set of sensor readings

- Our first model will be based on **simple linear regression**
  
  - this is a sensible choice as we saw some linear patterns in our data
    from the earlier scatter plots during the exploration stage.
  
******************
Exercise 6(a) (hw)
******************
- Here we'll split our initial data set into a **Training Set** and a **Test Set**
  
  - We do this using DataFrame's ``randomSplit()`` method. 
  - The method takes a **list of weights** and an optional **random seed**. 
  - The seed is used to initialize the random number generator used by the splitting function
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrame.randomSplit.html

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-6-a>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with the appropriate code.
    >>> # We'll hold out 20% of our data for testing and leave 80% for training
    >>> seed = 1800009193L
    >>> (split20DF, split80DF) = datasetDF.<FILL_IN>
    >>> 
    >>> # Let's cache these datasets for performance
    >>> testSetDF = <FILL_IN>
    >>> trainingSetDF = <FILL_IN>

************************************
6(b) - build Linear Regression Model
************************************
Next we'll create a Linear Regression Model and use the built in help to identify how to train it. 

- https://wtak23.github.io/pyspark/generated/generated/ml.regression.LinearRegression.html
- https://wtak23.github.io/pyspark/generated/generated/ml.regression.LinearRegressionModel.html

.. code-block:: python
    :linenos:

    >>> from pyspark.ml.regression import LinearRegression
    >>> from pyspark.ml.regression import LinearRegressionModel
    >>> from pyspark.ml import Pipeline
    >>> 
    >>> # Let's initialize our linear regression learner
    >>> lr = LinearRegression()
    >>> 
    >>> # We use explain params to dump the parameters we can use
    >>> print(lr.explainParams())
    elasticNetParam: the ElasticNet mixing parameter, in range [0, 1]. For alpha = 0, the penalty is an L2 penalty. For alpha = 1, it is an L1 penalty. (default: 0.0)
    featuresCol: features column name. (default: features)
    fitIntercept: whether to fit an intercept term. (default: True)
    labelCol: label column name. (default: label)
    maxIter: max number of iterations (>= 0). (default: 100)
    predictionCol: prediction column name. (default: prediction)
    regParam: regularization parameter (>= 0). (default: 0.0)
    solver: the solver algorithm for optimization. If this is not set or empty, default value is 'auto'. (default: auto)
    standardization: whether to standardize the training features before fitting the model. (default: True)
    tol: the convergence tolerance for iterative algorithms. (default: 1e-06)
    weightCol: weight column name. If this is not set or empty, we treat all instance weights as 1.0. (undefined)

************************************************************
6(c) - set model parameters, and fit linear regression model
************************************************************
Set model parameters

- Set the name of the prediction column to "Predicted_PE"
- Set the name of the label column to "PE"
- Set the maximum number of iterations to 100
- Set the regularization parameter to 0.1

.. code-block:: python
    :linenos:

    >>> # Now we set the parameters for the method
    >>> lr.setPredictionCol("Predicted_PE")\
    >>>   .setLabelCol("PE")\
    >>>   .setMaxIter(100)\
    >>>   .setRegParam(0.1)
    >>> lr.params
    Out[57]: 
    [Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='elasticNetParam', doc='the ElasticNet mixing parameter, in range [0, 1]. For alpha = 0, the penalty is an L2 penalty. For alpha = 1, it is an L1 penalty.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='featuresCol', doc='features column name.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='fitIntercept', doc='whether to fit an intercept term.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='labelCol', doc='label column name.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='maxIter', doc='max number of iterations (>= 0).'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='predictionCol', doc='prediction column name.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='regParam', doc='regularization parameter (>= 0).'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='solver', doc="the solver algorithm for optimization. If this is not set or empty, default value is 'auto'."),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='standardization', doc='whether to standardize the training features before fitting the model.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='tol', doc='the convergence tolerance for iterative algorithms.'),
     Param(parent='LinearRegression_4ebdb65445ee0d63fc9d', name='weightCol', doc='weight column name. If this is not set or empty, we treat all instance weights as 1.0.')]

Next, we create the ML Pipeline and set the stages to the Vectorizer and Linear Regression learner we created earlier.

.. code-block:: python

    >>> # We will use the new spark.ml pipeline API. If you have worked with scikit-learn this will be very familiar.
    >>> lrPipeline = Pipeline()
    >>> lrPipeline.setStages([vectorizer, lr])
    >>> lrPipeline.params
    Out[60]: [Param(parent='Pipeline_472c83c1c17610eebeb2', name='stages', doc='pipeline stages')]

Finally, we create a model by training on trainingSetDF.

.. code-block:: python

    >>> # Let's first train on the entire dataset to see what we get
    >>> lrModel = lrPipeline.fit(trainingSetDF)

**********************************
6(d) --- study the fitted LR model
**********************************
Run the next cell. Ensure that you understand what's going on.

.. code-block:: python
    :linenos:

    >>> # The intercept is as follows:
    >>> intercept = lrModel.stages[1].intercept
    >>> print 'intercept = {}, type(intercept) = {}'.format(intercept, type(intercept))
    intercept = 436.422672239, type(intercept) = <type 'float'>

    >>> # The coefficents (i.e., weights) are as follows:
    >>> weights = lrModel.stages[1].coefficients
    >>> print 'weights = {}, type(weights) = {}'.format(weights, type(weights))
    weights = [-1.91608232805,-0.255230167561,0.0792423513014,-0.147726340553], type(weights) = <class 'pyspark.mllib.linalg.DenseVector'>

    >>> # Create a list of the column names (without PE)
    >>> featuresNoLabel = [col for col in datasetDF.columns if col != "PE"]
    >>> print "featuresNoLabel = ", featuresNoLabel
    featuresNoLabel =  ['AT', 'V', 'AP', 'RH']

    >>> # Merge the weights and labels
    >>> coefficents = zip(weights, featuresNoLabel)
    >>> 
    >>> # Now let's sort the coefficients from greatest absolute weight most to the least absolute weight
    >>> coefficents.sort(key=lambda tup: abs(tup[0]), reverse=True)
    >>> 
    >>> equation = "y = {intercept}".format(intercept=intercept)
    >>> variables = []
    >>> for x in coefficents:
    >>>     weight = abs(x[0])
    >>>     name = x[1]
    >>>     symbol = "+" if (x[0] > 0) else "-"
    >>>     equation += (" {} ({} * {})".format(symbol, weight, name))
    >>> 
    >>> # Finally here is our equation
    >>> print("Linear Regression Equation: " + equation)
    Linear Regression Equation: y = 436.422672239 - (1.91608232805 * AT) - (0.255230167561 * V) - (0.147726340553 * RH) + (0.0792423513014 * AP)

**************************************
6(e) evalute model on the 20% test-set
**************************************
- Now apply our Linear Regression model to the 20% test set. 
- The output of the model will be a predicted Power Output column named "Predicted_PE".

.. code-block:: python

    # Apply our LR model to the test data and predict power output
    predictionsAndLabelsDF = lrModel.transform(testSetDF).select("AT", "V", "AP", "RH", "PE", "Predicted_PE")

    display(predictionsAndLabelsDF)

.. image:: /_static/img/cs110_6e.png
    :align: center
    :scale: 100 %

**********************************************************
6(f) -- quantify performance using ``RegressionEvaluator``
**********************************************************
https://wtak23.github.io/pyspark/generated/generated/ml.evaluation.RegressionEvaluator.html

.. code-block:: python

    >>> # Now let's compute an evaluation metric for our test dataset
    >>> from pyspark.ml.evaluation import RegressionEvaluator
    >>> 
    >>> # Create an RMSE evaluator using the label and predicted columns
    >>> regEval = RegressionEvaluator(predictionCol="Predicted_PE", labelCol="PE", metricName="rmse")
    >>> 
    >>> # Run the evaluator on the DataFrame
    >>> rmse = regEval.evaluate(predictionsAndLabelsDF)
    >>> 
    >>> print("Root Mean Squared Error: %.2f" % rmse)
    Root Mean Squared Error: 4.59

*********************
6(g) use R2 this time
*********************
.. code-block:: python

    >>> # Now let's compute another evaluation metric for our test dataset
    >>> r2 = regEval.evaluate(predictionsAndLabelsDF, {regEval.metricName: "r2"})
    >>> 
    >>> print("r2: {0:.2f}".format(r2))
    r2: 0.93

*********************************************
6(h) Register our test DataFrame as SQL table
*********************************************
- Assuming a **Gaussian distribution of errors**, a good model will have:

  - 68% of predictions within 1 RMSE
  - 95% within 2 RMSE of the actual value (see http://statweb.stanford.edu/~susan/courses/s60/split/node60.html).
Let's examine the predictions and see if a RMSE of 4.59 meets this criteria.

- We create a new DataFrame using ``selectExpr()`` to project a set of SQL expressions, and register the DataFrame as a SQL table using ``registerTempTable()``.

  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrame.registerTempTable.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.DataFrame.selectExpr.html
 
.. code-block:: python

    # First we remove the table if it already exists
    sqlContext.sql("DROP TABLE IF EXISTS Power_Plant_RMSE_Evaluation")
    dbutils.fs.rm("dbfs:/user/hive/warehouse/Power_Plant_RMSE_Evaluation", True)

    # Next we calculate the residual error and divide it by the RMSE
    predictionsAndLabelsDF.selectExpr("PE", "Predicted_PE", "PE - Predicted_PE Residual_Error", "(PE - Predicted_PE) / {} Within_RSME".format(rmse)).regist

.. admonition:: What did the above do?
   
   We can now use SQL to explore the ``Power_Plant_RMSE_Evaluation`` table. 

**********************************************************************
6(i) SQL statement on the SQL table registered from our test DataFrame
**********************************************************************
First let's look at at the table using a SQL SELECT statement.

.. code-block:: sql

    %sql
    SELECT * from Power_Plant_RMSE_Evaluation

.. image:: /_static/img/cs110_6i.png
    :align: center
    :scale: 100 %

***************************
6(j) Plot histogram of RMSE
***************************
.. code-block:: sql

  %sql
  -- Now we can display the RMSE as a Histogram
  SELECT Within_RSME  from Power_Plant_RMSE_Evaluation

.. image:: /_static/img/cs110_6j.png
    :align: center
    :scale: 100 %

*******************
6(k) Plot pie chart
*******************
- Perform the following steps:

  - Run the following cell
  - Click on the drop down next to the "Bar chart" icon a select "Pie" to turn the table into a Pie Chart plot
  - Increase the size of the graph by clicking and dragging the size control

.. code-block:: sql

  %sql
  SELECT case when Within_RSME <= 1.0 AND Within_RSME >= -1.0 then 1
              when  Within_RSME <= 2.0 AND Within_RSME >= -2.0 then 2 else 3
         end RSME_Multiple, COUNT(*) AS count
  FROM Power_Plant_RMSE_Evaluation
  GROUP BY case when Within_RSME <= 1.0 AND Within_RSME >= -1.0 then 1  when  Within_RSME <= 2.0 AND Within_RSME >= -2.0 then 2 else 3 end

.. image:: /_static/img/cs110_6k.png
    :align: center
    :scale: 100 %

.. note::

  From the pie chart, we can see that 68% of our test data predictions are within 1 RMSE of the actual values, and 97% (68% + 29%) of our test data predictions are within 2 RMSE. So the model is pretty decent. 

  Let's next see if we can tune the model to improve it further.

#############################
Part 7: Tuning and Evaluation
#############################
- An important task in ML is **model selection**, or using data to find the best model or parameters for a given task. This is also called **tuning**. 
- Tuning may be done for individual Estimators such as LinearRegression, or for entire Pipelines which include multiple algorithms, featurization, and other steps. 
- **Users can tune an entire Pipeline at once**, rather than tuning each element in the Pipeline separately. 
- Spark ML Pipeline supports model selection using tools such as ``CrossValidator``, which requires the following items:
  
  - ``Estimator``: algorithm or Pipeline to tune

    - https://wtak23.github.io/pyspark/generated/generated/ml.Estimator.html
  - Set of ``ParamMaps``: parameters to choose from, sometimes called a parameter grid to search over
  - ``Evaluator``: metric to measure how well a fitted Model does on held-out test data

    - https://wtak23.github.io/pyspark/generated/generated/ml.evaluation.Evaluator.html

- https://wtak23.github.io/pyspark/generated/generated/ml.Estimator.html
- https://wtak23.github.io/pyspark/generated/ml.evaluation.html
- https://wtak23.github.io/pyspark/generated/generated/ml.evaluation.Evaluator.html
- https://wtak23.github.io/pyspark/generated/ml.tuning.html
- https://wtak23.github.io/pyspark/generated/generated/ml.tuning.ParamGridBuilder.html
- https://wtak23.github.io/pyspark/generated/generated/ml.tuning.CrossValidator.html

.. admonition:: How model selection works in PySpark
   
   - At a high level, model selection tools such as ``CrossValidator`` work as follows:

     - They split the input data into separate training and test datasets.
     - For each (training, test) pair, they iterate through the set of ``ParamMaps``:
       
       - For each ``ParamMap`` in the ``ParamGridBuilder``, they fit the ``Estimator`` using those parameters
       - then they get the fitted Model, and evaluate the Model's performance using the ``Evaluator``.
     - They select the Model produced by the best-performing set of parameters.

********************************
7(a) Run Cross Validation Tuning
********************************
Here's what's going on:

- Create a CrossValidator using the Pipeline and RegressionEvaluator that we created earlier, and set the number of folds to 3
- Create a list of 10 regularization parameters
- Use ParamGridBuilder to build a parameter grid with the regularization parameters and add the grid to the CrossValidator
- Run the CrossValidator to find the parameters that yield the best model (i.e., lowest RMSE) and return the best model.


.. code-block:: python

    >>> from pyspark.ml.tuning import ParamGridBuilder, CrossValidator
    >>> 
    >>> # We can reuse the RegressionEvaluator, regEval, to judge the model based on the best Root Mean Squared Error
    >>> # Let's create our CrossValidator with 3 fold cross validation
    >>> crossval = CrossValidator(estimator=lrPipeline, evaluator=regEval, numFolds=3)
    >>> 
    >>> # Let's tune over our regularization parameter from 0.01 to 0.10
    >>> regParam = [x / 100.0 for x in range(1, 11)]
    >>> 
    >>> # We'll create a paramter grid using the ParamGridBuilder, and add the grid to the CrossValidator
    >>> paramGrid = (ParamGridBuilder()
    >>>              .addGrid(lr.regParam, regParam)
    >>>              .build())
    >>> crossval.setEstimatorParamMaps(paramGrid)
    >>> 
    >>> # Now let's find and return the best model
    >>> cvModel = crossval.fit(trainingSetDF).bestModel

*********************************************
Exercise 7(b) -- Evaluate tuned LR model (hw)
*********************************************
See section 6e on refreshers on how we did this for *non-tuned* LR model.

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-b-evaluate-tuned-lr-model>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with the appropriate code.
    >>> # Now let's use cvModel to compute an evaluation metric for our test dataset: testSetDF
    >>> predictionsAndLabelsDF = <FILL_IN>
    >>> 
    >>> # Run the previously created RMSE evaluator, regEval, on the predictionsAndLabelsDF DataFrame
    >>> rmseNew = <FILL_IN>
    >>> 
    >>> # Now let's compute the r2 evaluation metric for our test dataset
    >>> r2New = <FILL_IN>
    >>> 
    >>> print("Original Root Mean Squared Error: {0:2.2f}".format(rmse))
    >>> print("New Root Mean Squared Error: {0:2.2f}".format(rmseNew))
    >>> print("Old r2: {0:2.2f}".format(r2))
    >>> print("New r2: {0:2.2f}".format(r2New))
    Original Root Mean Squared Error: 4.59
    New Root Mean Squared Error: 4.59
    Old r2: 0.93
    New r2: 0.93
    >>> print("Regularization parameter of the best model: {0:.2f}".format(cvModel.stages[-1]._java_obj.parent().getRegParam()))
    Regularization parameter of the best model: 0.01

So not much of an improvement....

***********************************
Exercise 7(c) DecisionTreeRegressor
***********************************
Given that the only linearly correlated variable is **Temperature**, it makes sense try another Machine Learning method such as Decision Tree to handle non-linear data and see if we can improve our model.

- **Decision Tree** Learning uses a Decision Tree as a predictive model which maps observations about an item to conclusions about the item's target value. 
- It is one of the predictive modelling approaches used in statistics, data mining and machine learning. 
- Decision trees where the target variable can take continuous values (typically real numbers) are called **regression trees**. 

- In the next cell, create a ``DecisionTreeRegressor()``
- The next step is to set the parameters for the method:

  - Set the name of the prediction column to "Predicted_PE"
  - Set the name of the features column to "features"
  - Set the maximum number of bins to 100
- Create the ML Pipeline and set the stages to the ``Vectorizer`` we created earlier and Dec``isionTreeRegressor()`` learner we just created.

https://wtak23.github.io/pyspark/generated/generated/ml.regression.DecisionTreeRegressor.html

.. hint:: See Sec 6c

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-c-decisiontreeregressor>`__)

.. code-block:: python

    from pyspark.ml.regression import DecisionTreeRegressor

    # Create a DecisionTreeRegressor
    dt = <FILL_IN>
    
    dt.setLabelCol("PE")\
      .setPredictionCol("Predicted_PE")\
      .setFeaturesCol("features")\
      .setMaxBins(100)
    
    # Create a Pipeline
    dtPipeline = <FILL_IN>
    
    # Set the stages of the Pipeline
    dtPipeline.<FILL_IN>

*************
Exercise 7(d)
*************
Let's do CV to tune our model.

- We can reuse the exiting CrossValidator by replacing the ``Estimator`` with our new ``dtPipeline`` (the number of folds remains 3).
- Use ``ParamGridBuilder`` to build a parameter grid with the parameter ``dt.maxDepth`` and a list of the values 2 and 3, and add the grid to the ``CrossValidator``
- Run the ``CrossValidator`` to find the parameters that yield the best model (i.e., lowest RMSE) and return the best model.

.. note:: it will take some time to run the CrossValidator as it will run almost 50 Spark jobs

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-d>`__)

.. code-block:: python

    # TODO: Replace <FILL_IN> with the appropriate code.
    # Let's just reuse our CrossValidator with the new dtPipeline,  RegressionEvaluator regEval, and 3 fold cross validation
    crossval.setEstimator(dtPipeline)
    
    # Let's tune over our dt.maxDepth parameter on the values 2 and 3, create a paramter grid using the ParamGridBuilder
    paramGrid = <FILL_IN>
    
    # Add the grid to the CrossValidator
    crossval.<FILL_IN>
    
    # Now let's find and return the best model
    dtModel = crossval.<FILL_IN>

******************************************
Exercise 7(e) --- evaluate DTR performance
******************************************
Now let's see how our tuned ``DecisionTreeRegressor`` model's RMSE and :math:`r^2` values compare to our tuned ``LinearRegression`` model.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-e>`__)

.. code-block:: python
    
    >>> # Now let's use dtModel to compute an evaluation metric for our test dataset: testSetDF
    >>> predictionsAndLabelsDF = <FILL_IN>
    >>> 
    >>> # Run the previously created RMSE evaluator, regEval, on the predictionsAndLabelsDF DataFrame
    >>> rmseDT = <FILL_IN>
    >>> 
    >>> # Now let's compute the r2 evaluation metric for our test dataset
    >>> r2DT = <FILL_IN>
    >>> 
    >>> print("LR Root Mean Squared Error: {0:.2f}".format(rmseNew))
    >>> print("DT Root Mean Squared Error: {0:.2f}".format(rmseDT))
    >>> print("LR r2: {0:.2f}".format(r2New))
    >>> print("DT r2: {0:.2f}".format(r2DT))
    LR Root Mean Squared Error: 4.59
    DT Root Mean Squared Error: 5.19
    LR r2: 0.93
    DT r2: 0.91


- The line below will pull the Decision Tree model from the Pipeline as display it as an if-then-else string. 
- Again, we have to "reach through" to the JVM API to make this one work.

.. code-block:: python

    >>> print dtModel.stages[-1]._java_obj.toDebugString()
    DecisionTreeRegressionModel (uid=DecisionTreeRegressor_4abb88e13269ed50c86f) of depth 3 with 15 nodes
      If (feature 0 <= 17.94)
       If (feature 0 <= 11.7)
        If (feature 0 <= 8.69)
         Predict: 483.764931685101
        Else (feature 0 > 8.69)
         Predict: 476.0754881541267
       Else (feature 0 > 11.7)
        If (feature 0 <= 14.38)
         Predict: 469.098125445474
        Else (feature 0 > 14.38)
         Predict: 462.0270406852249
      Else (feature 0 > 17.94)
       If (feature 0 <= 23.01)
        If (feature 1 <= 56.65)
         Predict: 454.4627180406213
        Else (feature 1 > 56.65)
         Predict: 447.35858133971294
       Else (feature 0 > 23.01)
        If (feature 1 <= 65.75)
         Predict: 442.84435734581297
        Else (feature 1 > 65.75)
         Predict: 434.8233486238534



So our DecisionTree has slightly worse RMSE than our LinearRegression model (LR: 4.59 vs DT: 5.19). Maybe we can try an **Ensemble Learning method** such as **Gradient-Boosted Decision Trees** to see if we can strengthen our model by using an ensemble of weaker trees with weighting to reduce the error in our model.

Random forests or random decision tree forests are an ensemble learning method for regression that operate by constructing a multitude of decision trees at training time and outputting the class that is the mean prediction (regression) of the individual trees. Random decision forests correct for decision trees' habit of overfitting to their training set.

***************************************
Exercise 7(f) (Random Forest Regressor)
***************************************
- In the next cell, create a ``RandomForestRegressor()``
- The next step is to set the parameters for the method:

  - Set the name of the prediction column to "Predicted_PE"
  - Set the name of the features column to "features"
  - Set the random number generator seed to 100088121L
  - Set the maximum depth to 8
  - Set the number of trees to 30
- Create the ML Pipeline and set the stages to the ``Vectorizer`` we created earlier and ``RandomForestRegressor()`` learner we just created.

https://wtak23.github.io/pyspark/generated/generated/ml.regression.RandomForestRegressor.html

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-f>`__)

.. code-block:: python

    from pyspark.ml.regression import RandomForestRegressor
    
    # Create a RandomForestRegressor
    rf = <FILL_IN>
    
    rf.setLabelCol("PE")\
      .setPredictionCol("Predicted_PE")\
      .setFeaturesCol("features")\
      .setSeed(100088121L)\
      .setMaxDepth(8)\
      .setNumTrees(30)
    
    # Create a Pipeline
    rfPipeline = <FILL_IN>
    
    # Set the stages of the Pipeline
    rfPipeline.<FILL_IN>

********************************
Exercise 7(g) (cross validation)
********************************
- Use ``ParamGridBuilder`` to build a parameter grid with the parameter ``rf.maxBins`` and a list of the values 50 and 100, and add the grid to the ``CrossValidator``
- Run the ``CrossValidator`` to find the parameters that yield the best model (i.e., lowest RMSE) and return the best model.

.. note:: it will take some time to run the CrossValidator as it will run almost 100 Spark jobs, and each job takes longer to run than the prior CrossValidator runs.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-g>`__)

.. code-block:: python

    # TODO: Replace <FILL_IN> with the appropriate code.
    # Let's just reuse our CrossValidator with the new rfPipeline,  RegressionEvaluator regEval, and 3 fold cross validation
    crossval.setEstimator(rfPipeline)
    
    # Let's tune over our rf.maxBins parameter on the values 50 and 100, create a paramter grid using the ParamGridBuilder
    paramGrid = <FILL_IN>
    
    # Add the grid to the CrossValidator
    crossval.<FILL_IN>
    
    # Now let's find and return the best model
    rfModel = <FILL_IN>

********************************
Exercise 7(h) (model evaluation)
********************************
Now let's see how our tuned ``RandomForestRegressor`` model's RMSE and :math:`r^2`
​​  values compare to our tuned ``LinearRegression`` and tuned ``DecisionTreeRegressor`` models.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-7-h>`__)

.. code-block:: python

    >>> # Now let's use rfModel to compute an evaluation metric for our test dataset: testSetDF
    >>> predictionsAndLabelsDF = rfModel.transform(testSetDF).select("AT", "V", "AP", "RH", "PE", "Predicted_PE")
    >>> 
    >>> # Run the previously created RMSE evaluator, regEval, on the predictionsAndLabelsDF DataFrame
    >>> rmseRF = regEval.evaluate(predictionsAndLabelsDF)
    ​>>> 
    >>> # Now let's compute the r2 evaluation metric for our test dataset
    >>> r2RF = regEval.evaluate(predictionsAndLabelsDF, {regEval.metricName: "r2"})
    ​>>> 
    >>> print("LR Root Mean Squared Error: {0:.2f}".format(rmseNew))
    >>> print("DT Root Mean Squared Error: {0:.2f}".format(rmseDT))
    >>> print("RF Root Mean Squared Error: {0:.2f}".format(rmseRF))
    >>> print("LR r2: {0:.2f}".format(r2New))
    >>> print("DT r2: {0:.2f}".format(r2DT))
    >>> print("RF r2: {0:.2f}".format(r2RF))
    LR Root Mean Squared Error: 4.59
    DT Root Mean Squared Error: 5.19
    RF Root Mean Squared Error: 3.55
    LR r2: 0.93
    DT r2: 0.91
    RF r2: 0.96


Note that the Decision Tree and Random Forest values for r2 are identical. However, the RMSE for the Random Forest model is better.

The line below will pull the Random Forest model from the Pipeline as display it as an if-then-else string.

    >>> print rfModel.stages[-1]._java_obj.toDebugString()