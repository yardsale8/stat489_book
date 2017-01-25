..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Collection Types - Strings, Lists and Tuples
============================================

Strings Revisited
-----------------

Throughout the first chapters of this book we have used strings to represent
words or phrases that we wanted to print out.  Our definition was simple:  a
string is simply some characters inside quotes.  In this chapter we explore
strings in much more detail.


A Collection Data Type
----------------------

So far we have seen built-in types like: ``int``, ``float``, ``bool``, ``str``
``int``, ``float``, and ``bool`` are considered to be simple or primitive data
types because their values are not composed of any smaller parts.  They cannot
be broken down.  On the other hand, strings are different from the others
because they are made up of smaller pieces.  They are made up of smaller strings
each containing one **character**.  

Types that are comprised of smaller pieces are called **collection data types**.
Depending on what we are doing, we may want to treat a collection data type as a
single entity (the whole), or we may want to access its parts. This ambiguity is
useful.

Strings can be defined as sequential collections of characters.  This means that
the individual characters that make up the string are assumed to be in a
particular order from left to right.

A string that contains no characters, often referred to as the **empty string**,
is still considered to be a string.  It is simply a sequence of zero characters
and is represented by ``''`` or ``""`` (two single or two double quotes with
nothing in between).

Lists
-----

A **list** is a sequential collection of Python data values, where each value is
identified by an index. The values that make up a list are called its
**elements**. Lists are similar to strings, which are ordered collections of
characters, except that the elements of a list can have any type and for any one
list, the items can be of different types.

There are several ways to create a new list.  The simplest is to enclose the
elements in square brackets ( ``[`` and ``]``).  This is often referred to as
the **literal form** of a list.

.. sourcecode:: python
    
    [10, 20, 30, 40]
    ["spam", "bungee", "swallow"]
    []

The first example is a list of four integers. The second is a list of three
strings. As we said above, the elements of a list don't have to be the same
type.  The following list contains a string, a float, an integer, and another
list.

.. sourcecode:: python
    
    ["hello", 2.0, 5, [10, 20]]

.. note::

    Python is a **dynamically typed** language, meaning that the type of each
    object is determined at **run time** (when the code is executed).  Contrast
    this with a **statically typed** language like Java, where the type of each
    object needs to be specified in the code.  In Java, we would have jump
    through many more hoops to build an array that contained strings, numbers,
    and other arrays.  The dynamic nature of Python allows us to combine many
    types without specification.  It can take a while for a programmer that is
    used to static types to get used to a dynamically typed language. 

A list within another list is said to be **nested** and the inner list is often
called a **sublist**.  Finally, there is a special list that contains no
elements. It is called the empty list and is denoted ``[]``.

.. ipython:: python

    empty = []
    type(empty)

As you would expect, we can also assign list values to variables and pass lists as parameters to functions.  

.. activecode:: chp09_01
    
    vocabulary = ["iteration", "selection", "control"]
    numbers = [17, 123]
    empty = []
    mixedlist = ["hello", 2.0, 5*2, [10, 20]]

    print(numbers)
    print(mixedlist)
    newlist = [ numbers, vocabulary ]
    print(newlist)

.. _accessing-elements:

**Check your understanding**

.. mchoice:: test_question9_1_1
   :answer_a: False
   :answer_b: True
   :correct: a
   :feedback_a: Yes, unlike strings, lists can consist of any type of Python data.
   :feedback_b: Lists are heterogeneous, meaning they can have different types of data.

   A list can contain only integer items.

.. index:: list index, index, list traversal

Tuples
------

So far you have seen two types of sequential collections: strings, which are
made up of characters; and lists, which are made up of elements of any type.
The third type of built-in sequence is a **tuple**, which like a list, is a
sequence of items of any type.  Syntactically, a tuple is a comma-separated
sequence of values.  Although it is not *always* necessary, it is conventional
to enclose tuples in parentheses:

.. sourcecode:: python

    julia = ("Julia", "Roberts", 1967, "Duplicity", 2009, "Actress", "Atlanta, Georgia")

Tuples are useful for representing what other languages often call *records* ---
some related information that belongs together, like your student record.  There
is no description of what each of these *fields* means, but we can guess.  A
tuple lets us "chunk" together related information and use it as a single thing.

Because tuples are *delimited* by parentheses, we need some special syntax
which would otherwise be interpreted as an arithmetic expression.  Specifically,
a single item tuple needs an added comma, or it will be interpreted as an
arithmetic expression.

.. ipython:: python

    one_item = ("one",)
    one_item
    type(one_item)
    one_item_no_comma = ("one")
    one_item_no_comma
    type(one_item_no_comma)

.. mchoice:: tuple_1
    :answer_a: (1,2,3)
    :answer_b: ()
    :answer_c: (2)
    :answer_d: (2,)
    :correct: c
    :feedback_a: A tuple is surrounded by parentheses and separated by commas
    :feedback_b: This is the empty tuple
    :feedback_c: A length 1 tuple needs a comma
    :feedback_d: A length 1 tuple needs a comma

    Which of the following is NOT a tuple?



