Other Python Sequence Types
===========================

There are number of modules that add specialized sequence data structures often
useful in certain situations.

* The ``collections`` module from the standard module, which includes
    * ``deque``, a list-like structure which can efficiently append objects to either ends.

      .. ipython:: python

          from collections import deque
          d = deque([1,2,3])
          d.append(4)
          d.appendleft(0)
          d

    * ``nametuple``, a tuple that allows efficient accessing records by name.

* The ``numpy`` numerical library provides
    * arrays and matrices for efficient numerical computations

      .. ipython:: python

          import numpy as np
          v = np.array([1,2,3])
          v
          m = np.matrix([[1,2],[3,4]])
          m

    * functions that can be applied to all elements of a ``numpy`` array.

      .. ipython:: python

          np.cos(v)

* The ``pandas`` library provides
    * data frames similar in construction and usage to the ``data.frame`` from R

      .. ipython:: python

			import pandas as pd
			d = {'one' : pd.Series([1., 2., 3.], index=['a', 'b', 'c']),
				 'two' : pd.Series([1., 2., 3., 4.], index=['a', 'b', 'c', 'd'])}

			df = pd.DataFrame(d)
			df
			pd.DataFrame(d, index=['d', 'b', 'a'])
			pd.DataFrame(d, index=['d', 'b', 'a'], columns=['two', 'three'])

      .. note:: This example was copied from the ``pandas`` documentation.

* The ``pyrsistent`` library provides 
    * persistent and immutable data structures for use in functional programming.
