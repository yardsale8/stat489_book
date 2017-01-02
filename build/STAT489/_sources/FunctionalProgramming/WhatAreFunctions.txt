What Are Functions?
===================

Lambda Expressions are Functions
--------------------------------

TODO





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





Program Development
-------------------

At this point, you should be able to look at complete functions and tell what
they do. Also, if you have been doing the exercises, you have written some
small functions. As you write larger functions, you might start to have more
difficulty, especially with runtime and semantic errors.

To deal with increasingly complex programs, we are going to suggest a technique
called **incremental development**. The goal of incremental development is to
avoid long debugging sessions by adding and testing only a small amount of code
at a time.

As an example, suppose you want to find the distance between two points, given
by the coordinates (x\ :sub:`1`\ , y\ :sub:`1`\ ) and
(x\ :sub:`2`\ , y\ :sub:`2`\ ).  By the Pythagorean theorem, the distance is:

.. image:: Figures/distance_formula.png
   :alt: Distance formula 

The first step is to consider what a ``distance`` function should look like in
Python. In other words, what are the inputs (parameters) and what is the output
(return value)?

In this case, the two points are the inputs, which we can represent using four
parameters. The return value is the distance, which is a floating-point value.

Already we can write an outline of the function that captures our thinking so far.

.. sourcecode:: python
    
    def distance(x1, y1, x2, y2):
        return 0.0

Obviously, this version of the function doesn't compute distances; it always
returns zero. But it is syntactically correct, and it will run, which means
that we can test it before we make it more complicated.

To test the new function, we call it with sample values.


.. activecode:: ch06_distance1
    
    def distance(x1, y1, x2, y2):
        return 0.0

    print(distance(1, 2, 4, 6))


We chose these values so that the horizontal distance equals 3 and the vertical
distance equals 4; that way, the result is 5 (the hypotenuse of a 3-4-5
triangle). When testing a function, it is useful to know the right answer.

At this point we have confirmed that the function is syntactically correct, and
we can start adding lines of code. After each incremental change, we test the
function again. If an error occurs at any point, we know where it must be --- in
the last line we added.

A logical first step in the computation is to find the differences
x\ :sub:`2`\ - x\ :sub:`1`\  and y\ :sub:`2`\ - y\ :sub:`1`\ .  We will store
those values in temporary variables named ``dx`` and ``dy``.

.. sourcecode:: python
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        return 0.0


Next we compute the sum of squares of ``dx`` and ``dy``.

.. sourcecode:: python
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        dsquared = dx**2 + dy**2
        return 0.0

Again, we could run the program at this stage and check the value of ``dsquared`` (which
should be 25).

Finally, using the fractional exponent ``0.5`` to find the square root,
we compute and return the result.

.. activecode:: ch06_distancefinal
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        dsquared = dx**2 + dy**2
        result = dsquared**0.5
        return result

    print(distance(1, 2, 4, 6))


If that works correctly, you are done. Otherwise, you might want to print the
value of ``result`` before the return statement.

When you start out, you might add only a line or two of code at a time. As you
gain more experience, you might find yourself writing and debugging bigger
conceptual chunks. As you improve your programming skills you should find yourself
managing bigger and bigger chunks: this is very similar to the way we learned to read
letters, syllables, words, phrases, sentences, paragraphs, etc., or the way we learn
to chunk music --- from indvidual notes to chords, bars, phrases, and so on.  

The key aspects of the process are:

#. Start with a working skeleton program and make small incremental changes. At any
   point, if there is an error, you will know exactly where it is.
#. Use temporary variables to hold intermediate values so that you can easily inspect
   and check them.
#. Once the program is working, you might want to consolidate multiple statements 
   into compound expressions,
   but only do this if it does not make the program more difficult to read.

   
.. index:: composition, function composition




Composition
-----------

As we have already seen, you can call one function from within another.
This ability to build functions by using other functions is called **composition**.

As an example, we'll write a function that takes two points, the center of the
circle and a point on the perimeter, and computes the area of the circle.

Assume that the center point is stored in the variables ``xc`` and ``yc``, and
the perimeter point is in ``xp`` and ``yp``. The first step is to find the
radius of the circle, which is the distance between the two points.
Fortunately, we've just written a function, ``distance``, that does just that,
so now all we have to do is use it:

.. sourcecode:: python
    
    radius = distance(xc, yc, xp, yp)

The second step is to find the area of a circle with that radius and return it.
Again we will use one of our earlier functions:

.. sourcecode:: python
    
    result = area(radius)
    return result

Wrapping that up in a function, we get:

.. activecode:: ch06_newarea
    
    def distance(x1, y1, x2, y2):
	    dx = x2 - x1
	    dy = y2 - y1
	    dsquared = dx**2 + dy**2
	    result = dsquared**0.5
	    return result

    def area(radius):
        b = 3.14159 * radius**2
        return b

    def area2(xc, yc, xp, yp):
        radius = distance(xc, yc, xp, yp)
        result = area(radius)
        return result

    print(area2(0,0,1,1))



We called this function ``area2`` to distinguish it from the ``area`` function
defined earlier. There can only be one function with a given name within a
module.

Note that we could have written the composition without storing the intermediate results.

.. sourcecode:: python
    
    def area2(xc, yc, xp, yp):
        return area(distance(xc, yc, xp, yp))


.. index:: boolean function



