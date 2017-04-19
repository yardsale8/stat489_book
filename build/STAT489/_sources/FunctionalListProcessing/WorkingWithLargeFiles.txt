..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".


Working with Large Files
========================

Lazy sequences are useful in processing large files.  In this section, we will
explore the process of working with very large files.  This might involve
processing one large files or a number of large files.  First, we illustrate
processing a single large file as a lazy sequence.  Then we adapt this approach
to allow the processing of any number of files as a lazy stream.  Finally, we
look at more complicated lazy operations like ``reduceby`` and ``join``.

Processing a single large file
------------------------------

When processing a large file, it is important to keep the entire streaming
process lazy.  We will do this by sticking to the following rules.

.. admonition:: How to stream a large file

    1. Start with process with ``with_iter``, which is a lazy sequence of lines from
       the file.

    2. Pipe this sequence through a series of lazy constructs like ``map``,
       ``filter``, ``drop``, ``take``, etc.
    3. Use ``side_effect`` with chucks and ``print`` to keep track of your progress.

    4. If we need to write the results to a file, we do the following

        a. Embed the whole pipe in a ``with`` statement.
        b. Use ``side_effect`` to print the sequence while maintaining the laziness of
           the process.

    5. Consume the sequence in the proper way.  Make sure that you don't keep too
       much information in memory.  For example, comsuming the process with ``list``
       could be a bad idea for a very large stream.  Here are a couple of possible
       alternatives.

        a. Use ``consume`` to eat the whole sequence, one item at a time.  This is the
           typical end of the pipe when writing the results to disk.

        b. Use ``reduce`` or ``reduceby`` to aggregate the data to a managable size.
           Many times a collection of statistics will be much smaller in size than
           the original file.

Example - Processing United States Census data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As an example of processing a large file, suppose that we want to compute
statistics based off the `2011-2015 ACS 5-years PUMS
<https://www.census.gov/programs-surveys/acs/data/pums.html>`_.  This file is
fairly large, weighing in at just under 5GB.  Let's start use a lazy pipe to
count the number of rows.  First, we import all of the tools that we will need
in this and the next example.

.. ipython:: python

    from more_itertools import with_iter, consume, side_effect
    from csv import reader
    from toolz import compose, pipe, first
    from toolz.curried import get, take, filter, map, get, pluck, drop, reduceby, valmap, curry
    from toolz.curried import reduceby, valmap, curry
    from functools import reduce
    read_csv = compose(reader, with_iter, open)

Counting is a reduction, so we will create a helper function, a reduction, and
then stream the file through the reduction.

.. sourcecode:: python

    In [7]: count = lambda cur_count, next_row: cur_count + 1

    In [8]: count_rows = lambda seq: reduce(count, seq, 0)

    In [9]: pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
       ...:      read_csv,
       ...:      count_rows)
       ...: 
    Out[9]: 4639126

.. 
.. .. ipython:: python
.. 
..     count = lambda cur_count, next_row: cur_count + 1
..     count_rows = lambda seq: reduce(count, seq, 0)
..     pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
..          read_csv,
..          count_rows)

This file represents a sample of the entire census and consequently, we need to
use person weights (PWGTP) if we want to make a good estimate for the whole
United States population.  For example, suppose that we want to compute the
average interest, dividends, and net rental income in the past 12 months (INTP)
grouped by place of birth (POBP05). Since we want to focus on people that were
born in the United States or its territories, so we must apply a filter to keep
values of POBP05 between 1 and 56.

The formula for computing the average using the weights is given by

.. math::

    average = \frac{\sum_{i=1}^{N} PWGTP_i*INTP_I}{\sum_{i=1}^{N} PWGTP_i}

We start by inspecting the table header to determine the index of each of these
columns.

.. ipython:: python

    rows_to_keep = ['PWGTP', 'INTP', 'POBP05']
    keep_row = lambda tup: get(1, tup) in rows_to_keep
    header = pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
                   read_csv,
                   take(1),
                   list,
                   first,
                   enumerate,
                   filter(keep_row),
                   list)
    header

When processing a very large file, one valuable technique is preprocessing a
small portion of the file to test our code.  Let's use ``take`` to read in 20
rows, keeping only those columns of interest.


.. ipython:: python

    pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # Temparary - remove after preprocessing
          pluck([7, 33, 112]), # Abstraction for map(get(indexs))
          list) # Temparary - remove after preprocessing


So far, we have been using the pattern ``map(get([7, 33, 112]))`` to pull out
specific rows.  There is a better lazy abstraction of this pattern called
``pluck`` available in ``toolz``, which we can use to refactor that last batch
of code as follows.

.. ipython:: python

    pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # Temparary - remove after preprocessing
          drop(1), # Drop the header
          map(get([7, 33, 112])),
          list) # Temparary - remove after preprocessing

Now we will filter out the POB05 labels for the United States and its
territories (1-56).  

.. ipython:: python

    is_US = lambda row: int(get(-1, row)) <= 56
    pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # Temparary - remove after preprocessing
          drop(1), # Drop the header
          pluck([7, 33, 112]),
          filter(is_US),
          list) # Temparary - remove after preprocessing

Before we group the data by the state identifier, let's convert all three
columns to integers.

.. todo:: Switch this to splitting the stream when that is in

.. ipython:: python

    convert_row = compose(tuple, map(int))
    pipe('/Users/bn8210wy/Desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # Temparary - remove after preprocessing
          drop(1), # Drop the header
          pluck([7, 33, 112]),
          filter(is_US),
          map(convert_row),
          list) # Temparary - remove after preprocessing

The task, compute the mean value per state, is an example of ``reduceby``.  To
use this pattern, we need to write a key function that classifies each row and
an update function used to reduce each group to a statistic.  Because we need
both the numerator and denominator, we will need to use a reduction that keeps
track of both statistics simultaneously.

.. ipython:: python

    convert_row = compose(tuple, map(int))
    group_by_state = get(2)
    weighted_sum_update = lambda acc, row: (acc[0] + get(0, row)*get(1, row),
                                            acc[1] + get(0, row))
    pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # temparary - remove after preprocessing
          drop(1), # drop the header
          pluck([7, 33, 112]),
          filter(is_US),
          map(convert_row),
          reduceby(group_by_state, weighted_sum_update, init=(0,0)))

Now we need to divide the numerators and denominators for each state, which is
accomplished with ``valmap``.


.. ipython:: python

    convert_row = compose(tuple, map(int))
    group_by_state = get(2)
    weighted_sum_update = lambda acc, row: (acc[0] + get(0, row)*get(1, row),
                                            acc[1] + get(0, row))
    divide = lambda tup: tup[0]/tup[1]
    pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
          read_csv,
          take(20), # temparary - remove after preprocessing
          drop(1), # drop the header
          pluck([7, 33, 112]),
          filter(is_US),
          map(convert_row),
          reduceby(group_by_state, weighted_sum_update, init=(0,0)),
          valmap(divide))

Now that we have prototyped the process on a small number of nodes, it is time
to remove the guards (``take(20)``) and let the process go on the whole file.
We save the result of this computation (a dictionary with one pair per state)
for later processing.

.. ipython:: python

    convert_row = compose(tuple, map(int))
    group_by_state = get(2)
    weighted_sum_update = lambda acc, row: (acc[0] + get(0, row)*get(1, row),
                                            acc[1] + get(0, row))
    divide = lambda tup: tup[0]/tup[1]
    state_means = pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
                       read_csv,
                       drop(1), # drop the header
                       filter(is_US),
                       pluck([7, 33, 112]),
                       map(convert_row),
                       reduceby(group_by_state, weighted_sum_update, init=(0,0)),
                       valmap(divide))


What happened above is a common occurance.  I thought the code was working, but
there is a case in the larger file that I didn't see or consider: missing data.
We have to make a decision on how to deal with these cases.  Our options are (1)
use a default value of 0 when missing data or (2) filter out these cases.  Both
solutions have their drawbacks.  In this case, I will simply filter out all rows
that are missing one of the three entries.

Since we are back to prototyping a solution, this time to fix a bug, we
reintroduce ``take`` to make the testing fast.

.. ipython:: python

    convert_row = compose(tuple, map(int))
    group_by_state = get(2)
    weighted_sum_update = lambda acc, row: (acc[0] + get(0, row)*get(1, row),
                                            acc[1] + get(0, row))
    divide = lambda tup: tup[0]/tup[1]
    is_not_empty = lambda s: s != ''
    non_empty_row = compose(all, map(is_not_empty))
    state_means = pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
                       read_csv,
                       drop(1), # drop the header
                       take(10000), # temparary for prototyping
                       pluck([7, 33, 112]),
                       filter(is_US),
                       filter(non_empty_row),
                       map(convert_row),
                       reduceby(group_by_state, weighted_sum_update, init=(0,0)),
                       valmap(divide))
    list(state_means.items())[:10]


A process like this can take a long time to complete.  To help track progress,
we will use ``side_effect`` from the ``more_itertools`` library to print a
message every 1,000,000 rows.

.. ipython:: python

    from more_itertools import side_effect
    side_effect = curry(side_effect)

    print_progress = lambda x: print("Processing another 1,000,000 rows")

    #
    ## Main processing stream
    #

    state_means = pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
                       read_csv,
                       drop(1), # drop the header
                       take(10000), # temparary for prototyping
                       side_effect(print_progress, chunk_size=1000000),
                       pluck([7, 33, 112]),
                       filter(is_US),
                       filter(non_empty_row),
                       map(convert_row),
                       reduceby(group_by_state, weighted_sum_update, init=(0,0)),
                       valmap(divide))

Before processing the whole file, we should reexamine the process and make sure
that all of the parts that are streaming the files are lazy.  In this case, the
top 6 lines represent lazy sequences and the first item that will accumulate
data in memory will be ``reduceby``.  Luckily, we are only keeping a couple of
number per state, so this shouldn't be a problem with memory.  If we were
accumulating more information than memory would allow, we would need to look to
another solution.  Since we have confirmed that this process is safe, let's
remove the guard and process the whole file.


.. sourcecode:: python

    In [44]: state_means = pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
       ....:                    read_csv,
       ....:                    drop(1), # drop the header
       ....:                    side_effect(print_progress, chunk_size=1000000),
       ....:                    pluck([7, 33, 112]),
       ....:                    filter(is_US),
       ....:                    filter(non_empty_row),
       ....:                    map(convert_row),
       ....:                    reduceby(group_by_state, weighted_sum_update, init=(0,0)),
       ....:                    valmap(divide))
       ....: 
    Processing another 1,000,000 rows
    Processing another 1,000,000 rows
    Processing another 1,000,000 rows
    Processing another 1,000,000 rows
    Processing another 1,000,000 rows

    In [45]: state_means
    Out[45]: 
    {-9: 2046.2699365722697,
     1: 999.9947105822915,
     2: 1005.0048362739664,
     4: 726.756242052686,
     5: 1009.466231775314,
     6: 1558.4499375623134,
     8: 1552.1935989799554,
     9: 1789.1496099356484,
     10: 899.4040456732163,
     11: 2079.9369871958665,
     12: 838.0531860436864,
     13: 951.6220401800159,
     15: 1625.5767279905683,
     16: 2832.0063575622594,
     17: 3858.14536902721,
     18: 2790.0015546250092,
     19: 3448.747840879351,
     20: 2956.399048848033,
     21: 3252.290016740979,
     22: 1535.0876356557521,
     23: 1757.8102677368959,
     24: 2239.297897364191,
     25: 3124.465451212315,
     26: 2960.5169941729014,
     27: 3628.6608676898745,
     28: 1870.5233594943845,
     29: 3238.267152158706,
     30: 2588.821377840909,
     31: 3129.632818078311,
     32: 1472.4052393272962,
     33: 3214.308993515647,
     34: 3439.9406829790187,
     35: 1304.4119480317108,
     36: 4411.493735561985,
     37: 1673.9786311982366,
     38: 3999.247241640697,
     39: 3203.140221656785,
     40: 2484.5488916707764,
     41: 2206.3035717426096,
     42: 3680.1409606887096,
     44: 1798.405566658829,
     45: 1492.2188974478797,
     46: 2788.7323254961084,
     47: 1963.930496697591,
     48: 2079.411455332534,
     49: 2899.093137254902,
     50: 1741.443880688807,
     51: 2296.1152456323725,
     53: 3046.7845175626767,
     54: 2883.3576292748635,
     55: 3694.9032502831255,
     56: 1816.7817351598173}

.. .. ipython:: python
.. 
..     state_means = pipe('/users/bn8210wy/desktop/census/2011_2015/ss15pusa.csv',
..                        read_csv,
..                        drop(1), # drop the header
..                        side_effect(print_progress, chunk_size=1000000),
..                        pluck([7, 33, 112]),
..                        filter(is_US),
..                        filter(non_empty_row),
..                        map(convert_row),
..                        reduceby(group_by_state, weighted_sum_update, init=(0,0)),
..                        valmap(divide))
..     state_means


Finally, we will print this information out to a file.  To do this, we first
need to convert the current dictionary into a table using the ``items``
dictionary method, which is accomplished with the helper function
``dict_to_table``.  Then we will convert each row to a comma separated string
and finally use ``side_effect`` to print each row out to a file with ``consume``
at the end to "eat" the strings, keeping memory clean.  To make this work, we
move the ``pipe`` inside a ``with`` statement that opens and closes the output
file.  Note that the helper function for printing to the output file needs to be
constructed *inside* the ``with`` statement to allso access to the file handler.

.. ipython:: python

    dict_to_table = lambda d: d.items()
    comma_sep_row = lambda row: ','.join(map(str, row))

    with open('interest_by_state.csv', 'w') as outfile:
        print_to_outfile = lambda row_str: print(row_str, file=outfile) 
        pipe(state_means,
             dict_to_table,
             map(comma_sep_row),
             side_effect(print_to_outfile),
             consume)

Processing a number of large files
----------------------------------

Reducing and joining large files
--------------------------------
