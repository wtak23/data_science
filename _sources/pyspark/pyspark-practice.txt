``pyspark-practice.rst``
""""""""""""""""""""""""
.. contents:: `Contents`
   :depth: 2
   :local:

##########
Basics DFs
##########

.. code-block:: python

    >>> import pyspark
    >>> from pyspark import sql
    >>> 
    >>> row = sql.Row(name='Alice',age='11')
    >>> print row
    Row(age='11', name='Alice')
    
    >>> data = [('Alice',12), ('Bob', 32)]
    >>> df = sqlContext.createDataFrame(data,schema=('name','age')) 
    >>> df.printSchema()
    root
     |-- name: string (nullable = true)
     |-- age: long (nullable = true)

    >>> # select all column
    >>> print "df.select('*') = ",df.select('*')
    df.select('*') =  DataFrame[name: string, age: bigint]

    >>> print "df.select('*').collect() = ",df.select('*').collect() # careful with `collect` with big data
    df.select('*').collect() =  [Row(name=u'Alice', age=12), Row(name=u'Bob', age=32)]


    >>> df.select('*').show() 
    +-----+---+
    | name|age|
    +-----+---+
    |Alice| 12|
    |  Bob| 32|
    +-----+---+

    >>> # select name and age columns
    >>> df.select('name','age').show(n=2,truncate=False)
    +-----+---+
    |name |age|
    +-----+---+
    |Alice|12 |
    |Bob  |32 |
    +-----+---+

    >>> # select column 'age', add 10, provide name 'age' to resulting column
    >>> tmp = df.select(
    >>>                  df.name,
    >>>                  (df.age + 10).alias('age_inc')
    >>> )
    >>> tmp.show()
    +-----+-------+
    | name|age_inc|
    +-----+-------+
    |Alice|     22|
    |  Bob|     42|
    +-----+-------+

    >>> # drop column
    >>> df.drop(df.age).show()
    +-----+
    | name|
    +-----+
    |Alice|
    |  Bob|
    +-----+

    >>> df.select(df['name'].alias('hey')).show()
    +-----+
    |  hey|
    +-----+
    |Alice|
    |  Bob|
    +-----+

    >>> df.select((10+df.age.alias('s'))).show()
    +---------------------+
    |(age AS s#2369L + 10)|
    +---------------------+
    |                   22|
    |                   42|
    +---------------------+

####
UDFs
####
.. code-block:: python

    >>> # user-defined function
    >>> # SparkSession.udf (preloaded in databricks)
    >>> slen = udf(lambda s: len(s),sql.types.IntegerType())
    
    >>> print slen.__class__
    <class 'pyspark.sql.functions.UserDefinedFunction'>

    >>> df.select(slen(df.name).alias('slen')).show()
    +----+
    |slen|
    +----+
    |   5|
    |   3|
    +----+

    >>> doubled = udf(lambda s: 2*s, sql.types.IntegerType())
    >>> df2 = df.select(df.name, doubled(df.age).alias('age'))
    >>> df2.show()
    +-----+---+
    | name|age|
    +-----+---+
    |Alice| 24|
    |  Bob| 64|
    +-----+---+
    >>> 
    >>> df2.filter(df2.age > 30).show()
    +----+---+
    |name|age|
    +----+---+
    | Bob| 64|
    +----+---+

#######
Sorting
#######
.. code-block:: python

    >>> df.sort('age').show()
    +-----+---+
    | name|age|
    +-----+---+
    |Alice| 12|
    |  Bob| 32|
    +-----+---+
    >>> df.sort('age',ascending=False).show()
    +-----+---+
    | name|age|
    +-----+---+
    |  Bob| 32|
    |Alice| 12|
    +-----+---+

#############################
Create DF from list of tuples
#############################
.. code-block:: python

    >>> data = [('cat',1,21.0), ('dog',2,8.),
    >>>         ('cat',3,9.5), ('dog',3,16.2)]
    >>> df = sqlContext.createDataFrame(data, schema=['animal','age','weight'])
    >>> df.show()
    +------+---+------+
    |animal|age|weight|
    +------+---+------+
    |   cat|  1|  21.0|
    |   dog|  2|   8.0|
    |   cat|  3|   9.5|
    |   dog|  3|  16.2|
    +------+---+------+

    >>> print df.groupBy(df.animal).count().collect()
    [Row(animal=u'dog', count=2), Row(animal=u'cat', count=2)]
    >>> df.groupBy(df.animal).count().show()
    +------+-----+
    |animal|count|
    +------+-----+
    |   dog|    2|
    |   cat|    2|
    +------+-----+

#######
groupby
#######
.. code-block:: python

    
    >>> df.groupBy().count().show()
    +-----+
    |count|
    +-----+
    |    4|
    +-----+

    >>> df.groupBy().avg().show()
    +--------+-----------+
    |avg(age)|avg(weight)|
    +--------+-----------+
    |    2.25|     13.675|
    +--------+-----------+

    >>> df.groupBy('animal').avg('weight','age').show()
    +------+-----------+--------+
    |animal|avg(weight)|avg(age)|
    +------+-----------+--------+
    |   dog|       12.1|     2.5|
    |   cat|      15.25|     2.0|
    +------+-----------+--------+

########################
Practice with faker data
########################

.. code-block:: python

    >>> # create toy data
    >>> from faker import Factory
    >>> fake = Factory.create()
    >>> fake.seed(4321)
    >>> 
    >>> def fake_entry():
    >>>   name = fake.name().split() # name = ['firstname','lastname']
    >>>     
    >>>   # 5-element tuple = (last_name, first_name, ssn, job-title, age)
    >>>   return (name[1], name[0], fake.ssn(), fake.job(), abs(2016 - fake.date_time().year) + 1)

    >>> print fake.name().split()
    [u'Tracey', u'Harvey']
    >>> print fake_entry()
    (u'Hicks', u'Martha', u'039-19-0531', 'Energy engineer', 19)

******************************
Little refrehser on generators
******************************
.. code-block:: python

    >>> # create a generator via yield
    >>> def repeat(times, func, *args, **kwargs):
    >>>     for _ in xrange(times):
    >>>         yield func(*args, **kwargs)

    >>> tmp = repeat(5,fake_entry)
    >>> print tmp
    <generator object repeat at 0x7fe008486960>

    >>> for i,person in enumerate(tmp):
    >>>   print i,person
    0 (u'Warren', u'Melissa', u'824-45-1140', 'Civil engineer, contracting', 37)
    1 (u'Reed', u'Joshua', u'735-56-4346', 'Dance movement psychotherapist', 20)
    2 (u'Kerr', u'Lori', u'382-11-7793', 'Dispensing optician', 38)
    3 (u'Mills', u'Rachel', u'356-45-3733', 'Patent attorney', 27)
    4 (u'Madden', u'Amy', u'087-09-9992', 'Nutritional therapist', 45)

    >>> tmp = repeat(5,fake_entry)
    >>> print next(tmp)
    (u'Simpson', u'Kelly', u'048-55-3413', 'Brewing technologist', 39)
    >>> print next(tmp)
    (u'Walker', u'Blake', u'076-83-7404', 'Sports therapist', 10)
    >>> print next(tmp)
    (u'Joyce', u'Sheri', u'504-17-8123', 'Surveyor, quantity', 34)
    >>> print next(tmp)
    (u'Stokes', u'Michael', u'436-83-3006', 'Paramedic', 17)
    >>> print next(tmp)
    (u'Dawson', u'Gail', u'194-03-8285', 'Further education lecturer', 35)
    >>> try:
    >>>   print next(tmp)
    >>> except Exception as err:
    >>>   print type(err)
    <type 'exceptions.StopIteration'>

#########################
Register table to use SQL
#########################
.. code-block:: python

    >>> # schem=None is default; let Spark infer the schema from data
    >>> dataDF_ = sqlContext.createDataFrame(data)
    >>> dataDF_.printSchema()
    root
     |-- _1: string (nullable = true)
     |-- _2: string (nullable = true)
     |-- _3: string (nullable = true)
     |-- _4: string (nullable = true)
     |-- _5: long (nullable = true)

    >>> # explicitly provide scheme
    >>> dataDF = sqlContext.createDataFrame(data,schema=('last_name','first_name','ssn','occupation','age'))
    >>> dataDF.printSchema()
    root
     |-- last_name: string (nullable = true)
     |-- first_name: string (nullable = true)
     |-- ssn: string (nullable = true)
     |-- occupation: string (nullable = true)
     |-- age: long (nullable = true)
    >>> 
    >>> # register DF as a *named-table*
    >>> # https://wtak23.github.io/pyspark_doc/autosummary/pyspark.sql.SQLContext.registerDataFrameAsTable.html
    >>> # This registration is needed to query the data
    >>> sqlContext.registerDataFrameAsTable(dataDF,'dataframe')
    >>> 
    >>> # this allows us to use sql statements
    >>> sqlContext.sql("SELECT * FROM dataframe").show()
    +---------+-----------+-----------+--------------------+---+
    |last_name| first_name|        ssn|          occupation|age|
    +---------+-----------+-----------+--------------------+---+
    | Hamilton|Christopher|206-33-1107|  Investment analyst| 29|
    |  Leonard|        Mr.|102-08-1041|Arts development ...| 34|
    |   Hardin|       Paul|390-15-6991|Theatre stage man...| 15|
    |   Spears|   Jonathan|751-89-6784|     Tourism officer| 11|
    | Marshall|    William|149-71-3133|   Psychiatric nurse| 24|
    |    Perez|    Melanie|009-56-7562|    Fashion designer| 34|
    |Blanchard|     Teresa|541-85-8814|Designer, fashion...|  7|
    | Cardenas|      Keith|719-03-1247|Operations geologist| 39|
    |   Miller|     Teresa|494-46-7761|Commercial hortic...| 38|
    |      Lee|    Jeffrey|081-27-8487|Print production ...|  4|
    |    Henry|      James|810-74-4478| Animal technologist|  6|
    | Callahan|      Cindy|587-94-2931|                Land|  6|
    |  Herrera|   Samantha|443-69-1547|Senior tax profes...| 34|
    |     Dean|Christopher|411-61-6892|Radio broadcast a...|  3|
    |   Nelson|     Pamela|407-20-2588|Insurance account...| 15|
    |    Ortiz|     Thomas|471-83-1168|           Osteopath| 36|
    |  Sanford|      Paige|518-17-7246|Journalist, broad...| 23|
    |    Hobbs|       Cody|568-89-3594|   Librarian, public| 29|
    |  Frazier|      Cathy|175-46-6152|Local government ...| 13|
    |    Perez|     Ashley|507-10-0419| Call centre manager| 26|
    +---------+-----------+-----------+--------------------+---+
    only showing top 20 rows

####
More
####
.. code-block:: python

    >>> from pyspark.sql.types import BooleanType
    >>> subDF = dataDF.select('last_name', 'first_name', 'ssn', 'occupation', (dataDF.age - 1).alias('age'))
    >>> filteredDF = subDF.filter(subDF.age < 10)
    >>> #filteredDF.show(truncate=False) # <- use display
    >>> print 'subDF.count() = ', subDF.count()
    subDF.count() =  1000
    >>> print 'filteredDF.count() = ', filteredDF.count()
    filteredDF.count() =  194
    >>> less_ten = udf(lambda s: s < 10, BooleanType())
    >>> lambdaDF = subDF.filter(less_ten(subDF.age))
    >>> lambdaDF.show(n=5,truncate=False)
    +---------+-----------+-----------+--------------------------+---+
    |last_name|first_name |ssn        |occupation                |age|
    +---------+-----------+-----------+--------------------------+---+
    |Blanchard|Teresa     |541-85-8814|Designer, fashion/clothing|6  |
    |Lee      |Jeffrey    |081-27-8487|Print production planner  |3  |
    |Henry    |James      |810-74-4478|Animal technologist       |5  |
    |Callahan |Cindy      |587-94-2931|Land                      |5  |
    |Dean     |Christopher|411-61-6892|Radio broadcast assistant |2  |
    +---------+-----------+-----------+--------------------------+---+
    only showing top 5 rows

    >>> lambdaDF.count()
    Out[132]: 194