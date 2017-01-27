    ..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Saving Expressions for Later Execution - The `lambda` Expression
================================================================

Abstraction with Variables and Expressions
------------------------------------------

The most important concept in programming is **abstraction.**  Creating an
abstraction involves replacing code with a name, which replaces the *complexity
of the solution* with the *meaning of the code.*  In this way, a programmer can
deal with a complex problem by combining many small and easy to understand
abstractions.  This process is added by picking names that keep the meaning of
the code intact while hiding the implementation details (complexity), which is
why we will be so particular about the names that we use.

We have seen our first form of abstraction in the form of a variable.  Using
variables allows us to replace values with a name that expresses the meaning of
these values in the context of the problem.  Consider the following calculation.

.. ipython:: python

    int(100*(1.55*1.065*3))/100

While this expression is easy to understand *arithmetically*, it lacks any
real-world meaning.  Compare this to the following code, which has applied the
variable abstraction to give the code meaning.


.. ipython:: python

    iced_tea_price = 1.55
    tax_rate = 1.065
    number_of_glasses = 3
    total_cost = round(iced_tea_price*tax_rate*number_of_glasses, 2)
    total_cost

Now we see the meaning behind each of the numbers.  Here we have combined the
variable abstraction (represented by the variables ``iced_tea_price``,
``tax_rate``, ``number_of_glasses`` and ``total_cost``) with the ``round``
function, which is another form of abstraction.  In particular, the ``round``
function makes the meaning of the ``int(100*(...))/100`` portion of the
expression much easier to understand by hiding this complexity behind a
meaningful name.

The Generalization and the DRY Principle
----------------------------------------

Abstractions allow us to introduce two other programming important concepts:
**generalization** and **the "Don't Repeat Yourself" (DRY) principle.**  Code
that has been generalized using abstractions can be used to solve not just one
problem but **many** problems.  An example of the application of generalization
is the use the ``round`` function from the last section.  Not only can we use
this function to round to two decimal places when working with dollars and
cents, it generalizes the process of rounding to any number of decimal places.

.. ipython:: python

    from math import pi
    round(pi)
    round(pi, 3)
    round(pi, 7)

Adhering to the DRY principle is a standard approach to writing code that is
correct (e.g. computes the correct values), clean (easy to read) and
maintainable (can be changed or extended).  We will strive to **eliminate all
repeated code** in our programs.  One advantage to this approach is
increased productivity, since we won't waste time retyping the same code over and over.
Another, perhaps more important, advantage is that any mistakes that we make
will be isolated to one place in the code.  Functions will be our primary tool
for abstraction, generalization, and the elimination of replicated code.  In
this next section, we will introduce the ``lambda`` expression, which will allow
us to save expressions for later execution, as well as generalize the solution
to a problem.

The `lambda` Expression
-----------------------

While the iced tea example from above illustrated the power of abstraction to
compartmentalize complexity, it was not a general solution to the problem.
Suppose that we want to compute the cost (with tax) of purchasing 2 and 5
glasses of tea.  Currently, we would accomplish this as follows.


.. ipython:: python

    number_of_glasses = 2
    total_cost = round(iced_tea_price*tax_rate*number_of_glasses, 2)
    total_cost

    number_of_glasses = 5
    total_cost = round(iced_tea_price*tax_rate*number_of_glasses, 2)
    total_cost

We have violated the DRY principle by using the
``round(iced_tea_price*tax_rate*number_of_glasses, 2)`` expression twice!  We
can make a more general solution using the ``lambda`` expression, which allows
us to turn simple expressions into functions.  The syntax for the one variable
``lambda`` expression is as follows:

.. sourcecode:: python

    lambda PARAMETER: BODY_EXPRESSION 

.. note::

    We have specialized language when talking about lambda expressions (and
    other functions.)  The variable that the we are generalizing is called the
    **formal parameter** and the expression that we mean to evaluate is referred
    to as the **body** of the lambda expression.

Generalizing the application of the tax rate to the cost of an item would be a
useful abstraction, as this function could be applied in many situations.  The
general expression of applying tax is ``tax_rate*cost``.  We want to be able to
change the value of ``cost`` in our generalization, which is accomplished using a
lambda expression as shown below

.. ipython:: python

    apply_tax = lambda cost: round(tax_rate*cost, 2)
    apply_tax

Notice that we can save lambda expressions to variables in the same way that we
save any other value.  Simply evaluating the lambda expression does not execute
the encapsulated code, to do this we need to use a new form of syntax.  

Once a lambda expression is constructed, it can be **applied** later to a given
value of the variable using the following syntax.

.. sourcecode:: python

    LAMBDA_EXPRESSION(ARGUMENT)

LAMBDA_EXPRESSION can be the literal expression or a variable to which the
expression was saved.  For simple lambda expressions, all instances of PARAMETER
will be replaced with the value of the ARGUMENT, and then evaluate the
BODY_EXPRESSION\*.

.. note:: 

    \*Since lambda expressions are themselves expressions, we can embed lambda
    expressions inside lambda expressions.  This will cause problems with the
    simple substitution rule that we gave above.  More on this complexity later.

.. ipython:: python

    apply_tax = lambda cost: round(tax_rate*cost, 2)
    total_cost = apply_tax(iced_tea_price*number_of_glasses)
    total_cost


Hard-coding the tax rate inside ``apply_tax`` makes this a less general solution
to the problem.  We can fix this by adding another parameter to the lambda
expression. To do this, we will need to allow two variables in the body to
change from problem to problem, which can also be accomplished with the lambda
expression by adding additional parameters. The syntax for the more general
lambda expression, with many parameters, is as follows.

.. sourcecode:: python

    lambda PARAMETER_1, ... , PARAMETER_K: BODY_EXPRESSION 

We can apply this more general expression using a similar application syntax.


.. sourcecode:: python

    LAMBDA_EXPRESSION(ARGUMENT_1, ..., ARGUMENT_K)

Note that the number of arguments needs to match the number of arguments

.. ipython:: python

    pow = lambda x, y: x**y
    pow
    pow(2,3)
    pow(2)
    pow(1,2,3)

Returning to the iced tea example, we now make a more general version of
``apply_tax``.

.. ipython:: python

    apply_tax = lambda cost, tax: round(tax*cost, 2)
    pre_tax_cost = iced_tea_price*number_of_glasses
    total_cost = apply_tax(pre_tax_cost, tax_rate)
    total_cost

To continue the generalization process, we construct a lambda expression for
computing the (pre_tax) cost of any number of glasses of tea and use it to
compute the cost for 3, 2, and 5 glasses of tea.

.. ipython:: python

    pre_tax_cost = lambda num_glasses: iced_tea_price*num_glasses
    apply_tax(pre_tax_cost(3), tax_rate)
    apply_tax(pre_tax_cost(2), tax_rate)
    apply_tax(pre_tax_cost(5), tax_rate)

.. admonition:: Question

    Do you see where we have violated the DRY principle?  How might we fix this
    problem?

Finally, we will eliminated the repeated code and hide the complexity of the
computation of the total cost in another lambda expression.

.. ipython:: python

    total_cost = lambda num_glasses: apply_tax(pre_tax_cost(num_glasses), tax_rate)
    total_cost(3)
    total_cost(2)
    total_cost(5)

To better understand the evaluation of this code, use codelens to step through
the evaluation step-by-step.


.. codelens:: ch06_lambdacodelens
    :showoutput:

    iced_tea_price = 1.55
    tax_rate = 1.065
    apply_tax = lambda cost, tax: round(tax*cost, 2)
    pre_tax_cost = lambda num_glasses: iced_tea_price*num_glasses
    total_cost = lambda num_glasses: apply_tax(pre_tax_cost(num_glasses), tax_rate)
    total_cost(3)

This example includes many of the ideas that we will explore in a later chapter
on functional programming, including

1. **Abstracting constants with global variables.**  In this case, the values of
   ``iced_tea_price`` and ``tax_rate`` have been assigned to variables that are
   used by other functions and expressions.  Doing this at the top of our code
   allows us to easily change these constants at a later date.
2. **Abstracting expressions using functions by pulling out variables as formal
   parameters.**  We can think of these parameters as "holes" in our program that
   can be filled in later.
3. **Composing small functions to solve more complicated problems.**  Notice that
   ``total_cost`` is an example of function composition, as ``apply_tax`` is
   applied to the result of ``pre_tax_cost``.


Boolean Functions
-----------------

We have already seen that boolean values result from the evaluation of boolean
expressions.  Since the result of any expression evaluation can be returned by a
lambda expression, lambda expressions can return boolean values.  This turns out
to be a very convenient way to hide the details of complicated tests. For
example:

.. ipython:: python

    isDivisible = lambda x, y: True if x % y == 0 else False

    isDivisible(10, 5)

The name of this function is ``isDivisible``. It is common to give **boolean
functions** names that sound like yes/no questions.  ``isDivisible`` returns
either ``True`` or ``False`` to indicate whether the ``x`` is or is not
divisible by ``y``.

We can make the lambda expression more concise by taking advantage of the fact
that the condition of the ``if`` expression is itself a boolean expression. We
can return it directly, avoiding the ``if`` statement altogether:

.. ipython:: python

    isDivisible = lambda x, y: x % y == 0

    isDivisible(10, 5)


Boolean functions are often used in conditional statements:

.. sourcecode:: python

     EXPR_1 if isDivisible(x, y) else EXPR_2

.. note::

    It might be tempting to write something like ``isDivisible(x, y) == True`` as
    the condition of the if expression, but the extra comparison is not necessary.

The following example shows the ``isDivisible`` function at work.  Notice how
descriptive the code is when we move the testing details into a boolean
function, which is a direct result of using an abstraction.  Try it with a few
other actual parameters to see what is printed.

.. ipython:: python

    isDivisible = lambda x, y: x % y == 0

    "That works" if isDivisible(10, 5) else "Those values are no good"

Here is the same program in codelens.  When we evaluate the ``if`` statement in
the main part of the program, the evaluation of the boolean expression causes a
call to the ``isDivisible`` function.  This is very easy to see in codelens.

.. codelens:: ch06_boolcodelens
    :showoutput:

    isDivisible = lambda x, y: True if x % y == 0 else False

    outcome = "That works" if isDivisible(10, 5) else "Those values are no good"
    outcome



**Check your understanding**

.. mchoice:: test_question6_8_1
   :answer_a: A function that returns True or False
   :answer_b: A function that takes True or False as an argument
   :answer_c: The same as a Boolean expression
   :correct: a
   :feedback_a: A Boolean function is just like any other function, but it always returns True or False.
   :feedback_b: A Boolean function may take any number of arguments (including 0, though that is rare), of any type.
   :feedback_c: A Boolean expression is a statement that evaluates to True or False, e.g. 5+3==8.  A function is a series of expressions grouped together with a name that are only executed when you call the function.

   What is a Boolean function?

.. mchoice:: test_question6_8_2
   :answer_a: Yes
   :answer_b: No
   :correct: a
   :feedback_a: It is perfectly valid to return the result of evaluating a Boolean expression.
   :feedback_b: x +y < z is a valid Boolean expression, which will evaluate to True or False.  It is perfectly legal to return True or False from a function, and to have the statement to be evaluated in the same line as the return keyword.

   Is the following statement legal in Python (assuming x, y and z are defined to be numbers)?

   .. code-block:: python

     return x + y < z



.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_06_03

.. TODO:: Add last wrinkle to the tea example.

.. TODO:: Discuss extensibility

Aside: Lambda Calculus and the Power of the Lambda Expression
-------------------------------------------------------------

While the expressions that we have introduced so far may seem like a very small
subset of a programming language like Python, it turns out that they are very
powerful. `Alonzo Church <https://en.wikipedia.org/wiki/Alonzo_Church>`_
developed the lambda calculus in 1930 as a general method of describing
computation.  The lambda calculus consists of three basic building blocks.

1. **variables**
2. **lambda expressions/abstractions**
3. **an application rule for lambda expressions**

It has been shown that this system is **Turing complete**, meaning that it can
be used to describe **every** possible computation that can be performed on a
computer.  Thus we *could* simply write all of our programs with the tools
presented so far ... but we won't! Programs written in this style are
unnecessarily complicated without introducing many of the abstractions that are
already provided by Python.  For more information about the lambda calculus,
visit `the Wikipedia page
<https://en.wikipedia.org/wiki/Lambda_calculus#History>`_.


