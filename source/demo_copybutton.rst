Copy-button Demo
""""""""""""""""

>>> def func(x, sign=1.0):
...     """ Objective function """
...     return sign*(2*x[0]*x[1] + 2*x[0] - x[0]**2 - 2*x[1]**2)

>>> def func_deriv(x, sign=1.0):
...     """ Derivative of objective function """
...     dfdx0 = sign*(-2*x[0] + 2*x[1] + 2)
...     dfdx1 = sign*(2*x[0] - 4*x[1])
...     return np.array([ dfdx0, dfdx1 ])



.. code-block:: python
    :linenos:

    >>> import numpy as np
    >>> A = np.mat('[1 2;3 4]')
    >>> A
    matrix([[1, 2],
            [3, 4]])
    >>> A.I
    matrix([[-2. ,  1. ],
            [ 1.5, -0.5]])
    >>> b = np.mat('[5 6]')
    >>> b
    matrix([[5, 6]])
    >>> b.T
    matrix([[5],
            [6]])
    >>> A*b.T
    matrix([[17],
            [39]])

.. code-block:: python

    >>> import numpy as np
    >>> A = np.mat('[1 2;3 4]')
    >>> A
    matrix([[1, 2],
            [3, 4]])
    >>> A.I
    matrix([[-2. ,  1. ],
            [ 1.5, -0.5]])
    >>> b = np.mat('[5 6]')
    >>> b
    matrix([[5, 6]])
    >>> b.T
    matrix([[5],
            [6]])
    >>> A*b.T
    matrix([[17],
            [39]])

>>> import numpy as np
>>> A = np.mat('[1 2;3 4]')
>>> A
matrix([[1, 2],
        [3, 4]])
>>> A.I
matrix([[-2. ,  1. ],
        [ 1.5, -0.5]])
>>> b = np.mat('[5 6]')
>>> b
matrix([[5, 6]])
>>> b.T
matrix([[5],
        [6]])
>>> A*b.T
matrix([[17],
        [39]])


.. admonition:: Example

   A 2-dimensional array of size 2 x 3, composed of 4-byte integer
   elements:

   >>> x = np.array([[1, 2, 3], [4, 5, 6]], np.int32)
   >>> type(x)
   <type 'numpy.ndarray'>
   >>> x.shape
   (2, 3)
   >>> x.dtype
   dtype('int32')

   The array can be indexed using Python container-like syntax:

   >>> # The element of x in the *second* row, *third* column, namely, 6.
   >>> x[1, 2]

   For example :ref:`slicing <arrays.indexing>` can produce views of
   the array:

   >>> y = x[:,1]
   >>> y
   array([2, 5])
   >>> y[0] = 9 # this also changes the corresponding element in x
   >>> y
   array([9, 5])
   >>> x
   array([[1, 9, 3],
          [4, 5, 6]])


>>> a = 1
1