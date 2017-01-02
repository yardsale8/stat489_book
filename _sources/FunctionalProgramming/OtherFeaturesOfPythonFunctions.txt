Other Features of Python Functions
==================================





Tuples as Return Values
-----------------------

Functions can return tuples as return values. This is very useful --- we often want to
know some batsman's highest and lowest score, or we want to find the mean and the standard 
deviation, or we want to know the year, the month, and the day, or if we're doing
some ecological modeling we may want to know the number of rabbits and the number
of wolves on an island at a given time.  In each case, a function (which 
can only return a single value), can create a single tuple holding multiple elements. 

For example, we could write a function that returns both the area and the circumference
of a circle of radius r.

.. activecode:: chp09_tuple3

    
    def circleInfo(r):
        """ Return (circumference, area) of a circle of radius r """
        c = 2 * 3.14159 * r
        a = 3.14159 * r * r
        return (c, a)

    print(circleInfo(10))




.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_09_07




Tuple Assignment
----------------

Python has a very powerful **tuple assignment** feature that allows a tuple of variables 
on the left of an assignment to be assigned values from a tuple
on the right of the assignment.

.. sourcecode:: python

    (name, surname, birth_year, movie, movie_year, profession, birth_place) = julia

This does the equivalent of seven assignment statements, all on one easy line.  
One requirement is that the number of variables on the left must match the number
of elements in the tuple. 

Once in a while, it is useful to swap the values of two variables.  With
conventional assignment statements, we have to use a temporary variable. For
example, to swap ``a`` and ``b``:

.. sourcecode:: python

    temp = a
    a = b
    b = temp

Tuple assignment solves this problem neatly:

.. sourcecode:: python

    (a, b) = (b, a)

The left side is a tuple of variables; the right side is a tuple of values.
Each value is assigned to its respective variable. All the expressions on the
right side are evaluated before any of the assignments. This feature makes
tuple assignment quite versatile.

Naturally, the number of variables on the left and the number of values on the
right have to be the same.

.. sourcecode:: python

    >>> (a, b, c, d) = (1, 2, 3)
    ValueError: need more than 3 values to unpack 

.. index::
    single: tuple; return value 




Optional parameters
-------------------

To find the locations of the second or third occurrence of a character in a
string, we can modify the ``find`` function, adding a third parameter for the
starting position in the search string:

.. activecode:: ch08_fun4
    
    def find2(astring, achar, start):
        """
        Find and return the index of achar in astring.  
        Return -1 if achar does not occur in astring.
        """
        ix = start
        found = False
        while ix < len(astring) and not found:
            if astring[ix] == achar:
                found = True
            else:
                ix = ix + 1
        if found:
            return ix
        else:
            return -1
        
    print(find2('banana', 'a', 2))


The call ``find2('banana', 'a', 2)`` now returns ``3``, the index of the first
occurrence of 'a' in 'banana' after index 2. What does
``find2('banana', 'n', 3)`` return? If you said, 4, there is a good chance you
understand how ``find2`` works.  Try it.

Better still, we can combine ``find`` and ``find2`` using an
**optional parameter**.

.. activecode:: chp08_fun5
    
	def find3(astring, achar, start=0):
	    """
	    Find and return the index of achar in astring.  
	    Return -1 if achar does not occur in astring.
	    """
	    ix = start
	    found = False
	    while ix < len(astring) and not found:
	        if astring[ix] == achar:
	            found = True
	        else:
	            ix = ix + 1
	    if found:
	        return ix
	    else:
	        return -1
	
	print(find3('banana', 'a', 2))

The call ``find3('banana', 'a', 2)`` to this version of ``find`` behaves just
like ``find2``, while in the call ``find3('banana', 'a')``, ``start`` will be
set to the **default value** of ``0``.

Adding another optional parameter to ``find`` makes it search from a starting
position, up to but not including the end position.

.. activecode:: chp08_fun6
    
    def find4(astring, achar, start=0, end=None):
        """
        Find and return the index of achar in astring.  
        Return -1 if achar does not occur in astring.
        """
        ix = start
        if end == None:
            end = len(astring)

        found = False
        while ix < end and not found:
            if astring[ix] == achar:
                found = True
            else:
                ix = ix + 1
        if found:
            return ix
        else:
            return -1

    ss = "Python strings have some interesting methods."
 
    print(find4(ss, 's'))
    print(find4(ss, 's', 7))
    print(find4(ss, 's', 8))
    print(find4(ss, 's', 8, 13))
    print(find4(ss, '.'))


The optional value for ``end`` is interesting.  We give it a default value ``None`` if the
caller does not supply any argument.  In the body of the function we test what ``end`` is
and if the caller did not supply any argument, we reassign ``end`` to be the length of the string.
If the caller has supplied an argument for ``end``, however, the caller's value will be used in the loop.

The semantics of ``start`` and ``end`` in this function are precisely the same as they are in
the ``range`` function.



.. index:: module, string module, dir function, dot notation, function type,
           docstring


Variable Number of Arguments
----------------------------

TODO

Unpacking Arguments and Keywords
--------------------------------

TODO






Using a Main Function
---------------------

Using functions is a good idea.  It helps us to modularize our code by breaking a program
into logical parts where each part is responsible for a specific task.  For example, in one of our first programs there
was a function called ``drawSquare`` that was responsible for having some turtle draw a square of some size.
The actual turtle and the actual size of the square were defined to be provided as parameters. Here is that original program.

.. code-block:: python

    import turtle

    def drawSquare(t, sz):
        """Make turtle t draw a square of with side sz."""

        for i in range(4):
            t.forward(sz)
            t.left(90)


    wn = turtle.Screen()          # Set up the window and its attributes
    wn.bgcolor("lightgreen")

    alex = turtle.Turtle()        # create alex
    drawSquare(alex, 50)          # Call the function to draw the square

    wn.exitonclick()


If you look closely at the structure of this program, you will notice that we first perform all of our necessary ``import`` statements, in this case to be able to use the ``turtle`` module.  Next, we define the function ``drawSquare``.  At this point, we could have defined as many functions as were needed.  Finally, there are five statements that set up the window, create the turtle, perform the function invocation, and wait for a user click to terminate the program.

These final five statements perform the main processing that the program will do.  Notice that much of the detail has been pushed inside the ``drawSquare`` function.  However, there are still these five lines of code that are needed to get things done.

In many programming languages (e.g. Java and C++), it is not possible to simply have statements sitting alone like this at the bottom of the program.  They are required to be part of a special function that is automatically invoked by the operating system when the program is executed.  This special function is called **main**.  Although this is not required by the Python programming language, it is actually a good idea that we can incorporate into the logical structure of our program.  In other words, these five lines are logically related to one another in that they provide the main tasks that the program will perform.  Since functions are designed to allow us to break up a program into logical pieces, it makes sense to call this piece ``main``.

The following activecode shows this idea.  In line 11 we have defined a new function called ``main`` that doesn't need any parameters.  The five lines of main processing are now placed inside this function.  Finally, in order to execute that main processing code, we need to invoke the ``main`` function (line 20).  When you push run, you will see that the program works the same as it did before.

.. activecode:: ch04_1
    :nocodelens:

    import turtle

    def drawSquare(t, sz):
        """Make turtle t draw a square of with side sz."""

        for i in range(4):
            t.forward(sz)
            t.left(90)


    def main():                      # Define the main function
        wn = turtle.Screen()         # Set up the window and its attributes
        wn.bgcolor("lightgreen")

        alex = turtle.Turtle()       # create alex
        drawSquare(alex, 50)         # Call the function to draw the square

        wn.exitonclick()

    main()                           # Invoke the main function
    
    
Now our program structure is as follows.  First, import any modules that will be required.  Second, define any functions that will be needed.  Third, define a ``main`` function that will get the process started.  And finally, invoke the main function (which will in turn call the other functions as needed).

.. note::

     In Python there is nothing special about the name ``main``.  We could have called this function anything we wanted.  We chose ``main`` just to be consistent with some of the other languages.
     

**Advanced Topic**

Before the Python interpreter executes your program, it defines a few special variables.  One of those variables is called ``__name__`` and it is automatically set to the string value ``"__main__"`` when the program is being executed by itself in a standalone fashion.  On the other hand, if the program is being imported by another program, then the ``__name__`` variable is set to the name of that module.  This means that we can know whether the program is being run by itself or whether it is being used by another program and based on that observation, we may or may not choose to execute some of the code that we have written.

For example, assume that we have written a collection of functions to do some simple math.  We can include a ``main`` function to invoke these math functions.  It is much more likely, however, that these functions will be imported by another program for some other purpose.  In that case, we would not want to execute our main function.

The activecode below defines two simple functions and a main. 

.. activecode:: ch04_adv

    def squareit(n):
        return n * n
        
    def cubeit(n):
        return n*n*n
        
    def main():
        anum = int(input("Please enter a number"))
        print(squareit(anum))
        print(cubeit(anum))
        
    if __name__ == "__main__":
        main()
        
Line 12 uses an ``if`` statement to ask about the value of the ``__name__`` variable.  If the value is ``"__main__"``, then the ``main`` function will be called.  Otherwise, it can be assumed that the program is being imported into another program and we do not want to call ``main`` because that program will invoke the functions as needed.  This ability to conditionally execute our main function can be extremely useful when we are writing code that will potentially be used by others.  It allows us to include functionality that the user of the code will not need, most often as part of a testing process to be sure that the functions are working correctly.

.. note::

    In order to conditionally execute the ``main`` function, we used a structure
    called an ``if`` statement to create what is known as selection.  This topic
    will be studied in much more detail later.


