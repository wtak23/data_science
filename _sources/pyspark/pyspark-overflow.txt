``pyspark-overflow.rst``
""""""""""""""""""""""""
.. contents:: `Contents`
   :depth: 2
   :local:

##########################################################
How to get a value from the Row object in Spark Dataframe?
##########################################################
http://stackoverflow.com/questions/37999657/how-to-get-a-value-from-the-row-object-in-spark-dataframe

.. code-block:: python

    averageCount = (wordCountsDF
                    .groupBy().mean()).head()[0]

##################################################
How to add a constant column in a Spark DataFrame?
##################################################
http://stackoverflow.com/questions/32788322/how-to-add-a-constant-column-in-a-spark-dataframe?rq=1

.. code-block:: python

    >>> dt.withColumn('new_column', 10).head(5)
    AttributeError                            Traceback (most recent call last)
    <ipython-input-50-a6d0257ca2be> in <module>()
          1 dt = (messages
          2     .select(messages.fromuserid, messages.messagetype, floor(messages.datetime/(1000*60*5)).alias("dt")))
    ----> 3 dt.withColumn('new_column', 10).head(5)

.. rubric:: solution

The second argument for ``DataFrame.withColumn`` should be a Column so you have to use a ``literal``:

.. code-block:: python

    from pyspark.sql.functions import lit
    df.withColumn('new_column', lit(10))

    from pyspark.sql.functions import array, struct

    df.withColumn("some_array", array(lit(1), lit(2), lit(3)))
    df.withColumn("some_struct", struct(lit("foo"), lit(1), lit(.3)))


######################################
Add an empty column to Spark DataFrame
######################################
http://stackoverflow.com/questions/33038686/add-an-empty-column-to-spark-dataframe

Use ``literal`` and ``cast``

.. code-block:: python

    from pyspark.sql.functions import lit

    new_df = old_df.withColumn('new_column', lit(None).cast(StringType()))

A full example

.. code-block:: python

    df = sc.parallelize([row(1, "2"), row(2, "3")]).toDF()
    df.printSchema()

    ## root
    ##  |-- foo: long (nullable = true)
    ##  |-- bar: string (nullable = true)

    new_df = df.withColumn('new_column', lit(None).cast(StringType()))
    new_df.printSchema()

    ## root
    ##  |-- foo: long (nullable = true)
    ##  |-- bar: string (nullable = true)
    ##  |-- new_column: string (nullable = true)

    new_df.show()

    ## +---+---+----------+
    ## |foo|bar|new_column|
    ## +---+---+----------+
    ## |  1|  2|      null|
    ## |  2|  3|      null|
    ## +---+---+----------+


#################################################################
Count number of non-NaN entries in each column of Spark dataframe
#################################################################
http://stackoverflow.com/questions/33900726/count-number-of-non-nan-entries-in-each-column-of-spark-dataframe-with-pyspark

Creae dummy code

.. code-block:: python

    from pyspark.sql import Row

    row = Row("x", "y", "z")
    df = sc.parallelize([
        row(0, 1, 2), row(None, 3, 4), row(None, None, 5)]).toDF()

    ## +----+----+---+
    ## |   x|   y|  z|
    ## +----+----+---+
    ## |   0|   1|  2|
    ## |null|   3|  4|
    ## |null|null|  5|
    ## +----+----+---+

**********************
Use simple aggregation
**********************
.. code-block:: python

    from pyspark.sql.functions import col, count, sum

    def count_not_null(c):
        """Use conversion between boolean and integer
        - False -> 0
        - True ->  1
        """
        return sum(col(c).isNotNull().cast("integer")).alias(c)

    exprs = [count_not_null(c) for c in df.columns]
    df.agg(*exprs).show()

    ## +---+---+---+
    ## |  x|  y|  z|
    ## +---+---+---+
    ## |  1|  2|  3|
    ## +---+---+---+

**************************
Use SQL ``NULL`` semantics
**************************
Here you can achieve the same result without creating your own function

.. code-block:: python

    df.agg(*[
        count(c).alias(c)    # vertical (column-wise) operations in SQL ignore NULLs
        for c in df.columns
    ]).show()

    ## +---+---+---+
    ## |  x|  y|  z|
    ## +---+---+---+
    ## |  1|  2|  3|
    ## +---+---+---+

************
In fractions
************
.. code-block:: python

    exprs = [(count_not_null(c) / count("*")).alias(c) for c in df.columns]
    df.agg(*exprs).show()

    ## +------------------+------------------+---+
    ## |                 x|                 y|  z|
    ## +------------------+------------------+---+
    ## |0.3333333333333333|0.6666666666666666|1.0|
    ## +------------------+------------------+---+

or

.. code-block:: python

    # COUNT(*) is equivalent to COUNT(1) so NULLs won't be an issue
    df.select(*[(count(c) / count("*")).alias(c) for c in df.columns]).show()

    ## +------------------+------------------+---+
    ## |                 x|                 y|  z|
    ## +------------------+------------------+---+
    ## |0.3333333333333333|0.6666666666666666|1.0|
    ## +------------------+------------------+---+
    
####################################
Updating a dataframe column in spark
####################################
http://stackoverflow.com/questions/29109916/updating-a-dataframe-column-in-spark

.. rubric:: Question

- How would I go about changing a value in row x column y of a dataframe?
- In pandas this would be ``df.ix[x,y] = new_value``

.. rubric:: Solution

.. important::

  DataFrames are based on RDDs. **RDDs are immutable structures** and do not allow updating elements on-site. To change values, **you will need to create a new DataFrame** by transforming the original one either using the SQL-like DSL or RDD operations like map.

While you cannot modify a column as such, you may operate on a column and return a new DataFrame reflecting that change. For that you'd first create a ``UserDefinedFunction`` implementing the operation to apply and then selectively apply that function to the targeted column only.

.. code-block:: python

    from pyspark.sql.functions import UserDefinedFunction
    from pyspark.sql.types import StringType
    
    name = 'target_column'
    udf = UserDefinedFunction(lambda x: 'new_value', Stringtype())
    new_df = old_df.select(*[udf(column).alias(name) 
                             if column == name 
                             else column for column in old_df.columns])

- ``new_df`` now has the same schema as ``old_df`` 
- (assuming that ``old_df.target_column`` was of type ``StringType`` as well) - but all values in column ``target_column`` will be ``new_value``


########################################################
How do I add a new column to spark data frame (Pyspark)?
########################################################
http://stackoverflow.com/questions/33681487/how-do-i-add-a-new-column-to-spark-data-frame-pyspark

.. important:: You cannot add an arbitrary column to a DataFrame in Spark. 
  
  New columns can be created only by the following ways

********************
Use literals ``lit``
********************
.. code-block:: python

    from pyspark.sql.functions import lit

    df = sqlContext.createDataFrame(
        [(1, "a", 23.0), (3, "B", -23.0)], ("x1", "x2", "x3"))

    df_with_x4 = df.withColumn("x4", lit(0))
    df_with_x4.show()

    ## +---+---+-----+---+
    ## | x1| x2|   x3| x4|
    ## +---+---+-----+---+
    ## |  1|  a| 23.0|  0|
    ## |  3|  B|-23.0|  0|
    ## +---+---+-----+---+

*******************************
Transforming an existing column
*******************************
.. code-block:: python

    from pyspark.sql.functions import exp

    df_with_x5 = df_with_x4.withColumn("x5", exp("x3"))
    df_with_x5.show()

    ## +---+---+-----+---+--------------------+
    ## | x1| x2|   x3| x4|                  x5|
    ## +---+---+-----+---+--------------------+
    ## |  1|  a| 23.0|  0| 9.744803446248903E9|
    ## |  3|  B|-23.0|  0|1.026187963170189...|
    ## +---+---+-----+---+--------------------+

**************
Using ``join``
**************
.. code-block:: python

    from pyspark.sql.functions import exp

    lookup = sqlContext.createDataFrame([(1, "foo"), (2, "bar")], ("k", "v"))
    df_with_x6 = (df_with_x5
        .join(lookup, col("x1") == col("k"), "leftouter")
        .drop("k")
        .withColumnRenamed("v", "x6"))

    ## +---+---+-----+---+--------------------+----+
    ## | x1| x2|   x3| x4|                  x5|  x6|
    ## +---+---+-----+---+--------------------+----+
    ## |  1|  a| 23.0|  0| 9.744803446248903E9| foo|
    ## |  3|  B|-23.0|  0|1.026187963170189...|null|
    ## +---+---+-----+---+--------------------+----+

******************
Using function/UDF
******************
.. code-block:: python

    from pyspark.sql.functions import rand

    df_with_x7 = df_with_x6.withColumn("x7", rand())
    df_with_x7.show()

    ## +---+---+-----+---+--------------------+----+-------------------+
    ## | x1| x2|   x3| x4|                  x5|  x6|                 x7|
    ## +---+---+-----+---+--------------------+----+-------------------+
    ## |  1|  a| 23.0|  0| 9.744803446248903E9| foo|0.41930610446846617|
    ## |  3|  B|-23.0|  0|1.026187963170189...|null|0.37801881545497873|
    ## +---+---+-----+---+--------------------+----+-------------------+

################################################
How to change dataframe column names in pyspark?
################################################
http://stackoverflow.com/questions/34077353/how-to-change-dataframe-column-names-in-pyspark

***************************
Option 1. Using selectExpr.
***************************
.. code-block:: python

    data = sqlContext.createDataFrame([("Alberto", 2), ("Dakota", 2)], 
                                      ["Name", "askdaosdka"])
    data.show()
    data.printSchema()

    # Output
    #+-------+----------+
    #|   Name|askdaosdka|
    #+-------+----------+
    #|Alberto|         2|
    #| Dakota|         2|
    #+-------+----------+

    #root
    # |-- Name: string (nullable = true)
    # |-- askdaosdka: long (nullable = true)

    df = data.selectExpr("Name as name", "askdaosdka as age")
    df.show()
    df.printSchema()

    # Output
    #+-------+---+
    #|   name|age|
    #+-------+---+
    #|Alberto|  2|
    #| Dakota|  2|
    #+-------+---+

    #root
    # |-- name: string (nullable = true)
    # |-- age: long (nullable = true)

*************************************
Option 2. Using ``withColumnRenamed``
*************************************
Option 2. Using ``withColumnRenamed`` (`link <https://wtak23.github.io/pyspark/generated/generated/sql.DataFrame.withColumnRenamed.html>`__), notice that this method allows you to "overwrite" the same column.

.. code-block:: python

    oldColumns = data.schema.names
    newColumns = ["name", "age"]

    df = reduce(lambda data, idx: data.withColumnRenamed(oldColumns[idx], newColumns[idx]), xrange(len(oldColumns)), data)
    df.printSchema()
    df.show()

***********
Using alias
***********
.. code-block:: python

    from pyspark.sql.functions import *

    data = data.select(col("Name").alias("name"), col("askdaosdka").alias("age"))
    data.show()

    # Output
    #+-------+---+
    #|   name|age|
    #+-------+---+
    #|Alberto|  2|
    #| Dakota|  2|
    #+-------+---+


************************
Using ``sqlContext.sql``
************************
Using ``sqlContext.sql`` (`link <https://wtak23.github.io/pyspark/generated/generated/sql.SQLContext.sql.html>`__), which lets you use SQL queries on ``DataFrames`` registered as ``tables``.

.. code-block:: python

    sqlContext.registerDataFrameAsTable(data, "myTable")
    df2 = sqlContext.sql("SELECT Name AS name, askdaosdka as age from myTable")

    df2.show()

    # Output
    #+-------+---+
    #|   name|age|
    #+-------+---+
    #|Alberto|  2|
    #| Dakota|  2|
    #+-------+---+

###################################################################
PySpark DataFrames - way to enumerate without converting to Pandas?
###################################################################
http://stackoverflow.com/questions/32760888/pyspark-dataframes-way-to-enumerate-without-converting-to-pandas/32761138

Basically want the following in pandas in pyspark:

>>> indexes=[2,3,6,7] 
>>> df[indexes]

.. admonition:: answer

  Spark DataFrames don't support random row access.


########################################
Dividing two columns from a different DF
########################################
  It is not possible to reference column from another table. If you want to combine data you'll have to ``join`` first using something similar to this:

- http://stackoverflow.com/questions/38128014/dividing-two-columns-of-a-different-dataframes


.. note:: 

    - Personally not a fan of handling **joins** of two DF with overlapping column names using ``df.alias``.
    - See my private github (`link <https://github.com/wtak23/private_repos/blob/master/cs105_lab2_solutions.rst#e-exercise-average-number-of-daily-requests-per-host>`__)


.. code-block:: python

    from pyspark.sql.functions import col

    # maybe i need to get comfortable with this sql-like approach, but
    # i have the feeling this is asking for confusion...
    (df1.alias("df1")
        .join(df2.alias("df2"), ["day"])
        .select(col("day"), (col("df1.count") / col("df2.count")).alias("ratio")))

    # i'd rather do this
    df_out = (
      # join df1 and df2 on column ['day'], but rename 'count' to 'df2_count' to avoid overlap in column name after join
      df1.withColumnRenamed('count','df1_count').join(df2.withColumnRenamed('count','df2_count'), ['day'])
      .select('day', (col('df1_count')/col('df2_count')).alias('ratio'))
    )

###########################################
Ones I just bookmarked for future reference
###########################################

************************************************************
Reshaping/Pivoting data in Spark RDD and/or Spark DataFrames
************************************************************
http://stackoverflow.com/questions/30260015/reshaping-pivoting-data-in-spark-rdd-and-or-spark-dataframes?rq=1

