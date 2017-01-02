Mutable and Immutable Sequences
===============================



Strings are Immutable
---------------------

One final thing that makes strings different from some other Python collection types is that
you are not allowed to modify the individual characters in the collection.  It is tempting to use the ``[]`` operator on the left side of an assignment,
with the intention of changing a character in a string.  For example, in the following code, we would like to change the first letter of ``greeting``.

.. activecode:: cg08_imm1
    
    greeting = "Hello, world!"
    greeting[0] = 'J'            # ERROR!
    print(greeting)

Instead of producing the output ``Jello, world!``, this code produces the
runtime error ``TypeError: 'str' object does not support item assignment``.

Strings are **immutable**, which means you cannot change an existing string. The
best you can do is create a new string that is a variation on the original.

.. activecode:: ch08_imm2
    
    greeting = "Hello, world!"
    newGreeting = 'J' + greeting[1:]
    print(newGreeting)
    print(greeting)            # same as it was

The solution here is to concatenate a new first letter onto a slice of
``greeting``. This operation has no effect on the original string.

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



.. index:: traversal, for loop, concatenation, abecedarian series

.. index::
    single: McCloskey, Robert
    single: Make Way for Ducklings    




Lists are Mutable
-----------------

Unlike strings, lists are **mutable**.  This means we can change an item in a list by accessing
it directly as part of the assignment statement. Using the indexing operator (square brackets) on the left side of an assignment, we can
update one of the list items.

.. activecode:: ch09_7
    
    fruit = ["banana", "apple", "cherry"]
    print(fruit)

    fruit[0] = "pear"
    fruit[-1] = "orange"
    print(fruit)


An
assignment to an element of a list is called **item assignment**. Item
assignment does not work for strings.  Recall that strings are immutable.

Here is the same example in codelens so that you can step through the statements and see the changes to the list elements.

.. codelens:: item_assign
    
    fruit = ["banana", "apple", "cherry"]

    fruit[0] = "pear"
    fruit[-1] = "orange"



By combining assignment with the slice operator we can update several elements at once.

.. activecode:: ch09_8
    
    alist = ['a', 'b', 'c', 'd', 'e', 'f']
    alist[1:3] = ['x', 'y']
    print(alist)

We can also remove elements from a list by assigning the empty list to them.

.. activecode:: ch09_9
    
    alist = ['a', 'b', 'c', 'd', 'e', 'f']
    alist[1:3] = []
    print(alist)

We can even insert elements into a list by squeezing them into an empty slice at the
desired location.

.. activecode:: ch09_10
    
    alist = ['a', 'd', 'f']
    alist[1:1] = ['b', 'c']
    print(alist)
    alist[4:4] = ['e']
    print(alist)

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


.. index:: del statement, statement; del




List Deletion
-------------

Using slices to delete list elements can be awkward and therefore error-prone.
Python provides an alternative that is more readable.
The ``del`` statement removes an element from a list by using its position.

.. activecode:: ch09_11
    
    a = ['one', 'two', 'three']
    del a[1]
    print(a)

    alist = ['a', 'b', 'c', 'd', 'e', 'f']
    del alist[1:5]
    print(alist)

As you might expect, ``del`` handles negative indices and causes a runtime
error if the index is out of range.
In addition, you can use a slice as an index for ``del``.
As usual, slices select all the elements up to, but not including, the second
index.


.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_09_01




.. index:: is operator, objects and values




Tuples and Mutability
---------------------

So far you have seen two types of sequential collections: strings, which are made up of
characters; and lists, which are made up of elements of any type.  One of the
differences we noted is that the elements of a list can be modified, but the
characters in a string cannot. In other words, strings are **immutable** and
lists are **mutable**.

A **tuple**, like a list, is a sequence of items of any type. Unlike lists,
however, tuples are immutable. Syntactically, a tuple is a comma-separated
sequence of values.  Although it is not necessary, it is conventional to 
enclose tuples in parentheses:

.. sourcecode:: python

    julia = ("Julia", "Roberts", 1967, "Duplicity", 2009, "Actress", "Atlanta, Georgia")

Tuples are useful for representing what other languages often call *records* ---
some related information that belongs together, like your student record.  There is
no description of what each of these *fields* means, but we can guess.  A tuple
lets us "chunk" together related information and use it as a single thing.

Tuples support the same sequence operations as strings and
lists. 
For example, the index operator selects an element from a tuple.

As with strings, if we try to use item assignment to modify one of the elements of the
tuple, we get an error.

.. sourcecode:: python

    julia[0] = 'X'
    TypeError: 'tuple' object does not support item assignment

Of course, even if we can't modify the elements of a tuple, we can make a variable
reference a new tuple holding different information.  To construct the new tuple,
it is convenient that we can slice parts of the old tuple and join up the
bits to make the new tuple.  So ``julia`` has a new recent film, and we might want
to change her tuple.  We can easily slice off the parts we want and concatenate them with
the new tuple.

.. activecode:: ch09_tuple1


    julia = ("Julia", "Roberts", 1967, "Duplicity", 2009, "Actress", "Atlanta, Georgia")
    print(julia[2])
    print(julia[2:6])

    print(len(julia))

    julia = julia[:3] + ("Eat Pray Love", 2010) + julia[5:]
    print(julia)


To create a tuple with a single element (but you're probably not likely
to do that too often), we have to include the final comma, because without
the final comma, Python treats the ``(5)`` below as an integer in parentheses:

.. activecode:: chp09_tuple2

    tup = (5,)
    print(type(tup))

    x = (5)
    print(type(x))
 

.. index::
    single: assignment; tuple 
    single: tuple; assignment  

Immutable Data Structures with `pyrsistent`
-------------------------------------------

TODO
