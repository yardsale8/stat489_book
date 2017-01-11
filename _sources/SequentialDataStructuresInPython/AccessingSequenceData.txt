Accessing Sequence Data
=======================

As lists and strings are *collections* of items, it would be useful to have a
method for accessing the individual elements of the sequence.  In this section
we introduce both methods of accessing data from Python sequences: *indexing* for
a single element and *slicing* for a sub-sequence.  

Index Operator
--------------

The **indexing operator** (Python uses square brackets to enclose the index)
selects a single character from a string.  The characters are accessed by their
position or index value.  For example, in the string shown below, the 14
characters are indexed left to right from position 0 to position 13.  


.. image:: Figures/indexvalues.png
   :alt: index values

It is also the case that the positions are named from right to left using
negative numbers where -1 is the rightmost index and so on.  Note that the
character at index 6 (or -8) is the blank character.


.. ipython:: python
    
    school = "Luther College"
    school[2]
    school[-1]

The expression ``school[2]`` selects the character at index 2 from ``school``,
and creates a new string containing just this one character. The variable ``m``
refers to the result. 

The expression in brackets is called an **index**. An index specifies a member
of an ordered collection.  In this case the collection of characters in the
string. The index *indicates* which character you want. It can be any integer
expression so long as it evaluates to a valid index value.

Note that indexing returns a *string* --- Python has no special type for a
single character.  It is just a string of length 1.

As shown above, the syntax for the indexing operator in Python uses brackets to
surround the desired index.  

.. sourcecode:: python

    SEQUENCE[ INDEX ]

Python uses the following rules to evaluate an indexing expression.

1. Evaluate SEQUENCE

2. Evaluate INDEX

3. Get and return the index element.

In the process, the interpreter will make sure that SEQUENCE evaluates to a
list and the INDEX is in the proper range of values.

Note that SEQUENCE can be any python expression that evaluates to a sequence, be that
a variable that refers to a sequence, the literal expression of a sequence, or a
function that returns a sequence.  

.. ipython:: python

    my_list = [1, 2, 3]
    my_list[2]  # Sequence stored in a variable
    "aeiou"[1]  # Indexing with the literal string expression
    f = lambda x: "***" + str(x) + "***"
    f(12)
    f(12)[-4]  # indexing a string returns by a function

    
Similarly, the INDEX can be any expression that evaluates to an integer,
provided the result in the right range for the sequence in questions.  Remember
that computer scientists often start counting from zero. The letter at index
zero of ``"Luther College"`` is ``L``.  So at position ``2`` we have the letter
``t``.

For example, if you want the zero-eth letter of a string, you just put 0, or any
expression with the value 0, in the brackets.

.. ipython:: python
    
    school = "Luther College"
    school[0]
    school[1 - 1]


**Check your understanding**

.. mchoice:: test_question8_2_1
   :answer_a: t
   :answer_b: h
   :answer_c: c
   :answer_d: Error, you cannot use the [ ] operator with a string.
   :correct: b
   :feedback_a: Index locations do not start with 1, they start with 0.
   :feedback_b: Yes, index locations start with 0.
   :feedback_c: s[-3] would return c, counting from right to left.
   :feedback_d: [ ] is the index operator


   What is printed by the following statements?
      
   .. code-block:: python
   
      s = "python rocks"
      print(s[3])




.. mchoice:: test_question8_2_2
   :answer_a: tr
   :answer_b: ps
   :answer_c: nn
   :answer_d: Error, you cannot use the [ ] operator with the + operator.
   :correct: a
   :feedback_a: Yes, indexing operator has precedence over concatenation.
   :feedback_b: p is at location 0, not 2.
   :feedback_c: n is at location 5, not 2.
   :feedback_d: [ ] operator returns a string that can be concatenated with another string.


   What is printed by the following statements?
   
   .. code-block:: python
   
      s = "python rocks"
      print(s[2] + s[-5])

 
.. mchoice:: test_question9_3_1
   :answer_a: [ ]
   :answer_b: 3.14
   :answer_c: False
   :correct: b
   :feedback_a: The empty list is at index 4.
   :feedback_b: Yes, 3.14 is at index 5 since we start counting at 0 and sublists count as one item.
   :feedback_c: False is at index 6.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(alist[5])

   
.. mchoice:: test_question9_3_2
   :answer_a: Error, you cannot use the upper method on a list.
   :answer_b: 2
   :answer_c: CAT
   :correct: c
   :feedback_a: alist[2] is the string cat so the upper method is legal
   :feedback_b: 2 is the index.  We want the item at that index.
   :feedback_c: Yes, the string cat is upper cased to become CAT.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(alist[2].upper())

   
.. mchoice:: test_question9_3_3
   :answer_a: 56
   :answer_b: c
   :answer_c: cat
   :answer_d: Error, you cannot have two index values unless you are using slicing.
   :correct: b
   :feedback_a: Indexes start with 0, not 1.
   :feedback_b: Yes, the first character of the string at index 2 is c 
   :feedback_c: cat is the item at index 2 but then we index into it further.
   :feedback_d: Using more than one index is fine.  You read it from left to right.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(alist[2][0])

The Slice Operator
------------------

A substring of a string is called a **slice**. Selecting a slice is similar to
selecting a character:

.. ipython:: python
    
    singers = "Peter, Paul, and Mary"
    singers[0:5]
    singers[7:11]
    singers[17:21]
    
The `slice` operator ``sequence[n:m]`` returns the part of the string from the
n'th character to the m'th character, including the first but excluding the
last. In other words,  start with the character at index ``n`` and go up to but
do not include the character at index ``m``.  

If you omit the first index (before the colon), the slice starts at the
beginning of the string. If you omit the second index, the slice goes to the
end of the string.

.. ipython:: python
    
    fruit = "banana"
    fruit[:3]
    fruit[3:]

What do you think ``fruit[:]`` means?

The slice operation also work on lists.  

.. ipython:: python
    
    a_list = ['a', 'b', 'c', 'd', 'e', 'f']
    a_list[1:3]
    a_list[:4]
    a_list[3:]
    a_list[:]

The syntax for the `slice` operator is similar to that of the indexing operator
and uses brackets to surround the desired indexes, but a slice needs to specify
a starting and ending index

.. sourcecode:: python

    SEQUENCE[STARTING_INDEX:STOP_BEFORE_INDEX]

Python uses the following rules to evaluate an slicing expression.

1. Evaluate SEQUENCE
2. Evaluate STARTING_INDEX, using 0 as the index if omitted.
3. Evaluate STOP_BEFORE_INDEX, using len(SEQUENCE) as the index if omitted.
4. Get and return the requested sub-sequence of the same type as SEQUENCE 

In the process, the interpreter will make sure that SEQUENCE evaluates to a
sequence and the indexes are in the proper range of values.  Note integers that
are larger than the length of the sequence are valid!

.. ipython:: python

    short_word = "the"
    short_word[1:1000000]

Again, the SEQUENCE can be any python expression that evaluates to a sequence
and the indexes can be any expression that evaluated to an appropriate integer.


**Check your understanding**

.. mchoice:: test_question8_5_1
   :answer_a: python
   :answer_b: rocks
   :answer_c: hon r
   :answer_d: Error, you cannot have two numbers inside the [ ].
   :correct: c
   :feedback_a: That would be s[0:6].
   :feedback_b: That would be s[7:].
   :feedback_c: Yes, start with the character at index 3 and go up to but not include the character at index 8.
   :feedback_d: This is called slicing, not indexing.  It requires a start and an end.


   What is printed by the following statements?
   
   .. code-block:: python

      s = "python rocks"
      print(s[3:8])

.. mchoice:: test_question8_5_2
   :answer_a: rockrockrock
   :answer_b: rock rock rock
   :answer_c: rocksrocksrocks
   :answer_d: Error, you cannot use repetition with slicing.
   :correct: a
   :feedback_a: Yes, rock starts at 7 and goes through 10.  Repeat it 3 times.
   :feedback_b: Repetition does not add a space.
   :feedback_c: Slicing will not include the character at index 11.  Just up to it (10 in this case).
   :feedback_d: The slice will happen first, then the repetition.  So it is ok.


   What is printed by the following statements?
   
   .. code-block:: python

      s = "python rocks"
      print(s[7:11] * 3)


.. mchoice:: test_question9_6_1
   :answer_a: [ [ ], 3.14, False]
   :answer_b: [ [ ], 3.14]
   :answer_c: [ [56, 57, "dog"], [ ], 3.14, False]
   :correct: a
   :feedback_a: Yes, the slice starts at index 4 and goes up to and including the last item.
   :feedback_b: By leaving out the upper bound on the slice, we go up to and including the last item.
   :feedback_c: Index values start at 0.
   
   What is printed by the following statements?
   
   .. code-block:: python
   
     alist = [3, 67, "cat", [56, 57, "dog"], [ ], 3.14, False]
     print(alist[4:])


Nested Lists
------------

A nested list is a list that appears as an element in another list. In this
list, the element with index 3 is a nested list.  If we ``print(nested[3])``, we
get ``[10, 20]``. To extract an element from the nested list, we can proceed in
two steps.  First, extract the nested list, then extract the item of interest.
It is also possible to combine those steps using bracket operators that evaluate
from left to right.

.. ipython:: python
    
    nested = ["hello", 2.0, 5, [10, 20]]
    innerlist = nested[3]
    innerlist
    item = innerlist[1]
    item

    nested[3][1]


**Check your understanding**

.. mchoice:: test_question9_21_1
   :answer_a: 6
   :answer_b: 8
   :answer_c: 888
   :answer_d: 999
   :correct: c
   :feedback_a: 6 is in the wrong list.  alist[1] refers to the second item in alist, namely [888,999].
   :feedback_b: 8 is in the wrong list.  alist[1] refers to the second item in alist, namely [888,999].
   :feedback_c: Yes, alist[0][1][0] is True and alist[1] is the second list, the first item is 888.
   :feedback_d: alist[0][1][0] is True.  Take another look at the if statement.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [ [4, [True, False], 6, 8], [888, 999] ]
     if alist[0][1][0]:
        print(alist[1][0])
     else:
        print(alist[1][1])



.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_08_01


