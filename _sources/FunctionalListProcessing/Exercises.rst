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

.. tables

.. question:: 486 

   Use map and filter to filter the hours table to include only managers.
   In SQL this would be performed using SELECT and WHERE.  **Hint:** Start by
   creating a list of the names of all managers.
   
   .. sourcecode:: python

        hours = [["Alice", 43],
                   ["Bob", 37],
                   ["Fred", 15]]
        titles = [["Alice", "Manager"],
                  ["Betty", "Consultant"],
                  ["Bob", "Assistant"]]
.. tables

.. question:: 502 

   Use map, len, and filter to decide if the following tables contain a manager
   that worked at least 40 hours.

   .. sourcecode:: python

        hours = [["Alice", 43],
                   ["Bob", 37],
                   ["Fred", 15]]
        titles = [["Alice", "Manager"],
                  ["Betty", "Consultant"],
                  ["Bob", "Assistant"]]


.. question:: 531

   Use some combination of map and filter to create a sequence of
   functions that combine to average two matrices.  A complete solution will
   provide functions for each level of abstraction. 

   .. actex:: average-matrices
       
        M1 = [[1, 2], [3, 4]]
        M2 = [[5, 6], [7, 8]]

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
                
                row = lambda j, n: list(map(lambda i: j*i, range(1, n+1)))
                table = lambda n: list(map(lambda j: row(j, n), range(1, n+1)))
                table(12)


.. all_combos

.. question:: 474 
   
   Print out a neatly formatted multiplication table, up to 12 x 12.  You should
   do this by constructing a string.  For full credit, each column should be
   right-justified and your solution should include only ``map`` and helper
   functions. (You are allowed to use the strings ``join`` and ``rjust`` methods
   in your helper functions) **Hint:** Write a lambda function pads a number with the right
   number of spaces.  Use some combination of map, filter and reduce to solve
   this problem.



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

.. question:: 119

    Write a function called ``str_join`` that takes two arguments ``s`` (a
    string) and ``L`` (a list of strings) and returns the equivalent of
    ``s.join(L)``.  Use reduce to solve this problem without using the string
    ``join`` method.

.. basic strings

.. question:: 176

    .. tabbed:: 176

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

            .. ipython:: python
                
                from functools import reduce
                is_palindrome = lambda mystr: reduce(lambda acc, tup: acc and tup[0] == tup[1], zip(mystr,reversed(mystr)), True)
                is_palindrome('abba')



.. question:: 170

    Write a function called ``has_vowel`` that takes a string as input and returns
    ``True`` if the string contains a vowel (``'aeiou'`` ignore ``'y'``) and ``False``
    otherwise.  Use ``reduce`` to perform this task.


.. reducing built-ins

.. question:: 275 

    .. tabbed:: 275

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
                from functools import reduce
                from itertools import repeat


                rand_seq = lambda n, m: map(randint, repeat(0, n), repeat(m, n))
                update_max = lambda cur_max, item: item if item > cur_max else cur_max
                rand_max = lambda n, m: reduce(update_max, rand_seq(n, m))
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

                countOdd = lambda lst: reduce(lambda a, i: a + 1, filter(lambda n: n % 2 == 1, lst))

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

                lst = [random.randint(-1000, 1000) for i in range(100)]

                sumNegatives(lst)


.. reducing built-ins working with strings

.. question:: 442 

   Write a function called ``num_greater_5`` that counts how many words in a list have length 5.
   Use some combination of map, filter and reduce to solve this problem.

   .. actex:: ex_9_9

      num_greater_5 = lambda lst: 23 # your code here


   .. actex:: ex_8_4

.. question:: files_ex_3_2

   .. tabbed:: q3

        .. tab:: Question


            The following sample file called ``studentdata.txt`` contains one
            line for each student in an imaginary class.  The student's name is
            the first thing on each line, followed by some exam scores.  The
            number of scores might be different for each student.

            .. datafile:: studentdata.txt

                joe 10 15 20 30 40
                bill 23 16 19 22
                sue 8 22 17 14 32 17 24 21 2 9 11 17
                grace 12 28 21 45 26 10
                john 14 32 25 16 89

            Using the text file ``studentdata.txt`` (shown in above) write
            a program that creates a new data table that contains the students'
            names along with the minimum and maximum score for each student.

            Complete this exercise using ``map``, ``filter`` and/or reduce.
            **Note:** For full credit you will need to also implement ``max``
            and ``min`` using ``reduce``.



            .. actex:: ex_6_3
               :nocodelens:
               :available_files: studentdata.txt


        .. tab:: Answer

            .. activecode:: ch_files_q3answer
                :nocodelens:

                # Convert the following solution to one that uses map, filter and/or reduce
                # For this exercise,
                with open("studentdata.txt", "r") as f:
                    table = [line.split() for line in f]
                process_row = lambda row: (row[0], max(row), min(row))
                new_table = [process_row(row) for row in table]
                new_table

.. question:: files_ex_4_2

    `SeanLahman.com
    <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_
    provides a database of baseball statistics.  Download, unzip and extract the
    file titled **Batting.csv**.

    Write each of the following functions and apply them to the related task.
    Write all of your functions and expressions only using funcitonal tools like
    ``with_iter``, ``map``, ``filter``, ``reduce``, ``compose`` and/or ``pipe``.


    1.  Write a function that takes a year and table of batting data as input
        and returns the average number of runs scored in that year.  Call
        this function **average_runs_year**.
    2.  Write a function takes a list of years and a table of batting data and
        returns of list of tuples of the form `(year, averages_runs)`.  Call
        this function **average_runs_years** Use a list comprehension
        and the function from the last step.
    3.  Write a program that includes the above functions and reads
        **Batting.csv** and compute the average number of runs for the
        following years: 1900, 1910, ..., 2000, 2010.  Assume that the
        Batting.csv file is the same directory as your program.

.. question:: complement

    The ``toolz`` library includes a function called ``complement``, which takes a
    Boolean function as input and returns a Boolean function that is the logical
    opposite.  
    
    For example, ``complement(is_odd)`` would be equivalent to
    ``is_even`` and ``complement(less_than_5)`` would be equivalent to
    ``at_least_5``.  

    .. ipython:: python

        from toolz import complement
        is_odd = lambda n: n % 2 == 1
        is_odd(5)
        is_odd(4)
        is_even = complement(is_odd)
        is_even(5)
        is_even(4)

    .. ipython:: python

        less_than_5 = lambda n: n < 5
        less_than_5(2)
        less_than_5(22)
        at_least_5 = complement(less_than_5)
        at_least_5(2)
        at_least_5(22)
    
    Implement your own version of this function named
    ``my_complement``.


.. question:: do

    The ``toolz`` library includes a function called ``do`` that is useful when
    performing side effects.  We saw ``do`` in action in Chapter 5 when printing a
    sequence out to a file.  The function ``do(func, x)`` takes a (likely
    side-effecting) function ``func`` and a value ``x`` as inputs.  First, ``func``
    is called with ``x`` as an argument then the original ``x`` is returned.  Note
    that the any value returned by ``func(x)`` is discarded.  

    For example, we can use ``do`` to say hello to a given value (with print)
    and then return that value.

    .. ipython:: python

        from toolz import do
        say_hello = lambda x: print("Hello", x)
        do(say_hello, 4)
        list(map(lambda x: do(say_hello, x), [1,2,3]))
    
    
    Implement a version of
    this function named ``my_do``.


.. question:: juxt

    The ``toolz`` library includes a function called ``juxt`` that takes a
    sequence of functions that returns a function.  The new function will apply
    each of the original functions to any input and return a tuple containing
    the results.  
    
    For example, suppose that we want to make a function that (a)
    adds 1, (b) doubles and (c) squares any input.  This is accomplished using
    ``juxt`` as follows.

    .. ipython:: python

        from toolz import juxt
        f = juxt(lambda i: i + 1,
                 lambda i: 2*i,
                 lambda i: i**2)
        f(3)
        assert f(5) == (5 + 1, 2*5, 5**2)

    Implement a version of this function named ``my_juxt``.

.. question:: pipe

    Write and implementation of ``pipe`` called ``my_pipe`` that takes an expression
    ``x`` as the first argument and a sequence of functions ``f1``, ``f2``, ... as
    the remaining arguments and applies each function to the result of ``x``, from
    left to right.   Your function should pass the following assertions.

    .. sourcecode::

        assert my_pipe(5, str, lambda s: s + '!') == '5!'
        assert my_pipe([1,2,3], lambda L: map(lambda x: x**2, L), sum) == 14

.. question:: thread_first

    Implement a version of ``thread_first`` called ``my_thread_first`` that
    threads a value through the first argument of each of a list of functions.
    If any of the functions take more than one argument, these arguments can be
    given along with the function in a tuple.  For example, ``my_thread_first(5,
    f, g)`` should be equivalent to ``g(f(5))`` and ``my_thread_first(5, (add,
    1), (pow, 2))`` expands to ``pow(add(5,1), 2)``.  Note that each expression
    goes in the first argument of the next function call.

.. question:: files_ex_6_2

    Download, unzip and extract the file titled **Salaries.csv** and
    **AllstarFull.csv** from `seanlahman.com <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_
    .

    Write a program that computes the average salary of all players in the all
    star game in for each year between 2000 and 2010.  Write all of your
    functions and expressions only using funcitonal tools like ``with_iter``,
    ``map``, ``filter``, ``reduce``, ``compose`` and/or ``pipe``.  **Hint:** You
    will want to use ``groupby`` in your solution.


.. question:: files_ex_8_2

    Download, unzip and extract the file titled **Master.csv** and
    **BattingPost.csv**.  from `seanlahman.com <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_

    Write a program that computes the total runs scored in the post season by
    all players from from each state (all time). Write all of your
    functions and expressions only using funcitonal tools like ``with_iter``,
    ``map``, ``filter``, ``reduce``, ``compose`` and/or ``pipe``.  **Hint:** You
    will want to use ``groupby`` in your solution.

