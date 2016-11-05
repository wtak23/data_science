cs120 - Word Count Lab in RDD
"""""""""""""""""""""""""""""
https://github.com/spark-mooc/mooc-setup/raw/master/cs120_lab1b_word_count_rdd.dbc

.. note:: This is different from :ref:`cs105_lab1b` as it focuses on using pyspark RDD (Resilident distributed dataset)  rather than pyspark.sql DataFrames. So more usage of functional programming constructs.

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:

#########################################
Part 1: Creating a base RDD and pair RDDs
#########################################

**********************
1b) Pluralize and test
**********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst>`__)    


.. code-block:: python

    def makePlural(word):
        """Adds an 's' to `word`.

        Note:
            This is a simple function that only adds an 's'.  No attempt is made to follow proper
            pluralization rules.

        Args:
            word (str): A string.

        Returns:
            str: A string with 's' added to it.
        """
        return <FILL IN>

    print makePlural('cat')
    #cats

************************************
1c) Apply makePlural to the base RDD
************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#c-apply-makeplural-to-the-base-rdd>`__)    

.. code-block:: python

    pluralRDD = wordsRDD.map(<FILL IN>)
    print pluralRDD.collect()
    #['cats', 'elephants', 'rats', 'rats', 'cats']

*********************************
1d) Pass a lambda function to map
*********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#d-pass-a-lambda-function-to-map>`__)    

.. code-block:: python

    pluralLambdaRDD = wordsRDD.map(lambda <FILL IN>)
    print pluralLambdaRDD.collect()
    #['cats', 'elephants', 'rats', 'rats', 'cats']

***********************
1e) Length of each word
***********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#e-length-of-each-word>`__)    

.. code-block:: python

    pluralLengths = (pluralRDD
                     <FILL IN>
                     .collect())
    print pluralLengths
    #[4, 9, 4, 4, 4]


*************
1f) Pair RDDs
*************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#f-pair-rdds>`__)    

.. code-block:: python

    wordPairs = wordsRDD.<FILL IN>
    print wordPairs.collect()
    #[('cat', 1), ('elephant', 1), ('rat', 1), ('rat', 1), ('cat', 1)]

###############################
Part 2: Counting with pair RDDs
###############################

*****************************
2a) ``groupByKey()`` approach
*****************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#a-groupbykey-approach>`__)    

.. code-block:: python

    # Note that groupByKey requires no parameters
    wordsGrouped = wordPairs.<FILL IN>
    for key, value in wordsGrouped.collect():
        print '{0}: {1}'.format(key, list(value))
    #rat: [1, 1]
    #elephant: [1]
    #cat: [1, 1]

*********************************************
2b) Use ``groupByKey()`` to obtain the counts
*********************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#b-use-groupbykey-to-obtain-the-counts>`__)    

.. code-block:: python

    wordCountsGrouped = wordsGrouped.<FILL IN>
    print wordCountsGrouped.collect()
    #[('rat', 2), ('elephant', 1), ('cat', 2)]



**********************************
2c) Counting using ``reduceByKey``
**********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#c-counting-using-reducebykey>`__)    


.. code-block:: python

    wordCounts = wordPairs.reduceByKey(<FILL IN>)
    print wordCounts.collect()
    #[('rat', 2), ('elephant', 1), ('cat', 2)]

****************
2d) All together
****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#d-all-together>`__)    

.. code-block:: python

    wordCountsCollected = (wordsRDD
                           <FILL IN>
                           .collect())
    print wordCountsCollected
    #[('rat', 2), ('elephant', 1), ('cat', 2)]

#############################################
Part 3: Finding unique words and a mean value
#############################################
****************
3a) Unique words
****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#a-unique-words>`__)    

.. code-block:: python

    uniqueWords = <FILL IN>
    print uniqueWords
    #3

*************************
3b) Mean using ``reduce``
*************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#b-mean-using-reduce>`__)    

.. code-block:: python

    from operator import add
    totalCount = (wordCounts
                  .map(<FILL IN>)
                  .reduce(<FILL IN>))
    average = totalCount / float(<FILL IN>)
    print totalCount
    #5
    print round(average, 2)
    #1.67


##################################
Part 4: Apply word count to a file
##################################

**************************
4a) ``wordCount`` function
**************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#a-wordcount-function>`__)    

.. code-block:: python

    def wordCount(wordListRDD):
        """Creates a pair RDD with word counts from an RDD of words.

        Args:
            wordListRDD (RDD of str): An RDD consisting of words.

        Returns:
            RDD of (str, int): An RDD consisting of (word, count) tuples.
        """
        <FILL IN>
    print wordCount(wordsRDD).collect()
    #[('rat', 2), ('elephant', 1), ('cat', 2)]

**********************************
4b) Capitalization and punctuation
**********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#b-capitalization-and-punctuation>`__)    

.. code-block:: python

    import re
    def removePunctuation(text):
        """Removes punctuation, changes to lower case, and strips leading and trailing spaces.

        Note:
            Only spaces, letters, and numbers should be retained.  Other characters should should be
            eliminated (e.g. it's becomes its).  Leading and trailing spaces should be removed after
            punctuation is removed.

        Args:
            text (str): A string.

        Returns:
            str: The cleaned up string.
        """
        <FILL IN>

    print removePunctuation('Hi, you!')
    #hi you
    print removePunctuation(' No under_score!')
    #no underscore
    print removePunctuation(' *      Remove punctuation then spaces  * ')
    #remove punctuation then spaces


********************
4c) Load a text file
********************
.. code-block:: python

    >>> import os.path
    >>> fileName = "dbfs:/" + os.path.join('databricks-datasets', 'cs100', 'lab1', 'data-001', 'shakespeare.txt')
    >>> shakespeareRDD = sc.textFile(fileName, 8).map(removePunctuation)
    >>> print '\n'.join(shakespeareRDD
    >>>                 .zipWithIndex()  # to (line, lineNum)
    >>>                 .map(lambda (l, num): '{0}: {1}'.format(num, l))  # to 'lineNum: line'
    >>>                 .take(15))
    0: 1609
    1: 
    2: the sonnets
    3: 
    4: by william shakespeare
    5: 
    6: 
    7: 
    8: 1
    9: from fairest creatures we desire increase
    10: that thereby beautys rose might never die
    11: but as the riper should by time decease
    12: his tender heir might bear his memory
    13: but thou contracted to thine own bright eyes
    14: feedst thy lights flame with selfsubstantial fuel

********************
4d) Words from lines
********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#d-words-from-lines>`__)   

.. code-block:: python

    shakespeareWordsRDD = shakespeareRDD.<FILL_IN>
    shakespeareWordCount = shakespeareWordsRDD.count()
    print shakespeareWordsRDD.top(5)
    #[u'zwaggerd', u'zounds', u'zounds', u'zounds', u'zounds']
    print shakespeareWordCount
    #927631

*************************
4e) Remove empty elements
*************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#e-remove-empty-elements>`__)   


.. code-block:: python

    shakeWordsRDD = shakespeareWordsRDD.<FILL_IN>
    shakeWordCount = shakeWordsRDD.count()
    print shakeWordCount
    #882996


*******************
4f) Count the words
*******************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab1b_solutions.rst#f-count-the-words>`__)   

.. code-block:: python

    >>> top15WordsAndCounts = <FILL IN>
    >>> print '\n'.join(map(lambda (w, c): '{0}: {1}'.format(w, c), top15WordsAndCounts))
    the: 27361
    and: 26028
    i: 20681
    to: 19150
    of: 17463
    a: 14593
    you: 13615
    my: 12481
    in: 10956
    that: 10890
    is: 9134
    not: 8497
    with: 7771
    me: 7769
    it: 7678