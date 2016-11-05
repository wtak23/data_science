cs120 Lab - Math_review
"""""""""""""""""""""""
https://github.com/spark-mooc/mooc-setup/raw/master/cs120_lab1a_math_review.dbc

.. important:: 

  This is an actual homework program submitted to EdX. To adhere to the honor code, 
  the ``<FILL IN>`` is kept in my personal private `github repos <https://github.com/wtak23/private_repos/blob/master/cs105_lab2_solutions.rst>`__.

.. contents:: `Contents`
   :depth: 2
   :local:

.. rubric:: During this lab we will cover:

- Part 1: Math review
- Part 2: NumPy
- Part 3: Additional NumPy and Spark linear algebra
- Part 4: Python lambda expressions

.. note:: Too basic...skipped noting...

###########
Math review
###########

********************************************
Exercise (1a) Scalar multiplication: vectors
********************************************

.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Manually calculate your answer and represent the vector as a list of integers.
    # For example, [2, 4, 8].
    vectorX = <FILL IN>
    vectorY = <FILL IN>

**************************************************
Exercise (1b) Element-wise multiplication: vectors
**************************************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Manually calculate your answer and represent the vector as a list of integers.
    z = <FILL IN>

*************************
Exercise (1c) Dot product
*************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Manually calculate your answer and set the variables to their appropriate integer values.
    c1 = <FILL IN>
    c2 = <FILL IN>

***********************************
Exercise (1d) Matrix multiplication
***********************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Represent matrices as lists within lists. For example, [[1,2,3], [4,5,6]] represents a matrix with
    # two rows and three columns. Use integer values.
    matrixX = <FILL IN>
    matrixY = <FILL IN>

#####
NumPy
#####
***********************************
Exercise (2a) Scalar multiplication
***********************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Create a numpy array with the values 1, 2, 3
    simpleArray = <FILL IN>
    # Perform the scalar product of 5 and the numpy array
    timesFive = <FILL IN>
    print 'simpleArray\n{0}'.format(simpleArray)
    print '\ntimesFive\n{0}'.format(timesFive)

*********************************************************
Exercise (2b) Element-wise multiplication and dot product
*********************************************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    # Create a ndarray based on a range and step size.
    u = np.arange(0, 5, .5)
    v = np.arange(5, 10, .5)

    elementWise = <FILL IN>
    dotProduct = <FILL IN>
    print 'u: {0}'.format(u)
    print 'v: {0}'.format(v)
    print '\nelementWise\n{0}'.format(elementWise)
    print '\ndotProduct\n{0}'.format(dotProduct)

*************************
Exercise (2c) Matrix math
*************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    from numpy.linalg import inv

    A = np.matrix([[1,2,3,4],[5,6,7,8]])
    print 'A:\n{0}'.format(A)
    # Print A transpose
    print '\nA transpose:\n{0}'.format(A.T)

    # Multiply A by A transpose
    AAt = <FILL IN>
    print '\nAAt:\n{0}'.format(AAt)

    # Invert AAt with np.linalg.inv()
    AAtInv = <FILL IN>
    print '\nAAtInv:\n{0}'.format(AAtInv)

    # Show inverse times matrix equals identity
    # We round due to numerical precision
    print '\nAAtInv * AAt:\n{0}'.format((AAtInv * AAt).round(4))

#########################################
Additional NumPy and Spark linear algebra
#########################################

********************
Exercise (3a) Slices
********************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    features = np.array([1, 2, 3, 4])
    print 'features:\n{0}'.format(features)

    # The last three elements of features
    lastThree = <FILL IN>

    print '\nlastThree:\n{0}'.format(lastThree)

***************************************
Exercise (3b) Combining ndarray objects
***************************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    zeros = np.zeros(8)
    ones = np.ones(8)
    print 'zeros:\n{0}'.format(zeros)
    print '\nones:\n{0}'.format(ones)

    zerosThenOnes = <FILL IN>   # A 1 by 16 array
    zerosAboveOnes = <FILL IN>  # A 2 by 8 array

    print '\nzerosThenOnes:\n{0}'.format(zerosThenOnes)
    print '\nzerosAboveOnes:\n{0}'.format(zerosAboveOnes)

***********************************
Exercise (3c) PySpark's DenseVector
***********************************
.. code-block:: python

    from pyspark.mllib.linalg import DenseVector
    # TODO: Replace <FILL IN> with appropriate code
    numpyVector = np.array([-3, -4, 5])
    print '\nnumpyVector:\n{0}'.format(numpyVector)

    # Create a DenseVector consisting of the values [3.0, 4.0, 5.0]
    myDenseVector = <FILL IN>
    # Calculate the dot product between the two vectors.
    denseDotProduct = <FILL IN>

    print 'myDenseVector:\n{0}'.format(myDenseVector)
    print '\ndenseDotProduct:\n{0}'.format(denseDotProduct)


#########################
Python lambda expressions
#########################

*********************************************
Exercise (4a) Lambda is an anonymous function
*********************************************
.. code-block:: python

    # Example function
    def addS(x):
        return x + 's'
    print type(addS)
    print addS
    print addS('cat')

    # As a lambda
    addSLambda = lambda x: x + 's'
    print type(addSLambda)
    print addSLambda
    print addSLambda('cat')

    # TODO: Replace <FILL IN> with appropriate code
    # Recall that: "lambda x, y: x + y" creates a function that adds together two numbers
    multiplyByTen = lambda x: <FILL IN>
    print multiplyByTen(5)

    # Note that the function still shows its name as <lambda>
    print '\n', multiplyByTen

*****************************************
Exercise (4b) lambda fewer steps than def
*****************************************
.. code-block:: python

    # Code using def that we will recreate with lambdas
    def plus(x, y):
        return x + y

    def minus(x, y):
        return x - y

    functions = [plus, minus]
    print functions[0](4, 5)
    print functions[1](4, 5)


    > 

    # TODO: Replace <FILL IN> with appropriate code
    # The first function should add two values, while the second function should subtract the second
    # value from the first value.
    lambdaFunctions = [lambda <FILL IN> ,  lambda <FILL IN>]
    print lambdaFunctions[0](4, 5)
    print lambdaFunctions[1](4, 5)

*****************************************
Exercise (4c) Lambda expression arguments
*****************************************
.. code-block:: python

    # Examples.  Note that the spacing has been modified to distinguish parameters from tuples.

    # One-parameter function
    a1 = lambda x: x[0] + x[1]
    a2 = lambda (x0, x1): x0 + x1
    print 'a1( (3,4) ) = {0}'.format( a1( (3,4) ) )
    print 'a2( (3,4) ) = {0}'.format( a2( (3,4) ) )

    # Two-parameter function
    b1 = lambda x, y: (x[0] + y[0], x[1] + y[1])
    b2 = lambda (x0, x1), (y0, y1): (x0 + y0, x1 + y1)
    print '\nb1( (1,2), (3,4) ) = {0}'.format( b1( (1,2), (3,4) ) )
    print 'b2( (1,2), (3,4) ) = {0}'.format( b2( (1,2), (3,4) ) )

    # TODO: Replace <FILL IN> with appropriate code
    # Use both syntaxes to create a function that takes in a tuple of two values and swaps their order
    # E.g. (1, 2) => (2, 1)
    swap1 = lambda x: <FILL IN>
    swap2 = lambda (x0, x1): <FILL IN>
    print 'swap1((1, 2)) = {0}'.format(swap1((1, 2)))
    print 'swap2((1, 2)) = {0}'.format(swap2((1, 2)))

    # Using either syntax, create a function that takes in a tuple with three values and returns a tuple
    # of (2nd value, 3rd value, 1st value).  E.g. (1, 2, 3) => (2, 3, 1)
    swapOrder = <FILL IN>
    print 'swapOrder((1, 2, 3)) = {0}'.format(swapOrder((1, 2, 3)))

    # Using either syntax, create a function that takes in three tuples each with two values.  The
    # function should return a tuple with the values in the first position summed and the values in the
    # second position summed. E.g. (1, 2), (3, 4), (5, 6) => (1 + 3 + 5, 2 + 4 + 6) => (9, 12)
    sumThree = <FILL IN>
    print 'sumThree((1, 2), (3, 4), (5, 6)) = {0}'.format(sumThree((1, 2), (3, 4), (5, 6)))

************************************************
Exercise (4d) Restrictions on lambda expressions
************************************************

************************************
Exercise (4e) Functional programming
************************************
.. code-block:: python

    # TODO: Replace <FILL IN> with appropriate code
    dataset = FunctionalWrapper(range(10))

    # Multiply each element by 5
    mapResult = dataset.map(<FILL IN>)
    # Keep the even elements
    # Note that "x % 2" evaluates to the remainder of x divided by 2
    filterResult = dataset.filter(<FILL IN>)
    # Sum the elements
    reduceResult = dataset.reduce(<FILL IN>)

    print 'mapResult: {0}'.format(mapResult)
    print '\nfilterResult: {0}'.format(filterResult)
    print '\nreduceResult: {0}'.format(reduceResult)

***************************
Exercise (4f) Composability
***************************
.. code-block:: python

    # Example of a multi-line expression statement
    # Note that placing parentheses around the expression allows it to exist on multiple lines without
    # causing a syntax error.
    (dataset
     .map(lambda x: x + 2)
     .reduce(lambda x, y: x * y))

    # TODO: Replace <FILL IN> with appropriate code
    # Multiply the elements in dataset by five, keep just the even values, and sum those values
    finalSum = <FILL IN>
    print finalSum