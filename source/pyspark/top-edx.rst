.. __edx_course_notes:

EdX - Data Science and Engineering with Spark
"""""""""""""""""""""""""""""""""""""""""""""
Notes I took when completing EdX's program series on `Data Science and Engineering with Spark <https://www.edx.org/xseries/data-science-engineering-apache-spark>`__.

- **CS105**: Introduction to Apache Spark (`link <https://www.edx.org/course/introduction-apache-spark-uc-berkeleyx-cs105x>`__)
- **CS110**: Big Data Analysis with Apache Spark (`link <https://www.edx.org/course/big-data-analysis-apache-spark-uc-berkeleyx-cs110x>`__)
- **CS120**: Distributed Machine Learning with Apache Spark (`link <https://www.edx.org/course/distributed-machine-learning-apache-uc-berkeleyx-cs120x>`__)

.. important:: 

  To adhere to the honor code, I kept the content of ``<FILL IN>`` for the HW problems 
  in a separate personal private `github repos <https://github.com/wtak23/private_repos/>`__
  that only I have access to.

.. toctree::
    :maxdepth: 1
    :caption: Contents
    :name: top-edx

    cs105_lab0
    cs105_lab1a
    cs105_lab1a_coding
    cs105_lab1b
    cs105_lab2
    cs110_lab1
    cs110_lab2
    cs110_lab3b
    cs120_lab1a
    cs120_lab1b
    cs120_lab2
    cs120_lab3
    cs120_lab4

In Databricks, these come preloaded

>>> print sc.version
>>> print type(sc)
>>> print type(sqlContext)
1.6.2
<class '__main__.RemoteContext'>
<class 'pyspark.sql.context.HiveContext'>

.. note::

    I learned a whole lot from :ref:`cs105_lab2_4e`