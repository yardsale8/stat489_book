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

Character classification
------------------------

It is often helpful to examine a character and test whether it is upper- or
lowercase, or whether it is a character or a digit. The ``string`` module
provides several constants that are useful for these purposes. One of these,
``string.digits`` is equivalent to "0123456789".  It can be used to check if a
character is a digit using the ``in`` operator.

The string ``string.ascii_lowercase`` contains all of the ascii letters that the
system considers to be lowercase. Similarly, ``string.ascii_uppercase`` contains
all of the uppercase letters. ``string.punctuation`` comprises all the
characters considered to be punctuation. Try the following and see what you get.

.. ipython:: python
   
    import string
    string.ascii_lowercase
    string.ascii_uppercase
    string.digits
    string.punctuation

For more information consult the ``string`` module documentation (see `Global
Module Index <http://docs.python.org/py3k/py-modindex.html>`_).

We can use list comprehensions to describe a new string, but we need to convert
the result back to a string using the ``str`` conversion function.  For example,
let's remove all of the punctuation from a string.

.. ipython:: python

    zen_of_python = '''The Zen of Python, by Tim Peters
    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!'''

    zen_list_no_punc = [ch for ch in zen_of_python if ch not in string.punctuation]
    print(zen_list_no_punc)
    zen_string_no_punc = ''.join(zen_list_no_punc)
    print(zen_string_no_punc)

.. note::

    You can contemplate the zen of Python anytime by executing ``import this``.

    .. ipython:: python

        import this

.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_08_04


Common Comprehension Patterns
=============================

TODO

Use built-in helper functions
-----------------------------

Use built-in functions to reduce a list to a value
--------------------------------------------------

There are a number of built-in Python functions that help us reduce a list to a
value, including ``sum``, ``len``, ``max``, and ``min``.  Remember to use these
functions along with a list comprehension to describe a computation on a
sequence of values.

For example, suppose that we want to compute `the sum of squares
<https://en.wikipedia.org/wiki/Squared_deviations_from_the_mean>`_ for a small
set of numbers.  Let's give this a try using the regular definition, shown
below.

.. math:: 

    SS = \sum_{i=1}^n (y_i - \bar{y})^2

For each value in the list we must subtract the mean and the square this
difference.  Finally, we add up all of these values.  We will create a function
for computing the mean and then another for computing the sum of squares.

.. ipython:: python

    mean = lambda L: sum(L)/len(L)
    ss = lambda L: sum([(i - mean(L))**2 for i in L])
    my_list = [1,2,3,4,5]
    mean(my_list)
    ss(my_list)

On a modern computer, the above code is reasonably fast for fairly small lists.
Next, we use the IPython ``%timeit`` magic to time our function on various size
lists.

.. sourcecode:: python

    In [31]: %timeit ss(range(10**2))
       ....: %timeit ss(range(10**3))
       ....: %timeit ss(range(10**4))
       ....: 
    1000 loops, best of 3: 666 us per loop
    10 loops, best of 3: 53.2 ms per loop
    1 loop, best of 3: 5.97 s per loop

Notice that the ``ss`` function is taking about 100 times as long each time we
multiple the length of the list by 10.  This hints at a complexity of
:math:`O(n^2)`.  Consider the complexity of these functions.  The ``mean``
function must visit each element of the list and is :math:`O(n)`.  The
inefficiency of the ``ss`` function results from calling the ``mean`` function
**for each value in the list!**.  Thus the time complexity of ``ss`` is
:math:`n*O(n) = O(n*n) = O(n^2)`.  We can fix this issue by using the usual
simplification shown below.

.. math:: 

    SS = \sum_{i=1}^n{y_i^2} - \frac{\left(\sum_{i=1}^n y_i\right)^2}{n}

.. ipython:: python

    ss = lambda L: sum([i**2 for i in L]) - sum(L)**2/len(L)
    my_list = [1,2,3,4,5]
    ss(my_list)

Now we refactor the code to clear up the meaning of each part.

.. ipython:: python

    sum_square_values = lambda L: sum([i**2 for i in L])
    ss = lambda L: sum_square_values(L) - (sum(L))**2/len(L)
    my_list = [1,2,3,4,5]
    ss(my_list)

Each of the component functions, ``len``, ``sum_values`` and
``sum_square_values``, is :math:`O(n)` (they each visit a list element exactly
once and perform a :math:`O(1)` computation).  Therefore, this implementation is
:math:`O(n)`, which is illustrated below by the 10 fold increase in computation
time when increasing the length of a list by a factor of 10.

.. sourcecode:: python

    In [31]: %timeit ss(range(10**2))
       ....: %timeit ss(range(10**3))
       ....: %timeit ss(range(10**4))
    
    10000 loops, best of 3: 42.5 us per loop
    1000 loops, best of 3: 406 us per loop
    100 loops, best of 3: 4.11 ms per loop

.. admonition:: Beware of Premature Optimization!

    A well-known computer scientist, `Donald Knuth
    <https://en.wikipedia.org/wiki/Donald_Knuth>`_, `once said
    <http://web.archive.org/web/20130731202547/http://pplab.snu.ac.kr/courses/adv_pl05/papers/p261-knuth.pdf>`_

        Programmers waste enormous amounts of time thinking about, or worrying
        about, the speed of noncritical parts of their programs, and these
        attempts at efficiency actually have a strong negative impact when
        debugging and maintenance are considered. We should forget about small
        efficiencies, say about 97% of the time: **premature optimization is the
        root of all evil.** Yet we should not pass up our opportunities in that
        critical 3%. 
    
    It is important to think about the efficiency of your program, but follow
    Knuth's advice and worry about it only after you have demonstrated it is
    slow.  Instead, follow `another pieces of advice from Knuth
    <https://en.wikiquote.org/wiki/Donald_Knuth>`_.

        Let us change our traditional attitude to the construction of programs:
        Instead of imagining that our main task is to instruct a computer what
        to do, **let us concentrate rather on explaining to human beings what we
        want a computer to do.** 

    That is, you should focus on describing what your program does in such a way
    that another programmer can understand just by reading your code.



Use ``any`` and ``all`` for Boolean questions about a list
----------------------------------------------------------

There are two more functions that help use reduce a list to a value.  The Python
built-in functions ``any`` and ``all`` are useful when asking Boolean questions
about a list.  The function ``any`` takes a sequence as input and returns True
if *any* of the elements in the sequence evaluate to ``True``.  On the other
hand, when ``all`` is applied to a sequence, it only evaluates to ``True`` if
*all* of the elements of said sequence evaluate to ``True``.

Suppose that we want to know if any or all of the elements of a list are even.
We can write a lambda functions to perform each task as follows.

.. ipython:: python

    all_even = lambda L: all([ i % 2 == 0 for i in L])
    any_even = lambda L: any([ i % 2 == 0 for i in L])
    my_list = [1,2,3,4,5]
    any_even(my_list)
    all_even(my_list)

Notice that this pattern involves

1. Using a Boolean expression in the output expression of the comprehension.
2. Applying ``any`` or ``all`` to the list of Boolean values.

Let's refactor this code to clean it up, namely by introducing an ``is_even``
function.

.. ipython:: python

    is_even = lambda n: n % 2 == 0
    all_even = lambda L: all([is_even(i) for i in L])
    any_even = lambda L: any([is_even(i) for i in L])
    my_list = [1,2,3,4,5]
    any_even(my_list)
    all_even(my_list)

Use ``for`` twice to get all combinations
---------------------------------------

Suppose that we have two list ``L`` and ``M`` and we want to perform some
computation on all combinations of elements from these two lists.  This can be
accomplished using two (independent) ``for`` twice, once for each list.  The code
shown below creates a tuple of all combinations.

.. ipython:: python

    L = [1,2,3]
    M = ["a", "b"]

    new_list = [(i,j) for i in L for j in M]
    new_list

The second ``for`` can depend on the first
------------------------------------------

The last example illustrated a comprehension pattern for constructing all
combinations of elements from two list.  Consider the following program, which
applies this technique to one list versus itself.


.. ipython:: python

    L = [1,2,3]

    new_list = [(i,j) for i in L for j in L]
    new_list

Notice that some combinations are repeated, e.g. ``(1,2)`` and ``(2,1)``.
Suppose that instead we want all unique pairs of values.  In math, this
collection is often described as all :math:`i,j` such that :math:`i \le j`.  We
can use this approach with comprehensions as well.  Two methods are shown below.

**Method 1 - Filter with ``if``**

.. ipython:: python

    L = [1,2,3]

    new_list = [(i,j) for i in L for j in L if i <= j]
    new_list

The first approach matches the mathematical definition exactly and ensures that
no value is matched with another value more than once by keeping the pairs
sorted.  One of the reasons that comprehensions are useful is they mirror the
mathematical language of describing a collection.  The only drawback to this
approach is that it requires cycling through all combinations.  Because that are
:math:`n` values to pair with each of :math:`n` values, this operation is
:math:`O(n*n)=O(n^2)`.  Suppose that we know that there are no repeated values
in ``L``.  In this case, we can filter by *indices* instead of *values*.  The
resulting method, while still :math:`O(n^2)`, will be close to twice as fast.


**Method 2 - Use indices and ``range`` to filter**

.. ipython:: python

    L = [1,2,3]
    n = len(L)
    new_list = [(L[i],L[j]) for i in range(n) for j in range(i,n)]
    new_list

This approach ensures that no indice is matched with another indice more than
once.  The key point here is that we made the second ``range`` depend on the
first, shortening the length of the sequence.  Provided that all the elements of
``L`` are unique, this second method iterates over :math:`\frac{n(n-1)}{2}`
elements instead of :math:`n^2`.  In the long run, this approach will be a
little less than twice as fast but approach exactly twice as fast
asymptotically.  Unfortunately, :math:`O\left(\frac{n(n-1)}{2}\right)=O\left(\frac{n^2}{2} -
\frac{n}{2}\right)=O(n^2)`, so this will still be expensive for large list.

Sometimes it is easier to describe what your don't want
-------------------------------------------------------

Suppose that we want to use list comprehensions to describe all the prime
numbers up to ``n=120``.  A well-known algorithm for describing primes is the
`Sieve of Eratosthenes <https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes>`_,
For each number ``i`` between 2 and :math:`\sqrt{n}`, this algorithm crosses out
all the multiples of ``i``.  The remaining numbers will be prime.  Notice that
this algorithm describes numbers that are prime by *decribing all numbers that
are not*.  The following two list comprehensions perform the task of finding all
primes up to 120.

.. ipython:: python

    from math import sqrt
    n = 120
    not_prime = [j for i in range(2, int(sqrt(n) + 1)) for j in range(2*i,n + 1, i)]
    prime = [i for i in range(2,n+1) if i not in not_prime]
    prime

**Illustration of the Sieve of Eratosthenes**

.. figure:: https://upload.wikimedia.org/wikipedia/commons/b/b9/Sieve_of_Eratosthenes_animation.gif
    :alt: Illustration of the Sieve of Eratosthenes
    
    ..

    The Sieve of Eratosthenes finds all the primes up to some number ``n`` by
    crossing out all multiples of numbers from 2 to :math:`\sqrt{n}`.  This image was
    copied from `Wikipedia
    <https://commons.wikimedia.org/wiki/File:Sieve_of_Eratosthenes_animation.gif>`_
    and is covered by the `GNU Free Documentation License
    <https://en.wikipedia.org/wiki/en:GNU_Free_Documentation_License>`_.

As always, we can clean this code up with a little refactoring.  Let's use two
lambda expressions to give meaning two applications of range in ``not_prime``.

.. ipython:: python

    from math import sqrt
    n = 120
    possible_factors = lambda n: range(2, int(sqrt(n) + 1)) 
    multiples_of = lambda i, n: range(2*i,n + 1, i)
    not_prime = [j for i in possible_factors(n) for j in multiples_of(i, n)]
    prime = [i for i in range(2,n+1) if i not in not_prime]
    prime

.. admonition:: question

    How might you make the last example more general?

Apply Tranformations at Each Level of Abstraction
-------------------------------------------------

.. todo:: Include the examples found in ~/Desktop/grayscale.py
TODO


1. iterators: zip, enumerate, reversed
3. working with tuples
4. comprehensions for tables and matrices
