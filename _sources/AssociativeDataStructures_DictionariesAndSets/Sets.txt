Sets
====

The ``set`` is a useful associative Python data structure for collecting unique
values and checking membership.  If you find yourself building a data structure
that will only be used to check if items are ``in`` the group, the set is the
correct data structure for the task. Sets are based on mathematical sets and
come with methods for unions, intersections, etc.  Consequently, they are also
useful for comparing the membership of two groups.

Using a ``set`` to count unique values
--------------------------------------

Sets can be useful for determining the number of unique values in a collection.
Suppose that we are interested in determining how many unique words there are in
the Zen of Python

.. ipython:: python

    zen_no_punc = '''
    The Zen of Python by Tim Peters
    Beautiful is better than ugly
    Explicit is better than implicit
    Simple is better than complex
    Complex is better than complicated
    Flat is better than nested
    Sparse is better than dense
    Readability counts
    Special cases arent special enough to break the rules
    Although practicality beats purity
    Errors should never pass silently
    Unless explicitly silenced
    In the face of ambiguity refuse the temptation to guess
    There should be one and preferably only one obvious way to do it
    Although that way may not be obvious at first unless youre Dutch
    Now is better than never
    Although never is often better than right now
    If the implementation is hard to explain its a bad idea
    If the implementation is easy to explain it may be a good idea
    Namespaces are one honking great idea  lets do more of those'''

The easiest way to construct a set is using the ``set`` conversion function on a
list of values.

.. ipython:: python

    words_zen = zen_no_punc.lower().split()
    unique_words_zen = set(words_zen)
    unique_words_zen
    len(unique_words_zen)

We can now use ``in`` to determine if a given word is present in the set.

.. ipython:: python

    'the' in unique_words_zen
    'mississippi' in unique_words_zen

While this looks no different that performing the same operations on a list,
sets have a much more efficient item look-up (as discussed in a later section).

.. caution:: 

    Similar to the requirement for dictionary keys, entries in a ``set`` must be
    immutable, hashable items.  If you need to make a set of lists or dictionaries,
    you will need to convert them to the immutable alternative from ``pyrsistent``.

Comparing Membership with Sets
------------------------------

As sets a modeled after sets from mathematics, they are also useful in comparing
the membership of two groups.  To illustrate this process, we will create a set
containing the unique words from the `Gettysburg Address
<https://en.wikipedia.org/wiki/Gettysburg_Address>`_.

.. ipython:: python

    gettysburg_address = """Fourscore and seven years ago our fathers
    brought forth, on this continent, a new nation, conceived in liberty,
    and dedicated to the proposition that all men are created equal. Now we
    are engaged in a great civil war, testing whether that nation, or any
    nation so conceived, and so dedicated, can long endure. We are met on a
    great battle-field of that war. We have come to dedicate a portion of
    that field, as a final resting-place for those who here gave their
    lives, that that nation might live. It is altogether fitting and proper
    that we should do this. But, in a larger sense, we cannot dedicate, we
    cannot consecrate—we cannot hallow—this ground. The brave men, living
    and dead, who struggled here, have consecrated it far above our poor
    power to add or detract. The world will little note, nor long remember
    what we say here, but it can never forget what they did here. It is for
    us the living, rather, to be dedicated here to the unfinished work which
    they who fought here have thus far so nobly advanced.  It is rather for
    us to be here dedicated to the great task remaining before us—that from
    these honored dead we take increased devotion to that cause for which
    they here gave the last full measure of devotion—that we here highly
    resolve that these dead shall not have died in vain—that this nation,
    under God, shall have a new birth of freedom, and that government of the
    people, by the people, for the people, shall not perish from the
    earth.""" 
    words_gettysburg = gettysburg_address.lower().split()
    unique_words_getty = set(words_gettysburg)

Sets come with a number of useful methods that will be familiar to anyone that
has worked with sets in mathematics.

.. ipython:: python

    [attr for attr in dir(unique_words_zen) if not attr.startswith('__')]

The ``intersection`` method of a set can be used to construct another set that
contains all elements the two sets have in common.   The ``union`` method can be
used to create the set of words that are one or both original sets.

.. ipython:: python

    in_common = unique_words_zen.intersection(unique_words_getty)
    in_common
    len(in_common)
    union = unique_words_zen.union(unique_words_getty)
    len(union)

Notice that each method is called on one set using the other set as an argument
for the method.  This is the general pattern for using the ``set`` methods to
compare sets

We can check if one group is contained in another using ``issubset`` and
``issuperset``.

.. ipython:: python

    in_common.issubset(unique_words_zen)
    union.issuperset(in_common)

Suppose that you want to get the words in one text but not the other.  This can
be accomplished using the ``difference`` method.

.. ipython:: python

    zen_only = unique_words_zen.difference(unique_words_getty)
    len(unique_words_zen) - len(zen_only)

Similarly, the method `` symmetric_difference`` is used to find all words that
are in one set but not both.  (This is equivalent to
``union.difference(intersection)``)

.. ipython:: python

    sym_diff = unique_words_zen.symmetric_difference(unique_words_getty)
    len(sym_diff)

.. note::

    Sets also have methods for mutation, such as ``add``, ``pop``, ``remove`` and
    ``difference_update`` that are not covered here.

**Check your understanding**


.. mchoice:: set_count_1
    :answer_a: 9
    :answer_b: 10
    :correct: a
    :feedback_a: The word "fear" will only be counted once.
    :feedback_b: The word "fear" will only be counted once.  A value is either in a set or not in a set, there is no repetition of values.

    What value will the following code return?

    .. sourcecode:: python

        fear = "the only thing we have to fear is fear itself" 
        words = fear.split()
        len(set([w for w in words]) 

.. mchoice:: set_intersection_1
    :answer_a: 22
    :answer_b: 19
    :answer_c: 0
    :correct: c
    :feedback_a: The intersection would represent the words that are in common.  This answer gives total number of words including repeats ('fear', 'of', 'failure').
    :feedback_b: The intersection would represent the words that are in common.  This answer gives total number of unique words in the union of the sets.
    :feedback_c: These two quotes (by FDR and Winsten Churchhill, respectively) have no words in common.

     
    What value will the following code return?

    .. sourcecode:: python

        fear = "the only thing we have to fear is fear itself" 
        fear_words = set([w for w in fear.split()])
        success = "success consists of going from failure to failure without loss of enthusiasm"
        success_words = set([w for w in success.split()])
        len(success_words.intersection(fear_words))

.. mchoice:: set_union_1
    :answer_a: 22
    :answer_b: 19
    :answer_c: 0
    :correct: b
    :feedback_a: The union would represent the words unique words in the combined strings.  This answer gives total number of words including repeats ('fear', 'of', 'failure').
    :feedback_b: This answer gives total number of unique words in the union of the sets.
    :feedback_c: The union would represent the words unique words in the combined strings.  This answer given the size of the intersection, as these two quotes (by FDR and Winsten Churchhill, respectively) have no words in common.

     
    What value will the following code return?

    .. sourcecode:: python

        fear = "the only thing we have to fear is fear itself" 
        fear_words = set([w for w in fear.split()])
        success = "success consists of going from failure to failure without loss of enthusiasm"
        success_words = set([w for w in success.split()])
        len(success_words.union(fear_words))

Set Operations
--------------

Python sets can also be compared with a number of operations that are equivalent
to the methods shown above.

.. ipython:: python


    # issubset with <=
    in_common <= unique_words_zen
    # issuperset with >=
    union >= in_common
    # union with |
    len(unique_words_zen | unique_words_getty)
    # intersection with &
    len(unique_words_zen & unique_words_getty)
    # difference with -
    zen_only = unique_words_zen - unique_words_getty



Persistent Sets
---------------

As with other Python data structures, the ``pyrsistent`` module provides an
immutable and persistent implementation of a set.  This can be used to build up
a set without mutation with efficient operations that return new sets.  In
particular, we ``add`` and ``remove`` items from sets.

.. ipython:: python

    from pyrsistent import s
    s1 = s(1,2,3,3,4,4)
    s1
    s2 = s1.add(0)
    s1
    s2
    s1 is s2
    s3 = s2.remove(4)
    s2
    s3
    s2 is s3

These persistent sets come with all of the expected methods,

.. ipython:: python

    pset_methods = set([attr for attr in dir(s1) if not attr.startswith('__')])
    python_set_methods = set([attr for attr in dir(set([])) if not attr.startswith('__')])
    # The intersection of python set methods and pset methods
    pset_methods & python_set_methods

and all of the operations that work on python sets also work on ``Psets``.

.. ipython:: python

    s2 - s1
    s3 & s1
    s1 <= s2
