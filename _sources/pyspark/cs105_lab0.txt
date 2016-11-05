.. _cs105_lab0:

cs105_lab0 - Running Your First Notebook
""""""""""""""""""""""""""""""""""""""""
https://github.com/spark-mooc/mooc-setup/blob/master/cs105_lab0.dbc

.. note:: This notebook tests Spark Functionality (not a tutorial)

.. contents:: `Contents`
   :depth: 2
   :local:

##############################
Create DataFrame and filter it
##############################
>>> from pyspark.sql import Row
>>> data = [('Alice', 1), ('Bob', 2), ('Bill', 4)]
>>> df = sqlContext.createDataFrame(data, ['name', 'age'])
>>> fil = df.filter(df.age > 3).collect()
>>> print fil
[Row(name=u'Bill', age=4)]

>>> data = [('Alice', 1), ('Bob', 2), ('Bill', 4)]
>>> df = sqlContext.createDataFrame(data, schema=['name', 'age'])
>>> df.show()
+-----+---+
| name|age|
+-----+---+
|Alice|  1|
|  Bob|  2|
| Bill|  4|
+-----+---+

>>> fil = df.filter(df.age > 3).collect()
>>> print fil
[Row(name=u'Bill', age=4)]

################
Load a text file
################
.. code-block:: python

  >>> filename = 'databricks-datasets/cs100/lab1/data-001/shakespeare.txt'
  >>> dataDF = sqlContext.read.text(filename)
  >>> 
  >>> dataDF.show(10,truncate=False)
  >>> shakespeareCount = dataDF.count()
  >>> print "number of counts = ", shakespeareCount
  ​​+--------------------------------------------+
  |value                                       |
  +--------------------------------------------+
  |1609                                        |
  |                                            |
  |THE SONNETS                                 |
  |                                            |
  |by William Shakespeare                      |
  |                                            |
  |                                            |
  |                                            |
  |                     1                      |
  |  From fairest creatures we desire increase,|
  +--------------------------------------------+
  only showing top 10 rows

  number of counts =  122395

##############
Check plotting
##############

.. code-block:: python
    :linenos:

    # Check matplotlib plotting
    import matplotlib.pyplot as plt
    import matplotlib.cm as cm
    from math import log

    # function for generating plot layout
    def preparePlot(xticks, yticks, figsize=(10.5, 6), hideLabels=False, gridColor='#999999', gridWidth=1.0):
        plt.close()
        fig, ax = plt.subplots(figsize=figsize, facecolor='white', edgecolor='white')
        ax.axes.tick_params(labelcolor='#999999', labelsize='10')
        for axis, ticks in [(ax.get_xaxis(), xticks), (ax.get_yaxis(), yticks)]:
            axis.set_ticks_position('none')
            axis.set_ticks(ticks)
            axis.label.set_color('#999999')
            if hideLabels: axis.set_ticklabels([])
        plt.grid(color=gridColor, linewidth=gridWidth, linestyle='-')
        map(lambda position: ax.spines[position].set_visible(False), ['bottom', 'top', 'left', 'right'])
        return fig, ax

    # generate layout and plot data
    x = range(1, 50)
    y = [log(x1 ** 2) for x1 in x]
    fig, ax = preparePlot(range(5, 60, 10), range(0, 12, 1))
    plt.scatter(x, y, s=14**2, c='#d6ebf2', edgecolors='#8cbfd0', alpha=0.75)
    ax.set_xlabel(r'$range(1, 50)$'), ax.set_ylabel(r'$\log_e(x^2)$')
    display(fig)
    pass

.. image:: /_static/cs105_plot.png
   :scale: 100 %
   :align: center