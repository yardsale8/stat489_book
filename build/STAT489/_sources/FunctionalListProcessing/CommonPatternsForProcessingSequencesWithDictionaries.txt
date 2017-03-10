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

Maps and filters for dictionaries
---------------------------------

The ``toolz`` module contains maps and filters for dictionary keys, values, and
items.  In the same way the we can chain map, filter and reduce together to
solve most list processing problems, ``keymap``, ``keyfilter``, ``valmap``,
``valfilter``, ``itemfilter`` and ``itemmap`` can be useful when processing
dictionaries.

Example 1 - average quiz scores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To see these tools in action, let's revisit a homework exercise from a previous
chapter (**Chapter 5 Exercise 2**).  In this example, we have a number of quiz
scores stored in a file.  Each line of the file contains the students name
followed by each quiz score.  

.. ipython:: python

    file_str = '''joe 10 15 20 30 40
    bill 23 16 19 22
    sue 8 22 17 14 32 17 24 21 2 9 11 17
    grace 12 28 21 45 26 10
    john 14 32 25 16 89'''
    lines = file_str.split('\n')
    words = map(lambda line: line.split(), lines)
    words = list(words)
    words

We start by forming a dictionary with key's equal to the names (i.e. ``first``
of each row) and value containing all the ``rest`` of the line. 

.. ipython:: python

    from toolz.curried import first, drop, compose
    rest = compose(list, drop(1))
    scores = {first(line):rest(line) for line in words}
    scores

We wish to compute the average quiz score. To do this we will ``map`` in to all
of the values using ``valmap``.  Then we need to ``reduce`` the scores to the
average.  While this could be done with ``reduce``, it is cleaner to define a
``mean`` function using ``sum`` and ``len``.  Unfortunately, this approach to
computing the mean doesn't work with lazy constructs like ``map``, meaning we
either need to cast all of the maps to lists or use ``reduce`` to count the
number of elements.  We choose to former option, since this is a small example
and casing to a list isn't that much of a burden.

.. ipython:: python

    from toolz import valmap
    from toolz.curried import map
    mean = lambda L: sum(L)/len(L)
    scores = valmap(compose( mean, list, map(int)), scores)
    scores

In this example, we show an important technique for applying maps.  When we want
to apply transformations in sequence, we use composition with a curried map.  On
the other hand, when we want to perform multiple maps sequentially, we compose
the map helper functions to perform all transformations in one pass.

.. note:: 

    Computing the mean of a lazy sequence is difficult as (a) sequences like
    ``map`` don't have a length and (b) we can only process the sequence once
    before it is empty.   We will revisit this topic when we go into more detail
    about lazy evaluation in Python in an upcoming section.

Let's peel apart ``valmap(compose( mean, list, map(int)), scores)`` to make sure
we can interpret composition of this type.  We start by reinitializing the raw
``scores`` and applying each function in the ``compose(mean, list, map(int))``
recall that the function inside of ``valmap`` is meant to act on each of the
inner list values.  For illustration, we will work on ``'sue'``.

.. ipython:: python

    from toolz import get
    scores = {first(line):rest(line) for line in words}
    sue_scores = get('sue', scores)

    func = map(int)
    sue_scores = func(sue_scores)
    sue_scores

Remember that ``map(int)`` is the curried partial function that is equivalent to
``lambda L: map(int, L)``.  Due to the lazy nature of map, and in particular the
lack of a length, we apply the ``list`` conversion function.

.. ipython:: python

    func = list
    sue_scores = func(sue_scores)
    sue_scores

Now that the values are list of integers, we can compute the mean.

.. ipython:: python

    func = mean
    sue_scores = func(sue_scores)
    sue_scores

Of course these three function calls can be composed into one call.  Remember
that ``compose`` applies the functions from right to left.

.. ipython:: python

    sue_scores = get('sue', scores)
    func = compose(mean, list, map(int))
    func(sue_scores)

To apply this function to each of the values in our quiz score dictionary, we
use ``valmap`` to map it to all of the values.

.. ipython:: python

    func = compose(mean, list, map(int))
    valmap(func, scores)

While it is often advisable, there is no need to assign our helper function to a
external variable.  Using substitution, the final expression becomes

.. ipython:: python

    valmap(compose(mean, list, map(int)), scores)

This example illustrates the proper application of functional constructs such as
``map``, ``compose`` and ``valmap`` allows us to express complex computations in
a succinct form.  On the other hand, programmers should always be careful not to
be *too clever* when expressing a computation, always keeping an eye out for
readability.  The reader that is new to functional programming might need to work
at translating an expression like the one shown above, but it will become second
nature after a while.


.. admonition:: Advice on reading maps, pipes, compositions, and curried functions

    Here are some tips on interpreting expression involving the tools presented so
    far tni this chapter.

    1. **Maps with a single function**  Remember that a map applies its function to
       each element of a sequence.  The map is curried if it has only one argument,
       as in ``map(int)``.  This is a partial function that can be applied to a
       sequence and, in this case, will apply ``int`` to each element of the
       sequence.

    2. **Filters with a single function**  We have seen many examples of a
       filter, both in the form of a comprehension and using ``filter``.
       When reading a curried filter such as ``filter(lambda n: n > 5)``,
       think of it as a partial function that can be used to filter
       sequences in the future, which in this case would keep all elements
       larger than 5.

    3. **Maps with an inner composition**  A map that has a composed function as
       its first argument will apply each function, from right to left, to
       each element of the sequence.  **This is more efficient than applying
       a sequence of maps.**  Here is an example.

       .. ipython:: python 
       
           func= map(compose(lambda n: n + 2,
                             lambda n: n**2,
                         int))

       First note that this composition has one argument, meaning it is a
       curried partial function.  Also, remember to read the composition from
       right to left (bottom to top when stacked).  Keeping this all in mind, we
       see that this map will perform the following actions to each element of a
       list.

       1. Turn each element into an integer.
       2. Square each element.
       3. Add two to each element.

       .. ipython:: python 
       
           list(func(['1','2','3']))

       **Note:** Since ``pipe`` is not a function, it is not useful inside a
       ``map``.

    4. **Compositions/pipes of maps, filters and other functions**.  When the
           expression is a composition of maps, filters and other functions that
           act on a list, think of these as a sequence of actions on the *whole
           list*.  For example, consider the following function.

           .. ipython:: python

               func = compose('\n'.join,
                              map(lambda s: s + 3*"!"),
                              map(lambda s: s.upper()))

           Clearly this function is intended for a list of strings.  This
           function will perform the following actions.

           1. Turn all characters to upper case (``s.upper()``).
           2. Add three exclaimation marks to the end of each string (``s + 3*'!'``).
           3. Join all of the strings with newline characters (``'\n'.join``).

           Let's see this composition in action.

           .. ipython:: python

               print(func(['i', 'love', 'python']))

           As noted above, we could make this function more efficiency by
           replacing the sequence of maps with one map that composes these
           functions.  

           .. ipython:: python

               func = compose('\n'.join,
                              map(
                                compose(
                                  lambda s: s + 3*"!",
                                  lambda s: s.upper())))
               print(func(['i', 'love', 'python']))

           The efficient gain for larger lists is due to only visiting each
           element one time instead of twice.

           Recall that ``pipe`` is used to *push* an expression (the first
           argument) though a sequence of functions from left to right (the
           remaining arguments).  
           
           Using ``pipe`` to process a sequence is probably more readable than
           using a composition, as the first argument is the data to be
           processed and the functions are processed from left to right, which
           reads more naturally (if you grew up with a language that reads in
           the same direction).  The above process translates into to following
           expression.


           .. ipython:: python

               from toolz import pipe
               print(pipe(['i', 'love', 'python'],
                            map(
                              compose(
                                lambda s: s + 3*"!",
                                lambda s: s.upper())),
                            '\n'.join))

           While the ``pipe`` is easier to read, it is not as general as a
           function created using ``compose``, as it is a one-use expression and
           must be wrapped in a lambda/function to make it reusable.

Example 2 - filter out students with at least siz quiz scores.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Chapter 5 Exercise 1**  asks the programmer to filter on students with at
least 6 quiz scores.  This filter will need to be applied to each value in the
quiz score dictionary so we will be using ``valfilter``.

.. ipython:: python

    from toolz.curried import first, drop, compose
    lines = file_str.split('\n')
    words = map(lambda line: line.split(), lines)
    words = list(words)
    rest = compose(list, drop(1))
    scores = {first(line):rest(line) for line in words}
    scores

Again, we will cast all the results of ``filter`` to lists to force completion.
This time, we use ``pipe`` to push the scores through the ``valfilter`` then the
``valmap``, which are each curried partial functions.  While we are at it, we
might as well convert all the values to integers.  This accomplished using an
inner ``map(int)``, which switches all of the values to integers.  Then these
list are converted to lists.  

.. ipython:: python

    from toolz import pipe
    from toolz.curried import valmap, valfilter
    mean = lambda L: sum(L)/len(L)
    scores = pipe(scores, 
                  valfilter(lambda L: len(L) >= 6), 
                  valmap(compose(list, 
                                 map(int))))
    scores

Let's practice what we have learned so far and read through the ``pipe``
expression line by line.

The first line, ``pipe(scores,`` tells us that we are going to pipe or push the
scores through a sequence of functions (from left-to-right or top-to-bottom).
The first function, ``lvalfilter(lambda L: len(L) >= 6),`` is a curried function
(``valfilter`` takes two arguments, we have provided one) that only keep items
that have at least 6 values.  The final function is more complicated and will
need a bit more work to interpret.

The final function is a ``valmap`` that will apply two functions to all of the
elements of each value in score.  It is important to remember that the composed
function operates on values that are themselves lists.  Conseuently, the
functions applied to the values will also be list-processing funcitons like
``map``.  Since this is a composition, the functions are applied from
right-to-left. The first action turns each element of the value list into an
integer using the curried ``map(int)`` and then converted to a list with
``list``.

.. admonition:: Advice on writing higher-order functions

    Writing higher-order functions takes some practice.  When using higher order
    functions to process a data sctructure, you should

    1. **Learn to think in terms of map, filter and reduce.**  With practice, it
       becomes natural to convert a desited transformation into maps, filter and/or
       reduces.  
       
       If this feels like a daunting task when getting started, Try using the
       following steps.
       
       a. Write a solution using list comprehensions and loops. Be sure to test your
       solution, and save the tests to help with the next step.  
       
       b. Now inspect the code and identify the which of these patterns are being
       applied in your solution.  

       c. Finally, refactor your solution into a composition/pipe of maps, filters
       and reductions.  
       
       This may seem like unnecessary work, but the act of continuously
       refactering your code into higher-order functions will help you start to
       think in this way.  Remember that our goal is to learn to process large
       datasets over Hadoop using MapReduce and Spark, and that these
       implementations, especially Spark, require the ability to think in terms
       of these higher-order actions.

    2. **Look for opportunities to use curried funcitons.**  Higher order
       functions like map and filter require functions as arguments and
       curried functions allow us to create partial functions with ease.  If you
       haven't found the knack for using curried functions, you can build this
       skill through careful refactorizaiton of your code.  Get in the habit of
       writing helper functions for map and check to see if these functions
       could benefit from currying. For example, suppose we want to extract the
       column with index 2 from a table of data.  If this column represented an
       employees hours, we might write the process as follows.

       .. sourcecode :: python

           from toolz import get
           get_hours = lambda row: get(2, row)
           hours = map(get_hours, employee_data)
       
       But ``lambda row: get(2, row)`` represents a partial application of
       ``get`` with the first argument set to ``2`` and the second argument left
       open for latter application.  This could be refactored using ``partial``
       from functools as follows.

       .. sourcecode :: python

           from toolz import get
           from functools import partial
           get_hours = partial(get, 2)
           hours = map(get_hours, employee_data)
       
       While this approach does make it clear that ``get_hours`` is just a
       partial application of ``get``, we can make this even more succinct using
       the curried version of ``get``.

       .. sourcecode :: python

           from toolz.curried import get
           hours = map(get(2), employee_data)

    3. **Create your own curried functions.**  Once you get used to using
       curried functions like those found in the ``toolz`` package, you will
       start to see opportunities to write your own curried functions.
       There are two things to keep in mind when creating a curried
       function.  First, use the ``@curry`` decorator from ``toolz`` to
       transform any function definition into a curried function.  Second,
       try to put the arguments that might be used in multiple function
       calls to the left of arguments that are more likely to change from
       one call to the next.  This way, you can easily create partial
       funcitons that remove the repetition from all subsequent calls.
       arguments that will 

    4. **Try to keep all of the steps lazy when processing large amounts of
       data.** In the next section we will look at Python's lazy constructs
       in more detail.  These tools can be useful when processing large
       amounts of data, as they do not need to have all of the data loaded
       in memory at once.  An important skill when working with big data
       is keeping track of which steps are lazy or eager, and making sure
       that the data can be processed without loading it all in memory.

    5. **Obey the claan code rule regarding levels of abstraction.** It is still
       important to pay attention to the levels of abstraction in our data
       structures and keep to one level per function.  Anytime that your functions
       and expressions become too complex, check to make sure that you have stuck to
       this rule.

       For example, consider the following example given above.

       .. ipython:: python

           mean = lambda L: sum(L)/len(L)
           scores = pipe(scores, 
                         valfilter(lambda L: len(L) >= 6), 
                         valmap(compose(list, 
                                        map(int))))

       While this function doesn't technically break this rule (all functions, even the
       anonymous inner helper functions, all operate on one level), we could improve
       readability with some refactoring.


       .. ipython:: python

           mean = lambda L: sum(L)/len(L)
           at_least_six_items = lambda L: len(L) >= 6
           map_int_and_make_list = compose(list, map(int))
           scores = pipe(scores, 
                         valfilter(at_least_six_items), 
                         valmap(map_int_and_make_list))
           scores

       This refactored version hides the lower levels of abstraction for the values
       (items in values lists) using the helper functions ``mean``,
       ``at_least_six_items``, and ``map_int_and_make_list``.

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

To make this pattern clear, we first write the helper functions ``update_count``
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

As we know, the accumulator patter can be abstracted with the ``reduce``
function.  The solution using ``reduce`` uses the same update functions and
initial value as show above.

.. ipython:: python

    update_count = lambda word, counts: get(word, counts, 0) + 1
    update_dict = lambda wd, cnts: assoc(cnts, wd, update_count(wd, cnts))
    reduce(update_dict, words, {})
Like most common functional patterns, there are probably already solutions
available in some Python module.  In this case, the ``toolz`` package has a
function called ``frequencies`` that performs the task of counting occurrences of
items in a sequence.

.. ipython:: python

    from toolz import frequencies
    frequencies(words)

Counting Frequencies Using a Key Function
-----------------------------------------

The function **countby**  uses pattern similar to ``frequencies``, but is bit
more general.  Instead of counting frequencies of the raw data, we will first
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
``reduce`` solutions.  The presence of the ``key`` parameter in the update
function means that we will also make this a parameter in the reduce helper function
so that it can be passed along from call to call.  This is accomplished using a
curried function.  

.. ipython:: python

    @curry
    def update_dict(key, cnts, wd):
        update_count = lambda length, counts: get(length, counts, 0) + 1
        return assoc(cnts, key(wd), update_count(key(wd), cnts))
    countby = lambda key, lst: reduce(update_dict(key), lst, 0)
    countby(len, words)

Now that we understand the ``countby`` pattern, there is no reason to have to
implement it again, and in fact, this function is also available in the
``toolz`` module.

.. ipython:: python

    from toolz import countby
    words = zen_no_punc.split()
    countby(len, words)

One final note about ``countby``.  To see that ``countby`` is generalization of
``frequencies``, we note that using the ``identity`` function with ``countby``
is equivalent to ``frequencies``.

.. ipython:: python

    from toolz import countby, identity
    words = zen_no_punc.lower().split()
    countby(identity, words)

Grouping values with ``groupby``
--------------------------------

The functions ``frequencies`` and ``countby`` are examples of functions that
group data by some key and then reduce the resulting group to a count.  We can
generalize this process by separating the grouping and the reduction.

The first action, will group the values by some key.  In our first example, we
will group a table by the values from a given column.  We will start with the
imperative solution.  We will be using ``get`` to get the current group with a
default value of a empty list.  These values (lists) are updated by appending
the current value.  To keep the values immutable and the appends efficient, we
will use a persistent vector in place of a list.
In this example, we will keep *group* the hours *by* title.

.. ipython:: python

    from toolz.curried import get, drop, assoc
    from functools import partial
    from pyrsistent import pvector
    hours = [['name', 'hours', 'rate', 'title'],
            ['Ann',   '42',    '37.5', 'manager'],
            ['Bob',   '55',    '7.5' , 'assembly'],
            ['Alice', '12',    '225' , 'consultant'],
            ['Ann',   '44',    '37.5', 'manager'],
            ['Bob',   '51',    '7.5' , 'assembly'],
            ['Alice', '14',    '225' , 'consultant'],
            ['Ann',   '52',    '37.5', 'manager'],
            ['Bob',   '45',    '8.5' , 'assembly'],
            ['Alice', '17',    '225' , 'consultant']]

.. ipython:: python

    get_group_by_key = partial(get, default = pvector([]))
    get_key = get(3)
    get_hours = get(1)
    rest = drop(1)
    groups = {}
    for row in rest(hours):
        key = get_key(row)
        current_group = get(key, groups, pvector([]))
        current_hours = get_hours(row)
        new_group = current_group.append(current_hours)
        groups = assoc(groups, key, new_group)
    groups

We recognize this as the accumulator pattern, but to make the update a little
more clear, we will refactor the loop as follows.


.. ipython:: python

    def update_groups(groups, row):
        ''' helper functions to update the groups'''
        get_key = get(3)
        get_hours = get(1)
        key = get_key(row)
        current_group = get(key, groups, pvector([]))
        current_hours = get_hours(row)
        new_group = current_group.append(current_hours)
        return assoc(groups, key, new_group)

Then the loop for updating the groups becomes

.. ipython:: python

    groups = {}
    for row in hours[1:]:
        groups = update_groups(groups, row)
    groups

and the relationship to ``reduce`` becomes clear.

.. ipython:: python

    from functools import reduce
    reduce(update_groups, rest(hours), {})


This process can be abstracted by allowing the user to specify a key function
like ``get_key`` in the above example.  We will call this generalization
``groupby``, as we are *grouping* the elements of the sequence *by* some key.
Here is the implementation based on reduce.  Also, this instance will add the
whole element of the sequence to the group.


.. ipython:: python

    from functools import reduce
    def groupby(key_func, seq):
        ''' Group all items in seq by the value of the key_function'''
        def update_groups(groups, item):
            ''' helper functions to update the groups'''
            key = key_func(row)
            current_group = get(key, groups, pvector([]))
            new_group = current_group.append(item)
            return assoc(groups, key, new_group)
        return reduce(update_groups, rest(hours), {})

    groupby(get(1), hours)

As you might expect, ``groupby`` is provided by the ``toolz`` library.

.. ipython:: python

    from toolz import groupby
    groupby(get(3), hours)

It is a common pattern to use ``groupby`` to group the elements, then reduce the
values using ``valmap`` and ``reduce``.  For example, let's compute the total
pay (sum of hours*rate) for each group.  We start by creating a function for
turning a value into the pay.

.. ipython:: python

    from toolz.curried import get, pipe, valmap
    from operator import mul
    groups = groupby(get(3), hours)
    get_pay = lambda r: mul(*pipe(r, get([1,2]), map(float)))
    get_pay(get(1, hours))
                       

We could do this with ``reduce``, but in this case we can use a map to pull out
the pay, turn these strings into integers, and finally use ``sum``.  In the
process, we will practice our use of higher-order functions.

.. ipython:: python

    from toolz.curried import get, compose, valmap
    groups = groupby(get(3), rest(hours))
    pay_by_title = valmap(compose(sum, map(get_pay)), groups)
    pay_by_title

We will provide an abstraction called ``reduceby`` that combines ``groupby`` and
``reduce`` in the upcoming section on lazy evaluation.

The Recursive Approach to Counting Frequencies (Optional)
---------------------------------------------------------

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

