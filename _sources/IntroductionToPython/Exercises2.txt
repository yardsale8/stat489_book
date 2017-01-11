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

.. question:: spd_ex_6
   :number: 1

   .. tabbed:: q6

        .. tab:: Question

               Add parenthesis to the expression ``6 * 1 - 2`` to change its value
               from 4 to -6.

               .. actex:: ex_2_6

        .. tab:: Answer

            .. activecode:: q3_answer
                :nocanvas:

                print(6*(1-2))



.. question:: spd_ex_2

   What is the order of the arithmetic operations in the following expression.  Evaluate the expression by hand and then check your work.

   ::

       2 + (3 - 1) * 10 / 5 * (2 + 3)

   .. actex:: ex_2_2



.. question:: spd_ex_3

   .. tabbed:: q3

        .. tab:: Question

            Many people keep time using a 24 hour clock (11 is 11am and 23 is
            11pm, 0 is midnight).  If it is currently 13 and you set your alarm
            to go off in 50 hours, it will be 15 (3pm).  Write a Python program
            to solve the general version of the above problem using variables
            and ``lambda`` expressions. Print the solution to the specific
            example given above (i.e. current time is 13 and alarm goes off 50
            hours later.)

            .. actex:: ex_2_3

        .. tab:: Answer

            .. activecode:: q3_answer
                :nocanvas:

                ## question 3 solution ##

                hours = lambda cur_time, wait_time: cur_time + wait_time

                timeofday = lambda hours: hours % 24

                time_after_wait = lambda cur_time, wait_time: timeofday(hours(cur_time, wait_time))

                print(time_after_wait(13, 50))

..         .. tab:: Discussion
.. 
..             .. disqus::
..                 :shortname: interactivepython
..                 :identifier: a77ed6163c254612b0d649034b261659


.. question:: spd_ex_4

   It is possible to name the days 0 through 6 where day 0 is Sunday and day 6
   is Saturday.  If you go on a wonderful holiday leaving on day number 3 (a
   Wednesday) and you return home after 10 nights.  Write a general version of
   the program using variables and ``lambda`` expressions that takes the
   starting day number, and the length of your stay, and it will return the
   number of day of the week you will return on.  Print the solution to the
   specific example of this problem presented above (i.e. leave on day 3 and
   return 10 nights later).

   .. actex:: ex_2_4

       # Problem 4
       # My Name:



.. question:: spd_ex_9

   .. tabbed:: q9

        .. tab:: Question

            Write a program that will compute the area of a rectangle.  
            Use variable and lambda expressions in your solution.  Solve an 
            specific example and print a nice message with the answer.

            .. actex:: ex_2_9

        .. tab:: Answer

            .. activecode:: q9_answer
                :nocanvas:

                ## question 9 solution

                area = lambda width, height: width * height

                output = area(5,10)

                print("The area of the rectangle with width 5 and length 10 is", output)

.. question:: spd_ex_8

   Write a program that will compute the area of a circle.  Use variable and
   lambda expressions in your solution.  Solve an specific example and print a 
   nice message with the answer.

   .. actex:: ex_2_8




..         .. tab:: Discussion
.. 
..             .. disqus::
..                 :shortname: interactivepython
..                 :identifier: f69d286cc58943b6aef1d886e279a12b



.. question:: spd_ex_11

   .. tabbed:: q11

        .. tab:: Question

            Write a program that will convert degrees celsius to degrees fahrenheit.

            .. actex:: ex_2_11

        .. tab:: Answer

            .. activecode:: q11_answer
                :nocanvas:

                ## question 11 solution ##

                # formula to convert C to F is: (degrees Celcius) times (9/5) plus (32)
                deg_f = lambda deg_c: deg_c * (9 / 5) + 32

                deg_c_input = 20
                output = deg_f(deg_c_input)
                print(deg_c_input, " degrees Celsius is", output, " degrees Farenheit.")

..         .. tab:: Discussion
.. 
..             .. disqus::
..                 :shortname: interactivepython
..                 :identifier: c4a929d598ab4c46b484f6abbcec2655

.. question:: spd_ex_12

   Write a program that will convert degrees fahrenheit to degrees celsius.

   .. actex:: ex_2_12

.. question:: spd_ex_10

   .. tabbed:: q10

        .. tab:: Question

           Write a program that will compute MPG for a car.  Use variable and lambda
           expressions in your solution.  Solve an specific example and print a nice
           message with the answer.


           .. actex:: ex_2_10

        .. tab:: Answer

            .. activecode:: q10_answer
                :nocanvas:

                mpg = lambda miles, gallons_used: miles/gallons_used

                print("The mpg for a car that drove 121 miles on 8 gallons of gas is", mpg(121, 8))

.. question:: spd_ex_7

    The formula for computing the final amount if one is earning
    compound interest is given on Wikipedia as

    .. image:: Figures/compoundInterest.png
        :alt: formula for compound interest

    Write each of the following ``lambda`` expressions.

    1. Write a lambda expression named ``interest_multiplier`` that
       takes the interest rate ``r`` (integer) and the number of
       compound periods per year ``n`` and 
       computes the one plus the decimal of the interest
       rate, i.e. :math:`1 + \frac{r}{n}`. 

    2. Write a lambda expression named ``compound_interest_rate`` that
       takes ``r``, ``n``, and ``t`` as input and returns the compound 
       interest rate multiplier for this given situation, i.e. 
       :math:`\left(1 + \frac{r}{n} \right)^{n*t}`.  Be sure to use your
       function from part 1 in your solution.

    3. Write a lambda expression named ``future_value`` that takes 
       ``P``, ``r``, ``n``, and ``t`` as input and returns the compound 
       interest rate multiplier for this given situation, i.e. 
       :math:`P*\left(1 + \frac{r}{n} \right)^{n*t}`.  Be sure to use your
       functions from part 1 and 2 in your solution.


    Write a Python program that assigns the principal amount of 10000 to
    variable `P`, assign to `n` the value 12, and assign to `r` the 
    interest rate of 8% (0.08), and a time `t` of 10 years.  Calculate 
    and print the final amount.

    .. actex:: ex_2_7

