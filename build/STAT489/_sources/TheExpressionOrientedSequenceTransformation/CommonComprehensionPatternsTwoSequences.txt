..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Common Comprehension Patterns for Two Sequences
===============================================

List comprehensions are also useful for combining two sequences into a single
list.  In this section, we will look at a few common patterns that involve two
sequence expressions in one comprehension.

Use ``for`` twice to get all combinations
---------------------------------------

Suppose that we have two list ``L`` and ``M`` and we want to perform some
computation on all combinations of elements from these two lists.  This can be
accomplished using two (independent) ``for`` twice, once for each list.  The code
shown below creates a tuple of all combinations.

.. ipython:: python

    L = [1,2,3]
    M = ["a", "b"]

    new_list = [(i,j) for i in L for j in M]
    new_list

The second ``for`` can depend on the first
------------------------------------------

The last example illustrated a comprehension pattern for constructing all
combinations of elements from two list.  Consider the following program, which
applies this technique to one list versus itself.


.. ipython:: python

    L = [1,2,3]

    new_list = [(i,j) for i in L for j in L]
    new_list

Notice that some combinations are repeated, e.g. ``(1,2)`` and ``(2,1)``.
Suppose that instead we want all unique pairs of values.  In math, this
collection is often described as all :math:`i,j` such that :math:`i \le j`.  We
can use this approach with comprehensions as well.  Two methods are shown below.

**Method 1 - Filter with ``if``**

.. ipython:: python

    L = [1,2,3]

    new_list = [(i,j) for i in L for j in L if i <= j]
    new_list

The first approach matches the mathematical definition exactly and ensures that
no value is matched with another value more than once by keeping the pairs
sorted.  One of the reasons that comprehensions are useful is they mirror the
mathematical language of describing a collection.  The only drawback to this
approach is that it requires cycling through all combinations.  Because that are
:math:`n` values to pair with each of :math:`n` values, this operation is
:math:`O(n*n)=O(n^2)`.  Suppose that we know that there are no repeated values
in ``L``.  In this case, we can filter by *indices* instead of *values*.  The
resulting method, while still :math:`O(n^2)`, will be close to twice as fast.


**Method 2 - Use indices and ``range`` to filter**

.. ipython:: python

    L = [1,2,3]
    n = len(L)
    new_list = [(L[i],L[j]) for i in range(n) for j in range(i,n)]
    new_list

This approach ensures that no index is matched with another index more than
once.  The key point here is that we made the second ``range`` depend on the
first, shortening the length of the sequence.  Provided that all the elements of
``L`` are unique, this second method iterates over :math:`\frac{n(n-1)}{2}`
elements instead of :math:`n^2`.  In the long run, this approach will be a
little less than twice as fast but approach exactly twice as fast
asymptotically.  Unfortunately, :math:`O\left(\frac{n(n-1)}{2}\right)=O\left(\frac{n^2}{2} -
\frac{n}{2}\right)=O(n^2)`, so this will still be expensive for large list.

Sometimes it is easier to describe what your don't want
-------------------------------------------------------

Suppose that we want to use list comprehensions to describe all the prime
numbers up to ``n=120``.  A well-known algorithm for describing primes is the
`Sieve of Eratosthenes <https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes>`_,
For each number ``i`` between 2 and :math:`\sqrt{n}`, this algorithm crosses out
all the multiples of ``i``.  The remaining numbers will be prime.  Notice that
this algorithm describes numbers that are prime by *decribing all numbers that
are not*.  The following two list comprehensions perform the task of finding all
primes up to 120.

.. ipython:: python

    from math import sqrt
    n = 120
    not_prime = [j for i in range(2, int(sqrt(n) + 1)) for j in range(2*i,n + 1, i)]
    prime = [i for i in range(2,n+1) if i not in not_prime]
    prime

This is another application of the last two patterns.  We want all multiples of
``i`` and thus the second sequence expression depends on the first.
Furthermore, we want all multiples of ``i`` for all ``i`` up to the square root
of our cut-off, which requires two sequence expressions.

**Illustration of the Sieve of Eratosthenes**

.. figure:: https://upload.wikimedia.org/wikipedia/commons/b/b9/Sieve_of_Eratosthenes_animation.gif
    :alt: Illustration of the Sieve of Eratosthenes
    
    ..

    The Sieve of Eratosthenes finds all the primes up to some number ``n`` by
    crossing out all multiples of numbers from 2 to :math:`\sqrt{n}`.  This image was
    copied from `Wikipedia
    <https://commons.wikimedia.org/wiki/File:Sieve_of_Eratosthenes_animation.gif>`_
    and is covered by the `GNU Free Documentation License
    <https://en.wikipedia.org/wiki/en:GNU_Free_Documentation_License>`_.

As always, we can clean this code up with a little refactoring.  Let's use two
lambda expressions to give meaning two applications of range in ``not_prime``.

.. ipython:: python

    from math import sqrt
    n = 120
    possible_factors = lambda n: range(2, int(sqrt(n) + 1)) 
    multiples_of = lambda i, n: range(2*i,n + 1, i)
    not_prime = [j for i in possible_factors(n) for j in multiples_of(i, n)]
    prime = [i for i in range(2,n+1) if i not in not_prime]
    prime

.. admonition:: question

    How might you make the last example more general?


