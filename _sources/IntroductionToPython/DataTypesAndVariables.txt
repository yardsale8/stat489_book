
..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

.. qnum::
   :prefix: data-2-
   :start: 1

Data, Types, and Variables
==========================


Values and Data Types
---------------------

A **value** is one of the fundamental things --- like a word or a number ---
that a program manipulates. The values we have seen so far are ``5`` (the
result when we added ``2 + 3``), and ``"Hello, World!"``.  We often refer to these values as **objects** and we will use the words value and object interchangeably.

.. note::
	Actually, the 2 and the 3 that are part of the addition above are values(objects) as well.

These objects are classified into different **classes**, or **data types**: ``4``
is an *integer*, and ``"Hello, World!"`` is a *string*, so-called because it
contains a string or sequence of letters. You (and the interpreter) can identify strings
because they are enclosed in quotation marks.

If you are not sure what class a value falls into, Python has a function called
**type** which can tell you.

.. activecode:: ch02_1
    :nocanvas:

    print(type("Hello, World!"))
    print(type(17))
    print("Hello, World")

Not surprisingly, strings belong to the class **str** and integers belong to the
class **int**.

.. note::

	When we show the value of a string using the ``print`` function, such as in the third example above, the quotes are no longer present.  The
	value of the string is the sequence of characters inside the quotes.  The quotes are only necessary to help Python know what the value is.


In the Python shell, it is not necessary to use the ``print`` function to see the values shown above.  The shell evaluates the Python function and automatically prints the result.  For example, consider the shell session shown below.  When
we ask the shell to evaluate ``type("Hello, World!")``, it responds with the appropriate answer and then goes on to
display the prompt for the next use.

::

	Python 3.1.2 (r312:79360M, Mar 24 2010, 01:33:18)
	[GCC 4.0.1 (Apple Inc. build 5493)] on darwin
	Type "help", "copyright", "credits" or "license" for more information.
	>>> type("Hello, World!")
	<class 'str'>
	>>> type(17)
	<class 'int'>
	>>> "Hello, World"
	'Hello, World'
	>>>

Note that in the last example, we simply ask the shell to evaluate the string "Hello, World".  The result is as you might expect, the string itself.

Continuing with our discussion of data types, numbers with a decimal point belong to a class
called **float**, because these numbers are represented in a format called
*floating-point*.  At this stage, you can treat the words *class* and *type*
interchangeably.  We'll come back to a deeper understanding of what a class
is in later chapters.

.. activecode:: ch02_2
    :nocanvas:

    print(type(3.2))


What about values like ``"17"`` and ``"3.2"``? They look like numbers, but they
are in quotation marks like strings.

.. activecode:: ch02_3
    :nocanvas:

    print(type("17"))
    print(type("3.2"))

They're strings!

Strings in Python can be enclosed in either single quotes (``'``) or double
quotes (``"``), or three of each (``'''`` or ``"""``)

.. activecode:: ch02_4
    :nocanvas:

    print(type('This is a string.') )
    print(type("And so is this.") )
    print(type("""and this.""") )
    print(type('''and even this...''') )


Double quoted strings can contain single quotes inside them, as in ``"Bruce's
beard"``, and single quoted strings can have double quotes inside them, as in
``'The knights who say "Ni!"'``.
Strings enclosed with three occurrences of either quote symbol are called
triple quoted strings.  They can contain either single or double quotes:

.. activecode:: ch02_5
    :nocanvas:

    print('''"Oh no", she exclaimed, "Ben's bike is broken!"''')



Triple quoted strings can even span multiple lines:

.. activecode:: ch02_6
    :nocanvas:

    message = """This message will
    span several
    lines."""
    print(message)

    print("""This message will span
    several lines
    of the text.""")

Python doesn't care whether you use single or double quotes or the
three-of-a-kind quotes to surround your strings.  Once it has parsed the text of
your program or command, the way it stores the value is identical in all cases,
and the surrounding quotes are not part of the value.

.. activecode:: ch02_7
    :nocanvas:

    print('This is a string.')
    print("""And so is this.""")

So the Python language designers usually chose to surround their strings by
single quotes.  What do you think would happen if the string already contained
single quotes?

When you type a large integer, you might be tempted to use commas between
groups of three digits, as in ``42,000``. This is not a legal integer in
Python, but it does mean something else, which is legal:

.. activecode:: ch02_8
    :nocanvas:

    print(42000)
    print(42,000)


Well, that's not what we expected at all! Because of the comma, Python chose to
treat this as a *pair* of values.     In fact, the print function can print any number of values as long
as you separate them by commas.  Notice that the values are separated by spaces when they are displayed.

.. activecode:: ch02_8a
    :nocanvas:

    print(42, 17, 56, 34, 11, 4.35, 32)
    print(3.4, "hello", 45)

Remember not to put commas or spaces in your integers, no
matter how big they are. Also revisit what we said in the previous chapter:
formal languages are strict, the notation is concise, and even the smallest
change might mean something quite different from what you intended.

**Check your understanding**

.. mchoice:: test_question2_1_1
   :answer_a: Print out the value and determine the data type based on the value printed.
   :answer_b: Use the type function.
   :answer_c: Use it in a known equation and print the result.
   :answer_d: Look at the declaration of the variable.
   :correct: b
   :feedback_a: You may be able to determine the data type based on the printed value, but it may also be  deceptive, like when a string prints, there are no quotes around it.
   :feedback_b: The type function will tell you the class the value belongs to.
   :feedback_c: Only numeric values can be used in equations.
   :feedback_d: In Python variables are not declared.

   How can you determine the type of a variable?

.. mchoice:: test_question2_1_2
   :answer_a: Character
   :answer_b: Integer
   :answer_c: Float
   :answer_d: String
   :correct: d
   :feedback_a: It is not a single character.
   :feedback_b: The data is not numeric.
   :feedback_c: The value is not numeric with a decimal point.
   :feedback_d: Strings can be enclosed in single quotes.

   What is the data type of 'this is what kind of data'?


.. index:: type converter functions, int, float, str, truncation


Type conversion functions
-------------------------

Sometimes it is necessary to convert values from one type to another.  Python provides
a few simple functions that will allow us to do that.  The functions ``int``, ``float`` and ``str``
will (attempt to) convert their arguments into types `int`, `float` and `str`
respectively.  We call these **type conversion** functions.

The ``int`` function can take a floating point number or a string, and turn it
into an int. For floating point numbers, it *discards* the decimal portion of
the number - a process we call *truncation towards zero* on the number line.
Let us see this in action:

.. activecode:: ch02_20
    :nocanvas:

    print(3.14, int(3.14))
    print(3.9999, int(3.9999))       # This doesn't round to the closest int!
    print(3.0, int(3.0))
    print(-3.999, int(-3.999))        # Note that the result is closer to zero

    print("2345", int("2345"))        # parse a string to produce an int
    print(17, int(17))                # int even works on integers
    print(int("23bottles"))


The last case shows that a string has to be a syntactically legal number,
otherwise you'll get one of those pesky runtime errors.  Modify the example by deleting the
``bottles`` and rerun the program.  You should see the integer ``23``.

The type converter ``float`` can turn an integer, a float, or a syntactically
legal string into a float.

.. activecode:: ch02_21
    :nocanvas:

    print(float("123.45"))
    print(type(float("123.45")))


The type converter ``str`` turns its argument into a string.  Remember that when we print a string, the
quotes are removed.  However, if we print the type, we can see that it is definitely `str`.

.. activecode:: ch02_22
    :nocanvas:

    print(str(17))
    print(str(123.45))
    print(type(str(123.45)))

**Check your understanding**

.. mchoice:: test_question2_2_1
   :answer_a: Nothing is printed. It generates a runtime error.
   :answer_b: 53
   :answer_c: 54
   :answer_d: 53.785
   :correct: b
   :feedback_a: The statement is valid Python code.  It calls the int function on 53.785 and then prints the value that is returned.
   :feedback_b: The int function truncates all values after the decimal and prints the integer value.
   :feedback_c: When converting to an integer, the int function does not round.
   :feedback_d: The int function removes the fractional part of 53.785 and returns an integer, which is then printed.

   What value is printed when the following statement executes?

   .. code-block:: python

      print( int(53.785) )


.. index:: variable, assignment, assignment statement, state snapshot


Variables
---------

.. video:: assignvid
    :controls:
    :thumb: ../_static/assignment.png

    http://media.interactivepython.org/thinkcsVideos/Variables.mov
    http://media.interactivepython.org/thinkcsVideos/Variables.webm

One of the most powerful features of a programming language is the ability to
manipulate **variables**. A variable is a name that refers to a value.

**Assignment statements** create new variables and also give them values to refer to.

.. sourcecode:: python

    message = "What's up, Doc?"
    n = 17
    pi = 3.14159

This example makes three assignments. The first assigns the string value
``"What's up, Doc?"`` to a new variable named ``message``. The second gives the
integer ``17`` to ``n``, and the third assigns the floating-point number
``3.14159`` to a variable called ``pi``.

The **assignment token**, ``=``, should not be confused with *equality* (we will see later that equality uses the
``==`` token).  The assignment statement links a *name*, on the left hand
side of the operator, with a *value*, on the right hand side.  This is why you
will get an error if you enter:

.. sourcecode:: python

    17 = n

.. tip::

   When reading or writing code, say to yourself "n is assigned 17" or "n gets
   the value 17" or "n is a reference to the object 17" or "n refers to the object 17".  Don't say "n equals 17".

A common way to represent variables on paper is to write the name with an arrow
pointing to the variable's value. This kind of figure, known as a **reference diagram**, is often called a **state
snapshot** because it shows what state each of the variables is in at a
particular instant in time.  (Think of it as the variable's state of mind).
This diagram shows the result of executing the assignment statements shown above.

.. image:: Figures/refdiagram1.png
   :alt: Reference Diagram

If you ask Python to evaluate a variable, it will produce the value
that is currently linked to the variable.  In other words, evaluating a variable will give you the value that is referred to
by the variable.

.. activecode:: ch02_9
    :nocanvas:

    message = "What's up, Doc?"
    n = 17
    pi = 3.14159

    print(message)
    print(n)
    print(pi)

In each case the result is the value of the variable.
To see this in even more detail, we can run the program using codelens.

.. codelens:: ch02_9_codelens
    :showoutput:

    message = "What's up, Doc?"
    n = 17
    pi = 3.14159

    print(message)
    print(n)
    print(pi)

Now, as you step through the statements, you can see
the variables and the values they reference as those references are
created.




Variables also have
types; again, we can ask the interpreter what they are.

.. activecode:: ch02_10
    :nocanvas:

    message = "What's up, Doc?"
    n = 17
    pi = 3.14159

    print(type(message))
    print(type(n))
    print(type(pi))


The type of a variable is the type of the object it currently refers to.


We use variables in a program to "remember" things, like the current score at
the football game.  But variables are *variable*. This means they can change
over time, just like the scoreboard at a football game.  You can assign a value
to a variable, and later assign a different value to the same variable.

.. note::

    This is different from math. In math, if you give `x` the value 3, it
    cannot change to refer to a different value half-way through your
    calculations!

To see this, read and then run the following program.
You'll notice we change the value of `day` three times, and on the third
assignment we even give it a value that is of a different type.


.. codelens:: ch02_11
    :showoutput:

    day = "Thursday"
    print(day)
    day = "Friday"
    print(day)
    day = 21
    print(day)




A great deal of programming is about having the computer remember things.  For example, we might want to keep
track of the number of missed calls on your phone.  Each time another call is missed, we will arrange to update
or change the variable so that it will always reflect the correct value.

**Check your understanding**

.. mchoice:: test_question2_3_2
   :answer_a: Nothing is printed. A runtime error occurs.
   :answer_b: Thursday
   :answer_c: 32.5
   :answer_d: 19
   :correct: d
   :feedback_a: It is legal to change the type of data that a variable holds in Python.
   :feedback_b: This is the first value assigned to the variable day, but the next statements reassign that variable to new values.
   :feedback_c: This is the second value assigned to the variable day, but the next statement reassigns that variable to a new value.
   :feedback_d: The variable day will contain the last value assigned to it when it is printed.

   What is printed when the following statements execute?

   .. code-block:: python

     day = "Thursday"
     day = 32.5
     day = 19
     print(day)


.. index:: keyword, underscore character


Variable Names and Keywords
---------------------------

**Variable names** can be arbitrarily long. They can contain both letters and
digits, but they have to begin with a letter or an underscore. Although it is
legal to use uppercase letters, by convention we don't. If you do, remember
that case matters. ``Bruce`` and ``bruce`` are different variables.

.. caution::

   Variable names can never contain spaces.

The underscore character ( ``_``) can also appear in a name. It is often used in
names with multiple words, such as ``my_name`` or ``price_of_tea_in_china``.
There are some situations in which names beginning with an underscore have
special meaning, so a safe rule for beginners is to start all names with a
letter.

If you give a variable an illegal name, you get a syntax error.  In the example below, each
of the variable names is illegal.

::

    76trombones = "big parade"
    more$ = 1000000
    class = "Computer Science 101"


``76trombones`` is illegal because it does not begin with a letter.  ``more$``
is illegal because it contains an illegal character, the dollar sign. But
what's wrong with ``class``?

It turns out that ``class`` is one of the Python **keywords**. Keywords define
the language's syntax rules and structure, and they cannot be used as variable
names.
Python has thirty-something keywords (and every now and again improvements to
Python introduce or eliminate one or two):

======== ======== ======== ======== ======== ========
and      as       assert   break    class    continue
def      del      elif     else     except   exec
finally  for      from     global   if       import
in       is       lambda   nonlocal not      or
pass     raise    return   try      while    with
yield    True     False    None
======== ======== ======== ======== ======== ========

You might want to keep this list handy. If the interpreter complains about one
of your variable names and you don't know why, see if it is on this list.

Programmers generally choose names for their variables that are meaningful to
the human readers of the program --- they help the programmer document, or
remember, what the variable is used for.

.. caution::

    Beginners sometimes confuse "meaningful to the human readers" with
    "meaningful to the computer".  So they'll wrongly think that because
    they've called some variable ``average`` or ``pi``, it will somehow
    automagically calculate an average, or automagically associate the variable
    ``pi`` with the value 3.14159.  No! The computer doesn't attach semantic
    meaning to your variable names.

    So you'll find some instructors who deliberately don't choose meaningful
    names when they teach beginners --- not because they don't think it is a
    good habit, but because they're trying to reinforce the message that you,
    the programmer, have to write some program code to calculate the average,
    or you must write an assignment statement to give a variable the value you
    want it to have.

**Check your understanding**

.. mchoice:: test_question2_4_1
   :answer_a: True
   :answer_b: False
   :correct: b
   :feedback_a: -  The + character is not allowed in variable names.
   :feedback_b: -  The + character is not allowed in variable names (everything else in this name is fine).

   True or False:  the following is a legal variable name in Python:   A_good_grade_is_A+


.. index:: statement

