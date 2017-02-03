
Three General Tasks
===================

When processing a sequence of data, problems can frequency be solved using a
combination of three general operations: *map*, *filter* and *reduce*.  Many of
the examples from Chapter 4 can be framed in this light.

A **map** is the operation of applying or *mapping* a function to each element
of a list.  An example would be squaring all the elements in a list.

.. ipython:: python

    L = [1,2,3,4,5]
    sqr = lambda x: x**2
    sqr_L = [sqr(x) for x in L]
    sqr_L

In fact, the form of applying a map with a list comprehension will always have
the following form shown below for some function ``f``.

.. sourcecode:: python

    mapped_L = [f(x) for x in L]

A **filter** is the operation of *filtering* the list to only include values
that fit some condition.  For example, we would filter out all of the odd number
from a list of numbers.

.. ipython:: python

    L = [1,2,3,4,5]
    is_odd = lambda x: x %% 2 == 1
    sqr_L = [x for x in L is_odd(x)]
    sqr_L

Once again, the basic form of a filter is easy to express in the form of a list
comprehension.  Let ``predicate`` be a Boolean function that checks the
condition by which we filter.  Then a filter operation can be expressed as
follows.

.. sourcecode:: python

    filtered_L = [x for x in L predicate(x)]

.. note::  

    Since map and filter can be easily expressed with comprehensions, we
    will not focus on the recursive solutions to these problems.  For a fun and
    thorough introduction to recursion, including examples of map and filter, you
    should consult `**The Little Schemer** by Friedman and Felleisen
    <https://mitpress.mit.edu/books/little-schemer>`_.

The third general operation performed on lists is a reduction, which **reduces**
a list to a value.  Simple reductions can be performed using a list
comprehension in combination with one of Python's built-in reducers like
``sum``, ``len``, ``any``, ``all``, ``max`` and ``min``.  For example, we can
count the number of odd values in a list by combining a filter with the ``len``
reducer function.

.. ipython:: python

    L = [1,2,3,4,5]
    is_odd = lambda x: x %% 2 == 1
    num_odd = len([x for x in L is_odd(x)])
    num_odd

This action *reduced* the list to a value, namely the number of odd entries.
Furthermore, this example illustrates how we can combine these basic operations
of map, filter and reduce to complete a task.  In this case we first *filter*
out the odd values and then *reduce* that list to the length of the list.

While map and filter are easily represented using list comprehensions, we have
had to rely on Python built-in functions to reduce lists to values.  In general,
we will need to look for a more general solution to these problems and the
standard functional approach is through recursion.  

We will investigate recursion in the upcoming chapters, but first we look at
Python functions in more detail.
