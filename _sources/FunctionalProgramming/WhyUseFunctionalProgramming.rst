Why use Functional Programming?
===============================





Pure Functions
--------------


A **pure function** does not produce side effects. It communicates with the
calling program only through parameters (which it does not modify) and a return
value. Here is the ``doubleStuff`` function from the previous section written as a pure function.
To use the pure function version of ``double_stuff`` to modify ``things``,
you would assign the return value back to ``things``.


.. activecode:: ch09_mod2
    
    def doubleStuff(a_list):
        """ Return a new list in which contains doubles of the elements in a_list. """
        new_list = []
        for value in a_list:
            new_elem = 2 * value
            new_list.append(new_elem)
        return new_list
    
    things = [2, 5, 9]
    print(things)
    things = doubleStuff(things)
    print(things)

Once again, codelens helps us to see the actual references and objects as they are passed and returned.

.. codelens:: ch09_mod3

    def doubleStuff(a_list):
        """ Return a new list in which contains doubles of the elements in a_list. """
        new_list = []
        for value in a_list:
            new_elem = 2 * value
            new_list.append(new_elem)
        return new_list

    things = [2, 5, 9]
    things = doubleStuff(things)






Using Lists as Parameters
-------------------------

Functions which take lists as arguments and change them during execution are
called **modifiers** and the changes they make are called **side effects**.
Passing a list as an argument actually passes a reference to the list, not a
copy of the list. Since lists are mutable, changes made to the 
elements referenced by the parameter change
the same list that the argument is referencing. 
For example, the function below takes a list as an
argument and multiplies each element in the list by 2:

.. activecode:: chp09_parm1
    
    def doubleStuff(aList):
        """ Overwrite each element in aList with double its value. """
        for position in range(len(aList)):
            aList[position] = 2 * aList[position]

    things = [2, 5, 9]
    print(things)
    doubleStuff(things)
    print(things)
    


The parameter ``aList`` and the variable ``things`` are aliases for the
same object.  

.. image:: Figures/references4.png
   :alt: State snapshot for multiple references to a list as a parameter
   
Since the list object is shared by two references, there is only one copy.
If a function modifies the elements of a list parameter, the caller sees the change since the change
is occurring to the original.

This can be easily seen in codelens.  Note that after the call to ``doubleStuff``, the formal parameter ``aList`` refers to the same object as the actual parameter ``things``.  There is only one copy of the list object itself.


.. codelens:: chp09_parm1_trace
    
    def doubleStuff(aList):
        """ Overwrite each element in aList with double its value. """
        for position in range(len(aList)):
            aList[position] = 2 * aList[position]

    things = [2, 5, 9]

    doubleStuff(things)



.. index:: side effect, modifier

.. _pure-func-mod:




Which is Better?
----------------

Anything that can be done with modifiers can also be done with pure functions.
In fact, some programming languages only allow pure functions. There is some
evidence that programs that use pure functions are faster to develop and less
error-prone than programs that use modifiers. Nevertheless, modifiers are
convenient at times, and in some cases, functional programs are less efficient.

In general, we recommend that you write pure functions whenever it is
reasonable to do so and resort to modifiers only if there is a compelling
advantage. This approach might be called a *functional programming style*.




Functions that Produce Lists
----------------------------

The pure version of ``doubleStuff`` above made use of an 
important **pattern** for your toolbox. Whenever you need to
write a function that creates and returns a list, the pattern is
usually::

    initialize a result variable to be an empty list
    loop
       create a new element 
       append it to result
    return the result

Let us show another use of this pattern.  Assume you already have a function
``is_prime(x)`` that can test if x is prime.  Now, write a function
to return a list of all prime numbers less than n::

   def primes_upto(n):
       """ Return a list of all prime numbers less than n. """
       result = []
       for i in range(2, n):
           if is_prime(i):
               result.append(i)
       return result

Side-Effect Free Comprehensions are "Functional"
------------------------------------------------

TODO
