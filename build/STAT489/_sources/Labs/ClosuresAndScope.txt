Lab 1 - Closures and Scope
==========================

**Instructions:** Open a new word document and document your work as you
complete each task and answer each question.

In this lab, you will use codelens to investigate the concepts of a closure and
the scope of a variable.  You will be given a series of complicated lambda
expressions and asked to use codelens to answer some associated questions.

Closures
--------

When a function is that references a value outside its scope, a closure is
created.  Recall that a closure is a function bundled with references to each of
the variables defined outside the function definition.  

Referencing global variable
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. admonition:: Question 1 

    How does changing a global variable affect a function that references this variable?

A global variable is a variable that is defined at the top level, i.e. at the
interpreter prompt.  Global variables differ from local variables, which are
defined inside the scope of a function, which includes the formal parameters and
any variable defined inside the function.

Consider the following example.

.. ipython:: python

    x = 3
    f = lambda y: x**y
    f(2)
    # Now change the value of x
    x = 4
    # Does this change our answer?
    f(2)

Use codelens to step through this example and then complete **Task 1**.

.. codelens:: lab1_1

    x = 3
    f = lambda y: x**y
    answer1 = f(2)
    # Now change the value of x
    x = 4
    # Does this change our answer?
    answer2 = f(2)

.. admonition:: Task 1

     Where the two function calls the same or different?  Use what you learned
     from codelens to explain your answer.

Referencing local variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. admonition:: Question 2

     How does changing a local variable affect a function that references this variable?

Now we will make a similar example, but this time letting ``x`` be a local
variable defined outside of an inner ``lambda`` expression.

.. ipython:: python

    g = lambda x: lambda y: x**y
    # "set" x to 3 with a function call
    f1 = g(3)
    f1(2)
    # "set" x to 4 with a function call
    f2 = g(4)
    f2(2)
    # What happens when we call the first function now?
    f1(2)

Again step through the example in codelens and complete the following task.

.. codelens:: lab1_2

    g = lambda x: lambda y: x**y
    # "set" x to 3 with a function call
    f1= g(3)
    answer1 =  f1(2)
    # "set" x to 4 with a function call
    f2 = g(4)
    answer2 =  f2(2)
    answer3 =  f1(2)

.. admonition:: Question 2

     In what way ways does the second example differ from the first?

The Scope of a Variable
-----------------------

Now we will explore the scope of a variable.  It is important to note that
variables reference values.  Remember that the scope of a variable is all the
parts of the code where a variable will return it associated value.   

Consider each of the following examples.

**Example 1**

.. ipython:: python

    g = lambda x: lambda x: lambda x: 2*x
    f = g(1)
    h = f(2)
    h(3)

.. codelens:: lab1_3

    g = lambda x: lambda x: lambda x: 2*x
    f = g(1)
    h = f(2)
    h(3)

**Example 2**

.. ipython:: python

    g = lambda x: lambda y: lambda x: (x,y)
    f = g(1)
    h = f(2)
    h(3)


.. codelens:: lab1_4

    g = lambda x: lambda y: lambda x: (x,y)
    f = g(1)
    h = f(2)
    h(3)
    
**Example 3**

.. ipython:: python

    g = lambda y: lambda x: lambda y: lambda x: (x,y)
    f = g(1)
    h = f(2)
    i = h(3)
    i(5)

.. codelens:: lab1_5

    g = lambda y: lambda x: lambda y: lambda x: (x,y)
    f = g(1)
    h = f(2)
    i = h(3)
    i(5)

.. admonition:: Question 3

    For each of the following examples, describe the scope of each ``x`` and
    ``y``.  **Hint:** A diagram is a good approach.

.. admonition:: Question 4

    Rewrite each of the examples from the last task, this time renaming the
    variables using the capture free approach.

.. note::

     If you are interested in the gritty details, the `top two answers to this
     stackoverflow question
     <http://stackoverflow.com/questions/4020419/why-arent-python-nested-functions-called-closures>`_
     include more details.
