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

.. basic

.. question:: 15 
   :number: 1
   
   In Robert McCloskey's book *Make Way for Ducklings*, the names of the
   ducklings are Jack, Kack, Lack, Mack, Nack, Ouack, Pack, and Quack.  This
   loop tries to output these names in order. Save your answer in a variable
   named ``words`` and make sure that this value doesn't get overwritten later in
   your program.

   Use map plus a helper function to solve this problem.

   .. sourcecode:: python

        prefixes = "JKLMNOPQ"
        suffix = "ack"

        words = [first + suffix for first in prefixes]


   Of course, that's not quite right because Ouack and Quack are misspelled.
   Can you fix it?

    .. actex:: ex_8_2


.. basic

.. question:: 37

    .. tabbed:: q5

        .. tab:: Question

           Write a function that will return the number of digits in an integer.

           Use reduce to solve thie problem.

           .. actex:: ex_7_10

              numDigits = lambda n: 0  # your code here

              ====

              from unittest.gui import TestCaseGui

              class myTests(TestCaseGui):

                def testOne(self):
                    self.assertEqual(numDigits(2),1,"Tested numDigits on input of 2")
                    self.assertEqual(numDigits(55),2,"Tested numDigits on input of 55")
                    self.assertEqual(numDigits(1352),4,"Tested numDigits on input of 1352")
                    self.assertEqual(numDigits(444),3,"Tested numDigits on input of 444")



              myTests().main()


        .. tab:: Answer

            .. ipython:: python



                from functools import reduce
                numDigits = lambda n: reduce(lambda acc, ch: acc + 1, str(n), 0)

                numDigits(50)
                numDigits(20000)
                numDigits(1)




.. working with strings

.. question:: 148 
   
   Write a function named ``remove_char`` that removes all occurrences of a
   given letter from a string.  Do not use the ``replace`` string method.

   Use reduce to solve this problem.

   .. actex:: ex_8_7
      :nocodelens:

      remove_char = lambda theLetter, theString: "stuff" # your code here

      ====


      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

        def testOne(self):
            self.assertEqual(remove_char("a","apple"),"pple","Tested remove_char on inputs of 'a' and 'apple'")
            self.assertEqual(remove_char("a","banana"),"bnn","Tested remove_char on inputs of 'a' and 'banana'")
            self.assertEqual(remove_char("z","banana"),"banana","Tested remove_char on inputs of 'z' and 'banana'")



      myTests().main()


.. basic strings

.. question:: 176

    .. tabbed:: q9

        .. tab:: Question

           Write a function that recognizes palindromes. Use reduce to solve
           thie problem.  **Hint:** Use reversed and zip.

           .. actex:: ex_8_8
              :nocodelens:

              is_palindrome lambda myStr: False # your code here

              ====


              from unittest.gui import TestCaseGui

              class myTests(TestCaseGui):

                  def testOne(self):
                      self.assertEqual(is_palindrome("abba"),True,"Tested is_palindrome on input of 'abba'")
                      self.assertEqual(is_palindrome("abab"),False,"Tested is_palindrome on input of 'abab'")
                      self.assertEqual(is_palindrome("straw warts"),True,"Tested is_palindrome on input of 'straw warts'")
                      self.assertEqual(is_palindrome("a"),True,"Tested is_palindrome on input of 'a'")
                      self.assertEqual(is_palindrome(""),True,"Tested is_palindrome on input of ''")




              myTests().main()


        .. tab:: Answer

            .. activecode:: q9_answer
                :nocodelens:
                
                from functools import reduce
                is_palindrome lambda mystr: reduce(lambda acc, tup: acc and tup[0] == tup[1], zip(mystr,reversed(mystr)), Trus)
                is_palindrome('abba')




.. reducing built-ins

.. question:: 275 

   .. tabbed:: q5

        .. tab:: Question

           Write a Python function that takes ``n`` and ``m`` as input and
           returns the maximum value of a the list of ``n`` random integers
           between 0 and ``m``.  (Note:.  there is a builtin function named
           ``max``.)

           Use map to generating the random sequence and reduce to find the max.

           .. actex:: ex_9_5


        .. tab:: Answer

            .. ipython:: python

                from random import randint
                from functools import randint
                from itertools import repeat


                rand_seq = lambda n, m: map(randint, zip(repeat(0, n), repeat(m, n))
                update_max = lambda cur_max, item: item if item > cur_max else cur_max
                rand_max = lambda n, m: reduce(update_max, rand_seq(m, m))
                rand_max(10,5)


.. reducing built-ins

.. question:: 299 
   
   Write a function called ``mean_normal(n, m, sd)`` that computes the mean of ``n`` randomly selected values
   taken from a normal distribution with mean ``m`` and standard deviation
   ``sd``.  Use map and normalvariate (from the random module) to generate the
   sequence and use reduce to compute the mean.

   .. actex:: ex_9_4
                

.. reducing built-ins

.. question:: 310 
   
   Write a function ``sum_of_squares(xs)`` that computes the sum
   of the squares of the numbers in the list ``xs``.  For example,
   ``sum_of_squares([2, 3, 4])`` should return 4+9+16 which is 29.

   Use reduce to solve this problem.

   .. actex:: ex_7_11

      sum_of_squares = lambda xs: 1 # your code here

      ====
      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

          def testOne(self):
              self.assertEqual(sum_of_squares([2,3,4]),29,"Tested sum_of_squares on input [2,3,4]")
              self.assertEqual(sum_of_squares([0,1,-1]),2,"Tested sum_of_squares on input [0,1,-1]")
              self.assertEqual(sum_of_squares([5,12,14]),365,"Tested sum_of_squares on input [5,12,14]")

      myTests().main()

.. reducing built-ins

.. question:: 334 

   .. tabbed:: q7

        .. tab:: Question

           Write a function to count how many odd numbers are in a list.

           Use some combination of map, filter and reduce to solve this problem.

           .. actex:: ex_9_6

              countOdd = lambda lst: 3 # your code here

              ====
              from unittest.gui import TestCaseGui

              class myTests(TestCaseGui):

                  def testOne(self):
                      self.assertEqual(countOdd([1,3,5,7,9]),5,"Tested countOdd on input [1,3,5,7,9]")
                      self.assertEqual(countOdd([1,2,3,4,5]),3,"Tested countOdd on input [-1,-2,-3,-4,-5]")
                      self.assertEqual(countOdd([2,4,6,8,10]),0,"Tested countOdd on input [2,4,6,8,10]")
                      self.assertEqual(countOdd([0,-1,12,-33]),2,"Tested countOdd on input [0,-1,12,-33]")

              myTests().main()



        .. tab:: Answer

            .. ipython:: python

                import random

                countOdd = lambda lst: reduce(lambda a, i: a + i, filter(n % 2 == 1, lst))

                # make a random list to test the function
                lst = [random.randint(0, 1000) for i in range(100)]

                countOdd(lst)


.. reducing built-ins

.. question:: 377 

   Write a function called ``sum_even`` that sums up all the even numbers in a list.
   Use some combination of map, filter and reduce to solve this problem.

   .. actex:: ex_9_7

      sum_even = lambda lst: 42 # your code here

      ====
      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

          def testOne(self):
              self.assertEqual(sum_even([1,3,5,7,9]),0,"Tested sum_even on input [1,3,5,7,9]")
              self.assertEqual(sum_even([-1,-2,-3,-4,-5]),-6,"Tested sum_even on input [-1,-2,-3,-4,-5]")
              self.assertEqual(sum_even([2,4,6,7,9]),12,"Tested sum_even on input [2,4,6,7,9]")
              self.assertEqual(sum_even([0,1,12,33]),12,"Tested sum_even on input [0,1,12,33]")

      myTests().main()

.. reducing built-ins

.. question:: 400

   .. tabbed:: q9

        .. tab:: Question

           Sum up all the negative numbers in a list.
           Use some combination of map, filter and reduce to solve this problem.

           .. actex:: ex_9_8

              sumNegatives = lambda lst: -1 # your code here

              ====
              from unittest.gui import TestCaseGui

              class myTests(TestCaseGui):

                  def testOne(self):
                      self.assertEqual(sumNegatives([-1,-2,-3,-4,-5]),-15,"Tested sumNegatives on input [-1,-2,-3,-4,-5]")
                      self.assertEqual(sumNegatives([1,-3,5,-7,9]),-10,"Tested sumNegatives on input [1,-3,5,-7,9]")
                      self.assertEqual(sumNegatives([-2,-4,6,-7,9]),-13,"Tested sumNegatives on input [-2,-4,6,-7,9]")
                      self.assertEqual(sumNegatives([0,1,2,3,4]),0,"Tested sumNegatives on input [0,1,2,3,4]")

              myTests().main()



        .. tab:: Answer

            .. ipython:: python

                import random
                from operator import add

                sumNegatives = lambda lst: reduce(add, filter(lambda n: n < 0, lst))

                lst = [random.randint(0, 1000) for i in range(100)]

                sumNegative(lst)


.. reducing built-ins working with strings

.. question:: 442 

   Write a function called ``num_greater_5`` that counts how many words in a list have length 5.
   Use some combination of map, filter and reduce to solve this problem.

   .. actex:: ex_9_9

      num_greater_5 = lambda lst: 23 # your code here


.. all_combos

.. question:: 452

    .. tabbed:: q3

        .. tab:: Question

           Create a function that takes a value `n` as input and constructs a
           multiplication table for whole numbers up to :math:`n`.
           Use some combination of map, filter and reduce to solve this problem.


           .. actex:: ex_8_3


        .. tab:: Answer

            .. ipython:: python
                
                row = lambda j, n: map(lambda i: j*i, range(1, n+1))
                table = lambda n: map(lambda j: row(j, n), range(1, n+1))
                table(12)


.. all_combos

.. question:: 474 
   
   Print out a neatly formatted multiplication table, up to 12 x 12.  You should
   do this by constructing a string.  For full credit, each column should be
   right-justified and your solution should include only comprehensions and
   lambda functions. **Hint:** Write a lambda function pads a number with the
   right number of spaces.
   Use some combination of map, filter and reduce to solve this problem.

   .. actex:: ex_8_4

.. tables

.. question:: 486 

   Use list comprehensions to filter the hours table to include only managers.
   In SQL this would be performed using SELECT and WHERE.  **Hint:** Start by
   creating a list of the names of all managers.
   Use some combination of map, filter and reduce to solve this problem.
   .. actex:: select-where

        hours = [["Alice", 43],
                   ["Bob", 37],
                   ["Fred", 15]]
        titles = [["Alice", "Manager"],
                  ["Betty", "Consultant"],
                  ["Bob", "Assistant"]]
.. tables

.. question:: 502 

   Use list comprehensions to decide if the following tables contain a manager
   that worked at least 40 hours.
   Use some combination of map, filter and reduce to solve this problem.

   .. actex:: select-where

        hours = [["Alice", 43],
                   ["Bob", 37],
                   ["Fred", 15]]
        titles = [["Alice", "Manager"],
                  ["Betty", "Consultant"],
                  ["Bob", "Assistant"]]


.. question:: 531

    Use some combination of map, filter and reduce to create a sequence of
    functions that combine to average two matrices.  A complete solution will
    provide functions for each level of abstraction. 

   .. actex:: average-matrices
       
        M1 = [[1, 2], [3, 4]]
        M2 = [[5, 6], [7, 8]]
