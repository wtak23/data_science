#####################################
Spark Configuration Setup for Jupyter
#####################################
.. contents:: `Contents`
   :depth: 2
   :local:

about
=====

-  after much frustration with hours of trial and error, finally got
   pyspark to run on jupyter notebook
-  (most help I found on the web was based on the old IPython-notebook
   and Spark 1.6....I wanted to get things to work on Jupyter and Spark
   2.0, which I couldn't find much resource online)

https://spark.apache.org/docs/2.0.0/quick-start.html

Adding below in my ``.bashrc`` file finally solved my issues

.. code:: bash

    export SPARK_HOME=$HOME/mybin/spark-2.0.0-bin-hadoop2.7
    export PATH="$SPARK_HOME:$PATH"
    export PATH=$PATH:$SPARK_HOME/bin

    export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
    # export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH

    export ANACONDA_ROOT=~/anaconda2
    export PYSPARK_DRIVER_PYTHON=$ANACONDA_ROOT/bin/jupyter
    export PYSPARK_DRIVER_PYTHON_OPTS='notebook' pyspark
    export PYSPARK_PYTHON=$ANACONDA_ROOT/bin/python

.. code:: python

    import pyspark

.. code:: python

    import os

.. code:: python

    os.environ['SPARK_HOME']




.. parsed-literal::
    :class: myliteral

    '/home/takanori/mybin/spark-2.0.0-bin-hadoop2.7'



.. code:: python

    textFile = sc.textFile(os.path.join(os.environ['SPARK_HOME'],'README.md'))

.. code:: python

    textFile.count() # Number of items in this RDD




.. parsed-literal::
    :class: myliteral

    99



.. code:: python

    textFile.first() # First item in this RDD




.. parsed-literal::
    :class: myliteral

    u'# Apache Spark'



.. code:: python

    linesWithSpark = textFile.filter(lambda line: "Spark" in line)

.. code:: python

    textFile.filter(lambda line: "Spark" in line).count() # How many lines contain "Spark"?




.. parsed-literal::
    :class: myliteral

    19



.. code:: python

    textFile.map(lambda line: len(line.split())).reduce(lambda a, b: a if (a > b) else b)




.. parsed-literal::
    :class: myliteral

    22



.. code:: python

    >>> def max(a, b):
    ...     if a > b:
    ...         return a
    ...     else:
    ...         return b
    ...
    
    >>> textFile.map(lambda line: len(line.split())).reduce(max)




.. parsed-literal::
    :class: myliteral

    22



.. code:: python

    >>> wordCounts = textFile.flatMap(lambda line: line.split()).map(lambda word: (word, 1)).reduceByKey(lambda a, b: a+b)

.. code:: python

    wordCounts.collect()




.. parsed-literal::
    :class: myliteral

    [(u'when', 1),
     (u'R,', 1),
     (u'including', 3),
     (u'computation', 1),
     (u'using:', 1),
     (u'guidance', 2),
     (u'Scala,', 1),
     (u'environment', 1),
     (u'only', 1),
     (u'rich', 1),
     (u'Apache', 1),
     (u'sc.parallelize(range(1000)).count()', 1),
     (u'Building', 1),
     (u'And', 1),
     (u'guide,', 1),
     (u'return', 2),
     (u'Please', 3),
     (u'[Eclipse](https://cwiki.apache.org/confluence/display/SPARK/Useful+Developer+Tools#UsefulDeveloperTools-Eclipse)',
      1),
     (u'Try', 1),
     (u'not', 1),
     (u'Spark', 15),
     (u'scala>', 1),
     (u'Note', 1),
     (u'cluster.', 1),
     (u'./bin/pyspark', 1),
     (u'params', 1),
     (u'through', 1),
     (u'GraphX', 1),
     (u'[run', 1),
     (u'abbreviated', 1),
     (u'For', 3),
     (u'##', 8),
     (u'library', 1),
     (u'see', 3),
     (u'"local"', 1),
     (u'[Apache', 1),
     (u'will', 1),
     (u'#', 1),
     (u'processing,', 1),
     (u'for', 11),
     (u'[building', 1),
     (u'Maven', 1),
     (u'["Parallel', 1),
     (u'provides', 1),
     (u'print', 1),
     (u'supports', 2),
     (u'built,', 1),
     (u'[params]`.', 1),
     (u'available', 1),
     (u'run', 7),
     (u'tests](https://cwiki.apache.org/confluence/display/SPARK/Useful+Developer+Tools).',
      1),
     (u'This', 2),
     (u'Hadoop,', 2),
     (u'Tests', 1),
     (u'example:', 1),
     (u'-DskipTests', 1),
     (u'Maven](http://maven.apache.org/).', 1),
     (u'thread', 1),
     (u'programming', 1),
     (u'running', 1),
     (u'against', 1),
     (u'site,', 1),
     (u'comes', 1),
     (u'package.', 1),
     (u'and', 11),
     (u'package.)', 1),
     (u'prefer', 1),
     (u'documentation,', 1),
     (u'submit', 1),
     (u'tools', 1),
     (u'use', 3),
     (u'from', 1),
     (u'[project', 2),
     (u'./bin/run-example', 2),
     (u'fast', 1),
     (u'systems.', 1),
     (u'<http://spark.apache.org/>', 1),
     (u'Hadoop-supported', 1),
     (u'way', 1),
     (u'README', 1),
     (u'MASTER', 1),
     (u'engine', 1),
     (u'building', 2),
     (u'usage', 1),
     (u'instance:', 1),
     (u'with', 4),
     (u'protocols', 1),
     (u'IDE,', 1),
     (u'this', 1),
     (u'setup', 1),
     (u'shell:', 2),
     (u'project', 1),
     (u'following', 2),
     (u'distribution', 1),
     (u'detailed', 2),
     (u'have', 1),
     (u'stream', 1),
     (u'is', 6),
     (u'higher-level', 1),
     (u'tests', 2),
     (u'1000:', 2),
     (u'sample', 1),
     (u'["Specifying', 1),
     (u'Alternatively,', 1),
     (u'file', 1),
     (u'need', 1),
     (u'You', 4),
     (u'instructions.', 1),
     (u'different', 1),
     (u'programs,', 1),
     (u'storage', 1),
     (u'same', 1),
     (u'machine', 1),
     (u'Running', 1),
     (u'which', 2),
     (u'you', 4),
     (u'A', 1),
     (u'About', 1),
     (u'sc.parallelize(1', 1),
     (u'locally.', 1),
     (u'Hive', 2),
     (u'optimized', 1),
     (u'uses', 1),
     (u'Version"](http://spark.apache.org/docs/latest/building-spark.html#specifying-the-hadoop-version)',
      1),
     (u'variable', 1),
     (u'The', 1),
     (u'data', 1),
     (u'a', 8),
     (u'"yarn"', 1),
     (u'Thriftserver', 1),
     (u'processing.', 1),
     (u'./bin/spark-shell', 1),
     (u'Python', 2),
     (u'Spark](#building-spark).', 1),
     (u'clean', 1),
     (u'the', 22),
     (u'requires', 1),
     (u'talk', 1),
     (u'help', 1),
     (u'Hadoop', 3),
     (u'-T', 1),
     (u'high-level', 1),
     (u'its', 1),
     (u'web', 1),
     (u'Shell', 2),
     (u'how', 2),
     (u'graph', 1),
     (u'run:', 1),
     (u'should', 2),
     (u'to', 14),
     (u'module,', 1),
     (u'given.', 1),
     (u'directory.', 1),
     (u'must', 1),
     (u'do', 2),
     (u'Programs', 1),
     (u'Many', 1),
     (u'YARN,', 1),
     (u'using', 5),
     (u'Example', 1),
     (u'Once', 1),
     (u'Spark"](http://spark.apache.org/docs/latest/building-spark.html).', 1),
     (u'Because', 1),
     (u'name', 1),
     (u'Testing', 1),
     (u'refer', 2),
     (u'Streaming', 1),
     (u'[IntelliJ](https://cwiki.apache.org/confluence/display/SPARK/Useful+Developer+Tools#UsefulDeveloperTools-IntelliJ).',
      1),
     (u'SQL', 2),
     (u'them,', 1),
     (u'analysis.', 1),
     (u'set', 2),
     (u'Scala', 2),
     (u'thread,', 1),
     (u'individual', 1),
     (u'examples', 2),
     (u'runs.', 1),
     (u'Pi', 1),
     (u'More', 1),
     (u'Python,', 2),
     (u'Versions', 1),
     (u'find', 1),
     (u'version', 1),
     (u'wiki](https://cwiki.apache.org/confluence/display/SPARK).', 1),
     (u'`./bin/run-example', 1),
     (u'Configuration', 1),
     (u'command,', 2),
     (u'Maven,', 1),
     (u'core', 1),
     (u'Guide](http://spark.apache.org/docs/latest/configuration.html)', 1),
     (u'MASTER=spark://host:7077', 1),
     (u'Documentation', 1),
     (u'downloaded', 1),
     (u'distributions.', 1),
     (u'Spark.', 1),
     (u'["Building', 1),
     (u'by', 1),
     (u'on', 5),
     (u'package', 1),
     (u'of', 5),
     (u'changed', 1),
     (u'pre-built', 1),
     (u'Big', 1),
     (u'3"](https://cwiki.apache.org/confluence/display/MAVEN/Parallel+builds+in+Maven+3).',
      1),
     (u'or', 3),
     (u'learning,', 1),
     (u'locally', 2),
     (u'overview', 1),
     (u'one', 3),
     (u'(You', 1),
     (u'Online', 1),
     (u'versions', 1),
     (u'your', 1),
     (u'threads.', 1),
     (u'APIs', 1),
     (u'SparkPi', 2),
     (u'contains', 1),
     (u'system', 1),
     (u'`examples`', 2),
     (u'start', 1),
     (u'build/mvn', 1),
     (u'easiest', 1),
     (u'basic', 1),
     (u'more', 1),
     (u'option', 1),
     (u'that', 2),
     (u'N', 1),
     (u'"local[N]"', 1),
     (u'DataFrames,', 1),
     (u'particular', 2),
     (u'be', 2),
     (u'an', 4),
     (u'than', 1),
     (u'Interactive', 2),
     (u'builds', 1),
     (u'developing', 1),
     (u'programs', 2),
     (u'cluster', 2),
     (u'can', 7),
     (u'example', 3),
     (u'are', 1),
     (u'Data.', 1),
     (u'mesos://', 1),
     (u'computing', 1),
     (u'URL,', 1),
     (u'in', 6),
     (u'general', 2),
     (u'To', 2),
     (u'at', 2),
     (u'1000).count()', 1),
     (u'if', 4),
     (u'built', 1),
     (u'no', 1),
     (u'Java,', 1),
     (u'MLlib', 1),
     (u'also', 4),
     (u'other', 1),
     (u'build', 4),
     (u'online', 1),
     (u'several', 1),
     (u'HDFS', 1),
     (u'[Configuration', 1),
     (u'class', 2),
     (u'>>>', 1),
     (u'spark://', 1),
     (u'page](http://spark.apache.org/documentation.html)', 1),
     (u'documentation', 3),
     (u'It', 2),
     (u'graphs', 1),
     (u'./dev/run-tests', 1),
     (u'configure', 1),
     (u'<class>', 1),
     (u'first', 1),
     (u'latest', 1)]



.. code:: python

    linesWithSpark.cache()
    
    print linesWithSpark.count()
    print linesWithSpark.count()



.. parsed-literal::
    :class: myliteral

    19
    19


self-contained applications
===========================

.. code:: python

    %%bash
    echo $SPARK_HOME


.. parsed-literal::
    :class: myliteral

    /home/takanori/mybin/spark-2.0.0-bin-hadoop2.7


.. code:: python

    %%bash 
    #ls ${SPARK_HOME}/python/pyspark
    ls ${SPARK_HOME}/examples/src/main/python


.. parsed-literal::
    :class: myliteral

    als.py
    avro_inputformat.py
    kmeans.py
    logistic_regression.py
    ml
    mllib
    pagerank.py
    parquet_inputformat.py
    pi.py
    sort.py
    sql
    sql.py
    status_api_demo.py
    streaming
    transitive_closure.py
    wordcount.py


.. code:: python

    %%bash
    spark-submit ${SPARK_HOME}/examples/src/main/python/pi.py


.. parsed-literal::
    :class: myliteral

    jupyter: '/home/takanori/mybin/spark-2.0.0-bin-hadoop2.7/examples/src/main/python/pi.py' is not a Jupyter command


Note
====

to run above, need to unset these in the commandline shell:

.. code:: bash

    unset PYSPARK_DRIVER_PYTHON
    unset PYSPARK_DRIVER_PYTHON_OPTS
    spark-submit ${SPARK_HOME}/examples/src/main/python/pi.py

