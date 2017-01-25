Asking Boolean Questions about Sequences
========================================

The ``+`` and ``*`` operators are not the only operators that work with Python
sequence types, and in this section we will look at using Boolean operators to
ask questions about a sequence.


Comparing Equality
------------------

The comparison operators also work on strings. To see if two strings are equal
you simply write a boolean expression using the equality operator.

.. ipython:: python
    
    word = "banana"
    "Yes" if word == "banana" else "No"

We can perform tests of equality on a simple tuples as well.

.. ipython:: python

    a = ("one", "two")
    b = (1, 2)
    c = (1, 2)

    a == b
    b == c



The ``in`` and ``not in`` operators
-----------------------------------

The ``in`` operator tests if one string is a substring of another:

.. ipython:: python
    
    'p' in 'apple'
    'i' in 'apple'
    'ap' in 'apple'
    'pa' in 'apple'

Note that a string is a substring of itself, and the empty string is a substring
of any other string. (Also note that computer scientists like to think about
these edge cases quite carefully!) 

.. ipython:: python
    
    'a' in 'a'
    'apple' in 'apple'
    '' in 'a'
    '' in 'apple'
    
The ``not in`` operator returns the logical opposite result of ``in``.

.. ipython:: python

    'x' not in 'apple'

We can also use ``in`` and ``not in`` to test membership for lists.

.. ipython:: python
    
    fruit = ["apple", "orange", "banana", "cherry"]

    "apple" in fruit
    "pear" in fruit

**Check your understanding**

.. mchoice:: test_question9_4_1
   :answer_a: True
   :answer_b: False
   :correct: a
   :feedback_a: Yes, 3.14 is an item in the list alist.
   :feedback_b: There are 7 items in the list, 3.14 is one of them. 
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(3.14 in alist)


.. mchoice:: test_question9_4_2
   :answer_a: True
   :answer_b: False
   :correct: b
   :feedback_a: in returns True for top level items only.  57 is in a sublist.
   :feedback_b: Yes, 57 is not a top level item in alist.  It is in a sublist.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(57 in alist)


Other String Comparisons
------------------------

Other comparison operations are useful for putting words in
`lexicographical order <http://en.wikipedia.org/wiki/Lexicographic_order>`__.
This is similar to the alphabetical order you would use with a dictionary,
except that all the uppercase letters come before all the lowercase letters.

.. ipython:: python

    word = "zebra"
    word < "banana"
    word > "banana"

It is probably clear to you that the word `apple` would be less than (come
before) the word ``banana``.  After all, `a` is before `b` in the alphabet.  But
what if we consider the words ``apple`` and ``Apple``?  Are they the same?  

.. ipython:: python

    "apple" < "banana"
    "apple" == "Apple"
    "apple" < "Apple"

It turns out, as you recall from our discussion of variable names, that
uppercase and lowercase letters are considered to be different from one another.
The way the computer knows they are different is that each character is assigned
a unique integer value.  "A" is 65, "B" is 66, and "5" is 53.  The way you can
find out the so-called **ordinal value** for a given character is to use a
character function called ``ord``.

.. ipython:: python

    ord("A")
    ord("B")
    ord("5")

    ord("a")
    "apple" > "Apple"

When you compare characters or strings to one another, Python converts the
characters into their equivalent ordinal values and compares the integers from
left to right.  As you can see from the example above, "a" is greater than "A"
so "apple" is greater than "Apple".

Humans commonly ignore capitalization when comparing two words.  However,
computers do not.  A common way to address this issue is to convert strings to a
standard format, such as all lowercase, before performing the comparison. 

There is also a similar function called ``chr`` that converts integers into
their character equivalent.

.. ipython:: python

    chr(65)
    chr(66)

    chr(49)
    chr(53)

    ord(" ")
    print("The character for 32 is", chr(32), "!!!")

One thing to note in the last two examples is the fact that the space character
has an ordinal value (32).  Even though you don't see it, it is an actual
character.  We sometimes call it a *nonprinting* character.

**Check your understanding**

.. mchoice:: test_question8_6_1
   :answer_a: True
   :answer_b: False
   :correct: a
   :feedback_a: Both match up to the g but Dog is shorter than Doghouse so it comes first in the dictionary.
   :feedback_b: Strings are compared character by character.
   
   Evaluate the following comparison:
   
   .. code-block:: python

      "Dog" < "Doghouse"

   
   
.. mchoice:: test_question8_6_2
   :answer_a: True
   :answer_b: False
   :answer_c: They are the same word
   :correct: b
   :feedback_a: d is greater than D according to the ord function (68 versus 100).
   :feedback_b: Yes, upper case is less than lower case according to the ordinal values of the characters.
   :feedback_c: Python is case sensitive meaning that upper case and lower case characters are different.
   
   Evaluate the following comparison:
   
   .. code-block:: python

      "dog" < "Dog"

   
  
.. mchoice:: test_question8_6_3
   :answer_a: True
   :answer_b: False
   :correct: b
   :feedback_a: d is greater than D.
   :feedback_b: The length does not matter.  Lower case d is greater than upper case D.

   Evaluate the following comparison:
   
   .. code-block:: python

      "dog" < "Doghouse"

.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_08_01

