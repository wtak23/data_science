cs110 - Predicting Movie Ratings with Alternating Least Squares
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
https://raw.githubusercontent.com/spark-mooc/mooc-setup/master/cs110_lab2_als_prediction.py

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:

.. rubric:: During this lab we will cover:

- Part 0: Preliminaries
- Part 1: Basic Recommendations
- Part 2: Collaborative Filtering
- Part 3: Predictions for Yourself



#############
Preliminaries
#############
We read in each of the files and create a DataFrame consisting of parsed lines.

.. code-block:: python

    import os
    from databricks_test_helper import Test

    dbfs_dir = '/databricks-datasets/cs110x/ml-20m/data-001'
    ratings_filename = dbfs_dir + '/ratings.csv'
    movies_filename = dbfs_dir + '/movies.csv'

    # The following line is here to enable this notebook to be exported as source and
    # run on a local machine with a local copy of the files. Just change the dbfs_dir, above.
    if os.path.sep != '/':
      # Handle Windows.
      ratings_filename = ratings_filename.replace('/', os.path.sep)
      movie_filename = movie_filename.replace('/', os.path.sep)

***************************
The 20-million movie sample
***************************
First, let's take a look at the directory containing our files.

>>> for _i,_item in enumerate(dbutils.fs.ls(dbfs_dir)):
>>>   print _i,_item
0 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/README.txt', name=u'README.txt', size=8964L)
1 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/links.csv', name=u'links.csv', size=569517L)
2 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/links.csv.gz', name=u'links.csv.gz', size=245973L)
3 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/movies.csv', name=u'movies.csv', size=1397542L)
4 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/movies.csv.gz', name=u'movies.csv.gz', size=498839L)
5 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/ratings.csv', name=u'ratings.csv', size=533444411L)
6 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/ratings.csv.gz', name=u'ratings.csv.gz', size=132656084L)
7 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/tags.csv', name=u'tags.csv', size=16603996L)
8 FileInfo(path=u'dbfs:/databricks-datasets/cs110x/ml-20m/data-001/tags.csv.gz', name=u'tags.csv.gz', size=4787917L)

******************
CPU vs IO Tradeoff
******************
.. admonition:: Summary
   
   - CPU is the bottleneck -> process uncompressed files
   - I/O is the bottleneck -> process compressed files
   - explicitly give Schema for extra speedup (schema inference has overhead when creating DF)

Note that we have both compressed files (ending in ``.gz``) and uncompressed files. 

We have a CPU vs. I/O tradeoff here. 

- **If I/O is the bottleneck**, then we want to process the compressed files and pay the extra CPU overhead. 
- **If CPU is the bottleneck**, then it makes more sense to process the uncompressed files.

We've done some experiments, and we've determined that CPU is more of a bottleneck than I/O, on Community Edition. 
So, we're going to process the uncompressed data. 

In addition, we're going to speed things up further by **specifying the DataFrame schema explicitly**. 
(When the Spark CSV adapter infers the schema from a CSV file, it has to make an extra pass over the file. 
That'll slow things down here, and it isn't really necessary.)

.. code-block:: python

    from pyspark.sql.types import *

    ratings_df_schema = StructType([
       StructField('userId', IntegerType()),
       StructField('movieId', IntegerType()),
       StructField('rating', DoubleType()),
      ])
    movies_df_schema = StructType([
       StructField('ID', IntegerType()),
       StructField('title', StringType()),
      ])

**************
Load and Cache
**************
The Databricks File System (**DBFS**) sits on top of S3. 

- We're going to be accessing this data a lot. 
- Rather than read it over and over again from S3, we'll cache both the movies DF and the ratings DF in memory.

The code below will take about 30 sec to run:

.. code-block:: python

    >>> from pyspark.sql.functions import regexp_extract
    >>> from pyspark.sql.types import *
    >>> 
    >>> raw_ratings_df = sqlContext.read.format('com.databricks.spark.csv').options(header=True, inferSchema=False).schema(ratings_df_schema).load(ratings_filename)
    >>> ratings_df = raw_ratings_df.drop('Timestamp')
    >>> 
    >>> raw_movies_df = sqlContext.read.format('com.databricks.spark.csv').options(header=True, inferSchema=False).schema(movies_df_schema).load(movies_filename)
    >>> movies_df = raw_movies_df.drop('Genres').withColumnRenamed('movieId', 'ID')
    >>> 
    >>> ratings_df.cache()
    >>> movies_df.cache()
    >>> 
    >>> assert ratings_df.is_cached
    >>> assert movies_df.is_cached
    >>> 
    >>> raw_ratings_count = raw_ratings_df.count()
    >>> ratings_count = ratings_df.count()
    >>> raw_movies_count = raw_movies_df.count()
    >>> movies_count = movies_df.count()
    >>> 
    >>> print 'There are %s ratings and %s movies in the datasets' % (ratings_count, movies_count)
    There are 20000263 ratings and 27278 movies in the datasets
    >>> print 'Ratings:'
    >>> ratings_df.show(3)
    Ratings:
    +------+-------+------+
    |userId|movieId|rating|
    +------+-------+------+
    |     1|      2|   3.5|
    |     1|     29|   3.5|
    |     1|     32|   3.5|
    +------+-------+------+
    only showing top 3 rows

    >>> print 'Movies:'
    >>> movies_df.show(3, truncate=False)
    Movies:
    +---+-----------------------+
    |ID |title                  |
    +---+-----------------------+
    |1  |Toy Story (1995)       |
    |2  |Jumanji (1995)         |
    |3  |Grumpier Old Men (1995)|
    +---+-----------------------+
    only showing top 3 rows

    >>> assert raw_ratings_count == ratings_count
    >>> assert raw_movies_count == movies_count


.. code-block:: python

    >>> ratings_df.printSchema()
    root
     |-- userId: integer (nullable = true)
     |-- movieId: integer (nullable = true)
     |-- rating: double (nullable = true)

    >>> movies_df.printSchema()
    ​root
     |-- ID: integer (nullable = true)
     |-- title: string (nullable = true)


Data verification check:

.. code-block:: python

    assert ratings_count == 20000263
    assert movies_count == 27278
    assert movies_df.filter(movies_df.title == 'Toy Story (1995)').count() == 1
    assert ratings_df.filter((ratings_df.userId == 6) & (ratings_df.movieId == 1) & (ratings_df.rating == 5.0)).count() == 1


#####################
Basic Recommendations
#####################
One way to recommend movies is to always recommend the movies with the highest average rating. 

- In this part, we will use Spark to find the name, number of ratings, and the average rating of the 20 movies with the highest average rating and at least 500 reviews. 
- We want to filter our movies with high ratings but greater than or equal to 500 reviews because movies with few reviews may not have broad appeal to everyone.

*************************************************
Exercise (1a) Movies with Highest Average Ratings
*************************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-1a-movies-with-highest-average-ratings>`__)

Let's determine the movies with the highest average ratings.


.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with appropriate code
    >>> from pyspark.sql import functions as F
    
    >>> # From ratingsDF, create a movie_ids_with_avg_ratings_df that combines the two DataFrames
    >>> movie_ids_with_avg_ratings_df = ratings_df.groupBy('movieId').agg(F.count(ratings_df.rating).alias("count"), F.avg(ratings_df.rating).alias("average"))
    >>> print 'movie_ids_with_avg_ratings_df:'
    >>> movie_ids_with_avg_ratings_df.show(3, truncate=False)
    >>> movie_ids_with_avg_ratings_df:
    +-------+-----+------------------+
    |movieId|count|average           |
    +-------+-----+------------------+
    |1831   |7463 |2.5785207021305103|
    |431    |8946 |3.695059244355019 |
    |631    |2193 |2.7273141814865483|
    +-------+-----+------------------+
    only showing top 3 rows

    >>> # Note: movie_names_df is a temporary variable, used only to separate the steps necessary
    >>> # to create the movie_names_with_avg_ratings_df DataFrame.
    >>> movie_names_df = movie_ids_with_avg_ratings_df.<FILL_IN>
    >>> movie_names_with_avg_ratings_df = movie_names_df.<FILL_IN>
    >>> 
    >>> print 'movie_names_with_avg_ratings_df:'
    >>> movie_names_with_avg_ratings_df.show(3, truncate=False)
    movie_names_with_avg_ratings_df:
    +-------+----------------------------+-----+-------+
    |average|title                       |count|movieId|
    +-------+----------------------------+-----+-------+
    |5.0    |People of the Wind (1976)   |1    |129036 |
    |5.0    |Serving Life (2011)         |1    |129034 |
    |5.0    |Diplomatic Immunity (2009– )|1    |107434 |
    +-------+----------------------------+-----+-------+
    only showing top 3 rows

**************************************************************************
Exercise (1b) Movies with Highest Average Ratings and at least 500 reviews
**************************************************************************
- Now that we have a DataFrame of the movies with highest average ratings, we can use Spark to determine the **20 movies with highest average ratings and at least 500 reviews**.
- Add a single DataFrame transformation (in place of <FILL_IN>, below) to limit the results to movies with ratings from at least 500 people.

(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-1b-movies-with-highest-average-ratings-and-at-least-500-reviews>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> movies_with_500_ratings_or_more = movie_names_with_avg_ratings_df.<FILL_IN>
    >>> print 'Movies with highest ratings:'
    >>> movies_with_500_ratings_or_more.show(10, truncate=False)
    (4) Spark Jobs
    Movies with highest ratings:
    +-----------------+---------------------------------------------+-----+-------+
    |average          |title                                        |count|movieId|
    +-----------------+---------------------------------------------+-----+-------+
    |4.446990499637029|Shawshank Redemption, The (1994)             |63366|318    |
    |4.364732196832306|Godfather, The (1972)                        |41355|858    |
    |4.334372207803259|Usual Suspects, The (1995)                   |47006|50     |
    |4.310175010988133|Schindler's List (1993)                      |50054|527    |
    |4.275640557704942|Godfather: Part II, The (1974)               |27398|1221   |
    |4.2741796572216  |Seven Samurai (Shichinin no samurai) (1954)  |11611|2019   |
    |4.271333600779414|Rear Window (1954)                           |17449|904    |
    |4.263182346109176|Band of Brothers (2001)                      |4305 |7502   |
    |4.258326830670664|Casablanca (1942)                            |24349|912    |
    |4.256934865900383|Sunset Blvd. (a.k.a. Sunset Boulevard) (1950)|6525 |922    |
    +-----------------+---------------------------------------------+-----+-------+

#######################
Collaborative Filtering
#######################

*************************************
Exercise (2a) Creating a Training Set
*************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-2a-creating-a-training-set>`__)


.. code-block:: python

    >>> # We'll hold out 60% for training, 20% of our data for validation, and leave 20% for testing
    >>> seed = 1800009193L
    >>> (split_60_df, split_a_20_df, split_b_20_df) = <FILL_IN>
    >>> 
    >>> # Let's cache these datasets for performance
    >>> training_df = split_60_df.cache()
    >>> validation_df = split_a_20_df.cache()
    >>> test_df = split_b_20_df.cache()
    >>> 
    >>> print('Training: {0}, validation: {1}, test: {2}\n'.format(
    >>>   training_df.count(), validation_df.count(), test_df.count())
    >>> )
    Training: 12001389, validation: 4003694, test: 3995180

    >>> training_df.show(3)
    +------+-------+------+
    |userId|movieId|rating|
    +------+-------+------+
    |     1|      2|   3.5|
    |     1|     29|   3.5|
    |     1|     47|   3.5|
    +------+-------+------+

    >>> validation_df.show(3)
    +------+-------+------+
    |userId|movieId|rating|
    +------+-------+------+
    |     1|     32|   3.5|
    |     1|    253|   4.0|
    |     1|    293|   4.0|
    +------+-------+------+

    >>> test_df.show(3)
    +------+-------+------+
    |userId|movieId|rating|
    +------+-------+------+
    |     1|    112|   3.5|
    |     1|    151|   4.0|
    |     1|    318|   4.0|
    +------+-------+------+

***************************************
Exercise (2b) Alternating Least Squares
***************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-2b-alternating-least-squares>`__)

.. code-block:: python

    >>> # This step is broken in ML Pipelines: https://issues.apache.org/jira/browse/SPARK-14489
    >>> from pyspark.ml.recommendation import ALS
    >>> 
    >>> # Let's initialize our ALS learner
    >>> als = ALS()
    >>> 
    >>> # Now we set the parameters for the method
    >>> als.setMaxIter(5)\
    >>>    .setSeed(seed)\
    >>>    .setRegParam(0.1)\
    >>>    .<FILL_IN>
    >>> 
    >>> # Now let's compute an evaluation metric for our test dataset
    >>> from pyspark.ml.evaluation import RegressionEvaluator
    >>> 
    >>> # Create an RMSE evaluator using the label and predicted columns
    >>> reg_eval = RegressionEvaluator(predictionCol="prediction", labelCol="rating", metricName="rmse")
    >>> 
    >>> tolerance = 0.03
    >>> ranks = [4, 8, 12]
    >>> errors = [0, 0, 0]
    >>> models = [0, 0, 0]
    >>> err = 0
    >>> min_error = float('inf')
    >>> best_rank = -1
    >>> for rank in ranks:
    >>>   # Set the rank here:
    >>>   als.<FILL_IN>
    >>>   # Create the model with these parameters.
    >>>   model = als.fit(training_df)
    >>>   # Run the model to create a prediction. Predict against the validation_df.
    >>>   predict_df = model.<FILL_IN>
    >>>   
    >>>   # Remove NaN values from prediction (due to SPARK-14489)
    >>>   predicted_ratings_df = predict_df.filter(predict_df.prediction != float('nan'))
    >>>       
    >>>   # Run the previously created RMSE evaluator, reg_eval, on the predicted_ratings_df DataFrame
    >>>   error = reg_eval.<FILL_IN>
    >>>   errors[err] = error
    >>>   models[err] = model
    >>>   print 'For rank %s the RMSE is %s' % (rank, error)
    >>>   if error < min_error:
    >>>     min_error = error
    >>>     best_rank = err
    >>>   err += 1
    For rank 4 the RMSE is 0.82825406832
    For rank 8 the RMSE is 0.816154128069
    For rank 12 the RMSE is 0.810037726846

    >>> als.setRank(ranks[best_rank])
    >>> print 'The best model was trained with rank %s' % ranks[best_rank]
    >>> my_model = models[best_rank]
    The best model was trained with rank 12

******************************************
Why are we doing our own cross-validation?
******************************************

********************************
Excersie (2c) Testing Your Model
********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#excersie-2c-testing-your-model>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with the appropriate code
    >>> # In ML Pipelines, this next step has a bug that produces unwanted NaN values. We
    >>> # have to filter them out. See https://issues.apache.org/jira/browse/SPARK-14489
    >>> predict_df = my_model.<FILL_IN>
    >>> 
    >>> # Remove NaN values from prediction (due to SPARK-14489)
    >>> predicted_test_df = predict_df.filter(predict_df.prediction != float('nan'))
    >>> 
    >>> # Run the previously created RMSE evaluator, reg_eval, on the predicted_test_df DataFrame
    >>> test_RMSE = <FILL_IN>
    >>> 
    >>> print('The model had a RMSE on the test set of {0}'.format(test_RMSE))
    The model had a RMSE on the test set of 0.809624038485

**********************************
Exercise (2d) Comparing Your Model
**********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-2d-comparing-your-model>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL_IN> with the appropriate code.
    >>> # Compute the average rating
    >>> avg_rating_df = <FILL_IN>
    >>> 
    >>> # Extract the average rating value. (This is row 0, column 0.)
    >>> training_avg_rating = avg_rating_df.collect()[0][0]
    >>> 
    >>> print('The average rating for movies in the training set is {0}'.format(training_avg_rating))
    The average rating for movies in the training set is 3.52547984237

    >>> # Add a column with the average rating
    >>> test_for_avg_df = test_df.withColumn('prediction', <FILL_IN>)
    >>> 
    >>> # Run the previously created RMSE evaluator, reg_eval, on the test_for_avg_df DataFrame
    >>> test_avg_RMSE = <FILL_IN>
    >>> 
    >>> print("The RMSE on the average set is {0}".format(test_avg_RMSE))


########################
Predictions for Yourself
########################

.. code-block:: python

    >>> print 'Most rated movies:'
    >>> print '(average rating, movie name, number of reviews, movie ID)'
    >>> # display(movies_with_500_ratings_or_more.orderBy(movies_with_500_ratings_or_more['average'].desc()).take(50))
    >>> movies_with_500_ratings_or_more.orderBy(movies_with_500_ratings_or_more['average'].desc()).show(n=8,truncate=False)
    Most rated movies:
    (average rating, movie name, number of reviews, movie ID)
    +-----------------+-------------------------------------------+-----+-------+
    |average          |title                                      |count|movieId|
    +-----------------+-------------------------------------------+-----+-------+
    |4.446990499637029|Shawshank Redemption, The (1994)           |63366|318    |
    |4.364732196832306|Godfather, The (1972)                      |41355|858    |
    |4.334372207803259|Usual Suspects, The (1995)                 |47006|50     |
    |4.310175010988133|Schindler's List (1993)                    |50054|527    |
    |4.275640557704942|Godfather: Part II, The (1974)             |27398|1221   |
    |4.2741796572216  |Seven Samurai (Shichinin no samurai) (1954)|11611|2019   |
    |4.271333600779414|Rear Window (1954)                         |17449|904    |
    |4.263182346109176|Band of Brothers (2001)                    |4305 |7502   |
    +-----------------+-------------------------------------------+-----+-------+
    only showing top 8 rows

********************************
Exercise (3a) Your Movie Ratings
********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-3a-your-movie-ratings>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> from pyspark.sql import Row
    >>> my_user_id = 0
    >>> 
    >>> # Note that the movie IDs are the *last* number on each line. A common error was to use the number of ratings as the movie ID.
    >>> my_rated_movies = [
    >>>      <FILL IN>
    >>>      # The format of each line is (my_user_id, movie ID, your rating)
    >>>      # For example, to give the movie "Star Wars: Episode IV - A New Hope (1977)" a five rating, you would add the following line:
    >>>      #   (my_user_id, 260, 5),
    >>> ]
    >>> 
    >>> my_ratings_df = sqlContext.createDataFrame(my_rated_movies, ['userId','movieId','rating'])
    >>> print 'My movie ratings:'
    >>> display(my_ratings_df.limit(10))


*************************************************
Exercise (3b) Add Your Movies to Training Dataset
*************************************************
.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> training_with_my_ratings_df = <FILL IN>
    >>> 
    >>> print ('The training dataset now has %s more entries than the original training dataset' %
    >>>        (training_with_my_ratings_df.count() - training_df.count()))
    The training dataset now has 2 more entries than the original training dataset
    >>> assert (training_with_my_ratings_df.count() - training_df.count()) == my_ratings_df.count()

*********************************************
Exercise (3c) Train a Model with Your Ratings
*********************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-3c-train-a-model-with-your-ratings>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> 
    >>> # Reset the parameters for the ALS object.
    >>> als.setPredictionCol("prediction")\
    >>>    .setMaxIter(5)\
    >>>    .setSeed(seed)\
    >>>    .<FILL_IN>
    >>>    
    >>> # Create the model with these parameters.
    >>> my_ratings_model = als.<FILL_IN>

************************************************************
Exercise (3d) Check RMSE for the New Model with Your Ratings
************************************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-3d-check-rmse-for-the-new-model-with-your-ratings>`__)

.. code-block:: python

    >>> # TODO: Replace <FILL IN> with appropriate code
    >>> my_predict_df = my_ratings_model.<FILL IN>
    >>> 
    >>> # Remove NaN values from prediction (due to SPARK-14489)
    >>> predicted_test_my_ratings_df = my_predict_df.filter(my_predict_df.prediction != float('nan'))
    >>> 
    >>> # Run the previously created RMSE evaluator, reg_eval, on the predicted_test_my_ratings_df DataFrame
    >>> test_RMSE_my_ratings = <FILL IN>
    >>> print('The model had a RMSE on the test set of {0}'.format(test_RMSE_my_ratings))
    The model had a RMSE on the test set of 0.811317254176

**********************************
Exercise (3e) Predict Your Ratings
**********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-3e-predict-your-ratings>`__)

.. code-block:: python

    >>> # Create a list of my rated movie IDs
    >>> my_rated_movie_ids = [x[1] for x in my_rated_movies]
    >>> 
    >>> # Filter out the movies I already rated.
    >>> not_rated_df = movies_df.<FILL_IN>
    >>> 
    >>> # Rename the "ID" column to be "movieId", and add a column with my_user_id as "userId".
    >>> my_unrated_movies_df = not_rated_df.<FILL_IN>
    >>> 
    >>> # Use my_rating_model to predict ratings for the movies that I did not manually rate.
    >>> raw_predicted_ratings_df = my_ratings_model.<FILL_IN>
    >>> 
    >>> predicted_ratings_df = raw_predicted_ratings_df.filter(raw_predicted_ratings_df['prediction'] != float('nan'))

**********************************
Exercise (3f) Predict Your Ratings
**********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs110_lab2_solutions.rst#exercise-3f-predict-your-ratings>`__)

.. code-block:: python

    >>> predicted_with_counts_df = <FILL_IN>
    >>> predicted_highest_rated_movies_df = predicted_with_counts_df.<FILL_IN>
    >>> 
    >>> print ('My 25 highest rated movies as predicted (for movies with more than 75 reviews):')
    >>> predicted_highest_rated_movies_df.<FILL_IN>
    My 25 highest rated movies as predicted (for movies with more than 75 reviews):
    +-------+--------------------+------+----------+------------------+-----+
    |movieID|               title|userID|prediction|           average|count|
    +-------+--------------------+------+----------+------------------+-----+
    |   1210|Star Wars: Episod...|     0| 4.4931936| 4.004622216528961|46839|
    |   1196|Star Wars: Episod...|     0| 4.4817257| 4.188202061218635|45313|
    |   7153|Lord of the Rings...|     0|  4.370755|  4.14238211356367|31577|
    |   4993|Lord of the Rings...|     0|  4.335004| 4.137925065906852|37553|
    |   5952|Lord of the Rings...|     0| 4.3144684| 4.107520546734616|33947|
    |   1356|Star Trek: First ...|     0|  4.278973| 3.664872697164148|19324|
    |   1198|Raiders of the Lo...|     0|  4.138433| 4.219009123455364|43295|
    |   1376|Star Trek IV: The...|     0|  4.122119| 3.494617498854787|13098|
    |   1374|Star Trek II: The...|     0| 4.1175756|3.6956836343044106|15893|
    |   1197|Princess Bride, T...|     0|  4.053096|4.1767323390413065|32586|
    |  33779|Eddie Izzard: Dre...|     0| 4.0350504| 4.033653846153846|  208|
    |   1291|Indiana Jones and...|     0|  4.030114| 4.007592710997442|31280|
    |  69524|Raiders of the Lo...|     0|  3.991203| 3.890557939914163|  233|
    |   1372|Star Trek VI: The...|     0| 3.9851758| 3.303213036273246|10862|
    |   2571|  Matrix, The (1999)|     0| 3.9628763| 4.187185880702848|51334|
    |   4006|Transformers: The...|     0| 3.9442182|3.2378349788434413| 2836|
    |   3612|Slipper and the R...|     0|   3.87641| 3.431159420289855|  138|
    |    589|Terminator 2: Jud...|     0| 3.8694332|3.9319539085828037|52244|
    |  34405|     Serenity (2005)|     0| 3.8414702| 3.993260756868844| 7716|
    | 106642|Day of the Doctor...|     0|  3.826096|  3.91726618705036|  417|
    |    329|Star Trek: Genera...|     0| 3.8223531|3.3296280866535373|26404|
    |  91488| Snowman, The (1982)|     0|  3.812455|3.7756410256410255|   78|
    |    671|Mystery Science T...|     0| 3.8115058|3.6769375884294924| 6361|
    |  27611|Battlestar Galact...|     0| 3.8006465|4.0256588072122055| 2884|
    |  95654|  Geri's Game (1997)|     0| 3.7806861|        3.82421875|  128|
    +-------+--------------------+------+----------+------------------+-----+