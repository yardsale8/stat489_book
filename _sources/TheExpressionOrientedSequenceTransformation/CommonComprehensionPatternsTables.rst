..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Common Comprehension Patterns for Tables
========================================

In this final section on common comprehension patterns, we look at using
comprehensions to transform 2D data structures.


Flatten a 2D data structure
---------------------------

A 2D data structure can be flattened using two ``for`` expressions.  The second
``for`` will iterate over the *rows* from the first ``for``.  To flatten the
data structure, don't include an inner comprehension.


.. ipython:: python

    list_of_lists = [[1], [1, 2], [4, 5, "a"]]
    flat_list = [item for row in list_of_lists for item in row]
    flat_list

This pattern can take some time to get used to, but we note that it matches the
imperative approach to the sample problem.

.. ipython:: python

    flat_list = []
    for row in list_of_lists:
        for item in row:
            flat_list.append(item)
    flat_list

The following figure illustrates this connection.

.. figure:: Figures/two_for_diagram.png
    :alt: A comparison of a double for loop and list comprehension with two ``for`` expressions

    ..

    The list comprehension for looping through all rows and items preserves the
    order shown in the double for loop from the imperative approach.

In general, readers familiar with writing imperative loops can use those
patterns to transition to comprehensions.
    
Joining Tables
--------------

If our lists represent 2D tables of data, we can use comprehensions to join two
tables, a common operation in SQL.  

.. note:: 

     If you don't recall the distinctions between the different types of joins,
     see the first answer to `this stack overflow question
     <http://stackoverflow.com/questions/38549/what-is-the-difference-between-inner-join-and-outer-join>`_.

Recall that an *inner-join* combines all rows such that the rows match in some
way.  For example, if we have two lists that contain our employees hours and job
title, respectively.  The following program computes the inner join of these two
tables when matching the employees name.  Any rows for employees that don't
appear in both tables will be dropped.

.. ipython:: python

    hours = [["Alice", 43],
               ["Bob", 37],
               ["Fred", 15]]
    titles = [["Alice", "Manager"],
              ["Betty", "Consultant"],
              ["Bob", "Assistant"]]

    inner_join = [ (nameH, ttl, hrs) for nameH, hrs in hours for nameT, ttl in titles if nameH == nameT]
    inner_join

The key to joining the rows on common names is the use of the ``nameH ==
nameT``, which guarantees that only combinations of rows where the names match
will be processes.  

**Check your understanding**


.. mchoice:: join_1
    :answer_a: [(10, 'zero'), (11, 'one')]
    :answer_b: [(10, 'zero'), (10, 'one'), (11, 'zero'), (11, 'one')]
    :answer_c: [(10, 0), (11, 1)]
    :correct: a
    :feedback_a: This join will keep the second entries of the tuple when the first entries match.
    :feedback_b: This join will keep the second entries of the tuple, but only  when the first entries match.
    :feedback_c: Note that we are keeping j and w, the second entry in the respective tuples.

    Determine the table that will result from the following join.

    .. sourcecode:: python

        t1 = [(0, 10), (1, 11)]
        t2 = [(0, "zero"), (1, "one")]
        [(j, w) for i, j in t1 for n, w in t2 if n == i]

The left outer join of the tables will include all of the
rows from the first list, as well as the values from the second table if
present.  Here is the code for performing a left outer join using a list
comprehension.  We do this by combining the inner join with the rows that only
appear in the left table.

.. ipython:: python

    hours = [["Alice", 43],
               ["Bob", 37],
               ["Fred", 15]]

    titles = [["Alice", "Manager"],
              ["Betty", "Consultant"],
              ["Bob", "Assistant"]]

    left_names = [name for name, h in hours]
    right_names = [name for name, t in titles]

    inner_join = [ (nameH, ttl, hrs) for nameH, hrs in hours for nameT, ttl in titles if nameH == nameT]
    left_only_rows = [(name, None, hrs) for name, hrs in hours if name not in right_names]
    left_join = inner_join + left_only_rows
    left_join

To get the rows that are exclusive to the left table, we need to identify rows
with names that are only in the left-hand table.  This is facilitated by
creating the list of names for both lists, namely ``left_names`` and
``right_names``, and then filtering to check that ``name not in right_names`` in
the construction of ``left_only_rows``.  As these rows are not in the right
table, and thus lack a job title, we use ``None`` to represent a missing value.
Finally, the ``left_only_rows`` are added to the ``inner_join`` rows to
construct the ``left_join``.

You may have noticed that this approach required us to iterate through each
table a number of times.  This is not the most efficient implementation, and a
solution that uses a relational database should be more efficient and used to
larger problems, but for small problem this approach should be fine.


