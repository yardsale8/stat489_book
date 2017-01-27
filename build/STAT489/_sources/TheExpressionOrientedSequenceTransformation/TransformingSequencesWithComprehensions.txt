..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Transforming Sequences with Comprehensions
==========================================

Python has a very convenient method for describing one list in terms for another
call a *list comprehension*.  Comprehensions are very "functional" in their
nature and we will make heavy use of these comprehensions moving forward.


List Comprehensions
-------------------

Suppose that we wish to create a list from a sequence of values based on some
selection criteria.  An easy way to do this type of processing in Python is to
use a **list comprehension**.  List comprehensions are concise ways to create
lists.  The general syntax is::

   [<expression> for <item> in <sequence> if  <condition>]

where the if clause is optional.  For example,


.. ipython:: python

    mylist = [1,2,3,4,5]
    yourlist = [item ** 2 for item in mylist]
    yourlist

The expression describes each element of the list that is being built.  The
``for`` clause iterates through each item in a sequence.  The items are filtered
by the ``if`` clause if there is one.  In the example above, the ``for``
statement lets ``item`` take on all the values in the list ``mylist`` one after
the other. Each item is then squared before it is added to the list that is
being built.  The result is a list of squares of the values in ``mylist``.



.. figure:: http://python-3-patterns-idioms-test.readthedocs.io/en/latest/_images/listComprehensions.gif
    :alt: Parts of a list comprehension

    ..
    
    The three parts of a comprehension are the **output expression**, the
    description of the sequence, and the (optional) **predicate**.  This image
    is copied from the open source `Python 3 Patterns, Recipes and Idioms
    <https://bitbucket.org/BruceEckel/python-3-patterns-idioms/src/8f0091a18c73074fca1da624c652a9adb456654b/src/Introduction.rst?at=default&fileviewer=file-view-default>`_
    book and is shared under the `Creative Commons Attribution-Share Alike 3.0
    <http://creativecommons.org/licenses/by-sa/3.0/>`_ license.


The built-in ``range`` Python function is a useful tool for generating a
sequence of numbers.  The sequence provided by ``range`` always starts with 0.
If you ask for ``range(4)``, then you will get 4 values starting with 0.  In
other words, 0, 1, 2, and finally 3.  Notice that 4 is not included since we
started with 0.  Likewise, ``range(10)`` provides 10 values, 0 through 9.

.. ipython:: python

      [ i for i in range(4)]
      [x for x in range(10)]

.. note::

    Computer scientists like to count from 0! We will explain the reason why in
    the next chapter.


The `range <http://docs.python.org/py3k/library/functions
.html?highlight=range#range>`_ function is actually a very powerful function
when it comes to creating sequences of integers.  It can take one, two, or three
parameters.  We have seen the simplest case of one parameter such as
``range(4)`` which creates ``[0, 1, 2, 3]``.  But what if we really want to have
the sequence ``[1, 2, 3, 4]``?  We can do this by using a two parameter version
of ``range`` where the first parameter is the starting point and the second
parameter is the ending point.  The evaluation of ``range(1,5)`` produces the
desired sequence.  What happened to the 5?  In this case we interpret the
parameters of the ``range`` function to mean ``range(start,stop+1)``.


.. note::

    Why in the world would range not just work like range(start, stop)?  Think
    about it like this.  Because computer scientists like to start counting at 0
    instead of 1, ``range(N)`` produces a sequence of things that is N long, but
    the consequence of this is that the final number of the sequence is N-1.  In
    the case of start, stop it helps to simply think that the sequence begins
    with start and continues as long as the number is less than stop.

Here are a three examples for you to considered.  

.. ipython:: python

    [i for i in range(4)]
    [x for x in range(1, 10)]
    [item for item in range(1,10,2)]

Notice that the last call to ``range`` added the third parameter, which
represents the **step size**.  In this case, every item is 2 more than the last
item.   Making a list that counts down from some starting number can be
accomplished using a negative step size.

.. ipython:: python

    [ i for i in range(10, 0, -1)]


**Check your understanding**

.. mchoice:: test_question3_5_1
  :answer_a: Range should generate a list that stops at 9 (including 9).
  :answer_b: Range should generate a list that starts at 10 (including 10).
  :answer_c: Range should generate a list starting at 3 that stops at 10 (including 10).
  :answer_d: Range should generate a list using every 10th number between the start and the stopping number.
  :correct: a
  :feedback_a: Range will generate the list [3, 5, 7, 9].
  :feedback_b: The first argument (3) tells range what number to start at.
  :feedback_c: Range will always stop at the number before (not including) the specified ending point for the list.
  :feedback_d: The third argument (2) tells range how many numbers to skip between each element in the list.

  In the command range(3, 10, 2), what does the second argument (10) specify?

.. mchoice:: test_question3_5_2
  :answer_a: range(2, 5, 8)
  :answer_b: range(2, 8, 3)
  :answer_c: range(2, 10, 3)
  :answer_d: range(8, 1, -3)
  :correct: c
  :feedback_a: This command generates the list [2] because the first number (2) tells range where to start, the second number tells range where to end (5, not inclusive) and the third number tells range how many numbers to skip between elements (8).  Since 10>= 8, there is only one number in this list.
  :feedback_b: This command generates the list [2, 5] because 8 is not less than 8 (the specified ending number).
  :feedback_c: The first number is the starting point, the second is the maximum allowed, and the third is the amount to increment by.
  :feedback_d: This command generates the list [8, 5, 3] because it starts at 8, ends at (or above 1), and skips every third number going down.

  What command correctly generates the list [2, 5, 8]?

.. mchoice:: test_question3_5_3
  :answer_a: It will generate a list starting at 0, with every number included up to but not including the argument it was passed.
  :answer_b: It will generate a list starting at 1, with every number up to but not including the argument it was passed.
  :answer_c: It will generate a list starting at 1, with every number including the argument it was passed.
  :answer_d: It will cause an error: range always takes exactly 3 arguments.
  :correct: a
  :feedback_a: Yes, if you only give one number to range it starts with 0 and ends before the number specified incrementing by 1.
  :feedback_b: Range starts at 0 unless otherwise specified.
  :feedback_c: Range starts at 0 unless otherwise specified, and never includes its ending element (which is the argument it was passed).
  :feedback_d: If range is passed only one argument, it interprets that argument as the end of the list (not inclusive).

  What happens if you give range only one argument?  For example: range(4)


One final note about the ``range`` function in python: it is lazy!  Notice that
trying to evaluate this function by itself doesn't return the list.  Instead, it
returns a **generator** object that will wait as long as possible to generate
this list.  

.. ipython:: python

    range(5)

We have a number of methods for forcing ``range`` to complete the process
including comprehensions and the ``list`` conversion function.

.. ipython:: python

    list(range(5))

.. note::

    There are a number of lazy constructions in Python 3. We will look at these
    features in a later chapter.


An alternative method for generating odd values involves using a Boolean
function to filter items out of our list using the optional if clause.  For
example, let's compute the cube root for all odd values less than 10. 

.. ipython:: python

    is_odd = lambda x: x % 2 == 1
    cube_root = lambda x: x**(1/3)
    [cube_root(x) for x in range(10) if is_odd(x)]

Why might we want to use this version of the comprehension?  Here we are using
two explicit abstractions to describe the *intent* of our code.  This should
make it easier for someone that later reads through the code to understand the
meaning of this construction, i.e. that we are taking the *cube root* of *odd
numbers* up to 10.


**Check your understanding**

.. mchoice:: test_question9_20_1
   :answer_a: [4,2,8,6,5]
   :answer_b: [8,4,16,12,10]
   :answer_c: 10
   :answer_d: [10].
   :correct: d
   :feedback_a: Items from alist are doubled before being placed in blist.
   :feedback_b: Not all the items in alist are to be included in blist.  Look at the if clause.
   :feedback_c: The result needs to be a list.
   :feedback_d: Yes, 5 is the only odd number in alist.  It is doubled before being placed in blist.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4,2,8,6,5]
     blist = [num*2 for num in alist if num%2==1]
     print(blist)


.. note::

    This workspace is provided for your convenience.  You can use this
    activecode window to try out anything you like.

    .. activecode:: scratch_08_01

List Comprehensions for Two Dimensional Data
------------------------------------------

**Two dimensional (2D) data** is data that can be displayed in a table.  An
examples of two dimensional data include matrices and images.  We can use list
comprehensions to transform and filter 2D data by embedding one list
comprehension in another.

Consider the following matrix of integers.

.. math::
    \left[ \begin{array}{ccc}
                1, 2, 3\\
                4, 5, 6\\
                7, 8, 9
           \end{array}\right]


One method for representing this matrix in Python is with a list of lists.

.. ipython:: python

    mat = [[1,2,3],[4,5,6],[7,8,9]]
    mat

To write a comprehension that transforms 2D data into another 2D list, we embed
a comprehension inside a comprehension.

.. figure:: Figures/2D_comprehension.png
    :alt: 2D comprehension

    ..

    A 2D comprehension consists of a list comprehension inside another
    comprehension.  The outer sequence consists of all rows of the matrix
    and the inner sequence consists of elements from each row.  The inner
    comprehension can be thought of as representing each of the new rows in
    the resulting matrix.

For example, the following code will generate a new matrix that contains the
square of each value from the first matrix.

.. ipython:: python

    new_mat = [[e**2 for e in row] for row in mat]
    new_mat



For this example, we will transform an image by replacing all of the black
pixels with white pixels.  Recall that an image from `skimage` is stored as a
3D array of RGB values, but can be iterated over as a 2D matrix of tuples of 3
values.  Consider the following code,

.. sourcecode:: python

    from skimage import data
    import matplotlib.pylab as plt
    import numpy as np
    %matplotlib inline
    hub = data.hubble_deep_field()
    plt.imshow(hub)

which displays the following image.

.. image:: Figures/hubble_black.png

The RGB code for (pure) black is `(0,0,0)`.  The following code splits the task
into three parts.  First, the function `is_black` checks that each color is 0.
Next, the function `black_to_white` switches black to white (rgb(255,255,255)),
but otherwise leaves the color as is.  Finally, a 2D comprehension is used to
make a new image matrix or tuples.  Note that this array needs to be converted
to a `numpy array`.

.. sourcecode:: python

    # Black RGB is (0, 0, 0), we check that all colors == 0
    is_black = lambda t: all([col == 0 for col in t])

    # Replace black (0,0,0) with white (255, 255, 255) else leave it alone
    black_to_white = lambda t: (255,255,255) if is_black(t) else t

    #apply black_to_white to each RGB tuple
    new_img = np.array([[black_to_white(tup) for tup in row] for row in hub])
    plt.imshow(new_img)

The resulting image is shown below.

.. image:: Figures/hubble_white.png
