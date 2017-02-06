..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

What are Higher Order Functions?
================================

A **higher-order** function is a function that takes a function as an
argument and/or returns a function.  One of the first higher-order functions
presented in this text was the ``make_apply_tax`` function which returned a
specialized version of ``apply_tax``.

.. ipython:: python

    make_apply_tax = lambda rate: lambda cost: rate*cost
    apply_tax = make_apply_tax(1.065)
    apply_tax(5.05)

The functions ``map``, ``filter`` and ``reduce`` are examples of higher order
functions, as they take functions as arguments.  Another example of a built-in
Python function that is higher-order is the ``max`` function, as it can take a
``key`` function as an argument (as illustrated in the last chapter).

Using higher-order functions allows us to generalize higher level patterns.  For
example, we can replace many of the ``for`` loops found in imperative Python
code with some combination of ``map``, ``filter`` and ``reduce``.

.. note::

    The exercises at the end of this chapter allow you to practice this higher
    level thinking, as we to return to the exercises from Chapter 4, but this
    time use ``map``, ``filter`` and ``reduce`` to solve each problem.

The next section covers some of the other higher level abstractions that an be
achieved using higher-order functions.
