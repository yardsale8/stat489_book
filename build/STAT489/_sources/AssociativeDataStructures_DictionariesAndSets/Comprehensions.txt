Dictionary and Set Comprehensions
=================================

We have seen how list comprehensions can used to describe and construct lists
with an expression.  Python has similar syntax for constructing dictionaries and
sets using comprehensions.

The Dictionary Comprehension
----------------------------

The dictionary comprehension uses the following syntax.

.. sourcecode:: python

    dict_comp = {KEY:VAL for VAR in SEQ if COND}

Notice that the dictionary comprehension is similar to a list
comprehension in that it has a ``for`` sequence expression and an optional
``if`` filter.  This comprehension is delimited by braces (``{}``) and
distiguished by the ``KEY:VAL`` key-value pair in the operation expression.

For example, we could construct a dictionary that maps integers to their square
root as follows.

.. ipython:: python

    sqrts = {n:n**0.5 for n in range(5)}
    sqrts

This approach is useful for storing the output for expensive operations,
allowing the values to be looked up quickly without recomputing values.

.. note::

    We expand on this approach to saving expensive operations when discussing
    ``memiozation``.

The Set Comprehension
---------------------

The set comprehension looks very similar to a dictionary comprehension, but is
distiguished by only having a value in the operation expression.

.. sourcecode:: python

    set_comp = {VAL for VAR in SEQ if COND}

This comprehension is useful for creating a set of unique values from some
sequence of values.

.. ipython:: python

    from random import randint
    die_rolls = lambda n: [randint(1,6) for i in range(n)]
    unique_rolls = {roll for roll in die_rolls(5)}
    unique_rolls
