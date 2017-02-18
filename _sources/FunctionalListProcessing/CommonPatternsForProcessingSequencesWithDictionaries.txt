..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Common Patterns for Processing Sequences with Dictionaries
==========================================================

In this section, we will illustrate a number of common patterns for processing
lists using dictionaries.  These patterns include counting frequencies and counting
frequencies by some key function.  In each case, we will start by looking at the
imperative solution, then move on to the recursive solution and finally use a
pre-existing function from ``toolz``.

Counting Frequencies with Dictionaries
--------------------------------------

In this section, we continue the theme of processing sequential data.  Many
problems require that we group data by some common characteristic.  We will
refer to this operation as **counts** or **frequencies**.  In Python,
dictionaries are the right data structure for a keeping track of the counts for
various objects.  In this section, we will look at two low-level approaches to
writing a **frequencies** operation, with an imperative approach and with
recursion.

The Imperative Approach to Counting Frequences
----------------------------------------------

As a working example, suppose that we want to count the occurrences of each word
in a block of text.  For this example, we will use the Zen of Python with
punctuation already removed.

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

The imperative approach to counting is to use the accumulator pattern with a
dictionary as the accumulator.  We start with an empty dictionary and iterate
through the words,  updating the entries of the dictionary as we go.  While we
could accomplish this by mutating the same dictionary, in this example we will
use ``assoc`` to return a new, updated, copy of the dictionary.

.. ipython:: python

    from toolz import get, assoc
    words = zen_no_punc.lower().split()
    counts = {}
    for word in words:
        update_count = get(word, counts, 0) + 1
        counts = assoc(counts, word, update_count) 
    get('implementation', counts)

There are a couple of things to note in this example.  First, we are using
``get`` with a default value of 0 to get the current count.  As we are starting
with an empty dictionary, the default value will be used the first time we see
each word.  When we subsequent occurrences of the word, ``get`` will return the
value stored in the dictionary.

Also of note is using ``assoc`` to update and save a fresh copy of the
dictionary.   As we work through the words, counts will accumulate more and more
information about the word frequencies.

To make thi pattern clear, we first write the helper functions ``update_count``
and ``update_dict`` based on the code from the imperative solution.

.. ipython:: python

    update_count = lambda word, counts: get(word, counts, 0) + 1
    update_dict = lambda wd, cnts: assoc(cnts, wd, update_count(wd, cnts))

Using these functions, the imperative solution becomes

.. ipython:: python

    update_count = lambda word, counts: get(word, counts, 0) + 1
    update_dict = lambda wd, cnts: assoc(cnts, wd, update_count(wd, cnts))
    counts = {}
    for word in words:
        counts = update_dict(word, counts) 

To get a general feel for this pattern, we rewrite the code using more general
names.  

.. sourcecode:: python

    acc = {}
    for item in L:
        acc = update(acc, L) 

.. note::  

    We will generalize this pattern using the function ``reduce`` in the next
    chapter.


The Recursive Approach to Counting Frequencies
----------------------------------------------

Recursion is one of the building blocks of functional programming.  A
**recursive** function is a function that calls itself and **recursion** refers
to using recursive functions to solve a problem. 

There are some well-established abstractions that are used when using recursion
to process a list.  We start with a recursive definition of a list.  In a
recursive context, a list is either ``empty`` or the ``first(list),
rest(list)``, where ``first(list)`` is the next entry in the list and
``rest(list)`` is the remainder of the list.  We could define ``first`` and
``rest`` on Python lists as follows.

.. ipython:: python

    L = [1,2,3,4]
    first = lambda L: L[0]
    rest = lambda L: L[1:]
    first(L)
    rest(L)

As noted in a previous chapter, slicing all but the first element of a list is
an operation with a time complexity of :math:`O(n)`, which is an expensive
operation to apply once for each item in a list (The overall complexity would be
:math:`O(n^2)`).  We can use the ``Plist`` data structure from ``pyrsistent``
for a more efficient approach to processing list in this way.  A ``plist`` comes
with methods for ``first`` and ``rest``.  The time complexity for both the ``first``
and ``rest`` methods of a ``Plist`` is constant time, i.e. :math:`O(1)`.

.. ipython:: python

    from pyrsistent import plist
    L = plist([1,2,3,4])
    type(L)
    L.first
    L2 = L.rest
    L2
    L is L2

Note that ``L.rest`` does not mutate ``L``, but returns a reference to a new
``Plist``.


There are two more function that are useful when processing list in a recursive
fashion.  First, we need a function to check if a list is empty, which will will
call ``is_empty``.  

.. ipython:: python

    is_empty = lambda L: len(L) == 0
    is_empty(L)
    is_empty(plist([]))

Second, we introduce a function called ``cons`` to add a new
value to the beginning of a ``Plist``.  Luckily, the ``Plist`` data structure
comes with a ``cons`` method.

.. ipython:: python

    from pyrsistent import plist
    L = plist([1,2,3,4])
    L2 = L.cons(0)
    L2
    L is L2


Let's work on a recursive solution.  Before we write the recursive solution,
consider the following **laws of recursion**.

.. admonition:: The First and Second Laws of Recursion

    To paraphrase *The Little Schemer*, the first law of recursion is: **The first
    question is ``is_empty``.**  When processing a list recursive, we always
    check to see if the list is empty.  The second law of recursion is to call
    your function on the rest of the list.  This has the effect of always moving
    toward the base case of an empty list.  Proper application of the second law
    will assure that out recursive function will terminate.

Let's step though processing our text to get a feel for how recursion will work.

.. ipython:: python

    from toolz import get, assoc
    words = plist(zen_no_punc.lower().split())
    counts = {}
    counts = update_dict(words.first, counts)
    counts
    words = words.rest
    counts = update_dict(words.first, counts)
    counts
    words = words.rest
    counts = update_dict(words.first, counts)
    counts
    words = words.rest

Let's compose these expression using substitution, Specifically, we will embed
the ``word = word.rest`` in the line involving ``assoc``.  

.. ipython:: python

    counts = {}
    counts = update_dict(words.first, counts)
    counts = update_dict(words.rest.first, counts)
    counts = update_dict(words.rest.rest.first, counts)
    counts


A pattern emerges.  Each ``assoc`` operation is called the ``rest`` of the last
list.  This will continue until the list is empty.  If we tried to call
``first`` when the list is empty, we would get an exception.  This is the reason
for the first law of recursion: We should check ``is_empty`` to make sure the
recursion terminates correctly.   Let's add a conditional statement to the last
example to be sure that we return counts once we have emptied the list.


.. ipython:: python

    counts = {}
    counts = counts if is_empty(words) else update_dict(words.first, counts)
    counts = counts if is_empty(words.rest) else update_dict(words.rest.first, counts)
    counts = counts if is_empty(words.rest.rest) else update_dict(words.rest.rest.first, counts)
    counts

These expressions are getting a little complicated and very repetitive.  Let's
package the core logic in a lambda expression to clean things up.

.. ipython:: python

    counts = {}
    next_cnts = lambda cnts, wds: cnts if is_empty(wds) else update_dict(wds.first, cnts)
    counts = next_cnts(counts, words)
    counts = next_cnts(counts, words.rest)
    counts = next_cnts(counts, words.rest.rest)

We are almost there!  Again we will compose the expressions, this time using
substitution on ``count``.  To make this clear, we will work through each
substitution one by one.

.. ipython:: python

    counts = next_cnts({}, words)
    counts = next_cnts(counts, words.rest)
    counts = next_cnts(counts, words.rest.rest)

.. ipython:: python

    counts = next_cnts(next_cnts({}, words), words.rest)
    counts = next_cnts(counts, words.rest.rest)

.. ipython:: python

    counts = next_cnts(next_cnts(next_cnts({}, words), words.rest), words.rest.rest)
    counts

So what we want to do is repeatedly call ``next_cnts`` on the output of the
last call to ``next_cnts`` and the rest of ``words``.  We continue until the
``words`` list is empty, at which point we would return the ``counts``
dictionary .  Also note that the very first call to ``assoc_count`` is seeded
with an empty dictionary. 


Two small changes and we have a solution.  First, we define a recursive function
``count_words``.  Second, we embed a recursive call to abstract the pattern of
calling this function over and over until completion.  Note that each call to
``count_words`` needs the updated dictionary (using word.first which can now be
discarded) and the rest of the words.  Also recall that we start the process
with an empty dictionary.

.. ipython:: python

    counts = {}
    count_words = lambda cnts, wds: cnts if is_empty(wds) else count_words(update_dict(wds.first, cnts), wds.rest)
    count_words({}, words)

This function illustrates the pattern for recursion with an accumulator, which
is generalized in the following code.

.. sourcecode:: python

    rec_acc = lambda acc, lst: acc if is_empty(lst) else rec_acc(update(lst.first, acc), lst.rest)

The basic process is to return the accumulator ``acc`` if the list is empty.  If
not, we update ``acc`` (here with a helper function called ``update``) and recur
on the updated ``acc`` and the rest of the list.

Now look for similarities between the *imperative* accumulator pattern (shown
below) and the *recursive* accumulator pattern.  Both patterns involve applying
the *same* function to ``update`` the accumulator for each value.  They differ
in there method of iteration, with the imperative solution using a loop and the
recursive solution recurring on the rest of the list until it has been exhausted.
Readers that are more familiar with the imperative pattern can use this
relationship to help write the ``update`` function, and then apply the general
pattern.

.. sourcecode:: python

    # Recursive accumulator
    rec_acc = lambda acc, lst: acc if is_empty(lst) else rec_acc(update(lst.first, acc), lst.rest)

    # Imperative accumulator
    acc = {}
    for item in L:
        acc = update(item, acc) 

Like most common functional patterns, there are probably already solutions
available in some Python module.  In this case, the ``toolz`` package has a
function called ``frequency`` that performs the task of counting occurrences of
items in a sequence.

.. ipython:: python

    from toolz import frequencies
    frequencies(words)

Counting Frequencies Using a Key Function
-----------------------------------------

There is a pattern similar to ``frequencies``, but a bit more general, is
**countby**.  Instead of counting frequencies of the raw data, we will first
transform the data with a key function, then count the occurrences of these
values.  There is a restriction on the key-function, it must return an immutable
object that can be used as a key in a dictionary.

Returning to the Zen of Python, this time we will count the number of words by
length, that is count how many words are in the text for each word length
present.

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

We start with the imperative approach, which will again use the accumulator
pattern to update a dictionary as we iterate through the sequence.  The added
wrinkle is using a key-function, in this case ``len`` on each element before we
update the dictionary.

.. ipython:: python

    from toolz import get, assoc
    words = zen_no_punc.lower().split()
    counts = {}
    for word in words:
        update_count = get(len(word), counts, 0) + 1
        counts = assoc(counts, len(word), update_count) 
    counts

To clean this example up and illustrate the main pattern, we again make some
helper functions for updating the counts and updating the count dictionary.  The
only difference between these functions and those from the earlier sections is 

1. We have changed the parameter name to indicate that we are counting lengths
   here.
2. We need to apply the length function before updating the dictionary. In
   anticipation of a more general pattern, we will pass the length function to
   ``update_dict`` through a parameter named ``key``.

.. ipython:: python

    update_count = lambda length, counts: get(length, counts, 0) + 1
    update_dict = lambda key, wd, cnts: assoc(cnts, key(wd), update_count(key(wd), cnts))
    counts = {}
    for word in words:
        counts = update_dict(len, word, counts) 
    counts

As noted above, the same update function can be used to both the imperative and
recursive solution.  The presence of the ``key`` parameter in the update
function means that we will also make this a parameter in the recursive function
so that it can be passed along from call to call.  Finally, we write a wrapper
function called ``countby`` that calls ``countby_rec``, thus hiding the need for
the accumulator from the user.


.. ipython:: python

    from pyrsistent import plist
    words = plist(words)
    countby_rec = lambda key, acc, lst: acc if is_empty(lst) else countby_rec(key, update_dict(key, lst.first, acc), lst.rest)
    countby = lambda key, lst: countby_rec(key, {}, lst)
    countby(len, words)

Now that we understand the ``countby`` pattern, there is not reason to have to
implement it again, and in fact, this function is also available in the
``toolz`` module.

.. ipython:: python

    from toolz import countby
    words = zen_no_punc.split()
    countby(len, words)

On final note about ``countby``.  To see that ``countby`` is generalization of
``frequencies``, we note that using the ``identity`` function with ``countby``
is equivalent to ``frequencies``.

.. ipython:: python

    from toolz import countby, identity
    words = zen_no_punc.lower().split()
    countby(identity, words)
