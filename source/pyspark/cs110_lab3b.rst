.. raw:: html

    <style> 
    .emph {color:red; font-weight: bold; background-color: yellow;} 
    </style>

.. role:: emph

.. _cs110_lab3b:

cs110 - Text Analysis and Entity Resolution with TF-IDF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
https://raw.githubusercontent.com/spark-mooc/mooc-setup/master/cs110_lab3b_text_analysis_and_entity_resolution.py

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:




#############
Preliminaries
#############
****************
Background on ER
****************
- **Entity Resolution (ER)**, or **Record linkage** (`wiki <https://en.wikipedia.org/wiki/Record_linkage>`__) describes the process of joining records from one data source with another that describe the same entity. 
- Other synonymous terms include:

  - **"entity disambiguation/linking"**
  - **"duplicate detection"**, 
  - **"deduplication"**, 
  - **"record matching"**, 
  - **"(reference) reconciliation"**, 
  - **"object identification"**, 
  - **"data/information integration"**, 
  - **"conflation"**.
- ER refers to the task of finding records in a dataset that refer to the same entity across different data sources (e.g., data files, books, websites, databases). 
- ER is necessary when joining datasets based on entities that may or may not share a **common identifier** (e.g., database key, URI, National identification number), as may be the case due to differences in record shape, storage location, and/or curator style or preference. 
- A dataset that has undergone ER may be referred to as being **cross-linked**.

**********
Data files
**********
https://github.com/spark-mooc/mooc-setup/tree/master/metric-learning/data/3-amazon-googleproducts

The directory contains the following files:

- **Google.csv**, the Google Products dataset, named as targets.csv in the repository
- **Amazon.csv**, the Amazon dataset, named as sources.csv in the repository
- **Google_small.csv**, 200 records sampled from the Google data, subset of targets.csv
- **Amazon_small.csv**, 200 records sampled from the Amazon data, subset of sources.csv
- **Amazon_Google_perfectMapping.csv**, the "gold standard" mapping, named as mapping.csv in the repository
- **stopwords.txt**, a list of common English words

The "gold standard" file contains all of the true mappings between entities in the two datasets. 

- Every row in the gold standard file has a pair of record IDs (one Google, one Amazon) that belong to two records that describe the same thing in the real world. 
- We will use the gold standard to evaluate our algorithms.



.. code-block:: python
    :linenos:

    import re
    DATAFILE_PATTERN = '^(.+),"(.+)",(.*),(.*),(.*)'

    def removeQuotes(s):
        """ Remove quotation marks from an input string
        Args:
            s (str): input string that might have the quote "" characters
        Returns:
            str: a string without the quote characters
        """
        return ''.join(i for i in s if i!='"')


    def parseDatafileLine(datafileLine):
        """ Parse a line of the data file using the specified regular expression pattern
        Args:
            datafileLine (str): input string that is a line from the data file
        Returns:
            str: a string parsed using the given regular expression and without the quote characters
        """
        match = re.search(DATAFILE_PATTERN, datafileLine)
        if match is None:
            print 'Invalid datafile line: %s' % datafileLine
            return (datafileLine, -1)
        elif match.group(1) == '"id"':
            print 'Header datafile line: %s' % datafileLine
            return (datafileLine, 0)
        else:
            product = '%s %s %s' % (match.group(2), match.group(3), match.group(4))
            return ((removeQuotes(match.group(1)), product), 1)

.. code-block:: python

    >>> for _i,file_info in enumerate(dbutils.fs.ls('/databricks-datasets/cs100/lab3/data-001')):
    >>>   print _i,file_info
    0 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/Amazon.csv', name=u'Amazon.csv', size=1853189L)
    1 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/Amazon_Google_perfectMapping.csv', name=u'Amazon_Google_perfectMapping.csv', size=102234L)
    2 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/Amazon_small.csv', name=u'Amazon_small.csv', size=155487L)
    3 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/Google.csv', name=u'Google.csv', size=1070774L)
    4 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/Google_small.csv', name=u'Google_small.csv', size=64413L)
    5 FileInfo(path=u'dbfs:/databricks-datasets/cs100/lab3/data-001/stopwords.txt', name=u'stopwords.txt', size=622L)


>>> display(dbutils.fs.ls('/databricks-datasets/cs100/lab3/data-001'))

.. image:: /_static/img/cs110_lab3b_pic1.png
    :align: center
    :scale: 100 %
***************
Load data files
***************
First define our functions:

.. code-block:: python

    def parseData(filename):
        """ Parse a data file
        Args:
            filename (str): input file name of the data file
        Returns:
            RDD: a RDD of parsed lines
        """
        return (sc
                .textFile(filename, 4, 0)
                .map(parseDatafileLine))

    def loadData(path):
        """ Load a data file
        Args:
            path (str): input file name of the data file
        Returns:
            RDD: a RDD of parsed valid lines
        """
        filename = os.path.join(baseDir, inputPath, path)
        raw = parseData(filename).cache()
        failed = (raw
                  .filter(lambda s: s[1] == -1)
                  .map(lambda s: s[0]))
        for line in failed.take(10):
            print '%s - Invalid datafile line: %s' % (path, line)
        valid = (raw
                 .filter(lambda s: s[1] == 1)
                 .map(lambda s: s[0])
                 .cache())
        print '%s - Read %d lines, successfully parsed %d lines, failed to parse %d lines' % \
              (path,raw.count(),valid.count(),failed.count())
        assert failed.count() == 0
        assert raw.count() == (valid.count() + 1)
        return valid

Now load data

.. code-block:: python

    >>> data_dir = os.path.join('databricks-datasets', 'cs100', 'lab3', 'data-001')
    >>> GOOGLE_PATH = 'Google.csv'
    >>> GOOGLE_SMALL_PATH = 'Google_small.csv'
    >>> AMAZON_PATH = 'Amazon.csv'
    >>> AMAZON_SMALL_PATH = 'Amazon_small.csv'
    >>> GOLD_STANDARD_PATH = 'Amazon_Google_perfectMapping.csv'
    >>> STOPWORDS_PATH = 'stopwords.txt'
    >>> 
    >>> googleSmall = loadData(GOOGLE_SMALL_PATH)
    >>> google = loadData(GOOGLE_PATH)
    >>> amazonSmall = loadData(AMAZON_SMALL_PATH)
    >>> amazon = loadData(AMAZON_PATH)
    (32) Spark Jobs
    Google_small.csv - Read 201 lines, successfully parsed 200 lines, failed to parse 0 lines
    Google.csv - Read 3227 lines, successfully parsed 3226 lines, failed to parse 0 lines
    Amazon_small.csv - Read 201 lines, successfully parsed 200 lines, failed to parse 0 lines
    Amazon.csv - Read 1364 lines, successfully parsed 1363 lines, failed to parse 0 lines
    Command took 4.14s 

************************
Examine the lines loaded
************************
We read in each of the files and create an RDD consisting of lines. 

- For each of the data files ("Google.csv", "Amazon.csv", and the samples), we want to **parse the IDs out of each record**. 
- The IDs are the first column of the file (they are URLs for Google, and alphanumeric strings for Amazon). 
- Omitting the headers, we load these data files into **pair RDDs** where:

  - ``key`` = the **mapping ID**
  - ``value`` = a string consisting of the name/title, description, and manufacturer from the record.

The file format of an Amazon line is:
``"id","title","description","manufacturer","price"``

The file format of a Google line is:
``"id","name","description","manufacturer","price"``



.. code-block:: python

    >>> for line in googleSmall.take(3):
    >>>     print 'google: %s: %s' % (line[0], line[1])
    google: http://www.google.com/base/feeds/snippets/11448761432933644608: spanish vocabulary builder "expand your vocabulary! contains fun lessons that both teach and entertain you'll quickly find yourself mastering new terms. includes games and more!" 
    google: http://www.google.com/base/feeds/snippets/8175198959985911471: topics presents: museums of world "5 cd-rom set. step behind the velvet rope to examine some of the most treasured collections of antiquities art and inventions. includes the following the louvre - virtual visit 25 rooms in full screen interactive video detailed map of the louvre ..." 
    google: http://www.google.com/base/feeds/snippets/18445827127704822533: sierrahome hse hallmark card studio special edition win 98 me 2000 xp "hallmark card studio special edition (win 98 me 2000 xp)" "sierrahome"

.. code-block:: python

    >>> for line in amazonSmall.take(3):
    >>>     print 'amazon: %s: %s' % (line[0], line[1])
    amazon: b000jz4hqo: clickart 950 000 - premier image pack (dvd-rom)  "broderbund"
    amazon: b0006zf55o: ca international - arcserve lap/desktop oem 30pk "oem arcserve backup v11.1 win 30u for laptops and desktops" "computer associates"
    amazon: b00004tkvy: noah's ark activity center (jewel case ages 3-8)  "victory multimedia"

############################################
Part1: ER as Text Similarity - Bags of Words
############################################
A simple approach to ER is to **treat all records as strings** and compute their similarity with a **string distance function**. 

- In this part, we will build some components for performing **bag-of-words text-analysis**, and then use them to compute **record similarity**. 
- Bag-of-words is a conceptually simple yet powerful approach to text analysis. 
- The idea is to treat strings, a.k.a. **documents**, as *unordered collections of words*, or **tokens**, i.e., as bags of words.

.. admonition:: Note on terminology

    - a "**token**" is the result of parsing the document down to the elements we consider "**atomic**" for the task at hand. 
    
      - Tokens can be things like words, numbers, acronyms, or other exotica like word-roots or fixed-length character strings. 
    - Bag of words techniques all apply to any sort of token, so when we say "**bag-of-words**" we really mean "**bag-of-tokens**," strictly speaking. 
    - **Tokens** become the atomic unit of text comparison. 

      - **To compare two documents**, we count how many tokens they share in common. 
      - **To search for documents** with keyword queries (what Google does), then we *turn the keywords into tokens* and find documents that contain them. 
    - The power of this approach is that it **makes string comparisons insensitive to small differences** that probably do not affect meaning much, for example, punctuation and word order.
   
*********************
1a) Tokenize a String
*********************
- Note that ``\W`` includes the "``_``" character.
- You should use ``re.split()`` to perform the string split. 
- Also:
  
  - make sure you remove any empty tokens
  - make sure you convert the string to lower case.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-1-a-tokenize-a-string>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> quickbrownfox = 'A quick brown fox jumps over the lazy dog.'
    >>> split_regex = r'\W+'
    >>> 
    >>> def simpleTokenize(string):
    >>>     """ A simple implementation of input string tokenization
    >>>     Args:
    >>>         string (str): input string
    >>>     Returns:
    >>>         list: a list of tokens
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> print simpleTokenize(quickbrownfox) # Should give ['a', 'quick', 'brown', ... ]
    ['a', 'quick', 'brown', 'fox', 'jumps', 'over', 'the', 'lazy', 'dog']

    >>> # TEST Tokenize a String (1a)
    >>> Test.assertEquals(simpleTokenize(quickbrownfox),
    >>>                   ['a','quick','brown','fox','jumps','over','the','lazy','dog'],
    >>>                   'simpleTokenize should handle sample text')
    >>> Test.assertEquals(simpleTokenize(' '), [], 'simpleTokenize should handle empty string')
    >>> Test.assertEquals(simpleTokenize('!!!!123A/456_B/789C.123A'), ['123a','456_b','789c','123a'],
    >>>                   'simpleTokenize should handle punctuations and lowercase result')
    >>> Test.assertEquals(simpleTokenize('fox fox'), ['fox', 'fox'],
    >>>                   'simpleTokenize should not remove duplicates')
    1 test passed.
    1 test passed.
    1 test passed.
    1 test passed.

**********************
1b) removing stopwords
**********************
**Stopwords** (`wiki <https://en.wikipedia.org/wiki/Stop_words>`__) --- words that do not contribute much to the content or meaning of a document (e.g., "the", "a", "is", "to", etc.). 

Using the included file "``stopwords.txt``", implement ``tokenize``, an improved tokenizer that does not emit stopwords.

.. admonition:: hints
   
    .. rubric:: hint1

    Test membership as follows

    >>> my_set = set(['a', 'b', 'c'])
    >>> 'a' in my_set     # returns True
    >>> 'd' in my_set     # returns False
    >>> 'a' not in my_set # returns False

    .. rubric:: hint2

    - Within ``tokenize()``: 

      - first tokenize the string using ``simpleTokenize()``
      - Then, remove stopwords. 
    - To remove stop words, consider using a loop, a Python list comprehension, or the built-in Python ``filter()`` function


>>> stopfile = os.path.join(data_dir, STOPWORDS_PATH)
>>> stopwords = set(sc.textFile(stopfile).collect())
>>> print 'These are the stopwords: %s' % stopwords
These are the stopwords: set([u'all', u'just', u'being', u'over', u'both', u'through', u'yourselves', u'its', u'before', u'with', u'had', u'should', u'to', u'only', u'under', u'ours', u'has', u'do', u'them', u'his', u'very', u'they', u'not', u'during', u'now', u'him', u'nor', u'did', u'these', u't', u'each', u'where', u'because', u'doing', u'theirs', u'some', u'are', u'our', u'ourselves', u'out', u'what', u'for', u'below', u'does', u'above', u'between', u'she', u'be', u'we', u'after', u'here', u'hers', u'by', u'on', u'about', u'of', u'against', u's', u'or', u'own', u'into', u'yourself', u'down', u'your', u'from', u'her', u'whom', u'there', u'been', u'few', u'too', u'themselves', u'was', u'until', u'more', u'himself', u'that', u'but', u'off', u'herself', u'than', u'those', u'he', u'me', u'myself', u'this', u'up', u'will', u'while', u'can', u'were', u'my', u'and', u'then', u'is', u'in', u'am', u'it', u'an', u'as', u'itself', u'at', u'have', u'further', u'their', u'if', u'again', u'no', u'when', u'same', u'any', u'how', u'other', u'which', u'you', u'who', u'most', u'such', u'why', u'a', u'don', u'i', u'having', u'so', u'the', u'yours', u'once'])

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-1b-removing-stopwords>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def tokenize(string):
    >>>     """ An implementation of input string tokenization that excludes stopwords
    >>>     Args:
    >>>         string (str): input string
    >>>     Returns:
    >>>         list: a list of tokens without stopwords
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> print tokenize(quickbrownfox) # Should give ['quick', 'brown', ... ]
    ['quick', 'brown', 'fox', 'jumps', 'lazy', 'dog']

    >>> # TEST Removing stopwords (1b)
    >>> Test.assertEquals(tokenize("Why a the?"), [], 'tokenize should remove all stopwords')
    >>> Test.assertEquals(tokenize("Being at the_?"), ['the_'], 'tokenize should handle non-stopwords')
    >>> Test.assertEquals(tokenize(quickbrownfox), ['quick','brown','fox','jumps','lazy','dog'],
    >>>                     'tokenize should handle sample text')


*********************************
1c) Tokenizing the small datasets
*********************************
Now let's tokenize the two small datasets. 

- For each ID in a dataset, tokenize the values, and then count the total number of tokens.
- The resulting RDDs, ``amazonRecToToken`` and ``googleRecToToken`` should be collections of ``(recordID, [token_list])`` pairs. 
- For instance, here's a record that should be found in the resulting amazonRecToToken RDD:
  
  - ``('b00004tkvy', ['noah', 'ark', 'activity', 'center', 'jewel', 'case', 'ages', '3', '8', 'victory', 'multimedia'])``
- How many tokens, total, are there in the two datasets?

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-1c-tokenizing-the-small-datasets>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> amazonRecToToken = amazonSmall.<FILL IN>
    >>> googleRecToToken = googleSmall.<FILL IN>
    >>> 
    >>> def countTokens(vendorRDD):
    >>>     """ Count and return the number of tokens
    >>>     Args:
    >>>         vendorRDD (RDD of (recordId, tokenizedValue)): Pair tuple of record ID to tokenized output
    >>>     Returns:
    >>>         count: count of all tokens
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> totalTokens = countTokens(amazonRecToToken) + countTokens(googleRecToToken)
    >>> print 'There are %s tokens in the combined datasets' % totalTokens
    There are 22520 tokens in the combined datasets

**************************************
1d) Amazon record with the most tokens
**************************************
- Which Amazon record has the biggest number of tokens? 
- In other words, you want to sort the records and get the one with the largest count of tokens.

Hint: The RDD ``takeOrdered()`` (`link <https://wtak23.github.io/pyspark/generated/generated/pyspark.RDD.takeOrdered.html>`__) transformation may be of some help here.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-1d-amazon-record-with-the-most-tokens>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def findBiggestRecord(vendorRDD):
    >>>     """ Find and return the record with the largest number of tokens
    >>>     Args:
    >>>         vendorRDD (RDD of (recordId, tokens)): input Pair Tuple of record ID and tokens
    >>>     Returns:
    >>>         list: a list of 1 Pair Tuple of record ID and tokens
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> biggestRecordAmazon = findBiggestRecord(amazonRecToToken)
    >>> print 'The Amazon record with ID "%s" has the most tokens (%s)' % (biggestRecordAmazon[0][0],
    >>>                                                                    len(biggestRecordAmazon[0][1]))

#################################################################
Part2: ER as Text Similarity - Weighted Bag-of-Words using TF-IDF
#################################################################
- Bag-of-words comparisons are not very good when all tokens are treated the same: some tokens are more important than others. 
- Weights give us a way to specify which tokens to favor. 
- A good heuristic for assigning weights is called *Term-Frequency/Inverse-Document-Frequency* (`TF-IDF <https://en.wikipedia.org/wiki/Tf%E2%80%93idf>`__).
- TF = freqeuncy of a token in a document
  
  - if a document d contains 100 tokens and token t appears in d 5 times, then the **TF weight of t in d** is :math:`\text{TF}(t,d) = 5/100 = 1/20`
  - intuitively, frequently used word is more important to the meaning of the document.
  - it is a **local** weight (depends on both the token and document)
- **IDF** rewards tokens that are rare **overall** in a document.
  
  - the intuition is that it is more significant if two documents share a rare word than a common one.
  - it is a **global** weight (only depends on the token *t*)
  - Let *U* = set of documents and *N* = number of documents in *U*
  - Let :math:`n(t)` = the number of documents in *U* that contain token *t*
  - Then: :math:`\text{IDF}(t) = N/n(t)` (note: :math:`n(t)/N` is the frequency of *t* in *U*)

.. math::

    \text{TF-IDF}(t,d) = \text{TF}(t,d)\cdot\text{IDF}(t)

***************************
2a) Implement a TF function
***************************
Implement ``tf(tokens)`` (**input**: a list of tokens, **output** dictionary mapping tokens to TF weights)

The steps your function should perform are:

- Create an empty Python dictionary
- For each ``tokens`` in the input list, count 1 for each occurrence and add the token to the dictionary
- For each ``tokens`` in the dictionary, divide the token's count by the total number of tokens in the input ``tokens`` list 

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2a-implement-a-tf-function>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def tf(tokens):
    >>>     """ Compute TF
    >>>     Args:
    >>>         tokens (list of str): input list of tokens from tokenize
    >>>     Returns:
    >>>         dictionary: a dictionary of tokens to its TF values
    >>>     """
    >>>     <FILL IN>
    >>>     return <FILL IN>
    >>> 
    >>> print tf(tokenize(quickbrownfox)) # Should give { 'quick': 0.1666 ... }
    {'brown': 0.16666666666666666, 'lazy': 0.16666666666666666, 'jumps': 0.16666666666666666, 'fox': 0.16666666666666666, 'dog': 0.16666666666666666, 'quick': 0.16666666666666666}


*******************
2b) Create a corpus
*******************
- Create a **pair RDD** called ``corpusRDD``, consisting of a combination of the two small datasets, ``amazonRecToToken`` and ``googleRecToToken``. 
- Each element of the ``corpusRDD`` should be a **pair** consisting of a ``key`` from one of the small datasets (**ID or URL**) and the ``value`` is the associated value for that key from the small datasets.

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2b-create-a-corpus>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> corpusRDD = <FILL IN>
    >>> 
    >>> for i in corpusRDD.take(3):
    >>>   print(i)
    (2) Spark Jobs
    ('b000jz4hqo', ['clickart', '950', '000', 'premier', 'image', 'pack', 'dvd', 'rom', 'broderbund'])
    ('b0006zf55o', ['ca', 'international', 'arcserve', 'lap', 'desktop', 'oem', '30pk', 'oem', 'arcserve', 'backup', 'v11', '1', 'win', '30u', 'laptops', 'desktops', 'computer', 'associates'])
    ('b00004tkvy', ['noah', 'ark', 'activity', 'center', 'jewel', 'case', 'ages', '3', '8', 'victory', 'multimedia'])

******************************
2c) Implement an IDFs function
******************************
- Implement ``idfs`` that assigns an IDF weight to every unique token in an RDD called ``corpus``. 
- The function should return a pair RDD where the ``key`` is the **unique token** and ``value`` is the **IDF weight** for the token.
- The steps your function should perform are:

  - Calculate N (total number of documents in U). Think about how you can calculate N from the input RDD.
  - Create an ``RDD`` (not a pair RDD) containing the **unique tokens** from each document in the input corpus. For each document, you should only include a token once, *even if it appears multiple times in that document*.
  - For each of the unique tokens, **count how many documents it appears in** and then compute the *IDF* for that token: :math:`N/n(t)`
- Use your idfs to compute the IDF weights for all tokens in ``corpusRDD`` (the combined small datasets). 
- How many unique tokens are there?

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2c-implement-an-idfs-function>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def idfs(corpus):
    >>>     """ Compute IDF
    >>>     Args:
    >>>         corpus (RDD): input corpus
    >>>     Returns:
    >>>         RDD: a RDD of (token, IDF value)
    >>>     """
    >>>     uniqueTokens = corpus.<FILL IN>
    >>>     tokenCountPairTuple = uniqueTokens.<FILL IN>
    >>>     tokenSumPairTuple = tokenCountPairTuple.<FILL IN>
    >>>     N = <FILL IN>
    >>>     return (tokenSumPairTuple.<FILL IN>)
    >>> 
    >>> idfsSmall = idfs(amazonRecToToken.union(googleRecToToken))
    >>> uniqueTokenCount = idfsSmall.count()
    >>> 
    >>> print 'There are %s unique tokens in the small datasets.' % uniqueTokenCount
    There are 4772 unique tokens in the small datasets.

********************************
2d) Tokens with the smallest IDF
********************************

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2d-tokens-with-the-smallest-idf>`__)  

.. code-block:: python

    >>> smallIDFTokens = <FILL_IN>
    >>> print smallIDFTokens
    [('software', 4.25531914893617), ('new', 6.896551724137931), ('features', 6.896551724137931), ('use', 7.017543859649122), ('complete', 7.2727272727272725), ('easy', 7.6923076923076925), ('create', 8.333333333333334), ('system', 8.333333333333334), ('cd', 8.333333333333334), ('1', 8.51063829787234), ('windows', 8.51063829787234)]

*****************
2e) IDF Histogram
*****************
Plot a histogram of IDF values. Be sure to use appropriate scaling and bucketing for the data.

First plot the histogram using matplotlib.

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2e-idf-histogram>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with the appropriate code
    >>> import matplotlib.pyplot as plt
    >>> 
    >>> small_idf_values = <FILL_IN>
    >>> fig = <FILL_IN>
    >>> plt.<FILL_IN>
    >>> display(fig)

.. image:: /_static/img/lab3b_2e_hist1.png
    :align: center
    :scale: 100 %

Next, plot the histogram using the Databricks`` display()`` function. After the cell runs, click on Plot Options and select Histogram.

.. code-block:: python

    # TODO: Replace <FILL_IN> with the appropriate code
    from pyspark.sql import Row

    # Create a DataFrame and visualize using display()
    idfsToCountRow = idfsSmall.<FILL_IN>
    idfsToCountDF = sqlContext.createDataFrame(idfsToCountRow)
    display(idfsToCountDF)

.. image:: /_static/img/lab3b_2e_hist2.png
    :align: center
    :scale: 100 %

*******************************
2f) Implement a TF-IDF function
*******************************
Use your ``tf`` function to implement a ``tfidf(tokens, idfs)`` function

- **Input**: list of tokens from a document, ``dict`` of IDF weights and
- **Output**: dict mapping individual tokens to total TF-IDF weights

The steps your function should perform are:

- Calculate the token frequencies (TF) for ``tokens``
- Create a ``dict`` where each token maps to the token's frequency times the token's IDF weight

- Use your ``tfidf`` function to compute the weights of Amazon product record 'b000hkgj8k'. 
- To do this, we need to extract the record for the token from the tokenized small Amazon dataset and we need to convert the IDFs for the small dataset into a dict. 

  - We can do the **first part**, by using a ``filter()`` transformation to extract the matching record and a ``collect()`` action to return the value to the driver.
  - For the **second part**, we use the ``collectAsMap()`` action to return the IDFs to the driver as a dict.


- https://wtak23.github.io/pyspark/generated/generated/pyspark.RDD.collectAsMap.html

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-2f-implement-a-tf-idf-function>`__)   

.. code-block:: python

    >>> def tfidf(tokens, idfs):
    >>>     """ Compute TF-IDF
    >>>     Args:
    >>>         tokens (list of str): input list of tokens from tokenize
    >>>         idfs (dictionary): record to IDF value
    >>>     Returns:
    >>>         dictionary: a dictionary of records to TF-IDF values
    >>>     """
    >>>     tfs = <FILL IN>
    >>>     tfIdfDict = <FILL IN>
    >>>     return tfIdfDict
    >>> 
    >>> recb000hkgj8k = amazonRecToToken.filter(lambda x: x[0] == 'b000hkgj8k').collect()[0][1]
    >>> idfsSmallWeights = idfsSmall.collectAsMap()
    >>> rec_b000hkgj8k_weights = tfidf(recb000hkgj8k, idfsSmallWeights)
    >>> 
    >>> recb000jz4hqo = amazonRecToToken.filter(lambda x: x[0] == 'b000jz4hqo').collect()[0][1]
    >>> rec_b000jz4hqo_weights = tfidf(recb000jz4hqo, idfsSmallWeights)
    >>> 
    >>> print 'Amazon record "b000hkgj8k" has tokens and weights:\n%s' % rec_b000hkgj8k_weights
    >>> print 'Amazon record "b000jz4hqo" has tokens and weights: \n%s' % rec_b000jz4hqo_weights
    (3) Spark Jobs
    Amazon record "b000hkgj8k" has tokens and weights:
    {'autocad': 33.33333333333333, 'autodesk': 8.333333333333332, 'courseware': 66.66666666666666, 'psg': 33.33333333333333, '2007': 3.5087719298245617, 'customizing': 16.666666666666664, 'interface': 3.0303030303030303}
    Amazon record "b000jz4hqo" has tokens and weights: 
    {'rom': 1.8518518518518519, 'clickart': 22.22222222222222, '950': 44.44444444444444, 'image': 4.040404040404041, 'premier': 11.11111111111111, '000': 4.444444444444445, 'dvd': 1.7777777777777777, 'broderbund': 22.22222222222222, 'pack': 3.4188034188034186}

###################################################
Part 3: ER as Text Similarity --- Cosine Similarity
###################################################
- Now we are ready to do **text comparisons** in a formal way. 
- The **metric of string distance** we will use is called cosine similarity (`wiki <https://en.wikipedia.org/wiki/Cosine_similarity>`__). 

  - We will treat each document as a vector in some high dimensional space. 
  - Then, to compare two documents we compute the cosine of the angle between their two document vectors.
- The first question to answer is *how do we represent documents as vectors*? 

  - The answer is familiar: **bag-of-words**! 
- We **treat each unique token as a dimension**, and **treat token weights** as magnitudes in their respective token dimensions. 


.. admonition:: Example
   
   For example, suppose we use simple counts as weights, and we want to interpret the string "Hello, world! Goodbye, world!" as a vector. Then in the "hello" and "goodbye" dimensions the vector has value 1, in the "world" dimension it has value 2, and it is zero in all other dimensions. 


.. math::

    a \cdot b = \| a \| \| b \| \cos \theta

    \text{similarity} = \cos \theta = \frac{a \cdot b}{\|a\| \|b\|} = \frac{\sum a_i b_i}{\sqrt{\sum a_i^2} \sqrt{\sum b_i^2}}

***********************************************************
3a) Implement the components of a cosineSimilarity function
***********************************************************
Implement the **components** of a ``cosineSimilarity`` function. 

Use the ``tokenize`` and ``tfidf`` functions, and the IDF weights from Part 2 for extracting tokens and assigning them weights. 

(`solution <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#excercise-3a-implement-the-components-of-a-cosinesimilarity-function>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> import math
    >>> 
    >>> def dotprod(a, b):
    >>>     """ Compute dot product
    >>>     Args:
    >>>         a (dictionary): first dictionary of record to value
    >>>         b (dictionary): second dictionary of record to value
    >>>     Returns:
    >>>         dotProd: result of the dot product with the two input dictionaries
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> def norm(a):
    >>>     """ Compute square root of the dot product
    >>>     Args:
    >>>         a (dictionary): a dictionary of record to value
    >>>     Returns:
    >>>         norm (float): the square root of the dot product value
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> def cossim(a, b):
    >>>     """ Compute cosine similarity
    >>>     Args:
    >>>         a (dictionary): first dictionary of record to value
    >>>         b (dictionary): second dictionary of record to value
    >>>     Returns:
    >>>         cossim: dot product of two dictionaries divided by the norm of the first dictionary and
    >>>                 then by the norm of the second dictionary
    >>>     """
    >>>     return <FILL IN>
    >>> 
    >>> testVec1 = {'foo': 2, 'bar': 3, 'baz': 5 }
    >>> testVec2 = {'foo': 1, 'bar': 0, 'baz': 20 }
    >>> dp = dotprod(testVec1, testVec2)
    >>> nm = norm(testVec1)
    >>> cs = cossim(testVec1, testVec2)
    >>> print dp, nm, cs
    102 6.16441400297


*****************************************
3b) Implement a cosineSimilarity function
*****************************************
Implement a ``cosineSimilarity(string1, string2, idfsDictionary)`` function that takes two strings and a dictionary of IDF weights, and computes their cosine similarity in the context of some global IDF weights.

The steps you should perform are:

- Apply your ``tfidf`` function to the tokenized first and second strings, using the dictionary of IDF weights
- Compute and return your ``cossim`` function applied to the results of the two ``tfidf`` functions

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-3b-implement-a-cosinesimilarity-function>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def cosineSimilarity(string1, string2, idfsDictionary):
    >>>     """ Compute cosine similarity between two strings
    >>>     Args:
    >>>         string1 (str): first string
    >>>         string2 (str): second string
    >>>         idfsDictionary (dictionary): a dictionary of IDF values
    >>>     Returns:
    >>>         cossim: cosine similarity value
    >>>     """
    >>>     w1 = tfidf(<FILL IN>)
    >>>     w2 = tfidf(<FILL IN>)
    >>>     return cossim(w1, w2)
    >>> 
    >>> cossimAdobe = cosineSimilarity('Adobe Photoshop',
    >>>                                'Adobe Illustrator',
    >>>                                idfsSmallWeights)
    >>> 
    >>> print cossimAdobe
    0.0577243382163

*****************************
3c) Perform Entity Resolution
*****************************
Now we can finally do some **entity resolution**! 

- For **every record in the small Google dataset**, use your ``cosineSimilarity`` function to compute its similarity to **every record in the small Amazon dataset**. 
- Then, build a ``dictionary`` mapping (Google URL, Amazon ID) tuples to similarity scores between 0 and 1.  (``mydict[googleID,amazonID]->similarity score``)
- We'll do this computation **two different ways**:

  - first we'll do it **without a broadcast variable**, and 
  - then we'll **use a broadcast variable**
- The steps you should perform are:

  - Create an RDD that is a combination of the small Google and small Amazon datasets that has as elements all pairs of elements (a, b) where a is in self and b is in other. The result will be an RDD of the form::

         [ ((Google URL1, Google String1), (Amazon ID1, Amazon String1)), ((Google URL1, Google String1), (Amazon ID2, Amazon String2)), ((Google URL2, Google String2), (Amazon ID1, Amazon String1)), ... ]

  - Define a worker function that given an element from the combination RDD computes the cosineSimlarity for the two records in the element
  - Apply the worker function to every element in the RDD
- Now, compute the similarity between Amazon record b000o24l3q and Google record http://www.google.com/base/feeds/snippets/17242822440574356561.

.. admonition:: Hint
   
   Use Spark's cartesian method.

   https://wtak23.github.io/pyspark/generated/generated/pyspark.RDD.cartesian.html

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-3c-perform-entity-resolution>`__) 

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> crossSmall = (googleSmall
    >>>               .<FILL IN>
    >>>               .cache())
    >>> 
    >>> def computeSimilarity(record):
    >>>     """ Compute similarity on a combination record
    >>>     Args:
    >>>         record: a pair, (google record, amazon record)
    >>>     Returns:
    >>>         pair: a pair, (google URL, amazon ID, cosine similarity value)
    >>>     """
    >>>     googleRec = record[0]
    >>>     amazonRec = record[1]
    >>>     googleURL = <FILL IN>
    >>>     amazonID = <FILL IN>
    >>>     googleValue = <FILL IN>
    >>>     amazonValue = <FILL IN>
    >>>     cs = cosineSimilarity(<FILL IN>, idfsSmallWeights)
    >>>     return (googleURL, amazonID, cs)
    >>> 
    >>> similarities = (crossSmall
    >>>                 .<FILL IN>
    >>>                 .cache())
    >>> 
    >>> def similar(amazonID, googleURL):
    >>>     """ Return similarity value
    >>>     Args:
    >>>         amazonID: amazon ID
    >>>         googleURL: google URL
    >>>     Returns:
    >>>         similar: cosine similarity value
    >>>     """
    >>>     return (similarities
    >>>             .filter(lambda record: (record[0] == googleURL and record[1] == amazonID))
    >>>             .collect()[0][2])
    >>> 
    >>> similarityAmazonGoogle = similar('b000o24l3q', 'http://www.google.com/base/feeds/snippets/17242822440574356561')
    >>> print 'Requested similarity is %s.' % similarityAmazonGoogle
    Requested similarity is 0.000303171940451.

******************************************************
3d) Perform Entity Resolution with Broadcast Variables
******************************************************
- The solution in (3c) works well for **small datasets**, but it requires Spark to (automatically) send the ``idfsSmallWeights`` **variable to all the workers for each record**. 
- For example, if we only have one worker, and we have 1,000 records, we would be sending idfSmallWeights to the same worker 1,000 times. 
- Further, if we didn't ``cache()`` similarities, then it might have to be recreated if we run ``similar()`` multiple times. 
- While this approach works fine for small datasets, it becomes a bottleneck for larger datasets.

Instead, we can use a **broadcast variable** 

- we define the broadcast variable in the **driver** and then we can refer to it in each **worker**. 
- Spark saves the broadcast variable at each worker, so **it is only sent once**.
- The steps you should perform are:

  - Define a ``computeSimilarityBroadcast`` function that given an element from the combination RDD computes the cosine simlarity for the two records in the element. 
  - This will be the same as the worker function ``computeSimilarity`` in (3c) **except that it uses a broadcast variable**.
  - Apply the worker function to every element in the RDD
- Again, compute the similarity between Amazon record b000o24l3q and Google record ``http://www.google.com/base/feeds/snippets/17242822440574356561``.

http://spark.apache.org/docs/latest/programming-guide.html#broadcast-variables

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-3d-perform-entity-resolution-with-broadcast-variables>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def computeSimilarityBroadcast(record):
    >>>     """ Compute similarity on a combination record, using Broadcast variable
    >>>     Args:
    >>>         record: a pair, (google record, amazon record)
    >>>     Returns:
    >>>         pair: a pair, (google URL, amazon ID, cosine similarity value)
    >>>     """
    >>>     googleRec = record[0]
    >>>     amazonRec = record[1]
    >>>     googleURL = <FILL IN>
    >>>     amazonID = <FILL IN>
    >>>     googleValue = <FILL IN>
    >>>     amazonValue = <FILL IN>
    >>>     cs = cosineSimilarity(<FILL IN>, idfsSmallBroadcast.value)
    >>>     return (googleURL, amazonID, cs)
    >>> 
    >>> idfsSmallBroadcast = sc.broadcast(idfsSmallWeights)
    >>> similaritiesBroadcast = (crossSmall
    >>>                          .<FILL IN>
    >>>                          .cache())
    >>> 
    >>> def similarBroadcast(amazonID, googleURL):
    >>>     """ Return similarity value, computed using Broadcast variable
    >>>     Args:
    >>>         amazonID: amazon ID
    >>>         googleURL: google URL
    >>>     Returns:
    >>>         similar: cosine similarity value
    >>>     """
    >>>     return (similaritiesBroadcast
    >>>             .filter(lambda record: (record[0] == googleURL and record[1] == amazonID))
    >>>             .collect()[0][2])
    >>> 
    >>> similarityAmazonGoogleBroadcast = similarBroadcast('b000o24l3q', 'http://www.google.com/base/feeds/snippets/17242822440574356561')
    >>> print 'Requested similarity is %s.' % similarityAmazonGoogleBroadcast
    Requested similarity is 0.000303171940451.

**************************************
3e) Perform a Gold Standard evaluation
**************************************
- First, we'll load the "**gold standard**" data and use it to answer several questions. 
- We read and parse the Gold Standard data, where the format of each line is "Amazon Product ID","Google URL". 
- The resulting RDD has elements of the form: ``("AmazonID GoogleURL", 'gold')``
- Run the following cell to create the ``parse_goldfile_line()`` function that we'll use to parse the data.

.. code-block:: python

    >>> GOLDFILE_PATTERN = '^(.+),(.+)'
    >>> 
    >>> # Parse each line of a data file useing the specified regular expression pattern
    >>> def parse_goldfile_line(goldfile_line):
    >>>     """ Parse a line from the 'golden standard' data file
    >>>     Args:
    >>>         goldfile_line: a line of data
    >>>     Returns:
    >>>         pair: ((key, 'gold', 1 if successful or else 0))
    >>>     """
    >>>     match = re.search(GOLDFILE_PATTERN, goldfile_line)
    >>>     if match is None:
    >>>         print 'Invalid goldfile line: %s' % goldfile_line
    >>>         return (goldfile_line, -1)
    >>>     elif match.group(1) == '"idAmazon"':
    >>>         print 'Header datafile line: %s' % goldfile_line
    >>>         return (goldfile_line, 0)
    >>>     else:
    >>>         key = '%s %s' % (removeQuotes(match.group(1)), removeQuotes(match.group(2)))
    >>>         return ((key, 'gold'), 1)
    >>> 
    >>> goldfile = os.path.join(data_dir, GOLD_STANDARD_PATH)
    >>> gsRaw = (sc
    >>>          .textFile(goldfile)
    >>>          .map(parse_goldfile_line)
    >>>          .cache())
    >>> 
    >>> gsFailed = (gsRaw
    >>>             .filter(lambda s: s[1] == -1)
    >>>             .map(lambda s: s[0]))
    >>> for line in gsFailed.take(10):
    >>>     print 'Invalid goldfile line: %s' % line
    >>> 
    >>> goldStandard = (gsRaw
    >>>                 .filter(lambda s: s[1] == 1)
    >>>                 .map(lambda s: s[0])
    >>>                 .cache())
    >>> 
    >>> print 'Read %d lines, successfully parsed %d lines, failed to parse %d lines' % (gsRaw.count(),
    >>>                                                                                  goldStandard.count(),
    >>>                                                                                  gsFailed.count())
    >>> assert (gsFailed.count() == 0)
    >>> assert (gsRaw.count() == (goldStandard.count() + 1))
    Read 1301 lines, successfully parsed 1300 lines, failed to parse 0 lines

********************************************************************
Using the "gold standard" data we can answer the following questions
********************************************************************
#. How many true duplicate pairs are there in the small datasets?
#. What is the average similarity score for true duplicates?
#. What about for non-duplicates? The steps you should perform are:
#. Create a new ``sims`` RDD from the ``similaritiesBroadcast`` RDD, where each element consists of a pair of the form ``("AmazonID GoogleURL", cosineSimilarityScore)``. 
  
  - An example entry from sims is: ``('b000bi7uqs http://www.google.com/base/feeds/snippets/18403148885652932189', 0.40202896125621296)``
#. Combine the ``sims`` RDD with the goldStandard RDD by creating a new ``trueDupsRDD`` RDD that has just the cosine similarity scores for those "AmazonID GoogleURL" pairs that appear in both the ``sims`` RDD and goldStandard RDD. 

  - Hint: you can do this using the ``join()`` transformation.
#. Count the number of true duplicate pairs in the ``trueDupsRDD`` dataset
#. Compute the average similarity score for true duplicates in the ``trueDupsRDD`` datasets. Remember to use ``float`` for calculation
#. Create a new ``nonDupsRDD`` RDD that has just the cosine similarity scores for those "AmazonID GoogleURL" pairs from the ``similaritiesBroadcast`` RDD that do not appear in both the ``sims`` RDD and ``goldStandard`` RDD.
#. Compute the average similarity score for non-duplicates in the last datasets. Remember to use ``float`` for calculation

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#using-the-gold-standard-data-we-can-answer-the-following-questions>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> sims = similaritiesBroadcast.<FILL IN>
    >>> 
    >>> trueDupsRDD = (sims
    >>>                .<FILL IN>)
    >>> trueDupsCount = trueDupsRDD.<FILL IN>
    >>> avgSimDups = <FILL IN>
    >>> 
    >>> nonDupsRDD = (sims
    >>>               .<FILL IN>)
    >>> avgSimNon = <FILL IN>
    >>> 
    >>> print 'There are %s true duplicates.' % trueDupsCount
    >>> print 'The average similarity of true duplicates is %s.' % avgSimDups
    >>> print 'And for non duplicates, it is %s.' % avgSimNon

###################
Part 4: Scalable ER
###################
- In the previous parts, we built a text similarity function and used it for small scale entity resolution. 
- Our implementation is limited by its **quadratic run time complexity**
  
  - this is not practical for even modestly sized datasets. 


.. admonition:: Section Overview

    In this part, we will implement a more scalable algorithm and use it to do entity resolution on the **full dataset**.

    For this section, we'll use the **complete Google and Amazon datasets**, not the *samples*

****************
Inverted Indices
****************
- To improve our ER algorithm, we begin by analyzing its running time. 
- the algorithm above is **quadratic** in **two ways**. 

  - First, we did a lot of **redundant computation of tokens and weights**, since each record was reprocessed every time it was compared. 
  - Second, we made quadratically many token comparisons between records.
- The **first source of quadratic overhead** can be eliminated with **precomputation and look-up tables**
- The **second source of quadratic overhead** is a little more tricky. 
- In the **worst case**, every token in every record in one dataset exists in every record in the other dataset
  
  - therefore every token makes a non-zero contribution to the cosine similarity. 
  - In this case, token comparison is unavoidably quadratic.
- But **in reality** most records have nothing (or very little) in common. 
- Moreover, it is typical for a record in one dataset to have at most one duplicate record in the other dataset (this is the case assuming each dataset has been de-duplicated against itself). 
- In this case, the output is **linear** in the size of the input and we can hope to achieve **linear running time**.
- We'll turn to **inverted index** data structure for this!

.. admonition:: Inverted Index --- Overview
   
    - An **inverted index** is a data structure that will allow us to avoid making quadratically many token comparisons. 
    - It maps each token in the dataset to the list of documents that contain the token. 
    - So, :emph:`instead of comparing`, record by record, each token to every other token to see if they match, we will use **inverted indices** to :emph:`look up records that match on a particular token`. 

.. admonition:: Note on terminology
   
    - In text search, a **forward index** maps documents in a dataset to the tokens they contain. 
    - An **inverted index** supports the inverse mapping.

*****************************
4a) Tokenize the full dataset
*****************************
Tokenize each of the two full datasets for Google and Amazon. Use the ``tokenize()`` function we defined in (1b).

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4a-tokenize-the-full-dataset>`__) 

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> amazonFullRecToToken = amazon.<FILL IN>
    >>> googleFullRecToToken = google.<FILL IN>
    >>> print 'Amazon full dataset is %s products, Google full dataset is %s products' \
    >>>     % (amazonFullRecToToken.count(),googleFullRecToToken.count())
    Amazon full dataset is 1363 products, Google full dataset is 3226 products


**************************************************
4b) Compute IDFs and TF-IDFs for the full datasets
**************************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4b-compute-idfs-and-tf-idfs-for-the-full-datasets>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> fullCorpusRDD = <FILL IN>
    >>> idfsFull = idfs(fullCorpusRDD)
    >>> idfsFullCount = idfsFull.count()
    >>> print 'There are %s unique tokens in the full datasets.' % idfsFullCount
    >>> 
    >>> # Convert to dict and then broadcast
    >>> idfsFullWeights = <FILL IN>
    >>> idfsFullBroadcast = <FILL IN>
    >>> 
    >>> # Pre-compute TF-IDF weights.  Build mappings from record ID weight vector.
    >>> amazonWeightsRDD = <FILL IN>
    >>> googleWeightsRDD = <FILL IN>
    >>> print 'There are %s Amazon weights and %s Google weights.' \
    >>>     % (amazonWeightsRDD.count(), googleWeightsRDD.count())
    There are 17078 unique tokens in the full datasets.
    There are 1363 Amazon weights and 3226 Google weights.

********************************************************
4c) Compute Norms for the weights from the full datasets
********************************************************
- Reuse the code from above to **compute norms of the IDF weights for the complete combined dataset**. 
- The steps you should perform are:

  - Create two collections, one for each of the full Amazon and Google datasets,
    where IDs/URLs map to the norm of the associated TF-IDF weighted token vectors.
  - Convert each collection into a broadcast variable, containing a dictionary 
    of the norm of IDF weights for the full dataset

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4c-compute-norms-for-the-weights-from-the-full-datasets>`__)

.. code-block:: python

    >>> amazonNorms = amazonWeightsRDD.<FILL IN>
    >>> amazonNormsBroadcast = <FILL IN>
    >>> googleNorms = googleWeightsRDD.<FILL IN>
    >>> googleNormsBroadcast = <FILL IN>
    >>> print 'There are %s Amazon norms and %s Google norms.' % (len(amazonNorms), len(googleNorms))
    There are 1363 Amazon norms and 3226 Google norms.


**************************************************
4d) Create inverted indices from the full datasets
**************************************************
Build inverted indices of both data sources. 

The steps you should perform are:
  
- Create an **invert function**: 

  - **input**: a pair of (ID/URL, TF-IDF weighted token vector), 
  - **output**: a list of pairs of (token, ID/URL). 
  - Recall that the TF-IDF weighted token vector is a dictionary with keys that are tokens and values that are weights.
- Use your **invert function** to convert the full Amazon and Google TF-IDF weighted token vector datasets 
  into **two RDDs** where each element is* a pair of a token and an ID/URL that contain that token*. 

  - :emph:`These are inverted indices`

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4d-create-inverted-indices-from-the-full-datasets>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def invert(record):
    >>>     """ Invert (ID, tokens) to a list of (token, ID)
    >>>     Args:
    >>>         record: a pair, (ID, token vector)
    >>>     Returns:
    >>>         pairs: a list of pairs of token to ID
    >>>     """
    >>>     <FILL IN>
    >>>     return (pairs)
    >>> 
    >>> amazonInvPairsRDD = (amazonWeightsRDD
    >>>                     .<FILL IN>
    >>>                     .cache())
    >>> 
    >>> googleInvPairsRDD = (googleWeightsRDD
    >>>                     .<FILL IN>
    >>>                     .cache())
    >>> 
    >>> print 'There are %s Amazon inverted pairs and %s Google inverted pairs.' \
    >>>   % (amazonInvPairsRDD.count(),googleInvPairsRDD.count())
    There are 111387 Amazon inverted pairs and 77678 Google inverted pairs.

************************************************
4e) Identify common tokens from the full dataset
************************************************
We are now in position to efficiently perform ER on the full datasets. 

Implement the following algorithm to **build an RDD** that *maps a pair of (ID, URL) to a list of tokens they share in common*:

- **create a new RDD** ``commonTokens`` that contains only tokens that appear in both datasets

  - This will yield an RDD of pairs of **(token, (ID, URL))**.
  - for this, use the two inverted indices (RDDs where each element is a pair of a token and an ID or URL that contains that token). 

- We need a mapping from (ID, URL) to token, so **create a function** ``swap`` that will swap the elements of the RDD you just created to create this new RDD consisting of ((ID, URL), token) pairs.
- Finally, **create an RDD** consisting of pairs mapping (ID, URL) to all the tokens the pair shares in common

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4e-identify-common-tokens-from-the-full-dataset>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> def swap(record):
    >>>     """ Swap (token, (ID, URL)) to ((ID, URL), token)
    >>>     Args:
    >>>         record: a pair, (token, (ID, URL))
    >>>     Returns:
    >>>         pair: ((ID, URL), token)
    >>>     """
    >>>     token = <FILL IN>
    >>>     keys = <FILL IN>
    >>>     return (keys, token)
    >>> 
    >>> commonTokens = (amazonInvPairsRDD
    >>>                 .<FILL IN>
    >>>                 .cache())
    >>> 
    >>> print 'Found %d common tokens' % commonTokens.count()
    (1) Spark Jobs
    Found 2441100 common tokens
    Command took 30.38s

************************************************
4f) Identify common tokens from the full dataset
************************************************
Use the data structures from parts (4a) and (4e) to **build a dictionary** to map *record pairs* to *cosine similarity scores*. 

The steps you should perform are:

- Create **two broadcast dictionaries** from the amazonWeights and googleWeights RDDs
- Create a ``fastCosinesSimilarity`` function

  - **input**: a record consisting of the pair ((Amazon ID, Google URL), tokens list) 
  - computes the sum for each of the tokens in the token list of the products of the Amazon weight for the token times the Google weight for the token. 
  - The sum should then be divided by the norm for the Google URL and then divided by the norm for the Amazon ID. 
  - **output**: the function should return this value in a pair with the key being the (Amazon ID, Google URL). 
- :emph:`Make sure you use broadcast variables` you created for both the weights and norms
- Apply your ``fastCosinesSimilarity`` function to the common tokens from the full dataset


(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab3b_solutions.rst#exercise-4f-identify-common-tokens-from-the-full-dataset>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> amazonWeightsBroadcast = <FILL IN>
    >>> googleWeightsBroadcast = <FILL IN>
    >>> 
    >>> def fastCosineSimilarity(record):
    >>>     """ Compute Cosine Similarity using Broadcast variables
    >>>     Args:
    >>>         record: ((ID, URL), iterable(token))
    >>>     Returns:
    >>>         pair: ((ID, URL), cosine similarity value)
    >>>     """
    >>>     amazonRec = <FILL IN>
    >>>     googleRec = <FILL IN>
    >>>     tokens = <FILL IN>
    >>>     s = <FILL IN>
    >>>     value = <FILL IN>
    >>>     key = (amazonRec, googleRec)
    >>>     return (key, value)
    >>> 
    >>> similaritiesFullRDD = (commonTokens
    >>>                        .<FILL IN>
    >>>                        .cache())
    >>> 
    >>> print similaritiesFullRDD.count()
    (3) Spark Jobs
    2441100
    Command took 6.98s 

################
Part 5: Analysis
################
.. math:: Fmeasure = 2 \cdot \frac{precision * recall}{precision + recall}

Now we have an authoritative list of **record-pair similarities**, but :emph:`we need a way to use those similarities to decide if two records are duplicates or not`. 

- The simplest approach is to pick a **threshold**. Pairs whose similarity is **above the threshold are declared duplicates**, and pairs below the threshold are declared distinct.
- Higher threshold -> more **False positives** (we deem a record-pair to be duplicates when it's not)
- Lower threshold -> more **False negatives** (record-pairs that are duplicates that we miss)

.. note::
    
    - In this part, we use the "**gold standard**" mapping from the included file to look up true duplicates, and the results of Part 4.


*****************************************************************
5a) Counting True Positives, False Positives, and False Negatives
*****************************************************************
Create functions that count **True Positives** (true duplicates above the threshold), FP, FN.

- We start with creating the ``simsFullRDD`` from our ``similaritiesFullRDD`` that consists of a pair of ((Amazon ID, Google URL), simlarity score)
- From this RDD, we create an RDD consisting of only the similarity scores
- To look up the similarity scores for true duplicates, we perform a **left outer join** using the **goldStandard RDD** and ``simsFullRDD`` and extract the similarities scores using the helper function

.. code-block:: python

    >>> # Create an RDD of ((Amazon ID, Google URL), similarity score)
    >>> simsFullRDD = similaritiesFullRDD.map(lambda x: ("%s %s" % (x[0][0], x[0][1]), x[1]))
    >>> 
    >>> # Create an RDD of just the similarity scores
    >>> simsFullValuesRDD = (simsFullRDD
    >>>                      .map(lambda x: x[1])
    >>>                      .cache())
    >>> 
    >>> # Look up all similarity scores for true duplicates
    >>>     
    >>> # This helper function will return the similarity score for records that are in the gold standard and the simsFullRDD (True positives), and will return 0 for records that are in the gold standard but not in simsFullRDD (False Negatives).
    >>> def gs_value(record):
    >>>     if (record[1][1] is None):
    >>>         return 0
    >>>     else:
    >>>         return record[1][1]
    >>> 
    >>> # Join the gold standard and simsFullRDD, and then extract the similarities scores using the helper function
    >>> trueDupSimsRDD = (goldStandard
    >>>                   .leftOuterJoin(simsFullRDD)
    >>>                   .map(gs_value)
    >>>                   .cache())
    >>> print 'There are %s true duplicates.' % trueDupSimsRDD.count()
    There are 1300 true duplicates.
    Command took 16.12s 


The next step is to **pick a threshold** between 0 and 1 for the count of True Positives. We would like to explore many different thresholds. To do this, we divide the **space of thresholds into 100 bins**, and take the following actions:

- We use :emph:`Spark Accumulators` to implement our counting function. 

  - We define a custom accumulator type, ``VectorAccumulatorParam``, along with functions to initialize the accumulator's vector to zero, and to add two vectors. 
  - Note that we have to use the ``+=`` operator because you can only add to an accumulator.
- We create a helper function to create a list with one entry (bit) set to a value and all others set to 0.
- We create 101 bins for the 100 threshold values between 0 and 1.
- Now, for each similarity score, we can compute the false positives. We do this by adding each similarity score to the appropriate bin of the vector. Then we remove true positives from the vector by using the gold standard data.
- We define functions for computing false positive and negative and true positives, for a given threshold.


.. code-block:: python

    from pyspark.accumulators import AccumulatorParam
    class VectorAccumulatorParam(AccumulatorParam):
        # Initialize the VectorAccumulator to 0
        def zero(self, value):
            return [0] * len(value)

        # Add two VectorAccumulator variables
        def addInPlace(self, val1, val2):
            for i in xrange(len(val1)):
                val1[i] += val2[i]
            return val1

    # Return a list with entry x set to value and all other entries set to 0
    def set_bit(x, value, length):
        bits = []
        for y in xrange(length):
            if (x == y):
              bits.append(value)
            else:
              bits.append(0)
        return bits

    # Pre-bin counts of false positives for different threshold ranges
    BINS = 101
    nthresholds = 100
    def bin(similarity):
        return int(similarity * nthresholds)

    # fpCounts[i] = number of entries (possible false positives) where bin(similarity) == i
    zeros = [0] * BINS
    fpCounts = sc.accumulator(zeros, VectorAccumulatorParam())

    def add_element(score):
        global fpCounts
        b = bin(score)
        fpCounts += set_bit(b, 1, BINS)

    simsFullValuesRDD.foreach(add_element)

    # Remove true positives from FP counts
    def sub_element(score):
        global fpCounts
        b = bin(score)
        fpCounts += set_bit(b, -1, BINS)

    trueDupSimsRDD.foreach(sub_element)

    def falsepos(threshold):
        fpList = fpCounts.value
        return sum([fpList[b] for b in range(0, BINS) if float(b) / nthresholds >= threshold])

    def falseneg(threshold):
        return trueDupSimsRDD.filter(lambda x: x < threshold).count()

    def truepos(threshold):
        return trueDupSimsRDD.count() - falsenegDict[threshold]

************************************
5b Precision, Recall, and F-measures
************************************
Define functions so that we can compute the Precision, Recall, and F-measure as a function of threshold value:

- Precision = true-positives / (true-positives + false-positives)
- Recall = true-positives / (true-positives + false-negatives)
- F-measure = 2 x Recall x Precision / (Recall + Precision)

.. code-block:: python

    # Precision = true-positives / (true-positives + false-positives)
    # Recall = true-positives / (true-positives + false-negatives)
    # F-measure = 2 x Recall x Precision / (Recall + Precision)

    def precision(threshold):
        tp = trueposDict[threshold]
        return float(tp) / (tp + falseposDict[threshold])

    def recall(threshold):
        tp = trueposDict[threshold]
        return float(tp) / (tp + falsenegDict[threshold])

    def fmeasure(threshold):
        r = recall(threshold)
        p = precision(threshold)
        return 2 * r * p / (r + p)

*************
5c Line Plots
*************


.. code-block:: python

    >>> thresholds = [float(n) / nthresholds for n in range(0, nthresholds)]
    >>> falseposDict = dict([(t, falsepos(t)) for t in thresholds])
    >>> falsenegDict = dict([(t, falseneg(t)) for t in thresholds])
    >>> trueposDict = dict([(t, truepos(t)) for t in thresholds])
    >>> 
    >>> precisions = [precision(t) for t in thresholds]
    >>> recalls = [recall(t) for t in thresholds]
    >>> fmeasures = [fmeasure(t) for t in thresholds]
    >>> 
    >>> print precisions[0], fmeasures[0]
    (200) Spark Jobs
    0.000532546802671 0.00106452669505
    Command took 23.93s 

    >>> fig = plt.figure()
    >>> plt.plot(thresholds, precisions)
    >>> plt.plot(thresholds, recalls)
    >>> plt.plot(thresholds, fmeasures)
    >>> plt.legend(['Precision', 'Recall', 'F-measure'])
    >>> display(fig)

.. image:: /_static/img/cs110_lab3b_5c.png
    :align: center
    :scale: 100 %

Also use Databrick's ``display`` function to create a similar plot.

.. image:: http://spark-mooc.github.io/web-assets/images/cs110x/lab3-change-plot-5c.png
   :align: center
   :scale: 100 %

.. code-block:: python

    # Create a DataFrame and visualize using display()
    graph = [(t, precision(t), recall(t),fmeasure(t)) for t in thresholds]
    graphRDD = sc.parallelize(graph)

    graphRow = graphRDD.map(lambda (t, x, y, z): Row(threshold=t, precision=x, recall=y, fmeasure=z))
    graphDF = sqlContext.createDataFrame(graphRow)
    display(graphDF)

.. image:: /_static/img/cs110_lab3b_5c2.png
    :align: center
    :scale: 100 %

#####################
Discussion of results
#####################
- State-of-the-art tools can get an **F-measure of about 60%** on this dataset. 
- In this lab exercise, our best **F-measure is closer to 40%**. 
- Look at some examples of errors (both False Positives and False Negatives) and think about what went wrong.
- There are several ways we might improve our simple classifier, including:

  - Using additional attributes
  - Performing better featurization of our textual data (e.g., stemming, n-grams, etc.)
  - Using different similarity functions