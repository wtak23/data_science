cs105_lab1a codes
"""""""""""""""""

.. contents:: `Contents`
   :depth: 2
   :local:

#################
Exercise Overview
#################
What the following exercise does:

* Create a Python collection of 10,000 integers
* Create a Spark DataFrame from that collection
* Subtract one from each value using ``map``
* Perform **action** ``collect`` to view results
* Perform **action** ``count`` to view counts
* Apply **transformation** ``filter`` and view results with ``collect``
* Learn about **lambda functions**
* Explore how **lazy evaluation** works and the **debugging challenges** that it introduces


###################
Create list of Data
###################
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

############################
Create DataFrame from a list
############################
Remember, we need to pass a schema as the 2nd argument to ``sqlContext.createDataFrame``

.. code-block:: python

    >>> dataDF = sqlContext.createDataFrame(data, ('last_name', 'first_name', 'ssn', 'occupation', 'age'))
    >>> print 'type of dataDF: {0}'.format(type(dataDF))
    type of dataDF: <class 'pyspark.sql.dataframe.DataFrame'>
    >>> # let's take a look at the DF's schema and some of its rows
    >>> dataDF.printSchema()
    root
     |-- last_name: string (nullable = true)
     |-- first_name: string (nullable = true)
     |-- ssn: string (nullable = true)
     |-- occupation: string (nullable = true)
     |-- age: long (nullable = true)
     
    >>> # How many partitions will the DataFrame be split into?
    >>> dataDF.rdd.getNumPartitions()
    Out[57]: 8
    >>> # *register* this DF as a named table (so we can use sql functions on it)
    >>> sqlContext.registerDataFrameAsTable(dataDF, 'dataframe')

    >>> # show content of DF
    >>> dataDF.show(5,truncate=False)
    (1) Spark Jobs
    +----------+----------+-----------+--------------------------------+---+
    |last_name |first_name|ssn        |occupation                      |age|
    +----------+----------+-----------+--------------------------------+---+
    |Harvey    |Tracey    |160-37-9051|Agricultural engineer           |39 |
    |Green     |Leslie    |361-94-4342|Teacher, primary school         |26 |
    |Lewis     |Tammy     |769-27-5887|Scientific laboratory technician|21 |
    |Cunningham|Kathleen  |175-24-7915|Geophysicist/field seismologist |42 |
    |Marquez   |Joshua    |310-69-7326|Forensic psychologist           |26 |
    +----------+----------+-----------+--------------------------------+---+
    only showing top 5 rows

####################################
Subtract one from each the *age* row
####################################
>>> # Transform dataDF through a select transformation and rename the newly created '(age -1)' column to 'age'
>>> # Because select is a transformation and Spark uses lazy evaluation, no jobs, stages,
>>> # or tasks will be launched when we run this code.
>>> subDF = dataDF.select('last_name', 'first_name', 'ssn', 'occupation', (dataDF.age - 1).alias('age'))

>>> # ``show`` is an action, so here job gets launched (so DB shows Spark Jobs dropdown menu)
>>> subDF.show(5)
(1) Spark Jobs
Job 53 View(Stages: 1/1)
+----------+----------+-----------+--------------------+---+
| last_name|first_name|        ssn|          occupation|age|
+----------+----------+-----------+--------------------+---+
|    Harvey|    Tracey|160-37-9051|Agricultural engi...| 38|
|     Green|    Leslie|361-94-4342|Teacher, primary ...| 25|
|     Lewis|     Tammy|769-27-5887|Scientific labora...| 20|
|Cunningham|  Kathleen|175-24-7915|Geophysicist/fiel...| 41|
|   Marquez|    Joshua|310-69-7326|Forensic psycholo...| 25|
+----------+----------+-----------+--------------------+---+

.. _cs105_lab1a_queryplancode:

#############################################
Apply transformations, and examine query plan
#############################################
Query plan can be examined by callined ``df.explain`` method (see :ref:`cs105_lab1a_queryplan`)

.. code-block:: python

    >>> # apply a transformation
    >>> newDF = dataDF.distinct().select('*')
    >>> # examine query plan (True = show all stages. Default is to just show the final plan)
    >>> newDF.explain(True)
    >>> # the output below may look gibberish, but with more experience, you'll get a handle of these (at least what the tutorial told me...)
    == Parsed Logical Plan ==
    'Project [*]
    +- Aggregate [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], [last_name#8,first_name#9,ssn#10,occupation#11,age#12L]
       +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Analyzed Logical Plan ==
    last_name: string, first_name: string, ssn: string, occupation: string, age: bigint
    Project [last_name#8,first_name#9,ssn#10,occupation#11,age#12L]
    +- Aggregate [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], [last_name#8,first_name#9,ssn#10,occupation#11,age#12L]
       +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Optimized Logical Plan ==
    Aggregate [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], [last_name#8,first_name#9,ssn#10,occupation#11,age#12L]
    +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Physical Plan ==
    TungstenAggregate(key=[last_name#8,first_name#9,ssn#10,occupation#11,age#12L], functions=[], output=[last_name#8,first_name#9,ssn#10,occupation#11,age#12L])
    +- TungstenExchange hashpartitioning(last_name#8,first_name#9,ssn#10,occupation#11,age#12L,200), None
       +- TungstenAggregate(key=[last_name#8,first_name#9,ssn#10,occupation#11,age#12L], functions=[], output=[last_name#8,first_name#9,ssn#10,occupation#11,age#12L])
          +- Scan ExistingRDD[last_name#8,first_name#9,ssn#10,occupation#11,age#12L]

Repeat by examining query plan for ``subDF`` after subtraction

.. code-block:: python

    >>> subDF.explain(True)
    == Parsed Logical Plan ==
    'Project [unresolvedalias('last_name),unresolvedalias('first_name),unresolvedalias('ssn),unresolvedalias('occupation),(age#12L - 1) AS age#13]
    +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Analyzed Logical Plan ==
    last_name: string, first_name: string, ssn: string, occupation: string, age: bigint
    Project [last_name#8,first_name#9,ssn#10,occupation#11,(age#12L - cast(1 as bigint)) AS age#13L]
    +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Optimized Logical Plan ==
    Project [last_name#8,first_name#9,ssn#10,occupation#11,(age#12L - 1) AS age#13L]
    +- LogicalRDD [last_name#8,first_name#9,ssn#10,occupation#11,age#12L], MapPartitionsRDD[8] at applySchemaToPythonRDD at NativeMethodAccessorImpl.java:-2

    == Physical Plan ==
    Project [last_name#8,first_name#9,ssn#10,occupation#11,(age#12L - 1) AS age#13L]
    +- Scan ExistingRDD[last_name#8,first_name#9,ssn#10,occupation#11,age#12L]

###############################
Use ``collect`` to view results
###############################
.. admonition:: Execution of ``collect`` with four partitions

  - Here the dataset is broken into four partitions, so four ``collect()`` tasks are launched. 
  - Each **task** collects the entries in its **partition** and sends the result to the **driver**, which creates a list of the values.

  .. image:: http://spark-mooc.github.io/web-assets/images/cs105x/diagram-3d.png
     :align: center

- To see a list of elements decremented by one, we need to create a new list on the driver from the the data distributed in the executor nodes. 
- To do this we can call the ``collect()`` method on our DataFrame. 
- ``collect()`` is often used after transformations to ensure that we are only returning a small amount of data to the driver. 
  
  - This is done because the data returned to the driver must fit into the driver's available memory. If not, the driver will crash.
- ``collect`` is a Spark ``Action``
- ``Action`` operations cause Spark to perform the (lazy) transformation operations that are required to compute the values returned by the action. 
- In our example, this means that tasks will now be launched to perform the createDataFrame, select, and collect operations.   

.. code-block:: python

  >>> # Let's collect the data
  >>> results = subDF.collect()
  >>> print results
  (1) Spark Jobs
  [Row(last_name=u'Harvey', first_name=u'Tracey', ssn=u'160-37-9051', occupation=u'Agricultural engineer', age=38), Row(last_name=u'Green', first_name=u'Leslie', ssn=u'361-94-4342', occupation=u'Teacher, primary                               school', age=25), Row(last_name=u'Lewis', first_name=u'Tammy', ssn=u'769-27-5887', occupation=u'Scientific laboratory technician', age=20), Row(last_name=u'Cunningham', first_name=u'Kathleen', ssn=u'175-24-7915', occupation=u'Geophysicist/field seismologist', age=41), Row(last_name=u'Marquez', first_name=u'Joshua', ssn=u'310-69-7326', occupation=u'Forensic psychologist', age=25), Row(last_name=u'Summers', first_name=u'Beth', ssn=u'099-90-9730', occupation=u'Best boy', age=42), Row(last_name=u'Jessica', first_name=u'Mrs.', ssn=u'476-06-5497', occupation=u'English as a foreign language teacher', age=42), Row(last_name=u'Turner', first_name=u'Diana', ssn=u'722-09-8354', occupation=u'Psychologist, prison and probation services', age=6), Row(last_name=u'Johnson', first_name=u'Ryan', ssn=u'715-56-1708', occupation=u'Sales executive', age=4), Row(last_name=u'Lewis', first_name=u'Melissa', ssn=u'123-48-8354', occupation=u'Engineer, broadcasting (operations)', age=16), Row(last_name=u'Hernandez', first_name=u'Benjamin', ssn=u'293-22-0265', occupation=u'Scientist, product/process deve
  ...

.. code-block:: python
      
    >>> # ``collect()`` create a list of Row objects...print each row at a time
    >>> for _i in xrange(10):
    >>>   print _i,results[_i]
    0 Row(last_name=u'Harvey', first_name=u'Tracey', ssn=u'160-37-9051', occupation=u'Agricultural engineer', age=38)
    1 Row(last_name=u'Green', first_name=u'Leslie', ssn=u'361-94-4342', occupation=u'Teacher, primary school', age=25)
    2 Row(last_name=u'Lewis', first_name=u'Tammy', ssn=u'769-27-5887', occupation=u'Scientific laboratory technician', age=20)
    3 Row(last_name=u'Cunningham', first_name=u'Kathleen', ssn=u'175-24-7915', occupation=u'Geophysicist/field seismologist', age=41)
    4 Row(last_name=u'Marquez', first_name=u'Joshua', ssn=u'310-69-7326', occupation=u'Forensic psychologist', age=25)
    5 Row(last_name=u'Summers', first_name=u'Beth', ssn=u'099-90-9730', occupation=u'Best boy', age=42)
    6 Row(last_name=u'Jessica', first_name=u'Mrs.', ssn=u'476-06-5497', occupation=u'English as a foreign language teacher', age=42)
    7 Row(last_name=u'Turner', first_name=u'Diana', ssn=u'722-09-8354', occupation=u'Psychologist, prison and probation services', age=6)
    8 Row(last_name=u'Johnson', first_name=u'Ryan', ssn=u'715-56-1708', occupation=u'Sales executive', age=4)
    9 Row(last_name=u'Lewis', first_name=u'Melissa', ssn=u'123-48-8354', occupation=u'Engineer, broadcasting (operations)', age=16)
    10 Row(last_name=u'Hernandez', first_name=u'Benjamin', ssn=u'293-22-0265', occupation=u'Scientist, product/process development', age=28)  

#############################
display helper function in DB
#############################

>>> display(subDF) 

.. image:: /_static/img/db_display_df.png
   :align: center

####################################
More actions: ``count`` to get total
####################################
The ``count()`` action will count the number of elements in a DataFrame.

- Because ``count()`` is an action operation, if we had not already performed an action with ``collect()``, then Spark would now perform the transformation operations when we executed ``count()``.
- Each task counts the entries in its partition and sends the result to your SparkContext, which adds up all of the counts. 

>>> # two actions here, so 2 spark jobs
>>> print dataDF.count()
>>> print subDF.count()
(2) Spark Jobs
10000
10000

.. admonition:: Figure shows what would happen if we ran ``count()`` on a small example dataset with just four partitions

  .. image:: http://spark-mooc.github.io/web-assets/images/cs105x/diagram-3e.png
     :align: center

#################################################################
Apply transformation ``filter`` and view results with ``collect``
#################################################################

.. admonition:: How ``filter`` might work on a small four-partition dataset.

  .. image:: http://spark-mooc.github.io/web-assets/images/cs105x/diagram-3f.png
     :align: center

Let's create a new DF that only contains people whose ages are less than 10

- You can also use ``where()``, an alias for ``filter()``, if you prefer something more SQL-like
- to view the filtered list of elements less than 10, we need to create a new list on the driver from the distributed data on the executor nodes. 
- We use the ``collect()`` method to return a list that contains all of the elements in this filtered DataFrame to the driver program.

.. code-block:: python

  >>> filteredDF = subDF.filter(subDF.age < 10)
  >>> filteredDF.show(5,truncate=False)
  >>> filteredDF.count()
  (2) Spark Jobs
  +---------+----------+-----------+-------------------------------------------+---+
  |last_name|first_name|ssn        |occupation                                 |age|
  +---------+----------+-----------+-------------------------------------------+---+
  |Turner   |Diana     |722-09-8354|Psychologist, prison and probation services|6  |
  |Johnson  |Ryan      |715-56-1708|Sales executive                            |4  |
  |Andrade  |Sophia    |386-07-6013|Social research officer, government        |5  |
  |Arnold   |Heather   |737-44-0894|Economist                                  |7  |
  |Joshua   |Mr.       |363-83-5358|Hotel manager                              |8  |
  +---------+----------+-----------+-------------------------------------------+---+
  only showing top 5 rows

  Out[33]: 2084

#########################
Lambda functions and UDFs
#########################
Python supports the use of small one-line anonymous functions that are not bound to a name at runtime.

- lambda functions, borrowed from LISP, can be used wherever function objects are required. 
- They are syntactically restricted to a single expression. 

.. note:: Remember that lambda functions are a matter of style and using them is never required - semantically, they are just syntactic sugar for a normal function definition. You can always define a separate normal function instead, but using a lambda function is an equivalent and more compact form of coding. 

- Ideally you should consider using lambda functions where you want to encapsulate non-reusable code without littering your code with one-line functions.
- Here, instead of defining a separate function for the ``filter()`` transformation, we will use an inline ``lambda()`` function and we will register that lambda as a Spark **User Defined Function (UDF)**. 
- A **UDF** is a special wrapper around a function, allowing the function to be used in a DataFrame query.

.. code-block:: python

    >>> from pyspark.sql.types import BooleanType

    >>> # Let's collect the even values less than 10
    >>> less_ten = udf(lambda s: s < 10, BooleanType())
    >>> lambdaDF = subDF.filter(less_ten(subDF.age))
    >>> lambdaDF.show(5)
    >>> lambdaDF.count()
    (2) Spark Jobs
    +---------+----------+-----------+--------------------+---+
    |last_name|first_name|        ssn|          occupation|age|
    +---------+----------+-----------+--------------------+---+
    |   Turner|     Diana|722-09-8354|Psychologist, pri...|  6|
    |  Johnson|      Ryan|715-56-1708|     Sales executive|  4|
    |  Andrade|    Sophia|386-07-6013|Social research o...|  5|
    |   Arnold|   Heather|737-44-0894|           Economist|  7|
    |   Joshua|       Mr.|363-83-5358|       Hotel manager|  8|
    +---------+----------+-----------+--------------------+---+
    only showing top 5 rows

    Out[55]: 2084


.. code-block:: python

    >>> # Let's collect the even values less than 10
    >>> even = udf(lambda s: s % 2 == 0, BooleanType())
    >>> evenDF = lambdaDF.filter(even(lambdaDF.age))
    >>> evenDF.show(5)
    >>> evenDF.count()
    (2) Spark Jobs
    +---------+----------+-----------+--------------------+---+
    |last_name|first_name|        ssn|          occupation|age|
    +---------+----------+-----------+--------------------+---+
    |   Turner|     Diana|722-09-8354|Psychologist, pri...|  6|
    |  Johnson|      Ryan|715-56-1708|     Sales executive|  4|
    |   Joshua|       Mr.|363-83-5358|       Hotel manager|  8|
    |    Kelly|     Tracy|082-13-6448|Architectural tec...|  8|
    |   Church|     David|370-59-5122|Museum education ...|  6|
    +---------+----------+-----------+--------------------+---+
    only showing top 5 rows

    Out[57]: 993

############################
Additional DataFrame actions
############################
.. note:: Note that for the first() and take() actions, the elements that are returned depend on how the DataFrame is partitioned.

- Instead of using the ``collect()`` action, we can use the ``take(n)`` action to return the first n elements of the DataFrame. 
- The ``first()`` action returns the first element of a DataFrame, and is equivalent to ``take(1)[0]``.

.. code-block:: python

    >>> print "first: {0}\n".format(filteredDF.first())
    ​>>> print "Four of them: {0}\n".format(filteredDF.take(4))
    (2) Spark Jobs
    first: Row(last_name=u'Turner', first_name=u'Diana', ssn=u'722-09-8354', occupation=u'Psychologist, prison and probation services', age=6)

    Four of them: [Row(last_name=u'Turner', first_name=u'Diana', ssn=u'722-09-8354', occupation=u'Psychologist, prison and probation services', age=6), Row(last_name=u'Johnson', first_name=u'Ryan', ssn=u'715-56-1708', occupation=u'Sales executive', age=4), Row(last_name=u'Andrade', first_name=u'Sophia', ssn=u'386-07-6013', occupation=u'Social research officer, government', age=5), Row(last_name=u'Arnold', first_name=u'Heather', ssn=u'737-44-0894', occupation=u'Economist', age=7)]

    >>> # for better presentation (on DB notebook)
    display(filteredDF.take(4))

####################################
Additional DataFrame transformations
####################################

*******
orderBy
*******
.. code-block:: python

    >>> # Get the five oldest people in the list. To do that, sort by age in descending order.
    >>> #display(dataDF.orderBy(dataDF.age.desc()).take(5))
    >>> for _ in dataDF.orderBy(dataDF.age.desc()).take(5):
    >>>   print _
    (2) Spark Jobs
    Row(last_name=u'Smith', first_name=u'Jessica', ssn=u'371-59-8543', occupation=u'Medical physicist', age=47)
    Row(last_name=u'Blankenship', first_name=u'Crystal', ssn=u'341-29-9523', occupation=u'Commercial/residential surveyor', age=47)
    Row(last_name=u'Meyer', first_name=u'Christine', ssn=u'803-59-5869', occupation=u'Early years teacher', age=47)
    Row(last_name=u'George', first_name=u'Wesley', ssn=u'622-72-1540', occupation=u'Therapist, art', age=47)
    Row(last_name=u'Davila', first_name=u'Steven', ssn=u'479-63-8770', occupation=u'Purchasing manager', age=47)

*************************************
A ``distinct`` and ``dropDuplicates``
*************************************
``distinct()`` filters out duplicate rows, and it considers all columns. 

.. code-block:: python

    >>> # since the data is randomly generated, very likely there's no duplicates
    >>> print dataDF.count()
    >>> print dataDF.distinct().count()
    (2) Spark Jobs
    10000
    10000

    >>> # a quick demonstration of distinct
    >>> tempDF = sqlContext.createDataFrame([("Joe", 1), ("Joe", 1), ("Anna", 15), ("Anna", 12), ("Ravi", 5)], ('name', 'score'))
    >>> tempDF.show()
    (2) Spark Jobs
    +----+-----+
    |name|score|
    +----+-----+
    | Joe|    1|
    | Joe|    1|
    |Anna|   15|
    |Anna|   12|
    |Ravi|    5|
    +----+-----+

    >>> tempDF.distinct().show() # note anna row was kept since score wasn' the same
    (2) Spark Jobs
    +----+-----+
    |name|score|
    +----+-----+
    |Ravi|    5|
    |Anna|   12|
    |Anna|   15|
    | Joe|    1|
    +----+-----+


``dropDuplicates()`` is like ``distinct()``, except that it **allows us to specify the columns to compare**. 

For instance, we can use it to drop all rows where the first name and last name duplicates (ignoring the occupation and age columns).

>>> print dataDF.count()
>>> print dataDF.dropDuplicates(['first_name', 'last_name']).count()
(2) Spark Jobs
10000
9352

****
drop
****
``drop()`` is like the opposite of ``select()``: Instead of selecting specific columns from a DataFrame, it drops a specifed column from a DataFrame.

- A simple use case: get rid of 5 columns from 1000 columned CSV table. 
- Instead of selecting 995 of the columns, it's easier just to drop the five you don't want.

>>> dataDF.drop('occupation').drop('age').show()
(1) Spark Jobs
+----------+----------+-----------+
| last_name|first_name|        ssn|
+----------+----------+-----------+
|    Harvey|    Tracey|160-37-9051|
|     Green|    Leslie|361-94-4342|
|     Lewis|     Tammy|769-27-5887|
|Cunningham|  Kathleen|175-24-7915|
|   Marquez|    Joshua|310-69-7326|
|   Summers|      Beth|099-90-9730|
|   Jessica|      Mrs.|476-06-5497|
|    Turner|     Diana|722-09-8354|
|   Johnson|      Ryan|715-56-1708|
|     Lewis|   Melissa|123-48-8354|
| Hernandez|  Benjamin|293-22-0265|
|     Dixon| Stephanie|041-23-3263|
|       Kim|      Leah|725-61-1132|
|    Snyder|    Leslie|268-79-4330|
|    Ortega|   Kenneth|077-96-8349|
|    Barnes|     Ricky|061-88-1648|
|     Adams|    Robert|582-28-0099|
|   Andrade|    Sophia|386-07-6013|
|     Weeks| Catherine|363-94-7993|
|     Tapia|    Thomas|386-39-5490|
+----------+----------+-----------+
only showing top 20 rows

*******
groupBy
*******
``groupBy()`` is one of the most powerful transformations. It allows you to perform aggregations on a DataFrame.
- Unlike other DataFrame transformations, ``groupBy()`` does not return a DataFrame. 
  
  - Instead, it returns a special ``GroupedData`` object that contains various aggregation functions.
- The most commonly used aggregation function is ``count()``, but there are others --- like ``sum()``, ``max()``, and ``avg()``.
- These aggregation functions typically create a new column and return a new DataFrame.

.. code-block:: python

    >>> dataDF.groupBy('occupation').count().show(n=5,truncate=False)
    (1) Spark Jobs
    +------------------------+-----+
    |occupation              |count|
    +------------------------+-----+
    |Agricultural engineer   |9    |
    |Operational researcher  |17   |
    |Textile designer        |11   |
    |Public relations officer|20   |
    |Politician's assistant  |11   |
    +------------------------+-----+
    only showing top 5 rows

    >>> dataDF.groupBy().avg('age').show(truncate=False)
    (1) Spark Jobs
    +--------+
    |avg(age)|
    +--------+
    |24.3803 |
    +--------+

    >>> # We can also use groupBy() to do aother useful aggregations:
    >>> print "Maximum age: {0}".format(dataDF.groupBy().max('age').first()[0])
    >>> print "Minimum age: {0}".format(dataDF.groupBy().min('age').first()[0])
    (2) Spark Jobs
    Maximum age: 47
    Minimum age: 1

******
sample
******


>>> sampledDF = dataDF.sample(withReplacement=False, fraction=0.10)
>>> print sampledDF.count()
>>> sampledDF.show(n=8)
(2) Spark Jobs
1028
+---------+----------+-----------+--------------------+---+
|last_name|first_name|        ssn|          occupation|age|
+---------+----------+-----------+--------------------+---+
|    Lewis|     Tammy|769-27-5887|Scientific labora...| 21|
|  Jessica|      Mrs.|476-06-5497|English as a fore...| 43|
|   Snyder|    Leslie|268-79-4330|        Chiropractor| 15|
|    Adams|    Robert|582-28-0099|Manufacturing sys...| 12|
|   Arnold|   Heather|737-44-0894|           Economist|  8|
|     Bird|    Curtis|790-03-8999|     Psychotherapist| 27|
|     Love|      Gary|117-61-4564|         Music tutor| 15|
|  Gardner|   Charles|695-93-4517|Conference centre...| 35|
+---------+----------+-----------+--------------------+---+
only showing top 8 rows
>>> print dataDF.sample(withReplacement=False, fraction=0.05).count()
(1) Spark Jobs
538

######################################
Caching DataFrames and Storage Options
######################################
::

  For efficiency Spark keeps your DataFrames in memory. (More formally, it keeps the RDDs that implement your DataFrames in memory.) By keeping the contents in memory, Spark can quickly access the data. However, memory is limited, so if you try to keep too many partitions in memory, Spark will automatically delete partitions from memory to make space for new ones. If you later refer to one of the deleted partitions, Spark will automatically recreate it for you, but that takes time.
  So, if you plan to use a DataFrame more than once, then you should tell Spark to cache it. You can use the cache() operation to keep the DataFrame in memory. However, you must still trigger an action on the DataFrame, such as collect() or count() before the caching will occur. In other words, cache() is lazy: It merely tells Spark that the DataFrame should be cached when the data is materialized. You have to run an action to materialize the data; the DataFrame will be cached as a side effect. The next time you use the DataFrame, Spark will use the cached data, rather than recomputing the DataFrame from the original data.
  You can see your cached DataFrame in the "Storage" section of the Spark web UI. If you click on the name value, you can see more information about where the the DataFrame is stored.

.. code-block:: python

    >>> # Cache the DataFrame
    >>> filteredDF.cache()
    >>> # Trigger an action
    >>> print filteredDF.count()
    >>> # Check if it is cached
    >>> print filteredDF.is_cached
    (1) Spark Jobs
    2084
    True


*****************************
Unpersist and storage options
*****************************
::

  Spark automatically manages the partitions cached in memory. If it has more partitions than available memory, by default, it will evict older partitions to make room for new ones. For efficiency, once you are finished using cached DataFrame, you can optionally tell Spark to stop caching it in memory by using the DataFrame's unpersist() method to inform Spark that you no longer need the cached data.

  Advanced: Spark provides many more options for managing how DataFrames cached. For instance, you can tell Spark to spill cached partitions to disk when it runs out of memory, instead of simply throwing old ones away. You can explore the API for DataFrame's persist() operation using Python's help() command. The persist() operation, optionally, takes a pySpark StorageLevel object.

.. code-block:: python

    >>> # If we are done with the DataFrame we can unpersist it so that its memory can be reclaimed
    >>> filteredDF.unpersist()
    >>> # Check if it is cached
    >>> print filteredDF.is_cached
    False


################################################
Debugging Spark applications and lazy evaluation
################################################

**********************************************
JVM and Py4J - How Python is Executed in Spark
**********************************************
Internally, Spark executes using a Java Virtual Machine (JVM). pySpark runs Python code in a JVM using `Py4J <http://py4j.sourceforge.net/>`__. Py4J enables Python programs running in a Python interpreter to dynamically access Java objects in a Java Virtual Machine. Methods are called as if the Java objects resided in the Python interpreter and Java collections can be accessed through standard Python collection methods. Py4J also enables Java programs to call back Python objects.

Because pySpark uses Py4J, coding errors often result in a complicated, confusing stack trace that can be difficult to understand. In the following section, we'll explore how to understand stack traces.

*****************************************************************
Challenges with lazy evaluation using transformations and actions
*****************************************************************
Spark's use of lazy evaluation can make debugging more difficult because code is not always executed immediately. To see an example of how this can happen, let's first define a broken filter function. Next we perform a filter() operation using the broken filtering function. No error will occur at this point due to Spark's use of lazy evaluation.

The filter() method will not be executed until an action operation is invoked on the DataFrame. We will perform an action by using the count() method to return a list that contains all of the elements in this DataFrame.

***************
Finding the bug
***************
When the filter() method is executed, Spark calls the UDF. Since our UDF has an error in the underlying filtering function brokenTen(), an error occurs.
Scroll through the output "Py4JJavaError Traceback (most recent call last)" part of the cell and first you will see that the line that generated the error is the count() method line. There is nothing wrong with this line. However, it is an action and that caused other methods to be executed. Continue scrolling through the Traceback and you will see the following error line::

  NameError: global name 'val' is not defined

Looking at this error line, we can see that we used the wrong variable name in our filtering function brokenTen().

**************************
Moving toward expert style
**************************
As you are learning Spark, I recommend that you write your code in the form:

.. code-block:: python

    df2 = df1.transformation1()
    df2.action1()
    df3 = df2.transformation2()
    df3.action2()

Using this style will make debugging your code much easier as it makes errors easier to localize - errors in your transformations will occur when the next action is executed.

Once you become more experienced with Spark, you can write your code with the form: ``df.transformation1().transformation2().action()``

We can also use ``lambda()`` functions instead of separately defined functions when their use improves readability and conciseness.

To make the expert coding style more readable, enclose the statement in parentheses and put each method, transformation, or action on a separate line.

.. code-block:: python

    >>> # Final version
    >>> from pyspark.sql.functions import *
    >>> (dataDF
    >>>  .filter(dataDF.age > 20)
    >>>  .select(concat(dataDF.first_name, lit(' '), dataDF.last_name), dataDF.occupation)
    >>>  .show(n=5,truncate=False)
    >>>  )
    (1) Spark Jobs
    +------------------------------+--------------------------------+
    |concat(first_name, ,last_name)|occupation                      |
    +------------------------------+--------------------------------+
    |Tracey Harvey                 |Agricultural engineer           |
    |Leslie Green                  |Teacher, primary school         |
    |Tammy Lewis                   |Scientific laboratory technician|
    |Kathleen Cunningham           |Geophysicist/field seismologist |
    |Joshua Marquez                |Forensic psychologist           |
    +------------------------------+--------------------------------+
    only showing top 5 rows