Mutable and Immutable Sequences
===============================

We have seen that in many ways lists and strings are similar, but there is a
major distinction between these containers.  In this section, we introduce the
idea for *mutable* and *immutable* sequences and reconsider lists, strings and
tuples in this light.

Strings and Tuples are Immutable
--------------------------------

One final thing that makes strings different from lists is that you are not
allowed to modify the individual characters in the collection.  It is tempting
to use the ``[]`` operator on the left side of an assignment, with the intention
of changing a character in a string.  For example, in the following code, we
would like to change the first letter of ``greeting``.

.. ipython:: python
    
    greeting = "Hello, world!"
    greeting[0] = 'J'            # ERROR!
    greeting

Instead of producing the output ``Jello, world!``, this code produces the
runtime error ``TypeError: 'str' object does not support item assignment``.

Strings are **immutable**, which means you cannot change an existing string. The
best you can do is create a new string that is a variation on the original.

.. ipython:: python
    
    greeting = "Hello, world!"
    newGreeting = 'J' + greeting[1:]
    newGreeting
    greeting            # same as it was

The solution here is to concatenate a new first letter onto a slice of
``greeting``. This operation has no effect on the original string.

Unlike lists, however, tuples are immutable.  As with strings, if we try to use
item assignment to modify one of the elements of the tuple, we get an error.

.. ipython:: python

    julia[0] = 'X'

Of course, even if we can't modify the elements of a tuple, we can make a
variable reference a new tuple holding different information.  To construct the
new tuple, it is convenient that we can slice parts of the old tuple and join up
the bits to make the new tuple.  So ``julia`` has a new recent film, and we
might want to change her tuple.  We can easily slice off the parts we want and
concatenate them with the new tuple.

.. ipython:: python


    julia = ("Julia", "Roberts", 1967, "Duplicity", 2009, "Actress", "Atlanta, Georgia")
    julia[2]
    julia[2:6]

    len(julia)

    julia = julia[:3] + ("Eat Pray Love", 2010) + julia[5:]
    julia


**Check your understanding**

.. mchoice:: test_question8_7_1
   :answer_a: Ball
   :answer_b: Call
   :answer_c: Error
   :correct: c
   :feedback_a: Assignment is not allowed with strings.
   :feedback_b: Assignment is not allowed with strings.
   :feedback_c: Yes, strings are immutable.

   What is printed by the following statements:
   
   .. code-block:: python

      s = "Ball"
      s[0] = "C"
      print(s)



Lists are Mutable
-----------------

Unlike strings and tuples, lists are **mutable**.  This means we can change an
item in a list by accessing it directly as part of the assignment statement.
Using the indexing operator (square brackets) on the left side of an assignment,
we can update one of the list items.

.. ipython:: python
    
    fruit = ["banana", "apple", "cherry"]
    fruit

    fruit[0] = "pear"
    fruit[-1] = "orange"
    fruit


An assignment to an element of a list is called **item assignment**. Item
assignment does not work for strings or tuples, as they are both immutable.

Here is the same example in codelens so that you can step through the statements
and see the changes to the list elements.

.. codelens:: item_assign
    
    fruit = ["banana", "apple", "cherry"]

    fruit[0] = "pear"
    fruit[-1] = "orange"



By combining assignment with the slice operator we can update several elements at once.

.. ipython:: python
    
    alist = ['a', 'b', 'c', 'd', 'e', 'f']
    alist[1:3] = ['x', 'y']
    alist

We can also remove elements from a list by assigning the empty list to them.

.. ipython:: python
    
    alist = ['a', 'b', 'c', 'd', 'e', 'f']
    alist[1:3] = []
    alist

We can even insert elements into a list by squeezing them into an empty slice at
the desired location.

.. ipython:: python
    
    alist = ['a', 'd', 'f']
    alist[1:1] = ['b', 'c']
    alist
    alist[4:4] = ['e']
    alist

**Check your understanding**

.. mchoice:: test_question9_7_1
   :answer_a: [4, 2, True, 8, 6, 5]
   :answer_b: [4, 2, True, 6, 5]
   :answer_c: Error, it is illegal to assign
   :correct: b
   :feedback_a: Item assignment does not insert the new item into the list.
   :feedback_b: Yes, the value True is placed in the list at index 2.  It replaces 8.
   :feedback_c: Item assignment is allowed with lists.  Lists are mutable.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4, 2, 8, 6, 5]
     alist[2] = True
     print(alist)



Immutable and Persistent Data Structures with ``pyrsistent``
------------------------------------------------------------

The act of *mutating* a data structure is common in both imperative and object
oriented programming and can be lead to very efficient algorithms in terms of
memory usage.  

As noted before, this textbook focuses on functional programming, which tends to
avoid mutation as much as possible.  Instead, in functional programs data
structures passing through functions are transformed into **new data
structures** in the same way that the slice operator returns a new list or
string.  

Unfortunately, this can be inefficient unless we use specialized data structures
that have been designed with this in mind.  Consequently, many modern functional
programming languages such as Clojure use data structures that are immutable and
persistent.  A **persistent** data structure is designed in such a way that it
can be transformed efficiently through operations such as assignment with
indexing and slicing.

In Python, the ``pyrsistent`` module provides a number of efficient persistent
data structures that work well when using the functional programming paradigm.  

You can install this module from inside IPython using the following ``!pip``
command.

.. sourcecode:: ipython

    In [1]: !pip install pyrsistent
    Collecting pyrsistent
      Downloading pyrsistent-0.12.0.tar.gz (91kB)
        100% |████████████████████████████████| 92kB 570kB/s
    Requirement already satisfied (use --upgrade to upgrade): six in /Users/tiverson/.pyenv/versions/3.5.2/envs/runestone/lib/python3.5/site-packages (from pyrsistent)
    Installing collected packages: pyrsistent
      Running setup.py install for pyrsistent ... done
    Successfully installed pyrsistent-0.12.0

.. note::

    You only need to install a module once in a given python enviroment.  After
    the initial installation, the module will continue to remain avaiable.

The ``pvector`` function from the ``pyrsistent`` module is an immutable
persistent version of a list.  First, we illustrate the immutability of the
``pvector`` by trying to assign a new value at index 0.

.. ipython::

    In [1]: from pyrsistent import pvector

    In [2]: fruit = pvector(["banana", "apple", "cherry"])

    In [3]: fruit[0] = "pear"
    ---------------------------------------------------------------------------
    TypeError                                 Traceback (most recent call last)
    <ipython-input-19-13775da5cf96> in <module>()
    ----> 1 fruit[0] = "pear"

    TypeError: 'pvectorc.PVector' object does not support item assignment

The ``pvector`` class provides a method called ``set`` that allows us to
(efficiently) construct a new ``pvector`` with a new value assigned to a
specific instance.

.. ipython:: 

    In [4]: new_fruit = fruit.set(0, "pear")

    In [5]: new_fruit
    Out[5]: pvector(['pear', 'apple', 'cherry'])

Recall that the ``id`` function gives a unique id number to each value in
memory.  We can use ``id`` to verify that ``new_fruit`` is indeed a new
``pvector``, different than the original ``fruit``.

.. ipython::  

    In [6]: id(fruit) == id(new_fruit)
    Out[6]: False

Other efficient features of the ``pvector`` include using ``append`` to add to
the end of the vector, as well as slicing the vector. 

.. ipython:: python

    fruit2 = fruit.append("watermelon")
    fruit  # The original fruit
    fruit2
    id(fruit) == id(fruit)  # Not the same vector

When writing programs in the functional style, consider using persistent and
immutable data structures.  We will explore other data structures from this
module in later sections on associative data structures and recursion.

.. note::

    This workspace is provided for your convenience.  You can use this
    activecode window to try out anything you like.

    .. activecode:: scratch_09_01
