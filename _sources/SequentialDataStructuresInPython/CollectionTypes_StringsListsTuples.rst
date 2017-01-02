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

So far we have seen built-in types like: ``int``, ``float``, 
``bool``, ``str`` and we've seen lists. 
``int``, ``float``, and
``bool`` are considered to be simple or primitive data types because their values are not composed
of any smaller parts.  They cannot be broken down.
On the other hand, strings and lists are different from the others because they
are made up of smaller pieces.  In the case of strings, they are made up of smaller
strings each containing one **character**.  

Types that are comprised of smaller pieces are called **collection data types**.
Depending on what we are doing, we may want to treat a collection data type as a
single entity (the whole), or we may want to access its parts. This ambiguity is useful.

Strings can be defined as sequential collections of characters.  This means that the individual characters
that make up the string are assumed to be in a particular order from left to right.

A string that contains no characters, often referred to as the **empty string**, is still considered to be a string.  It is simply a sequence of zero characters and is represented by '' or "" (two single or two double quotes with nothing in between).

.. index:: string operations, concatenation




Lists
-----

A **list** is a sequential collection of Python data values, where each value is identified by an
index. The values that make up a list are called its **elements**. Lists are
similar to strings, which are ordered collections of characters, except that the
elements of a list can have any type and for any one list, the items can be of different types.

.. index:: nested list, list; nested




List Values
-----------

There are several ways to create a new list.  The simplest is to enclose the
elements in square brackets ( ``[`` and ``]``).

.. sourcecode:: python
    
    [10, 20, 30, 40]
    ["spam", "bungee", "swallow"]

The first example is a list of four integers. The second is a list of three
strings. As we said above, the elements of a list don't have to be the same type.  The following
list contains a string, a float, an integer, and
another list.

.. sourcecode:: python
    
    ["hello", 2.0, 5, [10, 20]]

A list within another list is said to be **nested** and the inner list is often called a **sublist**.
Finally, there is a special list that contains no elements. It is called the
empty list and is denoted ``[]``.

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

TODO
