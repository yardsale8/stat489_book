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

.. question:: spd_ex_1
   :number: 1

   .. tabbed:: q1

        .. tab:: Question

            Evaluate the following numerical expressions in your head, then use
            the active code window to check your results:

            #. ``5 ** 2``
            #. ``9 * 5``
            #. ``15 / 12``
            #. ``12 / 15``
            #. ``15 // 12``
            #. ``12 // 15``
            #. ``5 % 2``
            #. ``9 % 5``
            #. ``15 % 12``
            #. ``12 % 15``
            #. ``6 % 6``
            #. ``0 % 7``

            .. activecode:: ch02_ex1

               print(5 ** 2)

        .. tab:: Answer

            #. ``5 ** 2  = 25``
            #. ``9 * 5 = 45``
            #. ``15 / 12 = 1.25``
            #. ``12 / 15 = 0.8``
            #. ``15 // 12 = 1``
            #. ``12 // 15 = 0``
            #. ``5 % 2 = 1``
            #. ``9 % 5 = 4``
            #. ``15 % 12 = 3``
            #. ``12 % 15 = 12``
            #. ``6 % 6 = 0``
            #. ``0 % 7 = 0``

..         .. tab:: Discussion
.. 
..             .. disqus::
..                 :shortname: interactivepython
..                 :identifier: c0a62044cac248859ce3695b46697ecc

.. question:: spd_ex_2

   What is the order of the arithmetic operations in the following expression.  Evaluate the expression by hand and then check your work.

   ::

       2 + (3 - 1) * 10 / 5 * (2 + 3)

   .. actex:: ex_2_2

.. question:: turtle_ex_12

   Create a turtle and assign it to a variable.  When you print its type, what do you get?

   .. actex:: ex_3_12


.. question:: turtle_ex_2

   .. shortanswer:: turtle_reflect

      Turtle objects have methods and attributes. For example, a turtle has a
      position and when you move the turtle forward, the position changes.
      Think about the other methods shown in the summary above.  Which
      attibutes, if any, does each method relate to?  Does the method change the
      attribute?

.. question:: turtle_ex_9

   .. tabbed:: q9

        .. tab:: Question

           Write a program to draw a shape like this:

           .. image:: Figures/star.png

           .. actex:: ex_3_9


        .. tab:: Answer

            .. activecode:: q9_answer
                :nocodelens:

                import turtle

                turing = turtle.Turtle()

                turing.forward(110)
                turing.left(216)
                turing.forward(110)
                turing.left(216)
                turing.forward(110)
                turing.left(216)
                turing.forward(110)
                turing.left(216)
                turing.forward(110)
                turing.left(216)

..         .. tab:: Discussion
.. 
..             .. disqus::
..                 :shortname: interactivepython
..                 :identifier: c611217310057488aab6a34d4b591e753

.. question:: turtle_ex_8

   On a piece of scratch paper, trace the following program and show the drawing.  When you are done, press ``run``
   and check your answer.

   .. activecode:: q9_answer 
       :nocodelens:

       import turtle
       wn = turtle.Screen()
       tess = turtle.Turtle()
       tess.right(90)
       tess.left(3600)
       tess.right(-90)
       tess.left(3600)
       tess.left(3645)
       tess.forward(-100)

   .. actex:: ex_3_8





.. question:: turtle_ex_11


   Write a program to draw some kind of picture.  Be creative and experiment
   with the turtle methods provided in the Python documentation for this module.

   .. actex:: ex_3_11


