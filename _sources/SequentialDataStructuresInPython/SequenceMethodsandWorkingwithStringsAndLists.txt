Sequence Methods and Working with Strings and Lists
===================================================



String Methods
--------------

We previously saw that each turtle instance has its own attributes and 
a number of methods that can be applied to the instance.  For example,
we wrote ``tess.right(90)`` when we wanted the turtle object ``tess`` to perform the ``right`` method to turn
to the right 90 degrees.  The "dot notation" is the way we connect the name of an object to the name of a method
it can perform.  

Strings are also objects.  Each string instance has its own attributes and methods.  The most important attribute of the string is the collection of characters.  There are a wide variety of methods.  Try the following program.

.. activecode:: chp08_upper

    ss = "Hello, World"
    print(ss.upper())

    tt = ss.lower()
    print(tt)


In this example, ``upper`` is a method that can be invoked on any string object 
to create a new string in which all the 
characters are in uppercase.  ``lower`` works in a similar fashion changing all characters in the string
to lowercase.  (The original string ``ss`` remains unchanged.  A new string ``tt`` is created.)

In addition to ``upper`` and ``lower``, the following table provides a summary of some other useful string methods.  There are a few activecode examples that follow so that you can try them out.

==========  ==============      ==================================================================
Method      Parameters          Description
==========  ==============      ==================================================================
upper       none                Returns a string in all uppercase
lower       none                Returns a string in all lowercase
capitalize  none                Returns a string with first character capitalized, the rest lower

strip       none                Returns a string with the leading and trailing whitespace removed
lstrip      none                Returns a string with the leading whitespace removed
rstrip      none                Returns a string with the trailing whitespace removed
count       item                Returns the number of occurrences of item
replace     old, new            Replaces all occurrences of old substring with new

center      width               Returns a string centered in a field of width spaces
ljust       width               Returns a string left justified in a field of width spaces
rjust       width               Returns a string right justified in a field of width spaces

find        item                Returns the leftmost index where the substring item is found
rfind       item                Returns the rightmost index where the substring item is found
index       item                Like find except causes a runtime error if item is not found
rindex      item                Like rfind except causes a runtime error if item is not found
==========  ==============      ==================================================================

You should experiment with these
methods so that you understand what they do.  Note once again that the methods that return strings do not
change the original.  You can also consult the `Python documentation for strings <http://docs.python.org/py3k/library/stdtypes.html#index-21>`_.

.. activecode:: ch08_methods1

    ss = "    Hello, World    "

    els = ss.count("l")
    print(els)

    print("***" + ss.strip() + "***")
    print("***" + ss.lstrip() + "***")
    print("***" + ss.rstrip() + "***")

    news = ss.replace("o", "***")
    print(news)


.. activecode:: ch08_methods2


    food = "banana bread"
    print(food.capitalize())

    print("*" + food.center(25) + "*")
    print("*" + food.ljust(25) + "*")     # stars added to show bounds
    print("*" + food.rjust(25) + "*")

    print(food.find("e"))
    print(food.find("na"))
    print(food.find("b"))

    print(food.rfind("e"))
    print(food.rfind("na"))
    print(food.rfind("b"))

    print(food.index("e"))


**Check your understanding**

.. mchoice:: test_question8_3_1
   :answer_a: 0
   :answer_b: 2
   :answer_c: 3
   :correct: c
   :feedback_a: There are definitely o and p characters.
   :feedback_b: There are 2 o characters but what about p?
   :feedback_c: Yes, add the number of o characters and the number of p characters.


   What is printed by the following statements?
   
   .. code-block:: python
   
      s = "python rocks"
      print(s.count("o") + s.count("p"))




.. mchoice:: test_question8_3_2
   :answer_a: yyyyy
   :answer_b: 55555
   :answer_c: n
   :answer_d: Error, you cannot combine all those things together.
   :correct: a
   :feedback_a: Yes, s[1] is y and the index of n is 5, so 5 y characters.  It is important to realize that the index method has precedence over the repetition operator.  Repetition is done last.
   :feedback_b: Close.  5 is not repeated, it is the number of times to repeat.
   :feedback_c: This expression uses the index of n
   :feedback_d: This is fine, the repetition operator used the result of indexing and the index method.


   What is printed by the following statements?
   
   .. code-block:: python
   
      s = "python rocks"
      print(s[1] * s.index("n"))


.. index::
    single: len function
    single: function; len
    single: runtime error
    single: negative index
    single: index; negative




A ``find`` function
-------------------

Here is an implementation for the ``find`` method.

.. activecode:: ch08_run3
    
    def find(astring, achar):
        """
        Find and return the index of achar in astring.  
        Return -1 if achar does not occur in astring.
        """
        ix = 0
        found = False
        while ix < len(astring) and not found:
            if astring[ix] == achar:
                found = True
            else:
                ix = ix + 1
        if found:
            return ix
        else:
            return -1
        
    print(find("Compsci", "p"))
    print(find("Compsci", "C"))
    print(find("Compsci", "i"))
    print(find("Compsci", "x"))
    

In a sense, ``find`` is the opposite of the indexing operator. Instead of taking
an index and extracting the corresponding character, it takes a character and
finds the index where that character appears for the first time. If the character is not found,
the function returns ``-1``.

The ``while`` loop in this example uses a slightly more complex condition than we have seen
in previous programs.  Here there are two parts to the condition.  We want to keep going if there
are more characters to look through and we want to keep going if we have not found what we are 
looking for.  The variable ``found`` is a boolean variable that keeps track of whether we have found
the character we are searching for.  It is initialized to *False*.  If we find the character, we
reassign ``found`` to *True*.

The other part of the condition is the same as we used previously to traverse the characters of the
string.  Since we have now combined these two parts with a logical ``and``, it is necessary for them
both to be *True* to continue iterating.  If one part fails, the condition fails and the iteration stops.

When the iteration stops, we simply ask a question to find out why and then return the proper value.

.. note::

	This pattern of computation is sometimes called a eureka traversal because as
	soon as we find what we are looking for, we can cry Eureka!  and stop looking.  The way
	we stop looking is by setting ``found`` to True which causes the condition to fail.



.. index:: optional parameter, default value, parameter; optional

.. _optional_parameters:




List Methods
------------

The dot operator can also be used to access built-in methods of list objects.  
``append`` is a list method which adds the argument passed to it to the end of
the list. Continuing with this example, we show several other list methods.  Many of them are
easy to understand.  

.. activecode:: chp09_meth1

    mylist = []
    mylist.append(5)
    mylist.append(27)
    mylist.append(3)
    mylist.append(12)
    print(mylist)

    mylist.insert(1, 12)
    print(mylist)
    print(mylist.count(12))

    print(mylist.index(3))
    print(mylist.count(5))

    mylist.reverse()
    print(mylist)

    mylist.sort()
    print(mylist)

    mylist.remove(5)
    print(mylist)

    lastitem = mylist.pop()
    print(lastitem)
    print(mylist)

There are two ways to use the ``pop`` method.  The first, with no parameter, will remove and return the
last item of the list.  If you provide a parameter for the position, ``pop`` will remove and return the
item at that position.  Either way the list is changed.

The following table provides a summary of the list methods shown above.  The column labeled
`result` gives an explanation as to what the return value is as it relates to the new value of the list.  The word
**mutator** means that the list is changed by the method but nothing is returned (actually ``None`` is returned).  A **hybrid** method is one that not only changes the list but also returns a value as its result.  Finally, if the result is simply a return, then the list
is unchanged by the method.

Be sure
to experiment with these methods to gain a better understanding of what they do.




==========  ==============  ============  ================================================
Method      Parameters       Result       Description
==========  ==============  ============  ================================================
append      item            mutator       Adds a new item to the end of a list
insert      position, item  mutator       Inserts a new item at the position given
pop         none            hybrid        Removes and returns the last item
pop         position        hybrid        Removes and returns the item at position
sort        none            mutator       Modifies a list to be sorted
reverse     none            mutator       Modifies a list to be in reverse order
index       item            return idx    Returns the position of first occurrence of item
count       item            return ct     Returns the number of occurrences of item
remove      item            mutator       Removes the first occurrence of item
==========  ==============  ============  ================================================


Details for these and others
can be found in the `Python Documentation <http://docs.python.org/py3k/library/stdtypes.html#sequence-types-str-bytes-bytearray-list-tuple-range>`_.

It is important to remember that methods like ``append``, ``sort``, 
and ``reverse`` all return ``None``.  This means that re-assigning ``mylist`` to the result of sorting ``mylist`` will result in losing the entire list.  Calls like these will likely never appear as part of an assignment statement (see line 8 below).

.. activecode:: chp09_meth2

    mylist = []
    mylist.append(5)
    mylist.append(27)
    mylist.append(3)
    mylist.append(12)
    print(mylist)

    mylist = mylist.sort()   #probably an error
    print(mylist)

**Check your understanding**

.. mchoice:: test_question9_13_1
   :answer_a: [4, 2, 8, 6, 5, False, True]
   :answer_b: [4, 2, 8, 6, 5, True, False]
   :answer_c: [True, False, 4, 2, 8, 6, 5]
   :correct: b
   :feedback_a: True was added first, then False was added last.
   :feedback_b: Yes, each item is added to the end of the list.
   :feedback_c: append adds at the end, not the beginning.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4, 2, 8, 6, 5]
     alist.append(True)
     alist.append(False)
     print(alist)



.. mchoice:: test_question9_13_2
   :answer_a: [False, 4, 2, True, 8, 6, 5]
   :answer_b: [4, False, True, 2, 8, 6, 5]
   :answer_c: [False, 2, True, 6, 5]
   :correct: a
   :feedback_a: Yes, first True was added at index 2, then False was added at index 0.
   :feedback_b: insert will place items at the index position specified and move everything down to the right.
   :feedback_c: insert does not remove anything or replace anything.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4, 2, 8, 6, 5]
     alist.insert(2, True)
     alist.insert(0, False)
     print(alist)


.. mchoice:: test_question9_13_3
   :answer_a: [4, 8, 6]
   :answer_b: [2, 6, 5]
   :answer_c: [4, 2, 6]
   :correct: c
   :feedback_a: pop(2) removes the item at index 2, not the 2 itself.
   :feedback_b: pop() removes the last item, not the first.
   :feedback_c: Yes, first the 8 was removed, then the last item, which was 5.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4, 2, 8, 6, 5]
     temp = alist.pop(2)
     temp = alist.pop()
     print(alist)

   
   
.. mchoice:: test_question9_13_4
   :answer_a: [2, 8, 6, 5]
   :answer_b: [4, 2, 8, 6, 5]
   :answer_c: 4
   :answer_d: None
   :correct: c
   :feedback_a: alist is now the value that was returned from pop(0).
   :feedback_b: pop(0) changes the list by removing the first item.
   :feedback_c: Yes, first the 4 was removed from the list, then returned and assigned to alist.  The list is lost.
   :feedback_d: pop(0) returns the first item in the list so alist has now been changed.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4, 2, 8, 6, 5]
     alist = alist.pop(0)
     print(alist)



.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_09_03







Strings and Lists
-----------------

Two of the most useful methods on strings involve lists of
strings. The ``split`` method
breaks a string into a list of words.  By
default, any number of whitespace characters is considered a word boundary.

.. activecode:: ch09_split1
    
    song = "The rain in Spain..."
    wds = song.split()
    print(wds)

An optional argument called a **delimiter** can be used to specify which
characters to use as word boundaries. The following example uses the string
``ai`` as the delimiter:

.. activecode:: ch09_split2
    
    song = "The rain in Spain..."
    wds = song.split('ai')
    print(wds)

Notice that the delimiter doesn't appear in the result.

The inverse of the ``split`` method is ``join``.  You choose a
desired **separator** string, (often called the *glue*) 
and join the list with the glue between each of the elements.

.. activecode:: ch09_join

    wds = ["red", "blue", "green"]
    glue = ';'
    s = glue.join(wds)
    print(s)
    print(wds)

    print("***".join(wds))
    print("".join(wds))


The list that you glue together (``wds`` in this example) is not modified.  Also, 
you can use empty glue or multi-character strings as glue.



**Check your understanding**

.. mchoice:: test_question9_22_1
   :answer_a: Poe
   :answer_b: EdgarAllanPoe
   :answer_c: EAP
   :answer_d: William Shakespeare
   :correct: c
   :feedback_a: Three characters but not the right ones.  namelist is the list of names.
   :feedback_b: Too many characters in this case.  There should be a single letter from each name.
   :feedback_c: Yes, split creates a list of the three names.  The for loop iterates through the names and creates a string from the first characters.
   :feedback_d: That does not make any sense.
   
   What is printed by the following statements?
   
   .. code-block:: python

     myname = "Edgar Allan Poe"
     namelist = myname.split()
     init = ""
     for aname in namelist:
         init = init + aname[0]
     print(init)


    



``list`` Type Conversion Function
---------------------------------
    
Python has a built-in type conversion function called 
``list`` that tries to turn whatever you give it
into a list.  For example, try the following:

.. activecode:: ch09_list1
    
    xs = list("Crunchy Frog")
    print(xs)


The string "Crunchy Frog" is turned into a list by taking each character in the string and placing it in a list.  In general, any sequence can be turned into a list using this function.  The result will be a list containing the elements in the original sequence.  It is not legal to use the ``list`` conversion function on any argument that is not a sequence.

It is also important to point out that the ``list`` conversion function will place each element of the original sequence in the new list.  When working with strings, this is very different than the result of the ``split`` method.  Whereas ``split`` will break a string into a list of "words", ``list`` will always break it into a list of characters.
    
