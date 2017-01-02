Understanding Name and Variable Scope
=====================================





Variables and Parameters are Local
----------------------------------

An assignment statement in a function creates a **local variable** for the
variable on the left hand side of the assignment operator. It is called local because this variable only
exists inside the function and you cannot use it outside. For example,
consider again the ``square`` function:

.. codelens:: bad_local

    def square(x):
        y = x * x
        return y

    z = square(10)
    print(y)


If you press the 'last >>' button you will see an error message.
When we try to use ``y`` on line 6 (outside the function) Python looks for a global
variable named ``y`` but does not find one.  This results in the
error: ``Name Error: 'y' is not defined.``

The variable ``y`` only exists while the function is being executed ---
we call this its **lifetime**.
When the execution of the function terminates (returns),
the local variables  are destroyed.  Codelens helps you  visualize this
because the local variables disappear after the function returns.  Go back and step through the
statements paying particular attention to the variables that are created when the function is called.
Note when they are subsequently destroyed as the function returns.

Formal parameters are also local and act like local variables.
For example, the lifetime of ``x`` begins when ``square`` is
called,
and its lifetime ends when the function completes its execution.

So it is not possible for a function to set some local variable to a
value, complete its execution, and then when it is called again next
time, recover the local variable.  Each call of the function creates
new local variables, and their lifetimes expire when the function returns
to the caller.

On the other hand, it is legal for a function to access a global variable.  However, this is considered
**bad form** by nearly all programmers and should be avoided.  Look at the following,
nonsensical variation of the square function.

.. activecode:: badsquare_1

    def badsquare(x):
        y = x ** power
        return y

    power = 2
    result = badsquare(10)
    print(result)


Although the ``badsquare`` function works, it is silly and poorly written.  We have done it here to illustrate
an important rule about how variables are looked up in Python.
First, Python looks at the variables that are defined as local variables in
the function.  We call this the **local scope**.  If the variable name is not
found in the local scope, then Python looks at the global variables,
or **global scope**.  This is exactly the case illustrated in the code above.
``power`` is not found locally in ``badsquare`` but it does exist globally.
The appropriate way to write this function would be to pass power as a parameter.
For practice, you should rewrite the badsquare example to have a second parameter called power.

There is another variation on this theme of local versus global variables.  Assignment statements in the local function cannot 
change variables defined outside the function.  Consider the following
codelens example:

.. codelens::  cl_powerof_bad

    def powerof(x, p):
        power = p   # Another dumb mistake
        y = x ** power
        return y

    power = 3
    result = powerof(10, 2)
    print(result)

Now step through the code.  What do you notice about the values of variable ``power``
in the local scope compared to the variable ``power`` in the global scope?

The value of ``power`` in the local scope was different than the global scope.
That is because in this example ``power`` was used on the left hand side of the
assignment statement ``power = p``.  When a variable name is used on the
left hand side of an assignment statement Python creates a local variable.
When a local variable has the same name as a global variable we say that the
local shadows the global.  A **shadow** means that the global variable cannot
be accessed by Python because the local variable will be found first. This is
another good reason not to use global variables. As you can see,
it makes your code confusing and difficult to
understand.

To cement all of these ideas even further lets look at one final example.
Inside the ``square`` function we are going to make an assignment to the
parameter ``x``  There's no good reason to do this other than to emphasize
the fact that the parameter ``x`` is a local variable.  If you step through
the example in codelens you will see that although ``x`` is 0 in the local
variables for ``square``, the ``x`` in the global scope remains 2.  This is confusing
to many beginning programmers who think that an assignment to a
formal parameter will cause a change to the value of the variable that was
used as the actual parameter, especially when the two share the same name.
But this example demonstrates that that is clearly not how Python operates.

.. codelens:: cl_change_parm

    def square(x):
        y = x * x
        x = 0       # assign a new value to the parameter x
        return y

    x = 2
    z = square(x)
    print(z)




**Check your understanding**

.. mchoice:: test_question5_3_1
   :answer_a: Its value
   :answer_b: The range of statements in the code where a variable can be accessed.
   :answer_c: Its name
   :correct: b
   :feedback_a: Value is the contents of the variable.  Scope concerns where the variable is &quot;known&quot;.
   :feedback_b:
   :feedback_c: The name of a variable is just an identifier or alias.  Scope concerns where the variable is &quot;known&quot;.

   What is a variable's scope?

.. mchoice:: test_question5_3_2
   :answer_a: A temporary variable that is only used inside a function
   :answer_b: The same as a parameter
   :answer_c: Another name for any variable
   :correct: a
   :feedback_a: Yes, a local variable is a temporary variable that is only known (only exists) in the function it is defined in.
   :feedback_b: While parameters may be considered local variables, functions may also define and use additional local variables.
   :feedback_c: Variables that are used outside a function are not local, but rather global variables.

   What is a local variable?

.. mchoice:: test_question5_3_3
   :answer_a: Yes, and there is no reason not to.
   :answer_b: Yes, but it is considered bad form.
   :answer_c: No, it will cause an error.
   :correct: b
   :feedback_a: While there is no problem as far as Python is concerned, it is generally considered bad style because of the potential for the programmer to get confused.
   :feedback_b: it is generally considered bad style because of the potential for the programmer to get confused.  If you must use global variables (also generally bad form) make sure they have unique names.
   :feedback_c: Python manages global and local scope separately and has clear rules for how to handle variables with the same name in different scopes, so this will not cause a Python error.

   Can you use the same name for a local variable as a global variable?

The Scope of a Name or Variable
-------------------------------

TODO





Functions can Call Other Functions
----------------------------------

It is important to understand that each of the functions we write can be used
and called from other functions we write.  This is one of the most important
ways that computer scientists take a large problem and break it down into a
group of smaller problems. This process of breaking a problem into smaller
subproblems is called **functional decomposition**.

Here's a simple example of functional decomposition using two functions. The
first function called ``square`` simply computes the square of a given number.
The second function called ``sum_of_squares`` makes use of square to compute
the sum of three numbers that have been squared.

.. codelens:: sumofsquares

    def square(x):
        y = x * x
        return y

    def sum_of_squares(x, y, z):
        a = square(x)
        b = square(y)
        c = square(z)

        return a + b + c

    a = -5
    b = 2
    c = 10
    result = sum_of_squares(a, b, c)
    print(result)


Even though this is a pretty simple idea, in practice this example
illustrates many very important Python concepts, including local and global
variables along with parameter passing.  Note that when you step through this
example, codelens bolds line 1 and line 5 as the functions are defined.  The
body of square is not executed until it is called from the ``sum_of_squares``
function for the first time on line 6.  Also notice that when ``square`` is
called there are two groups of local variables, one for ``square`` and one
for ``sum_of_squares``.  As you step through you will notice that ``x``, and ``y`` are local variables in both functions and may even have
different values.  This illustrates that even though they are named the same,
they are in fact, very different.

Now we will look at another example that uses two functions.  This example illustrates an
important computer science problem solving technique called
**generalization**.  Assume we want to write a
function to draw a square.  The generalization step is to realize that a
square is just a special kind of rectangle.

To draw a rectangle we need to be able to call a function with different
arguments for width and height.  Unlike the case of the square,
we cannot repeat the same thing 4 times, because the four sides are not equal.
However, it is the case that drawing the bottom and right sides are the
same sequence as drawing the top and left sides.  So we eventually come up with
this rather nice code that can draw a rectangle.

.. code-block:: python

    def drawRectangle(t, w, h):
        """Get turtle t to draw a rectangle of width w and height h."""
        for i in range(2):
            t.forward(w)
            t.left(90)
            t.forward(h)
            t.left(90)

The parameter names are deliberately chosen as single letters to ensure they're not misunderstood.
In real programs, once you've had more experience, we will insist on better variable names than this.
The point is that the program doesn't "understand" that you're drawing a rectangle or that the
parameters represent the width and the height.  Concepts like rectangle, width, and height are meaningful
for humans.  They are not concepts that the program or the computer understands.

*Thinking like a computer scientist* involves looking for patterns and
relationships.  In the code above, we've done that to some extent.  We did
not just draw four sides. Instead, we spotted that we could draw the
rectangle as two halves and used a loop to repeat that pattern twice.

But now we might spot that a square is a special kind of rectangle.  A square
simply uses the same value for both the height and the width.
We already have a function that draws a rectangle, so we can use that to draw
our square.

.. code-block:: python

    def drawSquare(tx, sz):        # a new version of drawSquare
        drawRectangle(tx, sz, sz)

Here is the entire example with the necessary set up code.

.. activecode:: ch04_3
    :nocodelens:

    import turtle

    def drawRectangle(t, w, h):
        """Get turtle t to draw a rectangle of width w and height h."""
        for i in range(2):
            t.forward(w)
            t.left(90)
            t.forward(h)
            t.left(90)

    def drawSquare(tx, sz):        # a new version of drawSquare
        drawRectangle(tx, sz, sz)

    wn = turtle.Screen()             # Set up the window
    wn.bgcolor("lightgreen")

    tess = turtle.Turtle()           # create tess

    drawSquare(tess, 50)

    wn.exitonclick()



There are some points worth noting here:

* Functions can call other functions.
* Rewriting `drawSquare` like this captures the relationship
  that we've spotted.
* A caller of this function might say `drawSquare(tess, 50)`.  The parameters
  of this function, ``tx`` and ``sz``, are assigned the values of the tess object, and
  the integer 50 respectively.
* In the body of the function, ``tz`` and ``sz`` are just like any other variable.
* When the call is made to ``drawRectangle``, the values in variables ``tx`` and ``sz``
  are fetched first, then the call happens.  So as we enter the top of
  function `drawRectangle`, its variable ``t`` is assigned the tess object, and ``w`` and
  ``h`` in that function are both given the value 50.


So far, it may not be clear why it is worth the trouble to create all of these
new functions. Actually, there are a lot of reasons, but this example
demonstrates two:

#. Creating a new function gives you an opportunity to name a group of
   statements. Functions can simplify a program by hiding a complex computation
   behind a single command. The function (including its name) can capture your
   mental chunking, or *abstraction*, of the problem.
#. Creating a new function can make a program smaller by eliminating repetitive
   code.
#. Sometimes you can write functions that allow you to solve a specific
   problem using a more general solution.


.. admonition:: Lab

    * `Drawing a Circle <../Labs/lab04_01.html>`_ In this guided lab exercise we will work
      through a simple problem solving exercise related to drawing a circle with the turtle.

.. index:: flow of execution






Flow of Execution Summary
-------------------------

When you are working with functions it is really important to know the order
in which statements are executed. This is called the **flow of
execution** and we've already talked about it a number of times in this
chapter.

Execution always begins at the first statement of the program.  Statements are
executed one at a time, in order, from top to bottom.
Function definitions do not alter the flow of execution of the program, but
remember that statements inside the function are not executed until the
function is called.
Function calls are like a detour in the flow of execution. Instead of going to
the next statement, the flow jumps to the first line of the called function,
executes all the statements there, and then comes back to pick up where it left
off.

That sounds simple enough, until you remember that one function can call
another. While in the middle of one function, the program might have to execute
the statements in another function. But while executing that new function, the
program might have to execute yet another function!

Fortunately, Python is adept at keeping track of where it is, so each time a
function completes, the program picks up where it left off in the function that
called it. When it gets to the end of the program, it terminates.

What's the moral of this sordid tale? When you read a program, don't read from
top to bottom. Instead, follow the flow of execution.  This means that you will read the def statements as you
are scanning from top to bottom, but you should skip the body of the function
until you reach a point where that function is called.


.. index::
    single: parameter
    single: function; parameter
    single: argument
    single: function; argument
    single: import statement
    single: statement; import
    single: composition
    single: function; composition


.. index:: bar chart


**Check your understanding**

.. mchoice:: test_question5_6_1
   :answer_a: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
   :answer_b: 1, 2, 3, 5, 6, 7, 9, 10, 11
   :answer_c: 9, 10, 11, 1, 2, 3, 5, 6, 7
   :answer_d: 9, 10, 5, 6, 7, 1, 2, 3, 11
   :answer_e: 1, 5, 9, 10, 6, 2, 3, 7, 11
   :correct: e
   :feedback_a: Although Python typically processes lines in order from top to bottom, function definitions and calls are an exception to this rule.
   :feedback_b: Although Python typically processes lines in order from top to bottom, function definitions and calls are an exception to this rule.  Although this order skips blank lines, it still lists the lines of code in order.
   :feedback_c: This is close, in that Python will not execute the functions until after they are called, but there are two problems here.  First, Python does not know which lines are function definitions until it processes them, so it must at least process the function headers before skipping over the functions. Section, notice that line 10 involves a function call.  Python must execute the function square before moving on to line 11.
   :feedback_d: This is close, in that Python will not execute the functions until after they are called, but there is one problem here.  Python does not know which lines are function definitions until it processes them, so it must at least process the function headers before skipping over the functions.
   :feedback_e: Python starts at line 1, notices that it is a function definition and skips over all of the lines in the function definition until it finds a line that it no longer included in the function (line 5).  It then notices line 5 is also a function definition and again skips over the function body to line 9.  On line 10 it notices it has a function to execute, so it goes back and executes the body of that function.  Notice that that function includes another function call.  Finally, it will return to line 11 after the function square is complete.

   Consider the following Python code. Note that line numbers are included on the left.

   .. code-block:: python
      :linenos:

      def pow(b, p):
          y = b ** p
          return y
     
      def square(x):
          a = pow(x, 2)
          return a
     
      n = 5
      result = square(n)
      print(result)

   Which of the following best reflects the order in which these lines of code are processed in Python?

.. mchoice:: test_question5_6_2
   :answer_a: 25
   :answer_b: 5
   :answer_c: 125
   :answer_d: 32
   :correct: a
   :feedback_a: The function square returns the square of its input (via a call to pow)
   :feedback_b: What is printed is the output of the square function.  5 is the input to the square function.
   :feedback_c: Notice that pow is called from within square with a base (b) of 5 and a power (p) of two.
   :feedback_d: Notice that pow is called from within square with a base (b) of 5 and a power (p) of two.

   Consider the following Python code. Note that line numbers are included on the left.

   .. code-block:: python
      :linenos:

      def pow(b, p):
          y = b ** p
          return y
     
      def square(x):
          a = pow(x, 2)
          return a
     
      n = 5
      result = square(n)
      print(result)

   What does this function print?

