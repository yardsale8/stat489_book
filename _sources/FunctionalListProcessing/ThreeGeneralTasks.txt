
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

**General Form of a map**

.. sourcecode:: python

    mapped_L = [f(x) for x in L]

A **filter** is the operation of *filtering* the list to only include values
that fit some condition.  For example, we would filter out all of the odd number
from a list of numbers.

.. ipython:: python

    L = [1,2,3,4,5]
    is_odd = lambda x: x % 2 == 1
    odd_L = [x for x in L if is_odd(x)]
    odd_L

Once again, the basic form of a filter is easy to express in the form of a list
comprehension.  Let ``predicate`` be a Boolean function that checks the
condition by which we filter.  Then a filter operation can be expressed as
follows.

**General form of a filter**

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
    is_odd = lambda x: x % 2 == 1
    num_odd = len([x for x in L if is_odd(x)])
    num_odd

This action *reduced* the list to a value, namely the number of odd entries.
Furthermore, this example illustrates how we can combine these basic operations
of map, filter and reduce to complete a task.  In this case we first *filter*
out the odd values and then *reduce* that list to the length of the list.

While map and filter are easily represented using list comprehensions, we have
had to rely on Python built-in functions to reduce lists to values.  In general,
we will need to look for a more general solution to these problems and the
standard functional approach is through recursion.  

Let's look at the imperative solution to a few reduction problems and see if we
can see a pattern.

**Problem 1 - Compute the sum of all the numbers in a list**

.. ipython:: python

    my_list = [1,2,3,4,5]
    def sum_list(L):
        acc = 0
        for item in L:
            acc = acc + item
        return acc


    sum_list(my_list)

**Problem 2 - Join all the strings in a list into one string**

.. ipython:: python

    my_strings = ["a", "b", "c"]
    def join_strings(L):
        acc = L[0]
        for item in L[1:]:
            acc = acc + item
        return acc


    join_strings(my_strings)

**Problem 3 - Take a list of numbers and return a list of cumulative sums**

.. ipython:: python

    my_numbers = [1,2,3,4,5]
    def cumult_sum(L):
        acc = [L[0]]
        for item in L[1:]:
            acc = acc + [acc[-1] + item]
        return acc


    cumult_sum(my_numbers)

First note that ``join_strings`` uses the first entry in the sequence as the
initial value and iterates over the rest of the sequence.  This approach will be
valid with many reduction problems, and will make a nice default for our initial
value.

Each of the solutions shown above are examples of the accumulator pattern.  In
each case, the variable ``acc`` is set to some initial value and then updated as
we iterate though each value.  Also note how very similar the *shape* of the
code is in these examples.  A little refactoring will make this very clear.  We
will modify the code in two ways.  First, the initial value will be made a
parameter of each function.  Second, we will define and use a separate function
to update the accumulator.


**Problem 1 - Compute the sum of all the numbers in a list**

.. ipython:: python

    my_list = [1,2,3,4,5]
    def update(acc, item):
        return acc + item

    def sum_list(L,init):
        acc = init
        for item in L:
            acc = update(acc, item)
        return acc


    sum_list(my_list, 0)

**Problem 2 - Join all the strings in a list into one string**

.. ipython:: python

    my_strings = ["a", "b", "c"]
    def update(acc, item):
        return acc + item


    def join_strings(L, init):
        acc = init
        for item in L:
            acc = update(acc, item)
        return acc


    join_strings(my_strings[1:], my_strings[0])

**Problem 3 - Take a list of numbers and return a list of cumulative sums**

.. ipython:: python

    my_numbers = [1,2,3,4,5]
    def update(acc, item):
        return acc + [acc[-1] + item]


    def cumult_sum(L, init):
        acc = init
        for item in L:
            acc = update(acc, item)
        return acc

    cumult_sum(my_numbers[1:],[my_list[0]])


These three functions look to be identical, but they are all referencing a
different (globally defined) ``update`` function.  Recall that all Python data
are object, including functions.  The final modification we will make, it adding
a parameter for the update function, allowing us to answer all three problems
with one function.  In Python and LISP, this function is know as ``reduce``.  In
other languages, such as HAskell, this function is called ``foldl`` for *fold
from the left*.  In the process of making this last refactor, we will also set
up a default value of init, making sure to iterate through the rest of the list
if using the default.

.. ipython:: python

    my_list = [1,2,3,4,5]
    my_strings = ["a", "b", "c"]
    my_numbers = [1,2,3,4,5]

    def reduce(function, L,init=None):
        if init:
            acc = init
        else:
            acc = L[0]
            L = L[1:]
        for item in L:
            try:
                acc = function(acc, item)
            except:
                print(acc, init, item)
        return acc


    list_sum = reduce(lambda a, i: a+i, my_list)
    list_sum

    my_str = reduce(lambda a, i: a + i, my_strings)
    my_str

    csum = reduce(lambda a, i: a + [a[-1] + i], my_numbers[1:], [my_numbers[0]])
    csum


In reality, we didn't need to write this function, as it is provided in the
standard ``functools`` library.

.. ipython:: python

    from functools import reduce

    reduce(lambda a, i: a + i**2, [1,2,3,4,5], 0)
