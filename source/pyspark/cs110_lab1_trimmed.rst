cs110_lab1_trimmed
""""""""""""""""""
``cs110_lab1_trimmed.rst``


.. contents:: `Contents`
   :depth: 2
   :local:

.. rubric:: During this lab we will cover:

#. Load Your Data
#. Explore Your Data
#. Visualize Your Data
#. Data Preparation
#. Data Modeling
#. Tuning and Evaluation

#############################################
Part2: Extract-Transform-Load (ETL) Your Data
#############################################

.. code-block:: python

    >>> # show data on Amazon s3 at path dbfs:/databricks-datasets/power-plant/data
    >>> display(dbutils.fs.ls("/databricks-datasets/power-plant/data"))

.. image:: /_static/img/cs110_pic1.png
    :align: center

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

***********
Exercise 2a
***********
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab1_solutions.rst#exercise-2a>`__)

.. code-block:: python

    >>> # TODO: Load the data and print the first five lines.
    >>> rawTextRdd = <FILL_IN>
    AT  V AP  RH  PE
    14.96 41.76 1024.07 73.17 463.26
    25.18 62.96 1020.04 59.08 444.37
    5.11  39.4  1012.16 92.14 488.56
    20.86 57.32 1010.24 76.64 446.48



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

- Relevant links

  - https://wtak23.github.io/pyspark/generated/sql.types.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.types.StructField.html
  - https://wtak23.github.io/pyspark/generated/generated/sql.types.StructType.html


>>> struct1 = StructType([StructField("f1", StringType(), True)])
>>> struct1["f1"]
StructField(f1,StringType,true)
>>> struct1[0]
StructField(f1,StringType,true)







































