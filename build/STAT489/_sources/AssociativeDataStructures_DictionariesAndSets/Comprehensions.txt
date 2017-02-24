..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

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
distinguished by the ``KEY:VAL`` key-value pair in the operation expression.

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
distinguished by only having a value in the operation expression.

.. sourcecode:: python

    set_comp = {VAL for VAR in SEQ if COND}

This comprehension is useful for creating a set of unique values from some
sequence of values.

**Check your understanding**

.. ipython:: python

    from random import randint
    die_rolls = lambda n: [randint(1,6) for i in range(n)]
    unique_rolls = {roll for roll in die_rolls(5)}
    unique_rolls

.. mchoice:: identify_dictionary_comprehension_1
    :answer_a: Set comprehension
    :answer_b: List comprehension
    :answer_c: Dictionary comprehension
    :correct: c
    :feedback_a: A set comprehension needs one value in the operation expression, not a key-value pair.
    :feedback_b: A list comprehension is delimited by brackets ('[',']') not braces ('{', '}').
    :feedback_c: The dictionary comprehension can be identified by the surrounding braces and the key-value pair in the operation expression.

    Which type of comprehension is given below?

    .. sourcecode:: python

        {w:i for i, w in enumerate(words)}


.. mchoice:: identify_set_comprehension_1
    :answer_a: Set comprehension
    :answer_b: List comprehension
    :answer_c: Dictionary comprehension
    :correct: a
    :feedback_a: The set comprehension can be identified by the surrounding braces and single expression in the operation expression.
    :feedback_b: The dictionary comprehension needs a key-value pair in the operation expression.
    :feedback_c: A list comprehension is delimited by brackets ('[',']') not braces ('{', '}').

    Which type of comprehension is given below?

    .. sourcecode:: python

        {w for i, w in enumerate(words)}

.. mchoice:: set_comp_count_1
    :answer_a: 5
    :answer_b: 6
    :answer_c: 9
    :correct: a
    :feedback_a: The word "fear" will only be counted once and all words containing a 't' will be excluded.
    :feedback_b: The word "fear" will only be counted once.  A value is either in a set or not in a set, there is no repetition of values.
    :feedback_c: All words containing a 't' will be excluded.


    What value will the following code return?

    .. sourcecode:: python

        fear = "the only thing we have to fear is fear itself" 
        len({w for w in fear.split() if 't' not in w}) 

.. mchoice:: dict_comp_1
    :answer_a: 4
    :answer_b: 8
    :answer_c: Error: You can't have an expression in the value position of the key-value pair.
    :correct: b
    :feedback_a: This dictionary maps each word to twice the length of the word.
    :feedback_b: This dictionary maps each word to twice the length of the word.
    :feedback_c: Any expression can be used in the value position.  Expressions can also be used in the key position, but they must evaluate to an immutable hashable object.

     
    What value will the following code return?

    .. sourcecode:: python

        fear = "the only thing we have to fear is fear itself" 
        d = {w:2*len(w) for w in fear.split()}
        get('fear', d)

Merging Dictionaries
--------------------

One application of set and dictionary comprehensions is the process of merging
two dictionaries.  Let's create a function that called ``merge`` that takes two
dictionaries ``d1`` and ``d2`` as arguments and returns a new dictionary that
merges the values from both.  As it is possible that both dictionaries contain
the same keys, we will use the following rules to deal with these *key
collisions*.

1. Use the key-value pair from ``d2``, if present.
2. Use the key-value pair from ``d1`` for all ``key not in d2``. 

To make this process easier, we construct a helper function for selecting the
value from the correct dictionary.

.. ipython:: python

    from toolz import get
    get_value = lambda key, d1, d2: get(key, d2) if key in d2 else get(key, d1)
    d1, d2 = {'a':1, 'b':2}, {'a':10, 'c':12}
    assert get_value('a', d1, d2) == get('a', d2)
    assert get_value('b', d1, d2) == get('b', d1)

Note that we use two ``assert`` statements to determine if our helper function
is pulling values from the correct dictionary.  The fact that nothing happened
when we ran these lines indicates that the assertions held.

.. note:: 

    An assert statement will do nothing when the condition is true, but
    will throw an exception if it fails.  This is a useful technique for testing
    functions, which will be discussed on more detail in a future chapter.

The second helper function will take the two dictionaries as arguments and
return a set of the combined keys.

.. ipython:: python

    all_keys = lambda d1, d2: set(d1.keys()) | set(d2.keys())
    assert all_keys(d1, d2) == set(['a', 'b', 'c'])

Now we can used a dictionary comprehension to construct the merged dictionaries.

.. ipython:: python

    my_merge = lambda d1, d2: {key:get_value(key, d1, d2) for key in all_keys(d1, d2)}
    my_merge(d1, d2)

In a pattern that should have become familiar, the ``toolz`` package already
provides and implementation of ``merge`` that behaves in the same way.

.. ipython:: python

    from toolz import merge
    merge(d1, d2)

The levels of abstraction for a dictionary
------------------------------------------

The reader should take a moment to consider the *levels of abstraction* for a
dictionary.

.. admonition:: The levels of abstraction for a dictionary

    A dictionary consists of keys and values.

.. figure:: Figures/dict_levels.png
    :alt: The levels of abstraction for a dictionary

    ..

    A dictionary consists of keys and values.


Our rule for writing clean code is to write functions that only work at one
level of abstraction.  If we are going to adhere to this rule when working with
dictionaries, we should write functions for working with the keys and values,
and then apply these functions to the dictionary or dictionaries.  


.. admonition:: Writing clean code for dictionaries

    When processing dictionaries, do the following to ensure clean code:

    1. Write a function or functions to process keys.
    2. Write a function or functions to process the values.
    3. Write a function that uses a comprehension and the functions from **1** and
       **2** to process the dictionary.

The last example illustrated this pattern by first constructing functions that
worked on keys (made the collection of all keys) and values (pulled the value
from the correct dictionary).  These functions were then applied to the
dictionaries using a comprehension.

.. figure:: Figures/dict_levels_example.png
    :alt: my_merge example of level of abstraction for a dictionary

    ..

    In the my_merge example, two functions were written to process the keys and
    values and then these functions were used in a comprehension to merge the
    dictionaries.

.. note:: 

    We will develop a generalization of ``merge`` called ``merge_with`` when
    developing higher-order functions for dictionaries.
