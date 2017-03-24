..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Lazy Iteration
==============

We have already seen some Python expressions that exhibit lazy evaluation,
including ``range``, ``map`` and ``filter``. 

.. ipython:: python

    range(4)
    map(lambda x: x**2, range(5))
    filter(lambda x: x % 2 == 1, range(20))

Each of these object will hold off evaluation as long as possible.  In this
section, we will show you other methods for constructing your own lazy
constructs and discuss the advantage of chaining together lazy expressions.

Generator Expressions
---------------------

The core lazy type in Python is the *generator*.  The easiest way to construct a
lazy expression is using the **generator expression**, which has the same syntax
as a list comprehension, except that it is surrounded by parentheses. 

.. figure:: Figures/generator_expression.png
    :alt: The generator expression

    ..

    The syntax for the generator function is the same as that of a list
    comprehension, except being delimited by parentheses.  The resulting object will
    hold off computing each item until evaluation is forced.

For a first example, let's write the generator expression of squaring all of the
odd values in a sequence.

.. ipython:: python

    g = (item**2 for item in range(5) if item % 2 == 1)
    g

Notice that evaluating the generator doesn't produce the sequence.  We can force
the evaluation of the next item in the sequence using the ``next`` function.

.. ipython:: python

    next(g)
    next(g)
    next(g)

By design, the generator will throw an exception when it has completed the
sequence, which can be caught by a ``try-except`` block to determine the end of
the sequence.  In practice, this exception does not surface, as we process
generators in loops, comprehensions, or other lazy constructs like ``map`` and
``filter``.  Each of these techniques catches the termination exception behind
the scenes so that our code can successfully complete.

Note that a generator is a **single-use sequence** and must be reinitialized
before attempting to iterate a second time.


.. ipython:: python

    g = (item**2 for item in range(5) if item % 2 == 1)
    g
    x = list(g)
    x
    y = list(g)
    y
    g = (item**2 for item in range(5) if item % 2 == 1)
    z = list(g)
    z

Consequently, we need to process that sequences in one pass.  In particular, if
we want to reduce the sequence to a number of statistics, we will need to
compute all these statistics simultaneously.  

To illustrate processing a lazy sequence in we will return to the quiz score
example from previous chapters.  Recall that we have information on students
quiz scores stored in a flat file, with each line containing the students name
followed by the quiz scores.  Recall that our task is to return each students
name and average quiz score.

To lazily read a file in line by line, we use ``with_iter`` from the
``more_itertools`` library. This sequence will give us each line of the file,
one at a time without having to keep them all in memory at once.

.. ipython:: python

    file_iter = with_iter(open('studentdata.csv'))

Now we need to pass this lazy sequence through another generator expression to
split each line into words.  As seen in a previous section, this can be
accomplished using ``map``.

.. ipython:: python

    words = map(lambda line: line.split(), file_iter)

In our last attempt at this probem, we used a dictionary to hold the information
for each student.  This required use to hold all the information in memory at
the same time, which was fine for this small example.  To illustrate performing
this task in a lazy manner, we will need to compute all of the statistics on
each line as it passes through the stream.  This will be accomplished using
reduce to compute three pieces of information simultaneously: the students name,
the students total, and the students number of quizzes.


.. ipython:: python

    from toolz.curried import first, drop, compose
    rest = compose(list, drop(1))
    scores = {first(line):rest(line) for line in words}
    scores

We wish to compute the average quiz score. To do this we will ``map`` in to all
of the values using ``valmap``.  Then we need to ``reduce`` the scores to the
average.  While this could be done with ``reduce``, it is cleaner to define a
``mean`` function using ``sum`` and ``len``.  Unfortunately, this approach to
computing the mean doesn't work with lazy contructs like ``map``, meaning we
either need to cast all of the maps to lists or use ``reduce`` to count the
number of elements.  We choose to latter option.

.. ipython:: python

    from functools import reduce
    from toolz import valmap, compose
    from toolz.curried import map
    sum_count = lambda L: reduce(lambda a, i: (get(0, a) + i, get(1, a) + 1), L, (0, 0))
    div_sum_count = lambda tup: get(0, tup)/get(1, tup)
    mean = compose(div_sum_count,sum_count)
    scores = valmap(map(int), scores)
    scores = valmap(mean, scores)
    scores


Did you notice the ``pipe`` pattern in the two lines that start with ``scores
=``?  Let's clean up this part of the code with ``pipe``.

.. ipython:: python

    from toolz import pipe
    from toolz.curried import valmap
    scores = pipe(scores, valmap(map(int)), valmap(mean))
    scores

As we have seen with a sequence of maps, we can compose a sequence of value maps
into one value map with composed inner functions.  Keep in mind that ``compose``
applies functions from right to left, so we will need to reverse the order.

.. ipython:: python

    from toolz import pipe
    from toolz.curried import valmap
    scores = pipe(scores, valmap(compose(mean, map(int))))
    scores

The advantage of lazy sequence evaluation
-----------------------------------------

The primary advantage of using generator expressions to process sequences comes
from the fact that chaining together generators preserves the lazy evaluation.
For example, suppose that we want to compute the distance to some point
:math:`(a, b)` for a series of points.  One way to approach this problem is to
attack it in a series of small operations.

.. ipython:: python

    a, b = (3, 5)
    points = ((i, j) for i, j  in [(0, 0), (1, 1), (2, 2)])
    dist_along_axes = ((i - a, j - b) for i, j in points)
    sum_sqr_dist = ( d1**2 + d2**2 for d1, d2 in dist_along_axes)
    dist_to_ab = ( sqr_dist**(0.5) for sqr_dist in sum_sqr_dist)

    next(dist_to_ab)
    next(dist_to_ab)
    next(dist_to_ab)

Under casual inspection, it will appear that we have iterated over the points 4
times, one for each comprehension.  **The key feature to note is that each call
to next gives the complete solution for that point without forcing the
computation for the next point. This is true regardless of how many generators
we chain together!** In reality each point is completely processed at once, as
each sequence is lazy and waits to complete each calculation until the last
moment.  Consequently, the chain of generators will each compute the next value
and pass it along in sequence.  This is a very powerful *and efficient* approach
to composing operations on sequences, because we only need to hold one point in
memory at a time.

.. todo:: Add the image for eager evaluation

Contrast this with a solution that uses list comprehensions.  Each comprehension
is *eager* to complete its operation and this will result in the entire sequence
being processed before we can start computation on the next sequence.

.. ipython:: python

    a, b = (3, 5)
    points = [(i, j) for i, j  in [(0, 0), (1, 1), (2, 2)]]
    points
    dist_along_axes = [(i - a, j - b) for i, j in points]
    dist_along_axes
    sum_sqr_dist = [d1**2 + d2**2 for d1, d2 in dist_along_axes]
    sum_sqr_dist
    dist_to_ab = [sqr_dist**(0.5) for sqr_dist in sum_sqr_dist]
    dist_to_ab

.. todo:: Add an image for lazy evaluation

In constrast to the solution that used generators, the last batch of code
illustrates that each comprehension has completed it's computation before the
next operation.  Consequently each sequence must be held in memory
simultaneously.  If the data is very large, this can lead to problems with
memory usage and disk access.  In fact, "Big Data" problems typically involve
more data than can be held in the memory of any one machine.  Using lazy
evaluation gives our first solution to this problem by allowing us to process
the data incrementally without ever needing all of it in memory at one time.


More Complicated Generator Expressions
--------------------------------------

All of the tricks that you learned about list comprehensions will work with
generator expressions as well, be it nesting list comprehensions or including
multiple sequence expression.

.. ipython:: python

    g = (i*j for i in range(5) for j in range(i,5))
    g
    list(g)

The only caveat is that next generators are **very lazy** and can be difficult
to force to completion.  In this next example, this is accomplished by
mapping the ``list`` conversion function unto each embedded lazy sequence.


.. ipython:: python

    g = ((i*j for j in range(5)) for i in range(5))
    table = list(g)
    table
    mapped_table = list(map(list, table))
    mapped_table
    L = [[i*j for j in range(5)] for i in range(5)]
    L

**That answer is wrong! (or at least unexpected)**  In the last attempt, I
messed up by completing the outer generator without completing the inner
loops.  Therefore the value of ``i`` was stuck at the last generated value.
The correct way to resolve this nested structure is to process all the
sequences simulaneously as follows.

.. ipython:: python

    g = ((i*j for j in range(5)) for i in range(5))
    mapped_table = list(map(list, g))
    mapped_table

**Main Takeaway:** Processing nested, single-use lazy structures can be
tricky and return unexpected results depending on the order of execution.


Generator Functions
-------------------

A more robust method of creating generators is using the ``yield`` and/or
``yield from`` statements in a function definition.  


The ``yield`` statement
~~~~~~~~~~~~~~~~~~~~~~~

The ``yield`` statement is used to yield the next value in the lazy sequence and
tells Python that our function is really a generator.

.. ipython:: python

    def f(x):
        """ a function """
        return x**2

    def g(x):
        """ A generator """
        yield x**2

When we call a regular function like ``f``, the value is result is immediately
returned.

.. ipython:: python

    type(f)
    y = f(2)
    y

On the other hand, a call to a generator will yield a lazy generator object that
requires a call to ``next`` before it will return a value.

.. ipython:: python

    type(g)
    y = g(2)
    y
    next(y)

Generators can include any number of ``yield`` statements and will halt
execution at each statement, waiting for a request for the ``next`` value.

.. ipython:: python

    def many_yields(x):
        """ a generator with multiple yield statements """
        y = x**2
        yield y
        z = y + 2
        yield z
        yield "Awesome"

.. ipython:: python

    g = many_yields(2)
    next(g)
    next(g)
    next(g)
    next(g)

Notice that the generator captures and maintains the start of the body inbetween
calls to next.  For example, ``many_yields`` kept the value of ``y`` so that it
could be later used to compute ``z``.  As with generator expressions, any
``next`` calls beyond the last ``yield`` will throw an exception.

Finally, note that we can use comprehensions (list or generator) to process a
generator.  In this case, Python takes care of catching the ``StopIteration``
exception.

.. ipython:: python

    [x for x in many_yields(2)]

The ``yield from`` statement
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes we want to yield values from some other sequence.  In this case, we
can use the ``yield from`` statement, which automates the process of iterating
through the sequence, yielding one item at a time in a lazy fashion.

.. ipython:: python

    def g(L):
        yield from L

.. ipython:: python

    y = g([1,2,3])
    y
    type(y)
    next(y)
    next(y)
    next(y)

You can combine any combination of ``yield`` and ``yield from`` statements.

.. ipython:: python

    def g(L):
        yield "Wait for it"
        yield "Here it comes..."
        yield "...any second now..."
        yield from L
        yield "So there you go"
        yield "Enjoy!"

.. ipython:: python

    [x for x in g([1,2,3])]


.. todo:: A multiple choice about way to force completion of a generator
.. todo:: A few multiple choices questions guessing the output of various generators

.. note::

    Generator expressions also can used a ``return`` statement, but this
    immediately throws a ``StopIteration`` exception.  The main purpose of this
    statement in a generator is to control when a generated sequence halts.

Coroutines
----------

Generators are a form of one-way lazy evaluation. Once created they only return
items and can no longer receive values.  Python has another lazy structure that
can be used to pass values back and forth in a lazy way: a **coroutine**.

The keyword ``yield`` is again used to create a coroutine, but this time using
it in an assignment-like statement.  This assignment statement signifies both
the yielding of the next value and acquisition of the next value.



.. ipython:: python

    def coroutine(s):
        s = s.lower() 
        s = yield s
        s = s.lower() 
        s = yield s
        s = 3*s.upper() 
        s = yield s

As with generators, values are pulled from a coroutine using ``next``.  A
coroutine comes with a method ``send`` that is used to pass it the next value.

.. ipython:: python

    co = coroutine("Hi ")
    next(co)
    co.send("there ")
    co.send("Bob!")

.. todo:: Add a section on processing large data sets

.. todo:: Add a section on reduceby

.. todo:: Add a section on join
