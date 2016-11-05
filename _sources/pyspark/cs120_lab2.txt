cs120 - Linear Regression with DataFrames
"""""""""""""""""""""""""""""""""""""""""
https://github.com/spark-mooc/mooc-setup/raw/master/cs120_lab2_linear_regression_df.dbc

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:

.. rubric:: During this lab we will cover:

##########################################
Part 1: Read and parse the initial dataset
##########################################
***************************
1a) Load and check the data
***************************

.. code-block:: python

    # load testing library
    from databricks_test_helper import Test
    import os.path
    file_name = os.path.join('databricks-datasets', 'cs190', 'data-001', 'millionsong.txt')

    raw_data_df = sqlContext.read.load(file_name, 'text')

(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#a-load-and-check-the-data>`__)

.. code-block:: python

    >>> num_points = <FILL IN>
    >>> print num_points
    6724
    >>> sample_points = <FILL IN>
    >>> print sample_points
    [Row(value=u'2001.0,0.884123733793,0.610454259079,0.600498416968,0.474669212493,0.247232680947,0.357306088914,0.344136412234,0.339641227335,0.600858840135,0.425704689024,0.60491501652,0.419193351817'), Row(value=u'2001.0,0.854411946129,0.604124786151,0.593634078776,0.495885413963,0.266307830936,0.261472105188,0.506387076327,0.464453565511,0.665798573683,0.542968988766,0.58044428577,0.445219373624'), Row(value=u'2001.0,0.908982970575,0.632063159227,0.557428975183,0.498263761394,0.276396052336,0.312809861625,0.448530069406,0.448674249968,0.649791323916,0.489868662682,0.591908113534,0.4500023818'), Row(value=u'2001.0,0.842525219898,0.561826888508,0.508715259692,0.443531142139,0.296733836002,0.250213568176,0.488540873206,0.360508747659,0.575435243185,0.361005878554,0.678378718617,0.409036786173'), Row(value=u'2001.0,0.909303285534,0.653607720915,0.585580794716,0.473250503005,0.251417011835,0.326976795524,0.40432273022,0.371154511756,0.629401917965,0.482243251755,0.566901413923,0.463373691946')]


**********************
1b) Using LabeledPoint
**********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#b-using-labeledpoint>`__)

.. code-block:: python

    from pyspark.mllib.regression import LabeledPoint
    import numpy as np

    from pyspark.sql import functions as sql_functions

    def parse_points(df):
        """Converts a DataFrame of comma separated unicode strings into a DataFrame of `LabeledPoints`.

        Args:
            df: DataFrame where each row is a comma separated unicode string. The first element in the string
                is the label and the remaining elements are the features.

        Returns:
            DataFrame: Each row is converted into a `LabeledPoint`, which consists of a label and
                features. To convert an RDD to a DataFrame, simply call toDF().
        """
        <FILL IN>

    parsed_points_df = <FILL IN>
    first_point_features = <FILL IN>
    first_point_label = <FILL IN>

    d = len(first_point_features)

Print results

.. code-block:: python

    >>> parsed_points_df.show(n=3)
    +--------------------+------+
    |            features| label|
    +--------------------+------+
    |[0.884123733793,0...|2001.0|
    |[0.854411946129,0...|2001.0|
    |[0.908982970575,0...|2001.0|
    +--------------------+------+
    >>> print first_point_features, first_point_label
    [0.884123733793,0.610454259079,0.600498416968,0.474669212493,0.247232680947,0.357306088914,0.344136412234,0.339641227335,0.600858840135,0.425704689024,0.60491501652,0.419193351817] 2001.0
    >>> print d
    12

*************************
Visualization 1: Features
*************************
.. code-block:: python

    import matplotlib.pyplot as plt
    import matplotlib.cm as cm

    # takeSample(withReplacement, num, [seed]) randomly selects num elements from the dataset with/without replacement, and has an
    # optional seed parameter that one can set for reproducible results

    data_values = (parsed_points_df
                   .rdd
                   .map(lambda lp: lp.features.toArray())
                   .takeSample(False, 50, 47))

    # You can uncomment the line below to see randomly selected features.  These will be randomly
    # selected each time you run the cell because there is no set seed.  Note that you should run
    # this cell with the line commented out when answering the lab quiz questions.
    # data_values = (parsedPointsDF
    #                .rdd
    #                .map(lambda lp: lp.features.toArray())
    #                .takeSample(False, 50))

    def prepare_plot(xticks, yticks, figsize=(10.5, 6), hideLabels=False, gridColor='#999999',
                     gridWidth=1.0):
        """Template for generating the plot layout."""
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

    # generate layout and plot
    fig, ax = prepare_plot(np.arange(.5, 11, 1), np.arange(.5, 49, 1), figsize=(8,7), hideLabels=True,
                           gridColor='#eeeeee', gridWidth=1.1)
    image = plt.imshow(data_values,interpolation='nearest', aspect='auto', cmap=cm.Greys)
    for x, y, s in zip(np.arange(-.125, 12, 1), np.repeat(-.75, 12), [str(x) for x in range(12)]):
        plt.text(x, y, s, color='#999999', size='10')
    plt.text(4.7, -3, 'Feature', color='#999999', size='11'), ax.set_ylabel('Observation')
    display(fig)

.. image:: /_static/img/cs120_lab2_1.png
    :align: center
    :scale: 100 %

******************
1c) Find the range
******************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#c-find-the-range>`__)

.. code-block:: python

    >>> content_stats = (parsed_points_df
    >>>                  .<FILL IN>)

    >>> min_year = <FILL IN>
    >>> max_year = <FILL IN>

    >>> print min_year, max_year
    1922.0 2011.0

    >>> print content_stats.collect()[0] # an row object
    Row(min(label)=1922.0, max(label)=2011.0)

    >>> content_stats.show()
    +----------+----------+
    |min(label)|max(label)|
    +----------+----------+
    |    1922.0|    2011.0|
    +----------+----------+

****************
1d) Shift labels
****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#d-shift-labels>`__)

.. code-block:: python

    >>> parsed_data_df = parsed_points_df.<FILL IN>
    >>> # View the first point
    >>> print '\n{0}'.format(parsed_data_df.first())
    Row(features=DenseVector([0.8841, 0.6105, 0.6005, 0.4747, 0.2472, 0.3573, 0.3441, 0.3396, 0.6009, 0.4257, 0.6049, 0.4192]), label=79.0)

********************************
Visualization 2: Shifting labels
********************************
.. code-block:: python

    # get data for plot
    old_data = (parsed_points_df
                 .rdd
                 .map(lambda lp: (lp.label, 1))
                 .reduceByKey(lambda x, y: x + y)
                 .collect())
    x, y = zip(*old_data)

    # generate layout and plot data
    fig, ax = prepare_plot(np.arange(1920, 2050, 20), np.arange(0, 150, 20))
    plt.scatter(x, y, s=14**2, c='#d6ebf2', edgecolors='#8cbfd0', alpha=0.75)
    ax.set_xlabel('Year'), ax.set_ylabel('Count')
    display(fig)

.. image:: /_static/img/cs120_lab2_2.png
    :align: center
    :scale: 100 %

.. code-block:: python

    # get data for plot
    new_data = (parsed_points_df
                 .rdd
                 .map(lambda lp: (lp.label, 1))
                 .reduceByKey(lambda x, y: x + y)
                 .collect())
    x, y = zip(*new_data)

    # generate layout and plot data
    fig, ax = prepare_plot(np.arange(0, 120, 20), np.arange(0, 120, 20))
    plt.scatter(x, y, s=14**2, c='#d6ebf2', edgecolors='#8cbfd0', alpha=0.75)
    ax.set_xlabel('Year (shifted)'), ax.set_ylabel('Count')
    display(fig)
    pass

.. image:: /_static/img/cs120_lab2_3.png
    :align: center
    :scale: 100 %


***************************************
1e) Training, validation, and test sets
***************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#e-training-validation-and-test-sets>`__)

.. code-block:: python

    weights = [.8, .1, .1]
    seed = 42
    parsed_train_data_df, parsed_val_data_df, parsed_test_data_df = parsed_data_df.<FILL IN>
    parsed_train_data_df.<FILL IN>
    parsed_val_data_df.<FILL IN>
    parsed_test_data_df.<FILL IN>
    n_train = parsed_train_data_df.<FILL IN>
    n_val = parsed_val_data_df.<FILL IN>
    n_test = parsed_test_data_df.<FILL IN>

Print results

.. code-block:: python

    >>> print n_train, n_val, n_test, n_train + n_val + n_test
    5382 672 670 6724
    >>> print parsed_data_df.count()
    6724

############################################
Part 2: Create and evaluate a baseline model
############################################
*****************
2a) Average label
*****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#a-average-label>`__)

.. code-block:: python

    >>> average_train_year = (parsed_train_data_df
    >>>                         .<FILL IN>)
    >>> print average_train_year
    54.0403195838

***************************
2b) Root mean squared error
***************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#b-root-mean-squared-error>`__)

.. code-block:: python

    from pyspark.ml.evaluation import RegressionEvaluator

    preds_and_labels = [(1., 3.), (2., 1.), (2., 2.)]
    preds_and_labels_df = sqlContext.createDataFrame(preds_and_labels, ["prediction", "label"])

    evaluator = RegressionEvaluator(<FILL IN>)
    def calc_RMSE(dataset):
        """Calculates the root mean squared error for an dataset of (prediction, label) tuples.

        Args:
            dataset (DataFrame of (float, float)): A `DataFrame` consisting of (prediction, label) tuples.

        Returns:
            float: The square root of the mean of the squared errors.
        """
        return evaluator.<FILL IN>

    example_rmse = calc_RMSE(preds_and_labels_df)

Print result

.. code-block:: python

    print example_rmse
    1.29099444874

**************************************
2c) Training, validation and test RMSE
**************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#c-training-validation-and-test-rmse>`__)

.. code-block:: python

    preds_and_labels_train = parsed_train_data_df.<FILL IN>
    preds_and_labels_train_df = sqlContext.createDataFrame(preds_and_labels_train, ["prediction", "label"])
    rmse_train_base = <FILL IN>

    preds_and_labels_val = parsed_val_data_df.<FILL IN>
    preds_and_labels_val_df = sqlContext.createDataFrame(preds_and_labels_val, ["prediction", "label"])
    rmse_val_base = <FILL IN>

    preds_and_labels_test = parsed_test_data_df.<FILL IN>
    preds_and_labels_test_df = sqlContext.createDataFrame(preds_and_labels_test, ["prediction", "label"])
    rmse_test_base = <FILL IN>

Print result

.. code-block:: python

    >>> print 'Baseline Train RMSE = {0:.3f}'.format(rmse_train_base)
    Baseline Train RMSE = 21.430
    >>> print 'Baseline Validation RMSE = {0:.3f}'.format(rmse_val_base)
    Baseline Validation RMSE = 20.918
    >>> print 'Baseline Test RMSE = {0:.3f}'.format(rmse_test_base)
    Baseline Test RMSE = 21.829

*************************************
Visualization 3: Predicted vs. actual
*************************************
.. code-block:: python

    from matplotlib.colors import ListedColormap, Normalize
    from matplotlib.cm import get_cmap
    cmap = get_cmap('YlOrRd')
    norm = Normalize()

    def squared_error(label, prediction):
        """Calculates the squared error for a single prediction."""
        return float((label - prediction)**2)

    actual = np.asarray(parsed_val_data_df
                        .select('label')
                        .collect())
    error = np.asarray(parsed_val_data_df
                       .rdd
                       .map(lambda lp: (lp.label, lp.label))
                       .map(lambda (l, p): squared_error(l, p))
                       .collect())
    clrs = cmap(np.asarray(norm(error)))[:,0:3]

    fig, ax = prepare_plot(np.arange(0, 100, 20), np.arange(0, 100, 20))
    plt.scatter(actual, actual, s=14**2, c=clrs, edgecolors='#888888', alpha=0.75, linewidths=0.5)
    ax.set_xlabel('Predicted'), ax.set_ylabel('Actual')
    display(fig)

.. image:: /_static/img/cs120_lab2_4.png
    :align: center
    :scale: 100 %

.. code-block:: python

    def squared_error(label, prediction):
        """Calculates the squared error for a single prediction."""
        return float((label - prediction)**2)

    predictions = np.asarray(parsed_val_data_df
                             .rdd
                             .map(lambda lp: average_train_year)
                             .collect())
    error = np.asarray(parsed_val_data_df
                       .rdd
                       .map(lambda lp: (lp.label, average_train_year))
                       .map(lambda (l, p): squared_error(l, p))
                       .collect())
    norm = Normalize()
    clrs = cmap(np.asarray(norm(error)))[:,0:3]

    fig, ax = prepare_plot(np.arange(53.0, 55.0, 0.5), np.arange(0, 100, 20))
    ax.set_xlim(53, 55)
    plt.scatter(predictions, actual, s=14**2, c=clrs, edgecolors='#888888', alpha=0.75, linewidths=0.3)
    ax.set_xlabel('Predicted'), ax.set_ylabel('Actual')
    display(fig)

.. image:: /_static/img/cs120_lab2_5.png
    :align: center
    :scale: 100 %

###########################################################################
Part 3: Train (via gradient descent) and evaluate a linear regression model
###########################################################################
********************
3a) Gradient summand
********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#a-gradient-summand>`__)

.. code-block:: python

    from pyspark.mllib.linalg import DenseVector
    def gradient_summand(weights, lp):
        """Calculates the gradient summand for a given weight and `LabeledPoint`.

        Note:
            `DenseVector` behaves similarly to a `numpy.ndarray` and they can be used interchangably
            within this function.  For example, they both implement the `dot` method.

        Args:
            weights (DenseVector): An array of model weights (betas).
            lp (LabeledPoint): The `LabeledPoint` for a single observation.

        Returns:
            DenseVector: An array of values the same length as `weights`.  The gradient summand.
        """
        <FILL IN>

Usage

.. code-block:: python

    >>> example_w = DenseVector([1, 1, 1])
    >>> example_lp = LabeledPoint(2.0, [3, 1, 4])
    >>> # gradient_summand = (dot([1 1 1], [3 1 4]) - 2) * [3 1 4] = (8 - 2) * [3 1 4] = [18 6 24]
    >>> summand_one = gradient_summand(example_w, example_lp)
    >>> print summand_one
    [18.0,6.0,24.0]

    >>> example_w = DenseVector([.24, 1.2, -1.4])
    >>> example_lp = LabeledPoint(3.0, [-1.4, 4.2, 2.1])
    >>> summand_two = gradient_summand(example_w, example_lp)
    >>> print summand_two
    [1.7304,-5.1912,-2.5956]


***********************************
3b) Use weights to make predictions
***********************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#b-use-weights-to-make-predictions>`__)

.. code-block:: python

    def get_labeled_prediction(weights, observation):
        """Calculates predictions and returns a (prediction, label) tuple.

        Note:
            The labels should remain unchanged as we'll use this information to calculate prediction
            error later.

        Args:
            weights (np.ndarray): An array with one weight for each features in `trainData`.
            observation (LabeledPoint): A `LabeledPoint` that contain the correct label and the
                features for the data point.

        Returns:
            tuple: A (prediction, label) tuple. Convert the return type of the label and prediction to a float.
        """
        return <FILL IN>

Usage

.. code-block:: python

    >>> weights = np.array([1.0, 1.5])
    >>> prediction_example = sc.parallelize([LabeledPoint(2, np.array([1.0, .5])),
    >>>                                      LabeledPoint(1.5, np.array([.5, .5]))])
    >>> preds_and_labels_example = prediction_example.map(lambda lp: get_labeled_prediction(weights, lp))
    >>> print preds_and_labels_example.collect()
    [(1.75, 2.0), (1.25, 1.5)]


********************
3c) Gradient descent
********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#c-gradient-descent>`__)

.. code-block:: python

    def linreg_gradient_descent(train_data, num_iters):
        """Calculates the weights and error for a linear regression model trained with gradient descent.

        Note:
            `DenseVector` behaves similarly to a `numpy.ndarray` and they can be used interchangably
            within this function.  For example, they both implement the `dot` method.

        Args:
            train_data (RDD of LabeledPoint): The labeled data for use in training the model.
            num_iters (int): The number of iterations of gradient descent to perform.

        Returns:
            (np.ndarray, np.ndarray): A tuple of (weights, training errors).  Weights will be the
                final weights (one weight per feature) for the model, and training errors will contain
                an error (RMSE) for each iteration of the algorithm.
        """
        # The length of the training data
        n = train_data.count()
        # The number of features in the training data
        d = len(train_data.first().features)
        w = np.zeros(d)
        alpha = 1.0
        # We will compute and store the training error after each iteration
        error_train = np.zeros(num_iters)
        for i in range(num_iters):
            # Use get_labeled_prediction from (3b) with trainData to obtain an RDD of (label, prediction)
            # tuples.  Note that the weights all equal 0 for the first iteration, so the predictions will
            # have large errors to start.
            preds_and_labels_train = <FILL IN>
            preds_and_labels_train_df = sqlContext.createDataFrame(preds_and_labels_train, ["prediction", "label"])
            error_train[i] = calc_RMSE(preds_and_labels_train_df)

            # Calculate the `gradient`.  Make use of the `gradient_summand` function you wrote in (3a).
            # Note that `gradient` should be a `DenseVector` of length `d`.
            gradient = <FILL IN>

            # Update the weights
            alpha_i = alpha / (n * np.sqrt(i+1))
            w -= <FILL IN>
        return w, error_train

Usage

.. code-block:: python

    >>> # create a toy dataset with n = 10, d = 3, and then run 5 iterations of gradient descent
    >>> # note: the resulting model will not be useful; the goal here is to verify that
    >>> # linreg_gradient_descent is working properly
    >>> example_n = 10
    >>> example_d = 3
    >>> example_data = (sc
    >>>                  .parallelize(parsed_train_data_df.take(example_n))
    >>>                  .map(lambda lp: LabeledPoint(lp.label, lp.features[0:example_d])))
    >>> print example_data.take(2)
    [LabeledPoint(59.0, [0.0,0.696269780071,0.395207288435]), LabeledPoint(51.0, [0.146741531091,0.759714452095,0.545925367419])]
   
    >>> example_num_iters = 5
    >>> example_weights, example_error_train = linreg_gradient_descent(example_data, example_num_iters)
    >>> print example_weights
    [ 22.68915382  46.210194    51.74336678]

*******************
3d) Train the model
*******************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#d-train-the-model>`__)

.. code-block:: python

    >>> num_iters = 50
    >>> weights_LR0, error_train_LR0 = linreg_gradient_descent(<FILL IN>)
    >>> 
    >>> preds_and_labels = (parsed_val_data_df
    >>>                       .<FILL IN>)
    >>> preds_and_labels_df = sqlContext.createDataFrame(preds_and_labels, ["prediction", "label"])
    >>> rmse_val_LR0 = calc_RMSE(preds_and_labels_df)
    >>> 
    >>> print 'Validation RMSE:\n\tBaseline = {0:.3f}\n\tLR0 = {1:.3f}'.format(rmse_val_base,
    >>>                                                                        rmse_val_LR0)

*******************************
Visualization 4: Training error
*******************************
.. code-block:: python

    norm = Normalize()
    clrs = cmap(np.asarray(norm(np.log(error_train_LR0))))[:,0:3]

    fig, ax = prepare_plot(np.arange(0, 60, 10), np.arange(2, 6, 1))
    ax.set_ylim(2, 6)
    plt.scatter(range(0, num_iters), np.log(error_train_LR0), s=14**2, c=clrs, edgecolors='#888888', alpha=0.75)
    ax.set_xlabel('Iteration'), ax.set_ylabel(r'$\log_e(errorTrainLR0)$')
    display(fig)

.. image:: /_static/img/cs120_lab2_6.png
    :align: center
    :scale: 100 %

.. code-block:: python

    norm = Normalize()
    clrs = cmap(np.asarray(norm(error_train_LR0[6:])))[:,0:3]

    fig, ax = prepare_plot(np.arange(0, 60, 10), np.arange(17, 22, 1))
    ax.set_ylim(17.8, 21.2)
    plt.scatter(range(0, num_iters-6), error_train_LR0[6:], s=14**2, c=clrs, edgecolors='#888888', alpha=0.75)
    ax.set_xticklabels(map(str, range(6, 66, 10)))
    ax.set_xlabel('Iteration'), ax.set_ylabel(r'Training Error')
    display(fig)

.. image:: /_static/img/cs120_lab2_7.png
    :align: center
    :scale: 100 %

###################################################
Part 4: Train using SparkML and perform grid search
###################################################

********************
4a) LinearRegression
********************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#a-linearregression>`__)

.. code-block:: python

    from pyspark.ml.regression import LinearRegression
    # Values to use when training the linear regression model

    num_iters = 500  # iterations
    reg = 1e-1  # regParam
    alpha = .2  # elasticNetParam
    use_intercept = True  # intercept

    # TODO: Replace <FILL IN> with appropriate code
    lin_reg = LinearRegression(<FILL IN>)
    first_model = lin_reg.fit(parsed_train_data_df)

    # coeffsLR1 stores the model coefficients; interceptLR1 stores the model intercept
    coeffs_LR1 = <FILL IN>
    intercept_LR1 = <FILL IN>
    print coeffs_LR1, intercept_LR1
    #[21.8238800212,27.6186877074,-66.4789086231,54.191182811,-14.2978518435,-47.0287067393,35.1372526918,-20.0165577186,0.737339261177,-3.8022145328,-7.62277095338,-15.9836308238] 64.2456893425


*************
4b) Transform
*************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#b-transform>`__)

.. code-block:: python

    sample_prediction = first_model.<FILL IN>
    display(sample_prediction)

*****************
4c) Evaluate RMSE
*****************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#c-evaluate-rmse>`__)

.. code-block:: python

    >>> val_pred_df = <FILL IN>
    >>> rmse_val_LR1 = <FILL IN>
    >>> 
    >>> print ('Validation RMSE:\n\tBaseline = {0:.3f}\n\tLR0 = {1:.3f}' +
    >>>        '\n\tLR1 = {2:.3f}').format(rmse_val_base, rmse_val_LR0, rmse_val_LR1)
    Validation RMSE:
        Baseline = 20.918
        LR0 = 18.395
        LR1 = 15.313

***************
4d) Grid search
***************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#d-grid-search>`__)

.. code-block:: python

    best_RMSE = rmse_val_LR1
    best_reg_param = reg
    best_model = first_model

    num_iters = 500  # iterations
    alpha = .2  # elasticNetParam
    use_intercept = True  # intercept

    for reg in <FILL IN>:
        lin_reg = LinearRegression(maxIter=num_iters, regParam=reg, elasticNetParam=alpha, fitIntercept=use_intercept)
        model = lin_reg.fit(parsed_train_data_df)
        val_pred_df = model.transform(parsed_val_data_df)

        rmse_val_grid = calc_RMSE(val_pred_df)
        print rmse_val_grid

        if rmse_val_grid < best_RMSE:
            best_RMSE = rmse_val_grid
            best_reg_param = reg
            best_model = model

    rmse_val_LR_grid = best_RMSE

Result

.. code-block:: python

    >>> print ('Validation RMSE:\n\tBaseline = {0:.3f}\n\tLR0 = {1:.3f}\n\tLR1 = {2:.3f}\n' +
    >>>        '\tLRGrid = {3:.3f}').format(rmse_val_base, rmse_val_LR0, rmse_val_LR1, rmse_val_LR_grid)
    15.3134863369
    15.3134859827
    15.3052663831
    Validation RMSE:
        Baseline = 20.918
        LR0 = 18.395
        LR1 = 15.313
        LRGrid = 15.305


*****************************************
Visualization 5: Best model's predictions
*****************************************
.. code-block:: python

    parsed_val_df = best_model.transform(parsed_val_data_df)
    predictions = np.asarray(parsed_val_df
                             .select('prediction')
                             .collect())
    actual = np.asarray(parsed_val_df
                          .select('label')
                          .collect())
    error = np.asarray(parsed_val_df
                         .rdd
                         .map(lambda lp: squared_error(lp.label, lp.prediction))
                         .collect())

    norm = Normalize()
    clrs = cmap(np.asarray(norm(error)))[:,0:3]

    fig, ax = prepare_plot(np.arange(0, 120, 20), np.arange(0, 120, 20))
    ax.set_xlim(15, 82), ax.set_ylim(-5, 105)
    plt.scatter(predictions, actual, s=14**2, c=clrs, edgecolors='#888888', alpha=0.75, linewidths=.5)
    ax.set_xlabel('Predicted'), ax.set_ylabel(r'Actual')
    display(fig)

.. image:: /_static/img/cs120_lab2_8.png
    :align: center
    :scale: 100 %

****************************************
Visualization 6: Hyperparameter heat map
****************************************
.. code-block:: python

    from matplotlib.colors import LinearSegmentedColormap

    # Saved parameters and results, to save the time required to run 36 models
    num_iters = 500
    reg_params = [1.0, 2.0, 4.0, 8.0, 16.0, 32.0]
    alpha_params = [0.0, .1, .2, .4, .8, 1.0]
    rmse_val = np.array([[ 15.317156766552452, 15.327211561989827, 15.357152971253697, 15.455092206273847, 15.73774335576239,
                           16.36423857334287, 15.315019185101972, 15.305949211619886, 15.355590337955194, 15.573049001631558,
                           16.231992712117222, 17.700179790697746, 15.305266383061921, 15.301104931027034, 15.400125020566225,
                           15.824676190630191, 17.045905140628836, 19.365558346037535, 15.292810983243772, 15.333756681057828,
                           15.620051033979871, 16.631757941340428, 18.948786862836954, 20.91796910560631, 15.308301384150049,
                           15.522394576046239, 16.414106221093316, 18.655978799189178, 20.91796910560631, 20.91796910560631,
                           15.33442896030322, 15.680134490745722, 16.86502909075323, 19.72915603626022, 20.91796910560631,
                           20.91796910560631 ]])

    num_rows, num_cols = len(alpha_params), len(reg_params)
    rmse_val = np.array(rmse_val)
    rmse_val.shape = (num_rows, num_cols)

    fig, ax = prepare_plot(np.arange(0, num_cols, 1), np.arange(0, num_rows, 1), figsize=(8, 7), hideLabels=True,
                           gridWidth=0.)
    ax.set_xticklabels(reg_params), ax.set_yticklabels(alpha_params)
    ax.set_xlabel('Regularization Parameter'), ax.set_ylabel('Alpha')

    colors = LinearSegmentedColormap.from_list('blue', ['#0022ff', '#000055'], gamma=.2)
    image = plt.imshow(rmse_val,interpolation='nearest', aspect='auto',
                        cmap = colors)
    display(fig)

.. image:: /_static/img/cs120_lab2_9.png
    :align: center
    :scale: 100 %

.. code-block:: python

    # Zoom into the top left
    alpha_params_zoom, reg_params_zoom = alpha_params[1:5], reg_params[:4]
    rmse_val_zoom = rmse_val[1:5, :4]

    num_rows, num_cols = len(alpha_params_zoom), len(reg_params_zoom)

    fig, ax = prepare_plot(np.arange(0, num_cols, 1), np.arange(0, num_rows, 1), figsize=(8, 7), hideLabels=True,
                           gridWidth=0.)
    ax.set_xticklabels(reg_params_zoom), ax.set_yticklabels(alpha_params_zoom)
    ax.set_xlabel('Regularization Parameter'), ax.set_ylabel('Alpha')

    colors = LinearSegmentedColormap.from_list('blue', ['#0022ff', '#000055'], gamma=.2)
    image = plt.imshow(rmse_val_zoom, interpolation='nearest', aspect='auto',
                        cmap = colors)
    display(fig)

.. image:: /_static/img/cs120_lab2_10.png
    :align: center
    :scale: 100 %

#########################################
Part 5: Add interactions between features
#########################################
**************************
5a) Add 2-way interactions
**************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#a-add-2-way-interactions>`__)

.. code-block:: python

    import itertools

    def two_way_interactions(lp):
        """Creates a new `LabeledPoint` that includes two-way interactions.

        Note:
            For features [x, y] the two-way interactions would be [x^2, x*y, y*x, y^2] and these
            would be appended to the original [x, y] feature list.

        Args:
            lp (LabeledPoint): The label and features for this observation.

        Returns:
            LabeledPoint: The new `LabeledPoint` should have the same label as `lp`.  Its features
                should include the features from `lp` followed by the two-way interaction features.
        """
        <FILL IN>

    print two_way_interactions(LabeledPoint(0.0, [2, 3]))
    #(0.0,[2.0,3.0,4.0,6.0,6.0,9.0])

    # Transform the existing train, validation, and test sets to include two-way interactions.
    # Remember to convert them back to DataFrames at the end.
    train_data_interact_df = <FILL IN>
    val_data_interact_df = <FILL IN>
    test_data_interact_df = <FILL IN>


***************************
5b) Build interaction model
***************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#b-build-interaction-model>`__)

.. code-block:: python

    num_iters = 500
    reg = 1e-10
    alpha = .2
    use_intercept = True

    lin_reg = LinearRegression(maxIter=num_iters, regParam=reg, elasticNetParam=alpha, fitIntercept=use_intercept)
    model_interact = lin_reg.fit(<FILL IN>)
    preds_and_labels_interact_df = model_interact.transform(<FILL IN>)
    rmse_val_interact = calc_RMSE(preds_and_labels_interact_df)

Result

.. code-block:: python

    >>> print ('Validation RMSE:\n\tBaseline = {0:.3f}\n\tLR0 = {1:.3f}\n\tLR1 = {2:.3f}\n\tLRGrid = ' +
    >>>        '{3:.3f}\n\tLRInteract = {4:.3f}').format(rmse_val_base, rmse_val_LR0, rmse_val_LR1,
    >>>                                                  rmse_val_LR_grid, rmse_val_interact)
    Validation RMSE:
        Baseline = 20.918
        LR0 = 18.395
        LR1 = 15.313
        LRGrid = 15.305
        LRInteract = 14.350

*******************************************
5c) Evaluate interaction model on test data
*******************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#c-evaluate-interaction-model-on-test-data>`__)

.. code-block:: python

    >>> preds_and_labels_test_df = model_interact.<FILL IN>
    >>> rmse_test_interact = <FILL IN>
    >>> 
    >>> print ('Test RMSE:\n\tBaseline = {0:.3f}\n\tLRInteract = {1:.3f}'
    >>>        .format(rmse_test_base, rmse_test_interact))
    Test RMSE:
        Baseline = 21.829
        LRInteract = 14.999

**************************************************
5d) Use a pipeline to create the interaction model
**************************************************
(`sol <https://github.com/wtak23/private_repos/blob/master/cs120_lab2_solutions.rst#d-use-a-pipeline-to-create-the-interaction-model>`__)

.. code-block:: python

    from pyspark.ml import Pipeline
    from pyspark.ml.feature import PolynomialExpansion

    num_iters = 500
    reg = 1e-10
    alpha = .2
    use_intercept = True

    polynomial_expansion = PolynomialExpansion(<FILL IN>)
    linear_regression = LinearRegression(maxIter=num_iters, regParam=reg, elasticNetParam=alpha,
                                         fitIntercept=use_intercept, featuresCol='polyFeatures')

    pipeline = Pipeline(stages=[<FILL IN>])
    pipeline_model = pipeline.fit(parsed_train_data_df)

    predictions_df = pipeline_model.transform(parsed_test_data_df)

    evaluator = RegressionEvaluator()
    rmse_test_pipeline = evaluator.evaluate(predictions_df, {evaluator.metricName: "rmse"})

Result

.. code-block:: python

    >>> print('RMSE for test data set using pipelines: {0:.3f}'.format(rmse_test_pipeline))
    RMSE for test data set using pipelines: 14.994
