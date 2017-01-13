..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Statements: When Expressions Are Not Enough
===========================================


.. qnum::
   :prefix: func-1-
   :start: 1

.. index::
    single: function
    single: function definition
    single: definition; function
	

Functions
---------

.. video:: function_intro
   :controls:
   :thumb: ../_static/function_intro.png

   http://media.interactivepython.org/thinkcsVideos/FunctionsIntro.mov
   http://media.interactivepython.org/thinkcsVideos/FunctionsIntro.webm

In Python, a **function** is a named sequence of statements
that belong together.  Their primary purpose is to help us
organize programs into chunks that match how we think about
the solution to the problem.


The syntax for a **function definition** is:

.. code-block:: python

    def name( parameters ):
        statements

You can make up any names you want for the functions you create, except that
you can't use a name that is a Python keyword, and the names must follow the rules
for legal identifiers that were given previously. The parameters specify
what information, if any, you have to provide in order to use the new function.  Another way to say this is that the parameters specify what the function needs to do its work.

There can be any number of statements inside the function, but they have to be
indented from the ``def``. In the examples in this book, we will use the
standard indentation of four spaces. Function definitions are the second of
several **compound statements** we will see, all of which have the same
pattern:

#. A header line which begins with a keyword and ends with a colon.
#. A **body** consisting of one or more Python statements, each
   indented the same amount -- *4 spaces is the Python standard* -- from
   the header line.

We've already seen the ``for`` loop which follows this pattern.

In a function definition, the keyword in the header is ``def``, which is
followed by the name of the function and some *parameters* enclosed in
parentheses. The parameter list may be empty, or it may contain any number of
parameters separated from one another by commas. In either case, the parentheses are required.

We need to say a bit more about the parameters.  In the definition, the parameter list is more specifically known
as the **formal parameters**.  This list of names describes those things that the function will
need to receive from the user of the function.  When you use a function, you provide values to the formal parameters.

The figure below shows this relationship.  A function needs certain information to do its work.  These values, often called **arguments** or **actual parameters**, are passed to the function by the user.

.. image:: Figures/blackboxproc.png

This type of diagram is often called a **black-box diagram** because it only states the requirements from the perspective of the user.  The user must know the name of the function and what arguments need to be passed.  The details of how the function works are hidden inside the "black-box".

Suppose we're working with turtles and a common operation we need is to draw
squares.  It would make sense if we did not have to duplicate all the steps each time we want to make a square.   "Draw a square" can be thought of as an *abstraction* of a number of smaller steps.  We will need to provide two pieces of information for the function to do its work: a turtle to do the drawing and a size for the side of the square.  We could represent this using the following black-box diagram.

.. image:: Figures/turtleproc.png

Here is a program containing a function to capture this idea.  Give it a try.

.. activecode:: ch04_1
    :nocodelens:

    import turtle

    def drawSquare(t, sz):
        """Make turtle t draw a square of with side sz."""

        for i in range(4):
            t.forward(sz)
            t.left(90)


    wn = turtle.Screen()              # Set up the window and its attributes
    wn.bgcolor("lightgreen")

    alex = turtle.Turtle()            # create alex
    drawSquare(alex, 50)             # Call the function to draw the square passing the actual turtle and the actual side size

    wn.exitonclick()

This function is named ``drawSquare``.  It has two parameters --- one to tell
the function which turtle to move around and the other to tell it the size
of the square we want drawn.  In the function definition they are called ``t`` and ``sz`` respectively.   Make sure you know where the body of the function
ends --- it depends on the indentation and the blank lines don't count for
this purpose!

.. admonition::  docstrings

    If the first thing after the function header is a string (some tools insist that
    it must be a triple-quoted string), it is called a **docstring**
    and gets special treatment in Python and in some of the programming tools.

    Another way to retrieve this information is to use the interactive
    interpreter, and enter the expression ``<function_name>.__doc__``, which will retrieve the
    docstring for the function.  So the string you write as documentation at the start of a function is
    retrievable by python tools *at runtime*.  This is different from comments in your code,
    which are completely eliminated when the program is parsed.

    By convention, Python programmers use docstrings for the key documentation of
    their functions.

Defining a new function does not make the function run. To do that we need a
**function call**.  This is also known as a **function invocation**. We've already seen how to call some built-in functions like
``print``, ``range`` and ``int``. Function calls contain the name of the function to be
executed followed by a list of values, called *arguments*, which are assigned
to the parameters in the function definition.  So in the second to the last line of
the program, we call the function, and pass ``alex`` as the turtle to be manipulated,
and 50 as the size of the square we want.

.. The parameters being sent to the function, sometimes referred to as the **actual parameters** or **arguments**,
.. represent the specific data items that the function will use when it is executing.





Once we've defined a function, we can call it as often as we like and its
statements will be executed each time we call it.  In this case, we could use it to get
one of our turtles to draw a square and then we can move the turtle and have it draw a different square in a
different location.  Note that we lift the tail so that when ``alex`` moves there is no trace.  We put the tail
back down before drawing the next square.  Make sure you can identify both invocations of the ``drawSquare`` function.

.. activecode:: ch04_1a
    :nocodelens:

    import turtle

    def drawSquare(t, sz):
        """Make turtle t draw a square of with side sz."""

        for i in range(4):
            t.forward(sz)
            t.left(90)


    wn = turtle.Screen()          # Set up the window and its attributes
    wn.bgcolor("lightgreen")

    alex = turtle.Turtle()        # create alex
    drawSquare(alex, 50)          # Call the function to draw the square

    alex.penup()
    alex.goto(100,100)
    alex.pendown()

    drawSquare(alex,75)           # Draw another square

    wn.exitonclick()

In the next example, we've changed the ``drawSquare``
function a little and we get ``tess`` to draw 15 squares with some variations.  Once the function has
been defined, we can call it as many times as we like with whatever actual parameters we like.

.. activecode:: ch04_2
    :nocodelens:

    import turtle

    def drawMulticolorSquare(t, sz):
        """Make turtle t draw a multi-colour square of sz."""
        for i in ['red','purple','hotpink','blue']:
            t.color(i)
            t.forward(sz)
            t.left(90)

    wn = turtle.Screen()             # Set up the window and its attributes
    wn.bgcolor("lightgreen")

    tess = turtle.Turtle()           # create tess and set some attributes
    tess.pensize(3)

    size = 20                        # size of the smallest square
    for i in range(15):
        drawMulticolorSquare(tess, size)
        size = size + 10             # increase the size for next time
        tess.forward(10)             # move tess along a little
        tess.right(18)               # and give her some extra turn

    wn.exitonclick()


.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_05_01



**Check your understanding**

.. mchoice:: test_question5_1_1
   :answer_a: A named sequence of statements.
   :answer_b: Any sequence of statements.
   :answer_c: A mathematical expression that calculates a value.
   :answer_d: A statement of the form x = 5 + 4.
   :correct: a
   :feedback_a: Yes, a function is a named sequence of statements.
   :feedback_b: While functions contain sequences of statements, not all sequences of statements are considered functions.
   :feedback_c: While some functions do calculate values, the python idea of a function is slightly different from the mathematical idea of a function in that not all functions calculate values.  Consider, for example, the turtle functions in this section.   They made the turtle draw a specific shape, rather than calculating a value.
   :feedback_d: This statement is called an assignment statement.  It assigns the value on the right (9), to the name on the left (x).

   What is a function in Python?

.. mchoice:: test_question5_1_2
   :answer_a: To improve the speed of execution
   :answer_b: To help the programmer organize programs into chunks that match how they think about the solution to the problem.
   :answer_c: All Python programs must be written using functions
   :answer_d: To calculate values.
   :correct: b
   :feedback_a: Functions have little effect on how fast the program runs.
   :feedback_b: While functions are not required, they help the programmer better think about the solution by organizing pieces of the solution into logical chunks that can be reused.
   :feedback_c: In the first several chapters, you have seen many examples of Python programs written without the use of functions.  While writing and using functions is desirable and essential for good programming style as your programs get longer, it is not required.
   :feedback_d: Not all functions calculate values.

   What is one main purpose of a function?

.. mchoice:: test_question5_1_3
   :answer_a: def drawCircle(t):
   :answer_b: def drawCircle:
   :answer_c: drawCircle(t, sz):
   :answer_d: def drawCircle(t, sz)
   :correct: a
   :feedback_a: A function may take zero or more parameters.  It does not have to have two.  In this case the size of the circle might be specified in the body of the function.
   :feedback_b: A function needs to specify its parameters in its header.
   :feedback_c: A function definition needs to include the keyword def.
   :feedback_d: A function definition header must end in a colon (:).

   Which of the following is a valid function header (first line of a function definition)?

.. mchoice:: test_question5_1_4
   :answer_a: def drawSquare(t, sz)
   :answer_b: drawSquare
   :answer_c: drawSquare(t, sz)
   :answer_d: Make turtle t draw a square with side sz.
   :correct: b
   :feedback_a: This line is the complete function header (except for the semi-colon) which includes the name as well as several other components.
   :feedback_b: Yes, the name of the function is given after the keyword def and before the list of parameters.
   :feedback_c: This includes the function name and its parameters
   :feedback_d: This is a comment stating what the function does.

   What is the name of the following function?

   .. code-block:: python

     def drawSquare(t, sz):
         """Make turtle t draw a square of with side sz."""
         for i in range(4):
             t.forward(sz)
             t.left(90)



.. mchoice:: test_question5_1_5
   :answer_a: i
   :answer_b: t
   :answer_c: t, sz
   :answer_d: t, sz, i
   :correct: c
   :feedback_a: i is a variable used inside of the function, but not a parameter, which is passed in to the function.
   :feedback_b: t is only one of the parameters to this function.
   :feedback_c: Yes, the function specifies two parameters: t and sz.
   :feedback_d: the parameters include only those variables whose values that the function expects to receive as input.  They are specified in the header of the function.

   What are the parameters of the following function?

   .. code-block:: python

     def drawSquare(t, sz):
         """Make turtle t draw a square of with side sz."""
         for i in range(4):
             t.forward(sz)
             t.left(90)



.. mchoice:: test_question5_1_6
   :answer_a: def drawSquare(t, sz)
   :answer_b: drawSquare
   :answer_c: drawSquare(10)
   :answer_d: drawSquare(alex, 10):
   :answer_e: drawSquare(alex, 10)
   :correct: e
   :feedback_a: No, t and sz are the names of the formal parameters to this function.  When the function is called, it requires actual values to be passed in.
   :feedback_b: A function call always requires parentheses after the name of the function.
   :feedback_c: This function takes two parameters (arguments)
   :feedback_d: A colon is only required in a function definition.  It will cause an error with a function call.
   :feedback_e: Since alex was already previously defined and 10 is a value, we have passed in two correct values for this function.

   Considering the function below, which of the following statements correctly invokes, or calls, this function (i.e., causes it to run)?  Assume we already have a turtle named alex.

   .. code-block:: python

     def drawSquare(t, sz):
         """Make turtle t draw a square of with side sz."""
         for i in range(4):
             t.forward(sz)
             t.left(90)



.. mchoice:: test_question5_1_7
   :answer_a: True
   :answer_b: False
   :correct: a
   :feedback_a: Yes, you can call a function multiple times by putting the call in a loop.
   :feedback_b: One of the purposes of a function is to allow you to call it more than once.   Placing it in a loop allows it to executed multiple times as the body of the loop runs multiple times.

   True or false: A function can be called several times by placing a function call in the body of a loop.


Functions that Return Values
----------------------------

Most functions require arguments, values that control how the function does its
job. For example, if you want to find the absolute value of a number, you have
to indicate what the number is. Python has a built-in function for computing
the absolute value:

.. activecode:: ch04_4
    :nocanvas:

    print(abs(5))

    print(abs(-5))

In this example, the arguments to the ``abs`` function are 5 and -5.


Some functions take more than one argument. For example the math module contains a function
called
``pow`` which takes two arguments, the base and the exponent.

.. Inside the function,
.. the values that are passed get assigned to variables called **parameters**.

.. activecode:: ch04_5
    :nocanvas:

    import math
    print(math.pow(2, 3))

    print(math.pow(7, 4))

.. note::

     Of course, we have already seen that raising a base to an exponent can be done with the ** operator.

Another built-in function that takes more than one argument is ``max``.

.. activecode:: ch04_6
    :nocanvas:

    print(max(7, 11))
    print(max(4, 1, 17, 2, 12))
    print(max(3 * 11, 5 ** 3, 512 - 9, 1024 ** 0))

``max`` can be sent any number of arguments, separated by commas, and will
return the maximum value sent. The arguments can be either simple values or
expressions. In the last example, 503 is returned, since it is larger than 33,
125, and 1.  Note that ``max`` also works on lists of values.

Furthermore, functions like ``range``, ``int``, ``abs`` all return values that
can be used to build more complex expressions.

So an important difference between these functions and one like ``drawSquare`` is that
``drawSquare`` was not executed because we wanted it to compute a value --- on the contrary,
we wrote ``drawSquare`` because we wanted it to execute a sequence of steps that caused
the turtle to draw a specific shape.

Functions that return values are sometimes called **fruitful functions**.
In many other languages, a chunk that doesn't return a value is called a **procedure**,
but we will stick here with the Python way of also calling it a function, or if we want
to stress it, a *non-fruitful* function.


Fruitful functions still allow the user to provide information (arguments).  However there is now an additional
piece of data that is returned from the function.

.. image:: Figures/blackboxfun.png


How do we write our own fruitful function?  Let's start by creating a very simple
mathematical function that we will call ``square``.  The square function will take one number
as a parameter and return the result of squaring that number.  Here is the
black-box diagram with the Python code following.


.. image:: Figures/squarefun.png

.. activecode:: ch04_square

    def square(x):
        y = x * x
        return y

    toSquare = 10
    result = square(toSquare)
    print("The result of ", toSquare, " squared is ", result)

The **return** statement is followed by an expression which is evaluated.  Its
result is returned to the caller as the "fruit" of calling this function.
Because the return statement can contain any Python expression we could have
avoided creating the **temporary variable** ``y`` and simply used
``return x*x``.
Try modifying the square function above to see that this works just the same.
On the other hand, using **temporary variables** like ``y`` in the program above makes
debugging
easier.  These temporary variables are referred to as **local variables**.

.. The line `toInvest = float(input("How much do you want to invest?"))`
..  also shows yet another example
..  of *composition* --- we can call a function like `float`, and its arguments
 .. can be the results of other function calls (like `input`) that we've called along the way.

Notice something important here. The name of the variable we pass as an
argument --- ``toSquare`` --- has nothing to do with the name of the formal parameter
--- ``x``.  It is as if  ``x = toSquare`` is executed when ``square`` is called.
It doesn't matter what the value was named in
the caller. In ``square``, it's name is ``x``.  You can see this very clearly in
codelens, where the global variables and the local variables for the square
function are in separate boxes.

As you step through the example in codelens notice that the **return** statement not only causes the
function to return a value, but it also returns the flow of control back to the place in the program
where the function call was made.



.. codelens:: ch04_clsquare

    def square(x):
        y = x * x
        return y

    toSquare = 10
    squareResult = square(toSquare)
    print("The result of ", toSquare, " squared is ", squareResult)

Another important thing to notice as you step through this codelens
demonstration is the movement of the red and green arrows.  Codelens uses these arrows to show you where it is currently executing.
Recall that the red arrow always points to the next line of code that will be executed.  The light green arrow points to the line
that was just executed in the last step.

When you first start running this codelens demonstration you will notice that there is only a red arrow and it points to
line 1.  This is because line 1 is the next line to be executed and since it is the first line, there is no previously executed line
of code.  

When you click on the forward button, notice that the red arrow moves to line 5, skipping lines 2 and 3 of the function (and
the light green arrow has now appeared on line 1).  Why is this?
The answer is that function definition is not the same as function execution.  Lines 2
and 3 will not be executed until the function is called on line 6.  Line 1 defines the function and the name ``square`` is added to the
global variables, but that is all the ``def`` does at that point.  The body of the function will be executed later.  Continue to click
the forward button to see how the flow of control moves from the call, back up to the body of the function, and then finally back to line 7, after the function has returned its value and the value has been assigned to ``squareResult``.


.. Short variable names are more economical and sometimes make
.. code easier to read:
.. E = mc\ :sup:`2` would not be nearly so memorable if Einstein had
.. used longer variable names!  If you do prefer short names,
.. make sure you also have some comments to enlighten the reader
.. about what the variables are used for.


Finally, there is one more aspect of function return values that should be noted.  All Python functions return the value ``None`` unless there is an explicit return statement with
a value other than ``None.``
Consider the following common mistake made by beginning Python
programmers.  As you step through this example, pay very close attention to the return
value in the local variables listing.  Then look at what is printed when the
function returns.


.. codelens:: ch04_clsquare_bad

    def square(x):
        y = x * x
        print(y)   # Bad! should use return instead!

    toSquare = 10
    squareResult = square(toSquare)
    print("The result of ", toSquare, " squared is ", squareResult)

The problem with this function is that even though it prints the value of the square, that value will not be returned to the place
where the call was done.  Since line 6 uses the return value as the right hand side of an assignment statement, the evaluation of the 
function will be ``None``.  In this case, ``squareResult`` will refer to that value after the assignment statement and therefore the result printed in line 7 is incorrect.  Typically, functions will return values that can be printed or processed in some other way by the caller.

.. index::
    single: local variable
    single: variable; local
    single: lifetime





**Check your understanding**

.. mchoice:: test_question5_2_1
   :answer_a: You should never use a print statement in a function definition.
   :answer_b: You should not have any statements in a function after the return statement.  Once the function gets to the return statement it will immediately stop executing the function.
   :answer_c: You must calculate the value of x+y+z before you return it.
   :answer_d: A function cannot return a number.
   :correct: b
   :feedback_a: Although you should not mistake print for return, you may include print statements inside your functions.
   :feedback_b: This is a very common mistake so be sure to watch out for it when you write your code!
   :feedback_c: Python will automatically calculate the value x+y+z and then return it in the statement as it is written
   :feedback_d: Functions can return any legal data, including (but not limited to) numbers, strings, turtles, etc.

   What is wrong with the following function definition:

   .. code-block:: python

     def addEm(x, y, z):
         return x + y + z
         print('the answer is', x + y + z)


.. mchoice:: test_question5_2_2
   :answer_a: Nothing (no value)
   :answer_b: The value of x + y + z
   :answer_c: The string 'x + y + z'
   :correct: a
   :feedback_a: We have accidentally used print where we mean return.  Therefore, the function will return the value None by default.  This is a VERY COMMON mistake so watch out!  This mistake is also particularly difficult to find because when you run the function the output looks the same.  It is not until you try to assign its value to a variable that you can notice a difference.
   :feedback_b: Careful!  This is a very common mistake.  Here we have printed the value x+y+z but we have not returned it.  To return a value we MUST use the return keyword.
   :feedback_c: x+y+z calculates a number (assuming x+y+z are numbers) which represents the sum of the values x, y and z.

   What will the following function return?

   .. code-block:: python

    def addEm(x, y, z):
        print(x + y + z)




.. qnum::
   :prefix: select-7-
   :start: 1

Chained conditionals
--------------------

Python provides an alternative way to write nested selection such as the one shown in the previous section.
This is sometimes referred to as a **chained
conditional**

.. sourcecode:: python

    if x < y:
        print("x is less than y")
    elif x > y:
        print("x is greater than y")
    else:
        print("x and y must be equal")

The flow of control can be drawn in a different orientation but the resulting pattern is identical to the one shown above.

.. image:: Figures/flowchart_chained_conditional.png

``elif`` is an abbreviation of ``else if``. Again, exactly one branch will be
executed. There is no limit of the number of ``elif`` statements but only a
single (and optional) final ``else`` statement is allowed and it must be the last
branch in the statement.

Each condition is checked in order. If the first is false, the next is checked,
and so on. If one of them is true, the corresponding branch executes, and the
statement ends. Even if more than one condition is true, only the first true
branch executes.

Here is the same program using ``elif``.

.. activecode:: sel4

    x = 10
    y = 10

    if x < y:
        print("x is less than y")
    elif x > y:
        print("x is greater than y")
    else:
        print("x and y must be equal")




.. note::

  This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

  .. activecode:: scratch_06_02


**Check your understanding**

.. mchoice:: test_question6_7_1
   :answer_a: I only
   :answer_b: II only
   :answer_c: III only
   :answer_d: II and III
   :answer_e: I, II, and III
   :correct: b
   :feedback_a: You can not use a Boolean expression after an else.
   :feedback_b: Yes, II will give the same result.
   :feedback_c: No, III will not give the same result.  The first if statement will be true, but the second will be false, so the else part will execute.
   :feedback_d: No, Although II is correct III will not give the same result.  Try it.
   :feedback_e: No, in I you can not have a Boolean expression after an else.

   Which of I, II, and III below gives the same result as the following nested if?

   .. code-block:: python

     # nested if-else statement
     x = -10
     if x < 0:
         print("The negative number ",  x, " is not valid here.")
     else:
         if x > 0:
             print(x, " is a positive number")
         else:
             print(x, " is 0")


   .. code-block:: python

     I.
     
     if x < 0:
         print("The negative number ",  x, " is not valid here.")
     else x > 0:
         print(x, " is a positive number")
     else:
         print(x, " is 0")


   .. code-block:: python

     II.
     
     if x < 0:
         print("The negative number ",  x, " is not valid here.")
     elif x > 0:
         print(x, " is a positive number")
     else:
         print(x, " is 0")

   .. code-block:: python

     III.
     
     if x < 0:
         print("The negative number ",  x, " is not valid here.")
     if x > 0:
         print(x, " is a positive number")
     else:
         print(x, " is 0")


.. mchoice:: test_question6_7_2
   :answer_a: a
   :answer_b: b
   :answer_c: c
   :correct: c
   :feedback_a: While the value in x is less than the value in y (3 is less than 5) it is not less than the value in z (3 is not less than 2).
   :feedback_b: The value in y is not less than the value in x (5 is not less than 3).
   :feedback_c: Since the first two Boolean expressions are false the else will be executed.

   What will the following code print if x = 3, y = 5, and z = 2?

   .. code-block:: python

     if x < y and x < z:
         print("a")
     elif y < x and y < z:
         print("b")
     else:
         print("c")


What is an exception?
=====================

An *exception* is a signal that a condition has occurred that can't be easily
handled using the normal flow-of-control of a Python program. *Exceptions*
are often defined as being "errors" but this is not always the case. All
errors in Python are dealt with using *exceptions*, but not all
*exceptions* are errors.

Exception Handling Flow-of-control
==================================

To explain what an *exception* does, let's review the normal "flow of control"
in a Python program. In normal operation Python executes statements sequentially,
one after the other. For three constructs, if-statements, loops and function
invocations, this sequential execution is interrupted.

* For *if-statements*, only one of several statement blocks is executed and
  then flow-of-control jumps to the first statement after the if-statement.
* For *loops*, when the end of the loop is reached, flow-of-control jumps back
  to the start of the loop and a test is used to determine if the loop needs
  to execute again. If the loop is finished, flow-of-control jumps to the
  first statement after the loop.
* For *function invocations*, flow-of-control jumps to the first statement in
  the called function, the function is executed, and the flow-of-control
  jumps back to the next statement after the function call.

Do you see the pattern? If the flow-of-control is not purely sequential, it
always executes the first statement immediately following the altered
flow-of-control. That is why we can say that Python flow-of-control is
sequential. But there are cases where this sequential flow-of-control does
not work well. An example will best explain this.

Let's suppose that a program contains complex logic that is appropriately
subdivided into functions. The program is running and it currently is executing
function D, which was called by function C, which was called by function B,
which was called by function A, which was called from the main function. This
is illustrated by the following simplistic code example:

.. code-block:: python

  def main()
    A()

  def A():
    B()

  def B():
    C()

  def C():
    D()

  def D()
    # processing

Function D determines that the current processing won't work for some reason
and needs to send a message to the main function to try something different.
However, all that function D can do using normal flow-of-control is to return
a value to function C. So function D returns a special value to function C
that means "try something else". Function C has to recognize this value,
quit its processing, and return the special value to function B. And so forth
and so on. It would be very helpful if function D could communicate directly
with the main function (or functions A and B) without sending a special value
through the intermediate calling functions. Well, that is exactly what an
*exception* does. An *exception* is a message to any function currently on the
executing program's "run-time-stack". (The "run-time-stack" is what keeps track
of the active function calls while a program is executing.)

In Python, your create an *exception* message using the ``raise`` command. The
simplest format for a ``raise`` command is the keyword ``raise`` followed by
the name of an exception. For example:

.. code-block:: Python

  raise ExceptionName

So what happens to an *exception* message after it is created? The normal
flow-of-control of a Python program is interrupted and Python starts looking
for any code in its run-time-stack that is interested in dealing with the
message. It always searches from its current location at the bottom of the
run-time-stack, up the stack, in the order the functions were originally
called. A ``try: except:`` block is used to say "hey,
I can deal with that message." The first ``try: except:`` block that Python
finds on its search back up the run-time-stack will be executed. If there
is no ``try: except:`` block found, the program "crashes" and prints its
run-time-stack to the console.

Let's take a look at several code examples to illustrate this process. If
function D had a ``try: except:`` block around the code that ``raised`` a
``MyException`` message, then the flow-of-control would be passed to the
local ``except`` block. That is, function D would handle it's own issues.

.. code-block:: python

  def main()
    A()

  def A():
    B()

  def B():
    C()

  def C():
    D()

  def D()
    try:
      # processing code
      if something_special_happened:
        raise MyException
    except MyException:
      # execute if the MyException message happened

But perhaps function C is better able to handle the issue, so you could put
the ``try: except:`` block in function C:

.. code-block:: python

  def main()
    A()

  def A():
    B()

  def B():
    C()

  def C():
    try:
      D()
    except MyException:
      # execute if the MyException message happened

  def D()
    # processing code
    if something_special_happened:
      raise MyException

But perhaps the main function is better able to handle the issue, so you
could put the ``try: except:`` block in the main function:

.. code-block:: python

  def main()
    try:
      A()
    except MyException:
      # execute if the MyException message happened

  def A():
    B()

  def B():
    C()

  def C():
    D()

  def D()
    # processing code
    if something_special_happened:
      raise MyException

Summary
=======

Let's summarize our discussion. An *exception* is a message that something
"out-of-the-ordinary" has happened and the normal flow-of-control needs to
be abandoned. When an *exception* is ``raised``, Python searches its run-time-stack
for a ``try: except:`` block that can appropriately deal with the condition.
The first ``try: except:`` block that knows how to deal with the issue is
executed and then flow-of-control is returned to its normal sequential execution.
If no appropriate ``try: except:`` block is found, the program "crashes" and
prints its run-time-stack to the console.

As our final example, here is a program that crashes because no valid
``try: except:`` block was found to process the ``MyException`` message.
Notice that the ``try: except:`` block in the main function only knows how
to deal with ``ZeroDivisonError`` messages, not ``MyException`` messages.

.. code-block:: python

  def main()
    try:
      A()
    except ZeroDivisonError:
      # execute if a ZeroDivisonError message happened

  def A():
    B()

  def B():
    C()

  def C():
    D()

  def D()
    # processing code
    if something_special_happened:
      raise MyException


.. index:: exception, flow-of-control, raise, try: except:



.. todo:: loops 
