Operations On Sequences
=======================

Next, we will look at how to interpret expressions involving sequences and
various operators.

Concatenation and Repetition
----------------------------

In general, you cannot perform mathematical operations on lists.  Interestingly,
the ``+`` and ``*`` operator does work with lists, but for lists, the ``+``
operator **concatenates** lists and the ``*`` operator **repeats** the items in
a list a given number of times.  **Concatenation** means joining the two
operands by linking them end-to-end. For example:

.. ipython:: python

    fruit = ["apple", "orange", "banana", "cherry"]
    [1, 2] + [3, 4]
    fruit + [6, 7, 8, 9]

    [0] * 4
    [1, 2, ["hello", "goodbye"]] * 2


It is important to see that these operators create new lists from the elements
of the operand lists.  If you concatenate a list with 2 items and a list with 4
items, you will get a **new list** with 6 items (not a list with two sublists).
Similarly, repetition of a list of 2 items 4 times will give a list with 8
items.

One way for us to make this more clear is to run a part of this example in
codelens.  As you step through the code, you will see the variables being
created and the lists that they refer to.  Pay particular attention to the fact
that when ``newlist`` is created by the statement ``newlist = fruit + numlist``,
it refers to a completely new list formed by making copies of the items from
``fruit`` and ``numlist``.  You can see this very clearly in the codelens object
diagram.  The objects are different.



.. codelens:: chp09_concatid

    fruit = ["apple", "orange", "banana", "cherry"]
    numlist = [6, 7]

    newlist = fruit + numlist

    zeros = [0] * 4

In Python, every object has a unique identification tag.  Likewise, there is a
built-in function that can be called on any object to return its unique id.  The
function is appropriately called ``id`` and takes a single parameter, the object
that you are interested in knowing about.  You can see in the example below that
a real id is usually a very large integer value (corresponding to an address in
memory).

.. ipython:: python

    alist = [4, 5, 6]
    id(alist)

**Check your understanding**

.. mchoice:: test_question9_5_1
   :answer_a: 6
   :answer_b: [1, 2, 3, 4, 5, 6]
   :answer_c: [1, 3, 5, 2, 4, 6]
   :answer_d: [3, 7, 11]
   :correct: c
   :feedback_a: Concatenation does not add the lengths of the lists.
   :feedback_b: Concatenation does not reorder the items. 
   :feedback_c: Yes, a new list with all the items of the first list followed by all those from the second.
   :feedback_d: Concatenation does not add the individual items.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [1, 3, 5]
     blist = [2, 4, 6]
     print(alist + blist)

   
   
.. mchoice:: test_question9_5_2
   :answer_a: 9
   :answer_b: [1, 1, 1, 3, 3, 3, 5, 5, 5]
   :answer_c: [1, 3, 5, 1, 3, 5, 1, 3, 5]
   :answer_d: [3, 9, 15]
   :correct: c
   :feedback_a: Repetition does not multiply the lengths of the lists.  It repeats the items.
   :feedback_b: Repetition does not repeat each item individually.
   :feedback_c: Yes, the items of the list are repeated 3 times, one after another.
   :feedback_d: Repetition does not multiply the individual items.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [1, 3, 5]
     print(alist * 3)

Operations on Strings
---------------------


In general, you cannot perform mathematical operations on strings, even if the
strings look like numbers. The following are illegal (assuming that ``message``
has type string):

.. ipython:: python
    
    message = "Hi!"
    message - 1   
    "Hello" / 123   
    message * "Hello"   
    "15" + 2

Like with lists, the ``+`` operator **concatenates** strings and the ``*``
operator **repeats** the items in a string a given number of times. 
For example:

.. activecode:: ch08_add
    :nocanvas:

    fruit = "banana"
    bakedGood = " nut bread"
    print(fruit + bakedGood)

The output of this program is ``banana nut bread``. The space before the word
``nut`` is part of the string and is necessary to produce the space between
the concatenated strings.  Take out the space and run it again.

As with lists, the ``*`` operator also works on strings, performing repetition.
For example, ``'Fun'*3`` is ``'FunFunFun'``. One of the operands has to be a
string and the other has to be an integer.

.. ipython:: python

    "Go" * 6

    name = "Packers"
    name * 3

    name + "Go" * 3

    (name + "Go") * 3

This interpretation of ``+`` and ``*`` makes sense by analogy with addition and
multiplication. Just as ``4*3`` is equivalent to ``4+4+4``, we expect ``"Go"*3``
to be the same as ``"Go"+"Go"+"Go"``, and it is.  Note also in the last example
that the order of operations for ``*`` and ``+`` is the same as it was for
arithmetic.  The repetition is done before the concatenation.  If you want to
cause the concatenation to be done first, you will need to use parenthesis.


**Check your understanding**

.. mchoice:: test_question8_1_1
   :answer_a: python rocks
   :answer_b: python
   :answer_c: pythonrocks
   :answer_d: Error, you cannot add two strings together.
   :correct: c
   :feedback_a: Concatenation does not automatically add a space.
   :feedback_b: The expression s+t is evaluated first, then the resulting string is printed.
   :feedback_c: Yes, the two strings are glued end to end.
   :feedback_d: The + operator has different meanings depending on the operands, in this case, two strings.


   What is printed by the following statements?
   
   .. code-block:: python

      s = "python"
      t = "rocks"
      print(s + t)



.. mchoice:: test_question8_1_2
   :answer_a: python!!!
   :answer_b: python!python!python!
   :answer_c: pythonpythonpython!
   :answer_d: Error, you cannot perform concatenation and repetition at the same time.
   :correct: a
   :feedback_a: Yes, repetition has precedence over concatenation
   :feedback_b: Repetition is done first.
   :feedback_c: The repetition operator is working on the excl variable.
   :feedback_d: The + and * operator are defined for strings as well as numbers.


   What is printed by the following statements?
   
   .. code-block:: python
 
      s = "python"
      excl = "!"
      print(s+excl*3)




Length
------

The ``len`` function, when applied to a string, returns the number of characters in a string.

.. ipython:: python

    fruit = "Banana"
    len(fruit)
    

As with strings, the function ``len`` returns the length of a list (the number
of items in the list).  However, since lists can have items which are themselves
lists, it important to note that ``len`` only returns the top-most length.  In
other words, sublists are considered to be a single item when counting the
length of the list.

.. ipython:: python

    alist =  ["hello", 2.0, 5, [10, 20]]
    len(alist)
    len(['spam!', 1, ['Brie', 'Roquefort', 'Pol le Veq'], [1, 2, 3]])


**Check your understanding**

.. mchoice:: test_question8_4_1
   :answer_a: 11
   :answer_b: 12
   :correct: b
   :feedback_a: The blank counts as a character.
   :feedback_b: Yes, there are 12 characters in the string.


   What is printed by the following statements?
   
   .. code-block:: python
   
      s = "python rocks"
      print(len(s))


.. mchoice:: test_question9_2_1
   :answer_a: 4
   :answer_b: 5
   :correct: b
   :feedback_a: len returns the actual number of items in the list, not the maximum index value.
   :feedback_b: Yes, there are 5 items in this list.

   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", 3.14, False]
     print(len(alist))
   
   
.. mchoice:: test_question9_2_2
   :answer_a: 7
   :answer_b: 8
   :correct: a
   :feedback_a: Yes, there are 7 items in this list even though two of them happen to also be lists.
   :feedback_b: len returns the number of top level items in the list.  It does not count items in sublists.

   What is printed by the following statements?
   

   .. code-block:: python

      alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
      print(len(alist))
   
