..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Exercises
---------

.. question:: 0013
    :number: 1

    .. tabbed:: q1

        .. tab:: Question

            What is the result of each of the following:

            a. 'Python'[1]
            #. "Strings are sequences of characters."[5]
            #. len("wonderful")
            #. 'Mystery'[:4]
            #. 'p' in 'Pineapple'
            #. 'apple' in 'Pineapple'
            #. 'pear' not in 'Pineapple'
            #. 'apple' > 'pineapple'
            #. 'pineapple' < 'Peach'

        .. tab:: Answer

            a. 'Python'[1] = 'y'
            #. 'Strings are sequences of characters.'[5] = 'g'
            #. len('wonderful') = 9
            #. 'Mystery'[:4] = 'Myst'
            #. 'p' in 'Pineapple' = True
            #. 'apple' in 'Pineapple' = True
            #. 'pear' not in 'Pineapple' = True
            #. 'apple' > 'pineapple' = False
            #. 'pineapple' < 'Peach' = False


.. question:: 0044

   .. tabbed:: q1

        .. tab:: Question

           Draw a reference diagram for ``a`` and ``b`` before and after the third line of
           the following python code is executed:

           .. sourcecode:: python

               a = [1, 2, 3]
               b = a[:]
               b[0] = 5

        .. tab:: Answer

            Your diagram should show two variables referring to two different lists.  ``a`` refers to the original list with 1,2, and 3.
            ``b`` refers to a list with 5,2, and 3 since the zero-eth element was replaced with 5.

        .. tab:: Discussion

            .. disqus::
                :shortname: interactivepython
                :identifier: disqus_12314cf40dbe407cb145f029870c0347

.. question:: 0070

   Draw a reference diagram for ``a`` and ``b`` before and after the third line of
   the following python code is executed:

   .. sourcecode:: python

       a = [1, 2, 3]
       b = 2*a
       c = 3*b
       c[0] = 5

.. question:: 0081 
   
   **Question:** Determine the complexity of the following task: Sum up all the negative numbers in a list.



.. question:: 0087 

   **Question:** Determine the complexity of the following task: Count how many words in a list have length 5.

   **Answer:**

   .. reveal:: Answer
            
       To complete this task, we must

       1. visit each of the words in the list: :math:`n` operations, each :math:`O(1)`.
       2. For each word, check if the word is longer than 5: :math:`n` operations, each :math:`O(1)`.
       3. For each word larger than 5, add 1 to the count.  Suppose there are :math:`m` long words: :math:`m < n` operations, each :math:`O(1)`.

       Thus the total complexity is :math:`n*O(1) + n*O(1) + m*O(1) < n*(3*O(1)) = O(n*1) = O(n)`

.. question:: 0101 

     Determine the complexity of the following task: Add up all of the entries of an :math:`n\times n` matrix

