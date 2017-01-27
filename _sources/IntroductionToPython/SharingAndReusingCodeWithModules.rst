..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Sharing and Reusing Code with Modules
=====================================

.. todo:: Add an introduction

Modules and Getting Help
------------------------

A **module** is a file containing Python definitions and statements intended for
use in other Python programs. There are many Python modules that come with
Python as part of the **standard library**. 

.. We have already used one of these quite extensively, the ``turtle`` module.
.. Recall that once we import the module, we can use things that are defined
.. inside.


.. .. activecode:: chmod_01
..     :nocodelens:
.. 
..     import turtle            # allows us to use the turtles library
.. 
..     wn = turtle.Screen()     # creates a graphics window
..     alex = turtle.Turtle()   # create a turtle named alex
.. 
..     alex.forward(150)        # tell alex to move forward by 150 units
..     alex.left(90)            # turn by 90 degrees
..     alex.forward(75)         # complete the second side of a rectangle
..     wn.exitonclick()
.. 
.. 
.. Here we are using ``Screen`` and ``Turtle``, both of which are defined inside
.. the turtle module.
.. 
.. But what if no one had told us about turtle?  How would we know that it exists.
.. How would we know what it can do for us? The answer is to ask for help and the
.. best place to get help about the Python programming environment is to consult
.. with the Python Documentation.


The  `Python Documentation <http://docs.python.org/py3k/>`_ site for Python
version 3 (the home page is shown below) is an extremely useful reference for
all aspects of Python.  The site contains a listing of all the standard modules
that are available with Python (see `Global Module Index
<http://docs.python.org/py3k/py-modindex.html>`_).  You will also see that there
is a `Language Reference <http://docs.python.org/py3k/reference/index.html>`_
and a `Tutorial <http://docs.python.org/py3k/tutorial/index.html>`_, as well as
installation instructions, how-tos, and frequently asked questions.  We
encourage you to become familiar with this site and to use it often.

.. image:: Figures/pythondocmedium.png

If you have not done so already, take a look at the Global Module Index.  Here
you will see an alphabetical listing of all the modules that are available as
part of the standard library.  

.. Find the turtle module.
.. 
.. .. image:: Figures/moduleindexmedium.png
.. 
.. .. image:: Figures/turtlemodmedium.png
.. 
.. You can see that all the turtle functionality that we have talked about is
.. there.  However, there is so much more.  Take some time to read through and
.. familiarize yourself with some of the other things that turtles can do.
.. 
.. You can see all of the functionality of the items available in the turtle
.. module.  A programmer that was interested learning to use this module in their
.. programs would start by carefully exploring the documentation.
.. 
.. 

.. admonition:: Note: Python modules and limitations with activecode

    Throughout the chapters of this book, activecode windows allow you to
    practice the Python that you are learning.  We mentioned in the first
    chapter that programming is normally done using some type of development
    environment and that the activecode used here was strictly to help us learn.
    It is not the way we write production programs.

    To that end, it is necessary to mention that many of the  modules available
    in standard Python will **not** work in the activecode environment.  In
    fact, only turtle, math, and random have been ported at this point.  If you
    wish to explore any additional modules, you will need to also explore using
    a more robust development environment.

**Check your understanding**

.. mchoice:: question4_1_1
   :answer_a: A file containing Python definitions and statements intended for use in other Python programs.
   :answer_b: A separate block of code within a program.
   :answer_c: One line of code in a program.
   :answer_d: A file that contains documentation about functions in Python.
   :correct: a
   :feedback_a: A module can be reused in different programs.
   :feedback_b: While a module is separate block of code, it is separate from a program.
   :feedback_c: The call to a feature within a module may be one line of code, but modules are usually multiple lines of code separate from the program
   :feedback_d: Each module has its own documentation, but the module itself is more than just documentation.

   In Python a module is:

.. mchoice:: question4_1_2
   :answer_a: Go to the Python Documentation site.
   :answer_b: Look at the import statements of the program you are working with or writing.
   :answer_c: Ask the professor
   :answer_d: Look in this textbook.
   :correct: a
   :feedback_a: The site contains a listing of all the standard modules that are available with Python.
   :feedback_b: The import statements only tell you what modules are currently being used in the program, not how to use them or what they contain.
   :feedback_c: While the professor knows a subset of the modules available in Python, chances are the professor will have to look up the available modules just like you would.
   :feedback_d: This book only explains a portion of the modules available.  For a full listing you should look elsewhere.

   To find out information on the standard modules available with Python you should:

.. mchoice:: question4_1_3
   :answer_a: True
   :answer_b: False
   :correct: b
   :feedback_a: Only turtle, math, and random have been ported to work in activecode at this time.
   :feedback_b: Only turtle, math, and random have been ported to work in activecode at this time.

   True / False:  All standard Python modules will work in activecode.

The `math` module
-----------------

The ``math`` module contains the kinds of mathematical functions you would
typically find on your calculator and some mathematical constants like `pi` and
`e`.  As we noted above, when we ``import math``, we create a reference to a
module object that contains these elements.

.. image:: Figures/mathmod.png

Here are some items from the math module in action.  If you want more
information, you can check out the `Math Module
<http://docs.python.org/py3k/library/math.html#module-math>`_ Python
Documentation.

.. activecode:: chmodule_02

    import math

    print(math.pi)
    print(math.e)

    print(math.sqrt(2.0))

    print(math.sin(math.radians(90)))   # sin of 90 degrees



..  Like almost all other programming languages, angles are expressed in *radians*
.. rather than degrees.  There are two functions ``radians`` and ``degrees`` to
.. convert between the two popular ways of measuring angles.

.. Notice another difference between this module and our use of ``turtle``.  In
.. ``turtle`` we create objects (either ``Turtle`` or ``Screen``) and call methods
.. on those objects.  Remember that a turtle is a data object (recall ``alex`` and
.. ``tess``).  We need to create one in order to use it.  When we say ``alex =
.. turtle.Turtle()``, we are calling the constructor for the Turtle class which
.. returns a single turtle object.


Mathematical functions do not need to be constructed.  They simply perform a
task.  They are all housed together in a module called `math`.  Once we have
imported the math module, anything defined there can be used in our program.
Notice that we always use the name of the module followed by a `dot` followed by
the specific item from the module (``math.sqrt``).  You can think of this as
lastname.firstname where the lastname is the module family and the firstname is
the individual entry in the module.

If you have not done so already, take a look at the documentation for the math
module.

**Check your understanding**

.. mchoice:: question4_2_1
   :answer_a: import math
   :answer_b: include math
   :answer_c: use math
   :answer_d:  You don't need a statement.  You can always use the math module
   :correct: a
   :feedback_a: The module must be imported before you can use anything declared inside the module.
   :feedback_b: The correct term is not include, but you are close.
   :feedback_c: You will be using parts of the module, but that is not the right term.
   :feedback_d: You cannot use a Python module without a statement at the top of your program that explicitly tells Python you want to use the module.

   Which statement allows you to use the math module in your program?

The ``import`` statement
------------------------

There are three ways to import a module.  The first is the basic ``import``
statement, as shown below.

.. ipython:: python

    import math

When using this import statement, all the objects from the math module live in
the ``math`` namespace and are accessed using the ``.`` notation.  For example,
to see an approximation of :math:`\pi`, we would use ``math.pi``.

.. ipython:: python

    math.pi

It can be inconvenient to type the module name before each object and there are
two ways to avoid this annoyance.  First, we could assign a short alias for the
module using the ``import-as`` statement.

.. ipython:: python

    import math as m
    m.cos(m.pi/2)

The other alternative is to import elements into the **main namespace** using
the ``from-import`` statement, as shown below. In this case, we no longer need
to use the module name and dot notation to access the objects.

.. ipython:: python

    from math import pi, cos
    cos(pi/2)


You may be wondering why anyone might use the ``import`` or ``import-as``
statements and subject themselves to the inconvenience of prepending all module
objects with the dot notation.  The primary advantage to using these forms of
the import statement is that they avoid naming conflicts.  For example, both the
``math`` standard library and the ``numpy`` numerical library have a cosine
function.  In the example shown below, the second import statement **shadows**
the first ``cos`` function from the math module, which usually leads to a bug.


.. ipython:: python

    from math import pi, cos
    from numpy import cos
    cos(pi/2)

In this case, we were lucky that both ``cos`` functions worked the same way.
The ``numpy cos`` function has the added functionality of working on lists.
Let's change the example to introduce a bug.  

.. ipython:: python

    from numpy import cos
    from math import pi, cos

    xs = [1,2,3]
    cos(xs)

In this last example, the ``math cos`` function "overwrites" the ``numpy cos`` because
math is imported second. When trying to apply the ``cos`` to a list, we
get an error as the ``math cos`` doesn't work on a list, only numbers. We can
avoid this shadowing using an alias for the modules.


.. ipython:: python

    import numpy as np
    import math as m

    xs = [1,2,3]
    np.cos(xs)

The `random` module
-------------------

We often want to use **random numbers** in programs.  Here are a few typical
uses:

* To play a game of chance where the computer needs to throw some dice, pick a
  number, or flip a coin,
* To shuffle a deck of playing cards randomly,
* To randomly allow a new enemy spaceship to appear and shoot at you,
* To simulate possible rainfall when we make a computerized model for
  estimating the environmental impact of building a dam,
* For encrypting your banking session on the Internet.

Python provides a module ``random`` that helps with tasks like this.  You can
take a look at it in the documentation.  Here are the key things we can do with
it.

.. activecode:: chmodule_rand

    import random

    prob = random.random()
    print(prob)

    diceThrow = random.randrange(1, 7)       # return an int, one of 1,2,3,4,5,6
    print(diceThrow)

Press the run button a number of times.  Note that the values change each time.
These are random numbers.

The ``randrange`` function generates an integer between its lower and upper
argument, using the same semantics as ``range`` --- so the lower bound is
included, but the upper bound is excluded.   All the values have an equal
probability of occurring (i.e. the results are *uniformly* distributed).

The ``random()`` function returns a floating point number in the range [0.0,
1.0) --- the square bracket means "closed interval on the left" and the round
parenthesis means "open interval on the right".  In other words, 0.0 is
possible, but all returned numbers will be strictly less than 1.0.  It is usual
to *scale* the results after calling this method, to get them into a range
suitable for your application.

In the case shown here, we've converted the result of the method call to a
number in the range [0.0, 5.0).  Once more, these are uniformly distributed
numbers --- numbers close to 0 are just as likely to occur as numbers close to
0.5, or numbers close to 1.0.  If you continue to press the run button you will
see random values between 0.0 and up to but not including 5.0.

.. activecode:: chmodule_rand2

    import random

    prob = random.random()
    result = prob * 5
    print(result)






.. index:: deterministic algorithm,  algorithm; deterministic, unit tests

It is important to note that random number generators are based on a
**deterministic** algorithm --- repeatable and predictable.  So they're called
**pseudo-random** generators --- they are not genuinely random.  They start with
a *seed* value. Each time you ask for another random number, you'll get one
based on the current seed attribute, and the state of the seed (which is one of
the attributes of the generator) will be updated.  The good news is that each
time you run your program, the seed value is likely to be different meaning that
even though the random numbers are being created algorithmically, you will
likely get random behavior each time you execute.


.. admonition:: Lab

    * `Sine Wave <../Labs/sinlab.html>`_ In this guided lab exercise we will have the turtle plot a sine wave.

**Check your understanding**

.. mchoice:: question4_4_1
   :answer_a: math.pi
   :answer_b: math(pi)
   :answer_c: pi.math
   :answer_d: math->pi
   :correct: a
   :feedback_a: To invoke or reference something contained in a module you use the dot (.) notation.
   :feedback_b: This is the syntax for calling a function, not referencing an item in a module.
   :feedback_c: The module name must come first when accessing values and functions with a module.
   :feedback_d: The -> notation is not used in Python.

   Which of the following is the correct way to reference the value pi within the math module.   Assume you have already imported the math module.

.. mchoice:: question4_4_2
   :answer_a: the math module
   :answer_b: the random module
   :answer_c: the turtle module
   :answer_d: the game module
   :correct: b
   :feedback_a: While you might want to use the math module for other numerical computations in your program, it does not contain functions that are likely to help you simulate a dice roll.
   :feedback_b: You would likely call the function random.randrange.
   :feedback_c: The turtle module, while producing interesting graphics, is unlikely to help you here.
   :feedback_d: Python does not have a game module.

   Which module would you most likely use if you were writing a function to simulate rolling dice?


.. mchoice:: question4_4_3
   :answer_a: prob = random.randrange(1, 101)
   :answer_b: prob = random.randrange(1, 100)
   :answer_c: prob = random.randrange(0, 101)
   :answer_d: prob = random.randrange(0, 100)
   :correct: a
   :feedback_a: This will generate a number between 1 and 101, but does not include 101.
   :feedback_b: This will generate a number between 1 and 100, but does not include 100.  The highest value generated will be 99.
   :feedback_c: This will generate a number between 0 and 100.  The lowest value generated is 0.  The highest value generated will be 100.
   :feedback_d: This will generate a number between 0 and 100, but does not include 100.  The lowest value generated is 0 and the highest value generated will be 99.

   The correct code to generate a random number between 1 and 100 (inclusive) is:

.. mchoice:: question4_4_4
   :answer_a: There is no computer on the stage for the drawing.
   :answer_b: Because computers don't really generate random numbers, they generate pseudo-random numbers.
   :answer_c: They would just generate the same numbers over and over again.
   :answer_d: The computer can't tell what values were already selected, so it might generate all 5's instead of 5 unique numbers.
   :correct: b
   :feedback_a: They could easily put one there.
   :feedback_b: Computers generate random numbers using a deterministic algorithm.  This means that if anyone ever found out the algorithm they could accurately predict the next value to be generated and would always win the lottery.
   :feedback_c: This might happen if the same seed value was used over and over again, but they could make sure this was not the case.
   :feedback_d: While a programmer would need to ensure the computer did not select the same number more than once, it is easy to ensure this.

   One reason that lotteries don't use computers to generate random numbers is:


.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_04

Making your own modules
-----------------------

Making your own modules is as easy as saving the functions and values in a file
with the ``.py`` extension.  Provided that Python can find your file, you will
now be able to ``import`` and use your code in other programs. 

.. note::

    The easiest way to make sure that Python can locate your module is keeping
    in in the **current working directory**.  In IPython, you can see the
    location of the current working directory using the ``pwd`` magic alias.

    .. ipython:: python

        pwd

    Other methods for providing access to your module includes adding the
    modules address to the ``PYTHONPATH`` or using the ``distutils`` standard
    module to provide an installation of your module.  The best way to share a
    module in Python is using the Python Package Index, which allows users to
    install your program using ``pip``.  For more information, take a look at
    this `tutorial <https://wiki.python.org/moin/CheeseShopTutorial>`_.

.. admonition::  
