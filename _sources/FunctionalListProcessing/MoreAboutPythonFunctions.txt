More Details About Python Functions
===================================

In this chapter, we will look at all of the features of Python functions,
including the function definition statement, docstrings, optional parameters,
variable number of arguments/keywords and argument/keyword unpacking.  In the
process, proper documentation and testing of pure functions is illustrated.

In Python, a **function** is a named sequence of statements that belong
together.  Their primary purpose is to help us organize programs into chunks
that match how we think about the solution to the problem.  Thus far, we have
defined our function using expressions and lambdas, but as functions becomes
more complicated, we will want to use the function definition statement to make
the function definition more readable.

The syntax for a **function definition** statement is:

.. code-block:: python

    def name( parameters ):
        statements

In a function definition, the keyword in the header is ``def``, which is
followed by the name of the function and some *parameters* enclosed in
parentheses. The parameter list may be empty, or it may contain any number of
parameters separated from one another by commas. In either case, the parentheses
are required.

You can make up any names you want for the functions you create, except that you
can't use a name that is a Python keyword, and the names must follow the rules
for legal identifiers that were given previously. 

One of the primary distinctions between the function definition statement and
lambda expressions is that functions defined with this statement will almost
exclusively consist of statements.  There can be any number of statements inside
the function, but they have to be indented from the ``def``. In the examples in
this book, we will use the standard indentation of four spaces. Function
definitions are and example of **compound statements** we will see, all
of which have the same pattern:

#. A header line which begins with a keyword and ends with a colon.
#. A **body** consisting of one or more Python statements, each
   indented the same amount -- *4 spaces is the Python standard* -- from
   the header line.

In functional programs the body of a function will mostly consist of assignment
statements and possibly an ``if-elif-else`` or ``try-except`` block.  As we have
seen, most iteration can be handled by a list comprehension and in this chapter
we will develop additional alternatives for loops in the form of higher order
functions like ``map``, ``filter`` and ``reduce``.  The most important part of a
**fruitful** function is the ``return`` statement the halts the function and
returns one or more values.






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


Fruitful Functions
------------------

When writing functional programs, we focus on functions that return values,
called **fruitful functions**.  In many other languages, a chunk that doesn't
return a value is called a **procedure**, which we will call **non-fruitful**.
It is worth noting that non-fruitful functions will almost always be
side-effecting (what else could they do?).  Understanding a program that uses
side-effecting functions can be difficult, because the nature of the side-effect
is not obvious in the function call.  Consequently, functional programs involve
writing *pure* fruitful functions whenever possible.  A **pure** function is a
side-effect free fruitful function, making it referentially transparent.

.. image:: Figures/blackboxfun.png

How do we write our own fruitful function?  Let's start by creating a very
simple mathematical function that we will call ``square``.  The square function
will take one number as a parameter and return the result of squaring that
number.  Here is the black-box diagram with the Python code following.

.. image:: Figures/squarefun.png

.. ipython:: python

    def square(x):
        """ Return the square of the number x"""
        y = x * x
        return y

    number = 10
    result = square(number)
    result

The **return** statement is followed by an expression which is evaluated.  Its
result is returned to the caller as the "fruit" of calling this function.
Because the return statement can contain any Python expression we could have
avoided creating the **temporary variable** ``y`` and simply used ``return
x*x``.  On the other hand, using **temporary variables** like ``y`` in the
program above makes the code easier to read and debug.  Temporary
variables assigned inside the body of a function are **local variables** and
have a scope that includes the body of the functions.

.. admonition::  docstrings

    If the first thing after the function header is a string (some tools insist
    that it must be a triple-quoted string), it is called a **docstring** and
    gets special treatment in Python and in some of the programming tools.

    Another way to retrieve this information is to use the interactive
    interpreter, and enter the expression ``<function_name>.__doc__``, which
    will retrieve the docstring for the function.  So the string you write as
    documentation at the start of a function is retrievable by python tools *at
    runtime*.  This is different from comments in your code, which are
    completely eliminated when the program is parsed.

    By convention, Python programmers use docstrings for the key documentation of
    their functions.

    .. todo:: add information about the PEP on docstrings

As with lambda expressions, defining a new function does not make the function
run. To do that we need a **function call** using the same syntax as used with
built-in functions and lambda expressions.

Notice something important here. The name of the variable we pass as an argument
--- ``number`` --- has nothing to do with the name of the formal parameter ---
``x``.  It is as if  ``x = toSquare`` is executed when ``square`` is called.  It
doesn't matter what the value was named in the caller. In ``square``, its name
is ``x``.  You can see this very clearly in codelens, where the global variables
and the local variables for the square function are in separate boxes.

As you step through the example in codelens notice that the **return** statement
not only causes the function to return a value, but it also returns the flow of
control back to the place in the program where the function call was made.

.. codelens:: ch04_clsquare

    def square(x):
        y = x * x
        return y

    number = 10
    result = square(number)
    result

Another important thing to notice as you step through this codelens
demonstration is the movement of the red and green arrows.  Codelens uses these
arrows to show you where it is currently executing.  Recall that the red arrow
always points to the next line of code that will be executed.  The light green
arrow points to the line that was just executed in the last step.

When you first start running this codelens demonstration you will notice that
there is only a red arrow and it points to line 1.  This is because line 1 is
the next line to be executed and since it is the first line, there is no
previously executed line of code.  

When you click on the forward button, notice that the red arrow moves to line 5,
skipping lines 2 and 3 of the function (and the light green arrow has now
appeared on line 1).  Why is this?  The answer is that function definition is
not the same as function execution.  Lines 2 and 3 will not be executed until
the function is called on line 6.  Line 1 defines the function and the name
``square`` is added to the global variables, but that is all the ``def`` does at
that point.  The body of the function will be executed later.  Continue to click
the forward button to see how the flow of control moves from the call, back up
to the body of the function, and then finally back to line 7, after the function
has returned its value and the value has been assigned to ``squareResult``.


Finally, there is one more aspect of function return values that should be
noted.  All Python functions return the value ``None`` unless there is an
explicit return statement with a value other than ``None.`` Consider the
following common mistake made by beginning Python programmers.  As you step
through this example, pay very close attention to the return value in the local
variables listing.  Then look at what is printed when the function returns.


.. codelens:: ch04_clsquare_bad

    def square(x):
        y = x * x
        print(y)   # Bad! should use return instead!

    toSquare = 10
    squareResult = square(toSquare)
    print("The result of ", toSquare, " squared is ", squareResult)

The problem with this function is that even though it prints the value of the
square, that value will not be returned to the place where the call was done.
Since line 6 uses the return value as the right hand side of an assignment
statement, the evaluation of the function will be ``None``.  In this case,
``squareResult`` will refer to that value after the assignment statement and
therefore the result printed in line 7 is incorrect.  Typically, functions will
return values that can be printed or processed in some other way by the caller.

Void Functions and Side Effects
-------------------------------

Occasionally, we will also need to write non-fruitful functions, which are also
sometimes referred to as **procedures** or **void functions**.  The figure below
illustrates the black-box diagram of a void function.  These values, often
called **arguments** or **actual parameters**, are passed to the function by the
user.

.. image:: Figures/blackboxproc.png

Suppose we're working with turtles and a common operation we need is to draw
squares.  It would make sense if we did not have to duplicate all the steps each
time we want to make a square.   "Draw a square" can be thought of as an
*abstraction* of a number of smaller steps.  We will need to provide two pieces
of information for the function to do its work: a turtle to do the drawing and a
size for the side of the square.  We could represent this using the following
black-box diagram.

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

Everything that this function does is a side-effect.  The import statement adds
the turtle library to the main name space (a side-effect).  The function
definition saves the associated function value to the main namespace (a
side-effect).  The ``turtle.Screen`` call makes an external screen for turtles
(a side-effect)... etc.  All programs need some part of their code to be
side-effecting, if nothing else we need to read data in and output results.  The
goals in functional programming, regarding side-effect are as follows.

1. Make as many functions as possible pure and fruitful.  We will test these
   functions to confirm that they are correct and once tested, we will know that
   they are not the source of any bugs in our program.
2. Write small functions and provide a quality name for each.  Each function
   should perform one and only one abstract task.
3. Refactor longer functions by identifying portions of the code that perform
   some task and putting this code in another function.
4. Always be aware of side-effects and try to capture and contain side-effects
   in a small number of functions.  Side-effecting functions are much hard to
   test, which is one of the reasons that we will keep them to a minimum.

We will dedicate more time to each of these topics in the upcoming sections.



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
.. todo:: Make this about writing test functions.

At this point, you should be able to look at complete functions and tell what
they do. Also, if you have been doing the exercises, you have written some small
functions from expressions and list comprehensions. As you write larger
functions, you might start to have more difficulty, especially with runtime and
semantic errors.

To deal with increasingly complex programs, we are going to suggest a technique
called **incremental development**. The goal of incremental development is to
avoid long debugging sessions by adding and testing only a small amount of code
at a time.

As an example, suppose you want to find the distance between two points, given
by the coordinates :math:`(x_1, y_1)` and
:math:`(x_2, y_2)`.  By the Pythagorean theorem, the distance is:

.. image:: Figures/distance_formula.png
   :alt: Distance formula 

The first step is to consider what a ``distance`` function should look like in
Python. In other words, what are the inputs (parameters) and what is the output
(return value)?

In this case, the two points are the inputs, which we can represent using four
parameters. The return value is the distance, which is a floating-point value.

Already we can write an outline of the function that captures our thinking so far.

.. ipython:: python
    
    def distance(x1, y1, x2, y2):
        return 0.0

Obviously, this version of the function doesn't compute distances; it always
returns zero. But it is syntactically correct, and it will run, which means
that we can test it before we make it more complicated.

To test the new function, we create a test function.  We will use the convention
of naming a test function by prepending ``test_`` to the name of the function.


.. ipython:: python
    
    def distance(x1, y1, x2, y2):
        return 0.0

    def test_distance():
        assert distance(3,4,0,0) == 5
        assert distance(3,4,3,4) == 0
    test_distance()

Inside the test function, ``assert`` statements are used to test the function
for various hand computed cases.  In this example, we use the Pythagorean triple
(:math:`3^2+4^2=5^2`) and also assert that the distance from a point and itself
is 0.  An assert statement will be invisible if the expression evaluates to True
but throw and exception if it fails.

.. ipython:: python

    assert "a" == "a"
    assert "a" == "A"

For now, we follow the test function definition with a call to the test
functions.  This way, we can quickly check our test by running the file.  

.. note::

    In the future, we will remove these calls and use the ``py.test`` module to
    automatically run all out test for us.  This module will run all functions that
    start with ``test_``, which is why it is a good idea to use this naming
    convension.

At this point we have confirmed that the function is syntactically correct, and
we can start adding lines of code. After each incremental change, we test the
function again. If an error occurs at any point, we know where it must be --- in
the last line we added.

A logical first step in the computation is to find the differences
x\ :sub:`2`\ - x\ :sub:`1`\  and y\ :sub:`2`\ - y\ :sub:`1`\ .  We will store
those values in temporary variables named ``dx`` and ``dy``.

.. ipython:: python
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        return 0.0

    def test_distance():
        assert distance(3,4,0,0) == 5
        assert distance(3,4,3,4) == 0
    test_distance()

Next we compute the sum of squares of ``dx`` and ``dy``.

.. ipython:: python
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        dsquared = dx**2 + dy**2
        return 0.0

    def test_distance():
        assert distance(3,4,0,0) == 5
        assert distance(3,4,3,4) == 0
    test_distance()
    
Again, we could run the program at this stage and check the value of ``dsquared`` (which
should be 25).

Finally, using the fractional exponent ``0.5`` to find the square root,
we compute and return the result.

.. ipython:: python
    
    def distance(x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        dsquared = dx**2 + dy**2
        result = dsquared**0.5
        return result

    def test_distance():
        assert distance(3,4,0,0) == 5
        assert distance(3,4,3,4) == 0
    test_distance()


If that works correctly, you are done. When using ``assert`` statements, silence
is golden, meaning that when won't hear anything from our test function when our
function passes the tests.   No ``AssertionErrors``.  Otherwise, you might want
to print the value of ``result`` before the return statement.

When you start out, you might add only a line or two of code at a time. As you
gain more experience, you might find yourself writing and debugging bigger
conceptual chunks. As you improve your programming skills you should find
yourself managing bigger and bigger chunks: this is very similar to the way we
learned to read letters, syllables, words, phrases, sentences, paragraphs, etc.,
or the way we learn to chunk music --- from individual notes to chords, bars,
phrases, and so on.  

The key aspects of the process are:

#. Start with a working skeleton program and make small incremental changes. At any
   point, if there is an error, you will know exactly where it is.
#. Use temporary variables to hold intermediate values so that you can easily inspect
   and check them.
#. Once the program is working, you might want to consolidate multiple statements 
   into compound expressions,
   but only do this if it does not make the program more difficult to read.

.. note:: 

    In this example, we performed a development technique known as **test-driven
    design**, in which you start by writing a test that needs to be passed and
    then writing the function(s) needed to pass these tests.

Python Functional Parameters
============================

In this section, we will look at some alternative methods for defining
functional parameters. These include assigning default parameters, using a
variable number of arguments, and unpacking a list for use as arguments in a
function call.

Default Parameters
------------------

In an earlier chapter, we contended with the problem of creating a general
``apply_tax`` function.  One solution was to have the tax rate as a parameter.

.. ipython:: python

    def apply_tax (rate, cost): 
        return round(rate*cost, 2)

    apply_tax(1.065, 4.99)

It was noted that having to input the same tax rate can be annoying, but also
violated the DRY principle.  Our first solution to this problem was to use a
function factory and a closure to create specific implementations of
``apply_tax``.

.. ipython:: python

    def make_apply_tax(rate): 
        def apply_tax(cost): 
            return round(rate*cost, 2)
        return apply_tax

    apply_tax = make_apply_tax(1.065)
    apply_tax(4.99)

The standard "Pythonic" solution to this problem is to use a default parameter
for the tax rate.  The default value is selected to be some convenient and
typical value and the user can either use this default or provide their own.

.. ipython:: python

    def apply_tax(cost, rate=1.065):
         return round(rate*cost, 2)

    apply_tax(4.99)
    apply_tax(4.99, 1.07)
    apply_tax(4.99, rate=1.07)

Note that we can give an alternate value for the default value positionally (by
adding a second parameter) or by explicitly assigning a value to the parameter
(``rate=1.07``).

.. note::

Default parameters must follow all regular (positional) parameters.

Variable Arity Functions
------------------------

So far, our functions have had a fixed arity, a fixed number of inputs.  If we
define the function ``add`` to take two inputs, calls to this function will work
if and only if it is supplied two arguments.

.. ipython:: python

    add = lambda x,y: x + y
    add(1,2)
    add(1,2,3)
    add(1)

Here is an interesting fact about the ``print`` functions, it can take a
variable number of inputs.

.. ipython:: python

    print("A")
    print(1,2,3)

How does that work?  It turns out that we can design similar functions using the
variable arguments in our definition.  When we use ``*args`` as a parameter,
Python will accept any number of arguments and give them to us in a tuple named
``args``. You should think of ``*args`` to represent *zero or more arguments*
stored in a tuple named ``args``.  In the case of the ``add`` function, we can
simply apply the ``sum`` function to this tuple to get the sum of all the
numbers.

.. ipython:: python

    add = lambda *args: sum(args) #*
    add(1)
    add(1,2,3)
    add()

While it is traditional to use ``args`` for a variable number of arguments, you
can use a different name if your like.

.. ipython:: python

    add = lambda *bobs: sum(bobs) #*
    add(1)
    add(1,2,3)
    add()

We can combine a variable number of arguments with regular parameters, for
example, if we wanted to design ``add`` to take *one or more parameters*, you
would start with the required one parameter, then add the ``*args`` for zero or
more additional parameters.

.. ipython:: python

    add = lambda first, *args: first + sum(args) #*
    add(1)
    add(1,2,3)
    add()

.. note:: 

    The variable args must follow the positional arguments.

Keyword Arguments
-----------------

Just as using ``*args`` allows construction of functions with any number of
arguments, we can use the ``**kwargs`` to provide any number of *keyword
arguments*. **Keyword arguments**, like default parameters, are used to define
values by name as opposed to position.

To define a function that accepts keyword arguments, we add the special
``**kwargs`` parameter to the end of the parameter list.

.. ipython:: python

    def f(**kwargs): #**
        print('The keywords and values are', kwargs)

When calling such a function, we provide the keyword arguments by *unpacking* a
dictionary of keywords and the corresponding values.

.. ipython:: python

    f(x = 2, y = 3)

Notice that all of the keyword arguments are returned in a dictionary named
``kwargs``.  The keys of this dictionary are the strings for each keyword and
the value are the corresponding argument values.


Let's return to the ``apply_tax`` example.  Another solution to the problem is
to define the function to allow for keyword arguments, then check these
arguments for the ``'rate'`` keyword.

.. ipython:: python

    from toolz import get
    def apply_tax(cost, **kwargs): #**
        if 'rate' in kwargs:
            rate = get('rate', kwargs)
        else:
            rate = 1.065
        return round(rate*cost, 2)

    apply_tax(4.99)
    apply_tax(4.99, rate = 1.07)
        
Unpacking arguments and keywords
--------------------------------

The ``*args`` notation also has a utility in a function call.  Applying the
``*`` operator to a list **unpacks** it, passing each entry in the sequence as a
argument (separated by commas).  Thus, we think of ``*[1,2,3]`` as ``1,2,3`` and
``add(*[1,2,3])`` as ``add(1,2,3)``.

.. ipython:: python

    add(*[1,2,3]) #*

As we can see with the ``add`` function defined above, combining a variable
number of parameters with the unpacking operator allows us to write and use very
general functions.  Here we have a function that will work on any number of
arguments, as well as on unpacked lists.   In particular, applying this function
to the list allows us to add up a list of undetermined length!

Unpacking dictionaries with the ``**`` operator is similar to unpacking lists
with ``*`` operator.  In this case, we think of ``**{'x':5, 'y':2}`` as
returning ``x=5, y=2``.

Here is an example of using keyword unpacking with the ``apply_tax`` function
that accepts keyword arguments.

.. ipython:: python

    from toolz import get
    def apply_tax(cost, **kwargs): #**
        if 'rate' in kwargs:
            rate = get('rate', kwargs)
        else:
            rate = 1.065
        return round(rate*cost, 2)

    apply_tax(4.99, **{'rate':1.07})
        
.. todo:: Add some multiple choice problem related to types of parameters (positional, default, varargs, kwargs)
.. todo:: Add multiple choice problems that require the student to parse various combinations of parameters.
