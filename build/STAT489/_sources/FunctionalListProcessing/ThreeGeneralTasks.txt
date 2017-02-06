
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

Since this is a common functional pattern, we should construct a general
abstraction.  For this expression, we would want to be able to change the
function ``f`` being mapped and the list ``L``.  The following definition gives
an abstraction for ``map`` (titled ``my_map`` to avoid shadowing the built-in
``map``).

.. ipython:: python

    my_map = lambda func, L: [func(item) for item in L]
    my_map(lambda x: x**2, range(5))

In the above example, the first argument of ``my_map`` is the function (lambda
expression) that will be applied to each element and the second argument is the
sequence to be processed.  Python has a built-in function ``map`` that
generalizes this process.

.. ipython:: python

    out = map(lambda x: x**2, range(5))
    out
    type(out)
    list(out)
    out
    # out has been processed and is now empty
    [x for x in out]
    # We need to reinitialize out to process a second time.
    out = map(lambda x: x**2, range(5))
    [x for x in out]

Like the ``range`` function, ``map`` is *lazy* and must be forced to complete
evaluation using the ``list`` conversion function or another list comprehension.
**It should also be noted that a map can only be processed once.**  If we want
to process a map a second time, it will need to be re-initialized as shown
above.

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

    filtered_L = [x for x in L if predicate(x)]


As with ``map``, we can easily create an abstraction of this pattern.  In this
case, we want to be able to change the predicate function as well as the list
being processed.

.. ipython:: python

    my_filter = lambda pred, L: [x for x in L if pred(x)]
    my_filter(lambda x: x % 2 == 1, range(1,6))

``my_filter`` will iterated though all of the elements of the second argument
``range(1,6)``, applying ``lambda x: x % 2 == 1`` and only keeping the values
which return true.  Python also comes with a built-in, lazy implementation of
``filter``.  As with ``map``, we need to force completion of this process using
the ``list`` conversion function or another list comprehension and the filter
object will be empty after being processed.

.. ipython:: python

    
    out = filter(lambda x: x % 2 == 1, range(1,6))
    out
    type(out)
    list(out)

.. note:: 

    You will probably be initially annoyed at the laziness of ``map`` and
    ``filter``, but there is a very good reason for this feature.   We will
    discuss this advantage in an upcoming section on lazy evaluation in Python.


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
other languages, such as Haskell, this function is called ``foldl`` for *fold
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

It will probably take a while to get used to reading a call to reduce.   You
should think of the first argument as the accumulator update function.  The
reduce will keep updating the accumulator as it processes the list.  Let's step
through the process item by item to illustrate.

First, to make iterating through ``L`` one item at a time, we construct and
*iterator* for L using the ``iter`` function called ``iter_L``.  Then the next
element of ``L`` is acquired by applying ``next`` to ``iter_L``.  We start by
setting the accumulator ``acc`` to the initial value.  Then ``acc`` is updated
using the current value of the accumulator and the next element in the list.

.. ipython:: python

    L = [1,2,3,4]
    iter_L = iter(L)
    init = 0
    f = lambda a, i: a + i**2

    acc = 0
    current_item = next(iter_L)
    current_item
    acc = f(acc, current_item)
    acc

This process is continued until all of the elements of the list have been
processed (from left to right).

.. ipython:: python

    current_item = next(iter_L)
    current_item
    acc = f(acc, current_item)
    acc
    current_item = next(iter_L)
    current_item
    acc = f(acc, current_item)
    acc
    current_item = next(iter_L)
    current_item
    acc = f(acc, current_item)
    acc

With some practice, you will be able to think about reducing a list to a value
using this high level abstraction (and will (almost) never need to write the
accumulator pattern again!)

``map``, ``filter`` and ``reduce`` all take functions as arguments.
Consequently, these function are considered *higher order functions*.  We will
explore higher-order functions in the next section.
