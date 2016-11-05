.. _cs105_lab1b:

cs105_lab1b - Building a word count application
"""""""""""""""""""""""""""""""""""""""""""""""
https://raw.githubusercontent.com/spark-mooc/mooc-setup/master/cs105_lab1b_word_count.py

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:

.. rubric:: During this lab we will cover:

#. Creating a base DataFrame and performing operations
#. Counting with Spark SQL and DataFrames
#. Finding unique words and a mean value
#. Apply word count to a file

#######################################
Create a base DF and perform operations
#######################################

****************
Create a base DF
****************
.. code-block:: python

    >>> wordsDF = sqlContext.createDataFrame([('cat',), ('elephant',), ('rat',),
    >>>                                       ('rat',), ('cat', )], ['word'])
    >>> wordsDF.show()
    (2) Spark Jobs
    +--------+
    |    word|
    +--------+
    |     cat|
    |elephant|
    |     rat|
    |     rat|
    |     cat|
    +--------+

    >>> print type(wordsDF)
    <class 'pyspark.sql.dataframe.DataFrame'>

    >>> wordsDF.printSchema()
    root
     |-- word: string (nullable = true)

******************************
Use DF functions to add an 's'
******************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#use-df-functions-to-add-an-s>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql.functions import lit, concat
    >>> 
    >>> pluralDF = wordsDF.<FILL IN>
    >>> pluralDF.show()
    (2) Spark Jobs
    +---------+
    |     word|
    +---------+
    |     cats|
    |elephants|
    |     rats|
    |     rats|
    |     cats|
    +---------+

*******************
Length of each word
*******************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#length-of-each-word>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql.functions import length
    >>> pluralLengthsDF = pluralDF.<FILL IN>
    >>> pluralLengthsDF.show()
    (2) Spark Jobs
    +--------------+
    |length_of_word|
    +--------------+
    |             4|
    |             9|
    |             4|
    |             4|
    |             4|
    +--------------+


######################################
Counting with Spark SQL and DataFrames
######################################
***********************
Using groupBy and count
***********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#using-groupby-and-count>`__)

.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    >>> wordCountsDF = (wordsDF
    >>>                 <FILL IN>)
    >>> wordCountsDF.show()
    (2) Spark Jobs
    +--------+-----+
    |    word|count|
    +--------+-----+
    |     cat|    2|
    |     rat|    2|
    |elephant|    1|
    +--------+-----+

#####################################
Finding unique words and a mean value
#####################################
************
Unique words
************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#unique-words>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> uniqueWordsCount = <FILL IN>
    >>> print uniqueWordsCount
    (1) Spark Jobs
    3

********************************
Means of groups using DataFrames
********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#means-of-groups-using-dataframes>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> averageCount = (wordCountsDF
    >>>                 <FILL IN>)
    >>>                     
    >>> print averageCount
    (1) Spark Jobs
    1.66666666667

##########################
Apply word count to a file
##########################

**********************
The wordCount function
**********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#the-wordcount-function>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def wordCount(wordListDF):
    >>>     """Creates a DataFrame with word counts.
    >>> 
    >>>     Args:
    >>>         wordListDF (DataFrame of str): A DataFrame consisting of one string column called 'word'.
    >>> 
    >>>     Returns:
    >>>         DataFrame of (str, int): A DataFrame containing 'word' and 'count' columns.
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> wordCount(wordsDF).show()
    (2) Spark Jobs
    +--------+-----+
    |    word|count|
    +--------+-----+
    |     cat|    2|
    |     rat|    2|
    |elephant|    1|
    +--------+-----+

******************************
Capitalization and punctuation
******************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#capitalization-and-punctuation>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql.functions import regexp_replace, trim, col, lower
    >>> def removePunctuation(column):
    >>>     """Removes punctuation, changes to lower case, and strips leading and trailing spaces.
    >>> 
    >>>     Note:
    >>>         Only spaces, letters, and numbers should be retained.  Other characters should should be
    >>>         eliminated (e.g. it's becomes its).  Leading and trailing spaces should be removed after
    >>>         punctuation is removed.
    >>> 
    >>>     Args:
    >>>         column (Column): A Column containing a sentence.
    >>> 
    >>>     Returns:
    >>>         Column: A Column named 'sentence' with clean-up operations applied.
    >>>     """
    >>>     return <FILL IN>

    >>> sentenceDF = sqlContext.createDataFrame([('Hi, you!',),
    >>>                                          (' No under_score!',),
    >>>                                          (' *      Remove punctuation then spaces  * ',)], ['sentence'])
    >>> sentenceDF.show(truncate=False)
    (4) Spark Jobs
    +------------------------------------------+
    |sentence                                  |
    +------------------------------------------+
    |Hi, you!                                  |
    | No under_score!                          |
    | *      Remove punctuation then spaces  * |
    +------------------------------------------+

    >>> (sentenceDF
    >>>  .select(removePunctuation(col('sentence')))
    >>>  .show(truncate=False))
    +------------------------------+
    |sentence                      |
    +------------------------------+
    |hi you                        |
    |no underscore                 |
    |remove punctuation then spaces|
    +------------------------------+

****************
Load a text file
****************
.. code-block:: python

    >>> fileName = "dbfs:/databricks-datasets/cs100/lab1/data-001/shakespeare.txt"
    ​
    >>> shakespeareDF = sqlContext.read.text(fileName).select(removePunctuation(col('value')))
    >>> shakespeareDF.show(15, truncate=False)
    ​
    (1) Spark Jobs
    +-------------------------------------------------+
    |sentence                                         |
    +-------------------------------------------------+
    |1609                                             |
    |                                                 |
    |the sonnets                                      |
    |                                                 |
    |by william shakespeare                           |
    |                                                 |
    |                                                 |
    |                                                 |
    |1                                                |
    |from fairest creatures we desire increase        |
    |that thereby beautys rose might never die        |
    |but as the riper should by time decease          |
    |his tender heir might bear his memory            |
    |but thou contracted to thine own bright eyes     |
    |feedst thy lights flame with selfsubstantial fuel|
    +-------------------------------------------------+
    only showing top 15 rows


****************
Words from lines
****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#words-from-lines>`__)
    
.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql.functions import split, explode
    >>> shakeWordsDF = (shakespeareDF
    >>>                 <FILL IN>)
    >>> 
    >>> shakeWordsDF.show()
    +-----------+
    |       word|
    +-----------+
    |       1609|
    |        the|
    |    sonnets|
    |         by|
    |    william|
    |shakespeare|
    |          1|
    |       from|
    |    fairest|
    |  creatures|
    |         we|
    |     desire|
    |   increase|
    |       that|
    |    thereby|
    |    beautys|
    |       rose|
    |      might|
    |      never|
    |        die|
    +-----------+
    only showing top 20 rows

    >>> shakeWordsDFCount = shakeWordsDF.count()
    >>> print shakeWordsDFCount
    927631

***************
Count the words
***************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs105_lab1b_solutions.rst#count-the-words>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql.functions import desc
    >>> topWordsAndCountsDF = <FILL IN>
    >>> topWordsAndCountsDF.show()
    +----+-----+
    |word|count|
    +----+-----+
    | the|27361|
    | and|26028|
    |   i|20681|
    |  to|19150|
    |  of|17463|
    |   a|14593|
    | you|13615|
    |  my|12481|
    |  in|10956|
    |that|10890|
    |  is| 9134|
    | not| 8497|
    |with| 7771|
    |  me| 7769|
    |  it| 7678|
    | for| 7558|
    |  be| 6857|
    | his| 6857|
    |your| 6655|
    |this| 6602|
    +----+-----+
    only showing top 20 rows


##################################
Random stuffs I played around with
##################################
.. code-block:: python

    >>> # play with length
    >>> # https://wtak23.github.io/pyspark/generated/pyspark.sql.functions.length.htm
    >>> from pyspark.sql.functions import length
    >>> a=sqlContext.createDataFrame([('ABC',)], ['a']).select(length('a').alias('length')).collect()
    >>> print a
    >>> print a[0]['length']
    >>> import numpy as np
    >>> np.array(a)[0][0]
    (1) Spark Jobs
    [Row(length=3)]
    3
    Out[38]: 3

    >>> wordsDF.show()
    (2) Spark Jobs
    +--------+
    |    word|
    +--------+
    |     cat|
    |elephant|
    |     rat|
    |     rat|
    |     cat|
    +--------+

    >>> wordsDF.groupBy('word').count().show()
    (2) Spark Jobs
    +--------+-----+
    |    word|count|
    +--------+-----+
    |     cat|    2|
    |     rat|    2|
    |elephant|    1|
    +--------+-----+