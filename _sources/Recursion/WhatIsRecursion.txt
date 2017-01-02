..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

What Is Recursion?
==================

**Recursion** is a method of solving problems that involves breaking a
problem down into smaller and smaller subproblems until you get to a
small enough problem that it can be solved trivially. Usually recursion
involves a function calling itself. While it may not seem like much on
the surface, recursion allows us to write elegant solutions to problems
that may otherwise be very difficult to program.





Calculating the Sum of a List of Numbers
----------------------------------------

We will begin our investigation with a simple problem that you already
know how to solve without using recursion. Suppose that you want to
calculate the sum of a list of numbers such as:
:math:`[1, 3, 5, 7, 9]`. An iterative function that computes the sum
is shown below. The function uses an accumulator variable
(``theSum``) to compute a running total of all the numbers in the list
by starting with :math:`0` and adding each number in the list.



.. activecode:: lst_itsum
    :caption: Iterative Summation

    def listsum(numList):
        theSum = 0
        for i in numList:
            theSum = theSum + i
        return theSum
        
    print(listsum([1,3,5,7,9]))

Pretend for a minute that you do not have ``while`` loops or ``for``
loops. How would you compute the sum of a list of numbers? If you were a
mathematician you might start by recalling that addition is a function
that is defined for two parameters, a pair of numbers. To redefine the
problem from adding a list to adding pairs of numbers, we could rewrite
the list as a fully parenthesized expression. Such an expression looks
like this: 

.. math::
    ((((1 + 3) + 5) + 7) + 9)
    
We can also parenthesize
the expression the other way around,

.. math::

     (1 + (3 + (5 + (7 + 9)))) 

Notice that the innermost set of
parentheses, :math:`(7 + 9)`, is a problem that we can solve without a
loop or any special constructs. In fact, we can use the following
sequence of simplifications to compute a final sum.

.. math::

    total = \  (1 + (3 + (5 + (7 + 9)))) \\
    total = \  (1 + (3 + (5 + 16))) \\
    total = \  (1 + (3 + 21)) \\
    total = \  (1 + 24) \\
    total = \  25


How can we take this idea and turn it into a Python program? First,
let’s restate the sum problem in terms of Python lists. We might say the
the sum of the list ``numList`` is the sum of the first element of the
list (``numList[0]``), and the sum of the numbers in the rest of the
list (``numList[1:]``). To state it in a functional form:

.. math::

      listSum(numList) = first(numList) + listSum(rest(numList))
    \label{eqn:listsum}



In this equation :math:`first(numList)` returns the first element of
the list and :math:`rest(numList)` returns a list of everything but
the first element. This is easily expressed in Python.


.. activecode:: lst_recsum
    :caption: Recursive Summation

    def listsum(numList):
       if len(numList) == 1:
            return numList[0]
       else:
            return numList[0] + listsum(numList[1:])
            
    print(listsum([1,3,5,7,9]))

There are a few key ideas in this listing to look at. First, on line 2 we are checking to see if the list is one element long. This
check is crucial and is our escape clause from the function. The sum of
a list of length 1 is trivial; it is just the number in the list.
Second, on line 5 our function calls itself! This is the
reason that we call the ``listsum`` algorithm recursive. A recursive
function is a function that calls itself.

:ref:`Figure 1 <fig_recsumin>` shows the series of **recursive calls** that are
needed to sum the list :math:`[1, 3, 5, 7, 9]`. You should think of
this series of calls as a series of simplifications. Each time we make a
recursive call we are solving a smaller problem, until we reach the
point where the problem cannot get any smaller.

.. _fig_recsumin:

.. figure:: Figures/sumlistIn.png
   :align: center
   :alt: image


   Figure 1: Series of Recursive Calls Adding a List of Numbers

When we reach the point where the problem is as simple as it can get, we
begin to piece together the solutions of each of the small problems
until the initial problem is solved. :ref:`Figure 2 <fig_recsumout>` shows the
additions that are performed as ``listsum`` works its way backward
through the series of calls. When ``listsum`` returns from the topmost
problem, we have the solution to the whole problem.

.. _fig_recsumout:

.. figure:: Figures/sumlistOut.png
   :align: center
   :alt: image

   Figure2: Series of Recursive Returns from Adding a List of Numbers



The Three Laws of Recursion
---------------------------

Like the robots of Asimov, all recursive algorithms must obey three
important laws:

#. A recursive algorithm must have a **base case**.

#. A recursive algorithm must change its state and move toward the base
   case.

#. A recursive algorithm must call itself, recursively.

Let’s look at each one of these laws in more detail and see how it was
used in the ``listsum`` algorithm. First, a base case is the condition
that allows the algorithm to stop recursing. A base case is typically a
problem that is small enough to solve directly. In the ``listsum``
algorithm the base case is a list of length 1.

To obey the second law, we must arrange for a change of state that moves
the algorithm toward the base case. A change of state means that some
data that the algorithm is using is modified. Usually the data that
represents our problem gets smaller in some way. In the ``listsum``
algorithm our primary data structure is a list, so we must focus our
state-changing efforts on the list. Since the base case is a list of
length 1, a natural progression toward the base case is to shorten the
list. This is exactly what happens on line 5 of :ref:`ActiveCode 2 <lst_recsum>` when we call ``listsum`` with a shorter list.

The final law is that the algorithm must call itself. This is the very
definition of recursion. Recursion is a confusing concept to many
beginning programmers. As a novice programmer, you have learned that
functions are good because you can take a large problem and break it up
into smaller problems. The smaller problems can be solved by writing a
function to solve each problem. When we talk about recursion it may seem
that we are talking ourselves in circles. We have a problem to solve
with a function, but that function solves the problem by calling itself!
But the logic is not circular at all; the logic of recursion is an
elegant expression of solving a problem by breaking it down into a
smaller and easier problems.

In the remainder of this chapter we will look at more examples of
recursion. In each case we will focus on designing a solution to a
problem by using the three laws of recursion.


.. admonition:: Self Check

   .. mchoice:: question_recsimp_1
      :correct: c
      :answer_a: 6
      :answer_b: 5
      :answer_c: 4
      :answer_d: 3
      :feedback_a: There are only five numbers on the list, the number of recursive calls will not be greater than the size of the list.
      :feedback_b: The initial call to listsum is not a recursive call.
      :feedback_c: the first recursive call passes the list [4,6,8,10], the second [6,8,10] and so on until [10].
      :feedback_d: This would not be enough calls to cover all the numbers on the list

      How many recursive calls are made when computing the sum of the list [2,4,6,8,10]?

   .. mchoice:: question_recsimp_2
      :correct: d
      :answer_a: n == 0
      :answer_b: n == 1
      :answer_c: n &gt;= 0
      :answer_d: n &lt;= 1
      :feedback_a:  Although this would work there are better and slightly more efficient choices. since fact(1) and fact(0) are the same.
      :feedback_b: A good choice, but what happens if you call fact(0)?
      :feedback_c: This basecase would be true for all numbers greater than zero so fact of any positive number would be 1.
      :feedback_d: Good, this is the most efficient, and even keeps your program from crashing if you try to compute the factorial of a negative number.

      Suppose you are going to write a recusive function to calculate the factorial of a number.  fact(n) returns n * n-1 * n-2 * ... Where the factorial of zero is definded to be 1.  What would be the most appropriate base case?
