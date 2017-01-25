Sequence Methods and Working with Strings and Lists
===================================================

As discussed in the last chapter, all values in Python are objects that comes
bundled with any number of associated methods.  In this section, we will point
out some useful methods for working with sequences.


String Methods
--------------

We previously saw that each turtle instance has its own attributes and a number
of methods that can be applied to the instance.  For example, we wrote
``tess.right(90)`` when we wanted the turtle object ``tess`` to perform the
``right`` method to turn to the right 90 degrees.  The "dot notation" is the way
we connect the name of an object to the name of a method it can perform.  

Strings are also objects.  Each string instance has its own attributes and
methods.  The most important attribute of the string is the collection of
characters.  There are a wide variety of methods.  Consider the following program.

.. ipython:: python

    ss = "Hello, World"
    ss.upper()
    ss.lower()


In this example, ``upper`` is a method that can be invoked on any string object
to create a new string in which all the characters are in uppercase.  ``lower``
works in a similar fashion changing all characters in the string to lowercase.
(The original string ``ss`` remains unchanged.  A new string ``tt`` is created.)

In addition to ``upper`` and ``lower``, the following table provides a summary
of some other useful string methods.  There are a few examples that
follow so that you can try them out.

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

You should experiment with these methods so that you understand what they do.
Note once again that the methods that return strings do not change the original.
You can also consult the `Python documentation for strings
<http://docs.python.org/py3k/library/stdtypes.html#index-21>`_. Also recall that
you can explore all of the methods for an object such as a strong using the
``dir`` and ``help`` functions (any string will do!).

.. ipython:: python

    dir("a")


Here are some additional examples of useful methods associated with strings.
First we can use the various forms of ``strip`` to remove whitespace from a
string.  ``rstrip`` and ``lstrip`` stand for *right strip* and *left strip*
respectively.  ``replace`` is used to replace one sequence of characters with
another.

.. ipython:: python

    ss = "    Hello, World    "


    "***" + ss.strip()  + "***"
    "***" + ss.lstrip() + "***"
    "***" + ss.rstrip() + "***"

    ss.replace("o", "***")

Here are some other methods for transforming a string,

.. ipython:: python

    food = "banana bread"
    food.capitalize()

    "*" + food.center(25) + "*"
    "*" + food.ljust(25)  + "*"     # stars added to show bounds
    "*" + food.rjust(25)  + "*"

and finally some methods for finding and counting sub-sequences.

.. ipython:: python

    food.count("a")

    food.find("e")
    food.find("na")
    food.find("b")

    food.rfind("e")
    food.rfind("na")
    food.rfind("b")

    food.index("e")


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

.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_08_01

List Methods
------------

The dot operator can also be used to access built-in methods of list objects.
This example shows several other list methods, all of which are easy to
understand.  

.. ipython:: python

    mylist = [5, 27, 3, 12]
    mylist.count(12)
    mylist.index(3)
    list2 = sorted(mylist)
    list2
    mylist is list2
    l3 = reverse(mylist)
    l3
    l3 is mylist

.. note::

    It should be noted that many of Python's list methods *mutate* the list in
    place.  While mutating data in place in memory can be efficient, it also
    makes code hard to read.  To understand code that mutates a list (or even a
    variable) we are forced to track the **state** of each object throughout the
    program.  Programs that focus on mutation are not only harder to understand,
    but harder to distribute over many machines.  It is for this second reason
    that distributed systems such as Hadoop, MapReduce, and Spark use
    **stateless**, immutable constructions.


.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_08_01

Strings and Lists
-----------------

Two of the most useful methods on strings involve lists of strings. The
``split`` method breaks a string into a list of words.  By default, any number
of whitespace characters is considered a word boundary.

.. ipython:: python
    
    song = "The rain in Spain..."
    wds = song.split()
    wds

An optional argument called a **delimiter** can be used to specify which
characters to use as word boundaries. The following example uses the string
``ai`` as the delimiter:

.. ipython:: python
    
    wds = song.split('ai')
    wds

Notice that the delimiter doesn't appear in the result.

The inverse of the ``split`` method is ``join``.  You choose a desired
**separator** string, (often called the *glue*) and join the list with the glue
between each of the elements.

.. ipython:: python

    wds = ["red", "blue", "green"]
    glue = ';'
    s = glue.join(wds)
    s
    wds

    "***".join(wds)
    "".join(wds)


The list that you glue together (``wds`` in this example) is not modified.
Also, you can use empty glue or multi-character strings as glue.



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
    

.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_08_01

``list`` Type Conversion Function
---------------------------------
    
Python has a built-in type conversion function called ``list`` that tries to
turn whatever you give it into a list.  For example, try the following:

.. ipython:: python
    
    xs = list("Crunchy Frog")
    xs


The string ``"Crunchy Frog"`` is turned into a list by taking each character in
the string and placing it in a list.  In general, any sequence can be turned
into a list using this function.  The result will be a list containing the
elements in the original sequence.  It is not legal to use the ``list``
conversion function on any argument that is not a sequence.

.. note:: 

    Readers familiar with object oriented programming should note that these
    *type conversion* functions are actually constructors for the associated
    classes.  The ``type`` function that we introduced earlier is actually the
    constructor for a meta-class, which is a class that constructs other
    classes.

It is also important to point out that the ``list`` conversion function will
place each element of the original sequence in the new list.  When working with
strings, this is very different than the result of the ``split`` method.
Whereas ``split`` will break a string into a list of "words", ``list`` will
always break it into a list of characters.

We give more information about working with strings and lists in the section on
**Common Comprehension Patterns**.
    

.. note::

    This workspace is provided for your convenience.  You can use this
    activecode window to try out anything you like.

    .. activecode:: scratch_08_01
