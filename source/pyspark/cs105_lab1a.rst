cs105_lab1a - Learning Apache Spark
"""""""""""""""""""""""""""""""""""
https://raw.githubusercontent.com/spark-mooc/mooc-setup/master/cs105_lab1a_spark_tutorial.py

#############
Spark Context
#############
In Spark, communication occurs between a **driver** and **executors**.  

- The **driver** has Spark jobs and these jobs are split into *tasks* that are submitted to the **executors** for completion.  
- The results from these tasks are delivered back to the **driver**.
- In **Databricks**, the code gets executed in the **Spark driver's JVM** and not in an executor's JVM
- In **Jupyter notebook** it is executed within the kernel associated with the notebook. Since no Spark functionality is actually being used, no tasks are launched on the executors.

To use Spark and its DataFrame API we will need to use a ``SQLContext``.  

- When running Spark, you start a new Spark application by creating a ``SparkContext``. 
- You can then create a ``SQLContext``from the ``SparkContext``. 
- When the ``SparkContext`` is created, it asks the **master** for some **cores** to use to do work.  
- The **master** sets these **cores** aside just for you; they won't be used for other applications. 
- In Databricks, both a ``SparkContext`` and a ``SQLContext`` are created for you automatically.

  - ``sc`` = ``SparkContext``
  - ``sqlContext`` is your ``SQLContext``.

#######################################################
SparkContext and the Driver Program (Cluster Structure)
#######################################################
.. admonition:: Example cluster

  - purple-outline = **slots** (threads available to perform parallel work for Spark)
  - **Spark web UI** provides details about your Spark application 
    
    - in DB, go to *Clusters* and click *Spark UI* link (`link <https://community.cloud.databricks.com/?o=3468350985695707#setting/clusters/0905-023830-choir105/sparkUi>`__)
    - there you can see under the **jobs** tab a list of jobs scheduled to run

  .. image:: http://spark-mooc.github.io/web-assets/images/cs105x/diagram-2a.png
     :align: center

************************
About the Driver Program
************************
Every **Spark application** consists of a **driver program (DP)**

- The **driver program** launches parallel operations on the executor **JVMs** running either in a cluster or locally on the same machine. 

  - In Databricks, "**Databricks Shell**" is the **driver program**. 
  - When running locally, **pyspark** is the **driver program**. 
- The driver program contains the main loop for the program and creates **distributed datasets** on the cluster, then applies **operations** (transformations & actions) to those datasets. 
- Driver programs access Spark through a **SparkContext** object

  - ``SparkContext`` represents a connection to a computing cluster. 
- A **Spark SQL context object** (``sqlContext``) is the main entry point for Spark DataFrame and SQL functionality. 

  - A ``SQLContext`` can be used to create DataFrames, which allows you to direct the operations on your data.

*************************************************
About HiveContext (the type of sqlContext for DB)
*************************************************
>>> type(sqlContext)
pyspark.sql.context.HiveContext

Note that the type is ``HiveContext``. 

- This means we're working with a version of Spark that has **Hive support**. 

  - Compiling Spark with Hive support is a good idea, even if you don't have a Hive metastore. 
- A ``HiveContext`` "provides a superset of the functionality provided by the basic ``SQLContext``. 
- Additional features include:

  - the ability to write queries using the more complete **HiveQL parser**
  - access to **Hive UDFs** [user-defined functions], and 
  - the ability to **read data from Hive tables**. 
- To use a HiveContext, you do not need to have an existing Hive setup, and all of the data sources available to a SQLContext are still available."

************
SparkContext
************
Outside of ``pyspark`` or a notebook, ``SQLContext`` is created from the **lower-level** ``SparkContext``, which is usually used to create **RDDs**. 

- ``SparkContext`` is preloaded as ``sc`` in DB
- An RDD is the way Spark actually represents data internally; 
- DataFrames are actually implemented in terms of RDDs.
- While you can interact directly with RDDs, DataFrames are preferred. 
- They're generally faster, and they perform the same no matter what language (Python, R, Scala or Java) you use with Spark.

#############################################
Using DataFrames and chaining transformations
#############################################

********************
DataFrame and Schema
********************
.. important::

  A DataFrame is **immutable**, so once it is created, it cannot be changed. 

  - As a result, **each transformation creates a new DataFrame**. 

- A **DataFrame** consists of a series of ``Row`` objects; 
- each ``Row`` object has a set of **named columns**. 
- More formally, a DataFrame must have a **schema**
  
  - this means it must consist of **columns**
  - each columns has a **name** and a **type**. 
- Some data sources have schemas built into them. Examples include:

  - RDBMS databases, 
  - Parquet files, and 
  - NoSQL databases like Cassandra. 
- Other data sources don't have computer-readable schemas, but you can often apply a schema programmatically.

**********************
Ways to define schemas
**********************
We'll use a Python ``tuple`` to help us define the Spark DataFrame schema. 

- There are other ways to define schemas, though; 
- For instance, we could also use a Python ``namedtuple`` or a Spark ``Row`` object.
- see the Spark Programming Guide's discussion of schema inference for more information (`link <http://spark.apache.org/docs/latest/sql-programming-guide.html#inferring-the-schema-using-reflection>`__).  Also see :ref:`pyspark_proguide_schema_refl`


*************************************************************
Distributed Data and using a collection to create a DataFrame
*************************************************************
In Spark, datasets are represented as a **list of entries** called **RDDs**

- here the list is broken up into many **different partitions** that are each stored on a **different machine**. 
- Each **partition** holds a unique subset of the entries in the list. 
- DataFrames are ultimately represented as RDDs, with additional meta-data.

One of the defining features of Spark, compared to other data analytics frameworks (e.g., **Hadoop**), is that it **stores data in memory** rather than on disk. This allows Spark applications to run much more quickly, because they are not slowed down by needing to read data from disk. 

.. admonition:: Spark breaks a **list of data entries** into **partitions** that are **each stored in memory on a worker**

  .. image:: http://spark-mooc.github.io/web-assets/images/cs105x/diagram-3b.png
      :align: center


Let's now create a DataFrame using ``sqlContext.createDataFrame()`` (`link <https://wtak23.github.io/pyspark/generated/generated/sql.SQLContext.createDataFrame.html>`__)

- we'll pass our array of data in as an argument to that function. 
- Spark will create a new set of input data based on data that is passed in. 

.. admonition:: DataFrame and Schema

  - A **DataFrame requires a schema**
  - **schema** is **a list of ``columns``**
  - each ``column`` has a **name** and a **type**. 
  - The schema and the column names are passed as the second argument to ``createDataFrame()``.

.. _cs105_lab1a_queryplan:

******************************************
Query plans and the ``Catalyst Optimizer``
******************************************
.. admonition:: From Databricks slides
  
  .. image:: /_static/img/pyspark_plan_optimization.png
     :align: center
     
When you use DataFrames or Spark SQL, you are building up a ``query plan``. 

Each ``transformation`` you apply to a DataFrame adds *some information to the query plan*. 

.. admonition:: (unoptimized) logical query plan -> (optimized) logical plan -> physical plan

  When you finally call an ``action``, which triggers the execution of your Spark job, the following occurs:

  - Spark's ``Catalyst optimizer`` analyzes the ``query plan`` (called an **unoptimized logical query plan**) and attempts to optimize it. 
  - Optimizations includes: (but aren't limited to) 

    - rearranging and combining ``filter()`` operations for efficiency
    - converting Decimal operations to more efficient long integer operations
    - pushing some operations down into the data source (e.g., a ``filter()`` operation might be translated to a ``SQL WHERE`` clause, if the data source is a traditional SQL RDBMS). 
  - The result of this optimization phase is an **optimized logical plan**.
  - Once Catalyst has an **optimized logical plan**, it constructs multiple **physical plans** from it.
    
    - Specifically, it implements the query in terms of lower level Spark RDD operations. 
  - Catalyst chooses which physical plan to use via cost optimization (it determines which physical plan is the most efficient and uses that one).
  - Finally, once the physical RDD execution plan is established, Spark actually executes the job.

You can examine the query plan using the ``explain()`` function on a DataFrame. 

- By default, ``explain()`` only shows you the **final physical plan**; 
- if you pass it an argument of ``True``, it will show you **all phases**.
- (If you want to take a deeper dive into how Catalyst optimizes DataFrame queries, this blog post, while a little old, is an excellent overview: `Deep Dive into Spark SQL's Catalyst Optimizer <https://databricks.com/blog/2015/04/13/deep-dive-into-spark-sqls-catalyst-optimizer.html>`__.)

See :ref:`cs105_lab1a_queryplancode` for the coding part.

