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

#.

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



#. In Robert McCloskey's book *Make Way for Ducklings*, the names of the
   ducklings are Jack, Kack, Lack, Mack, Nack, Ouack, Pack, and Quack.  This
   loop tries to output these names in order.

   .. sourcecode:: python

        prefixes = "JKLMNOPQ"
        suffix = "ack"

        words = [first + suffix for first in prefixes]


   Of course, that's not quite right because Ouack and Quack are misspelled.
   Can you fix it?

    .. actex:: ex_8_2

#.

    .. tabbed:: q3

        .. tab:: Question

            Create a function that takes a value `n` as input and constructs a
            multiplication table for whole numbers up to :math:`n`.

           .. actex:: ex_8_3


        .. tab:: Answer

            .. activecode:: q3_answer
                
                table = lambda n: [i*j for i in range(1,n+1) for j in range(1,n+1)]
                print(table(12))




#. Print out a neatly formatted multiplication table, up to 12 x 12.  You should
   do this by constructing a string.  For full credit, each column should be
   right-justified and your solution should include only comprehensions and
   lambda functions. **Hint:** Write a lambda function pads a number with the
   right number of spaces.

   .. actex:: ex_8_4


#.

    .. tabbed:: q5

        .. tab:: Question

           Write a function that will return the number of digits in an integer.

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

            .. activecode:: q5_answer


                numDigits = lambda n: len(str(n))

                print(numDigits(50))
                print(numDigits(20000))
                print(numDigits(1))



#. Write a function that reverses its string argument.

   .. actex:: ex_8_5
      :nocodelens:

      reverse = lambda astring: "a" # your code here

      ====

      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

        def testOne(self):
            self.assertEqual(reverse("happy"),"yppah","Tested reverse on input of 'happy'")
            self.assertEqual(reverse("Python"),"nohtyP","Tested reverse on input of 'Python'")
            self.assertEqual(reverse(""),"","Tested reverse on input of ''")




      myTests().main()

#.

    .. tabbed:: q7

        .. tab:: Question

           Write a function that takes a string and mirrors its argument.

           .. actex:: ex_8_6
              :nocodelens:

              mirror = lambda mystr: "abba" # your code here

              ====

              from unittest.gui import TestCaseGui

              class myTests(TestCaseGui):

                  def testOne(self):
                      self.assertEqual(mirror("good"),"gooddoog","Tested mirror on input of 'good'")
                      self.assertEqual(mirror("Python"),"PythonnohtyP","Tested mirror on input of 'Python'")
                      self.assertEqual(mirror(""),"","Tested mirror on input of ''")
                      self.assertEqual(mirror("a"),"aa","Tested mirror on input of 'a'")


              myTests().main()



        .. tab:: Answer

            .. activecode:: q7_answer
                :nocodelens:

                reverse = lambda mystr: ''.join([ c for c in reversed(mystr)])
                mirror = lambda mystr: mystr + reverse(mystr)




#. Write a function that removes all occurrences of a given letter from a string.

   .. actex:: ex_8_7
      :nocodelens:

      remove_letter = lambda theLetter, theString: "stuff" # your code here

      ====


      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

        def testOne(self):
            self.assertEqual(remove_letter("a","apple"),"pple","Tested remove_letter on inputs of 'a' and 'apple'")
            self.assertEqual(remove_letter("a","banana"),"bnn","Tested remove_letter on inputs of 'a' and 'banana'")
            self.assertEqual(remove_letter("z","banana"),"banana","Tested remove_letter on inputs of 'z' and 'banana'")



      myTests().main()



#.

    .. tabbed:: q9

        .. tab:: Question

           Write a function that recognizes palindromes. (Hint: use your
           ``reverse`` function to make this easy!).  **Hint:** Use all,
           reversed and zip.

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
                
                pairs = lambda mystr: [(i, j) for i, j in zip(mystr,reversed(mystr))]
                check_each_pair = lambda mypairs: [i == j for i, j in pairs]
                is_palindrome lambda myStr: all(check_each_pair(myStr))

                # Or all together

                is_palindrome_alt = lambda s: all([i ==j for i, j in zip(s, reversed(s))])







#. Write a function that removes all occurrences of a string from another string.

   .. actex:: ex_8_11

      def remove_all(substr,theStr):
          # your code here



      ====

      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

        def testOne(self):
            self.assertEqual(remove_all("an","banana"),"ba","Tested remove_all on inputs of 'an' and 'banana'")
            self.assertEqual(remove_all("cyc","bicycle"),"bile","Tested remove_all on inputs of 'cyc' and 'bicycle'")
            self.assertEqual(remove_all("iss","Mississippi"),"Mippi","Tested remove_all on inputs of 'iss' and 'Mississippi'")
            self.assertEqual(remove_all("eggs","bicycle"),"bicycle","Tested remove_all on inputs of 'eggs' and 'bicycle'")



      myTests().main()







.. question:: strings_ex_1
   :number: 11


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


.. question:: strings_ex_2

   Create a list called ``myList`` with the following six items: 76, 92.3, "hello", True, 4, 76.  Do it with both append and with concatenation, one item at a time.

   .. actex:: ex_9_2




.. question:: strings_ex_4

   Create a list containing 100 random integers between 0 and 1000 (use iteration, append, and the random module).  Write a function called ``average`` that will take the list as a parameter and return the average.

   .. actex:: ex_9_4

.. question:: strings_ex_5

   .. tabbed:: q5

        .. tab:: Question

           Write a Python function that takes ``n`` and ``m`` as input and
           returns the maximum valu of a the list of ``n`` random integers
           between 0 and ``m``.  (Note:.  there is a builtin function named
           ``max``.)

           .. actex:: ex_9_5


        .. tab:: Answer

            .. activecode:: q5_answer

                from random import randint

                rand_max = lambda n, m: max([randint(0,m) for i in range(n)])

.. question:: strings_ex_4

   Write a function that computes the mean of ``n`` randomly selected values
   taken from a normal distribution with mean ``m`` and standard deviation
   ``sd``.

   .. actex:: ex_9_4
                


.. question:: strings_ex_6

   Write a function ``sum_of_squares(xs)`` that computes the sum
   of the squares of the numbers in the list ``xs``.  For example,
   ``sum_of_squares([2, 3, 4])`` should return 4+9+16 which is 29:

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

.. question:: strings_ex_7

   .. tabbed:: q7

        .. tab:: Question

           Write a function to count how many odd numbers are in a list.

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

            .. activecode:: q7_answer

                import random

                countOdd = lambda lst: sum([1 for i in lst of i % 2 == 1])

                # make a random list to test the function
                lst = [random.randint(0, 1000) for i in range(100)]

                print(countOdd(lst))



.. question:: strings_ex_8

   Sum up all the even numbers in a list.

   .. actex:: ex_9_7

      sumEven = lambda lst: 42 # your code here

      ====
      from unittest.gui import TestCaseGui

      class myTests(TestCaseGui):

          def testOne(self):
              self.assertEqual(sumEven([1,3,5,7,9]),0,"Tested sumEven on input [1,3,5,7,9]")
              self.assertEqual(sumEven([-1,-2,-3,-4,-5]),-6,"Tested sumEven on input [-1,-2,-3,-4,-5]")
              self.assertEqual(sumEven([2,4,6,7,9]),12,"Tested sumEven on input [2,4,6,7,9]")
              self.assertEqual(sumEven([0,1,12,33]),12,"Tested sumEven on input [0,1,12,33]")

      myTests().main()

.. question:: strings_ex_9

   .. tabbed:: q9

        .. tab:: Question

           Sum up all the negative numbers in a list.

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

            .. activecode:: q9_answer

                import random

                sumNegatives = lambda lst: sum([1 for i in lst if i < 0])

                lst = [random.randint(0, 1000) for i in range(100)]

                print(sumNegative(lst))



.. question:: strings_ex_10

   Count how many words in a list have length 5.

   .. actex:: ex_9_9

      countWords = lambda lst: 23 # your code here

