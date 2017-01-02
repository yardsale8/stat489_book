Transforming Sequences with Comprehensions
==========================================



List Comprehensions
-------------------

The previous example creates a list from a sequence of values based on some selection criteria.  An easy way to do this type of processing in Python is to use a **list comprehension**.  List comprehensions are concise ways to create lists.  The general syntax is::

   [<expression> for <item> in <sequence> if  <condition>]

where the if clause is optional.  For example,

.. activecode:: listcomp1

    mylist = [1,2,3,4,5]

    yourlist = [item ** 2 for item in mylist]

    print(yourlist)



The expression describes each element of the list that is being built.  The ``for`` clause iterates through each item in a sequence.  The items are filtered by the ``if`` clause if there is one.  In the example above, the ``for`` statement lets ``item`` take on all the values in the list ``mylist``.  Each item is then squared before it is added to the list that is being built.  The result is a list of squares of the values in ``mylist``.

To write the ``primes_upto`` function we will use the ``is_prime`` function to filter the sequence of integers coming from the ``range`` function.  In other words, for every integer from 2 up to but not including ``n``, if the integer is prime, keep it in the list.

.. sourcecode:: python

	def primes_upto(n):
	    """ Return a list of all prime numbers less than n using a list comprehension. """

	    result = [num for num in range(2,n) if is_prime(num)]
	    return result



.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_09_06
    
    

**Check your understanding**

.. mchoice:: test_question9_20_1
   :answer_a: [4,2,8,6,5]
   :answer_b: [8,4,16,12,10]
   :answer_c: 10
   :answer_d: [10].
   :correct: d
   :feedback_a: Items from alist are doubled before being placed in blist.
   :feedback_b: Not all the items in alist are to be included in blist.  Look at the if clause.
   :feedback_c: The result needs to be a list.
   :feedback_d: Yes, 5 is the only odd number in alist.  It is doubled before being placed in blist.
   
   What is printed by the following statements?
   
   .. code-block:: python

     alist = [4,2,8,6,5]
     blist = [num*2 for num in alist if num%2==1]
     print(blist)


.. index:: nested list, list; nested
       



Character classification
------------------------

It is often helpful to examine a character and test whether it is upper- or
lowercase, or whether it is a character or a digit. The ``string`` module
provides several constants that are useful for these purposes. One of these,
``string.digits`` is equivalent to "0123456789".  It can be used to check if a character
is a digit using the ``in`` operator.

The string ``string.ascii_lowercase`` contains all of the ascii letters that the system
considers to be lowercase. Similarly, ``string.ascii_uppercase`` contains all of the
uppercase letters. ``string.punctuation`` comprises all the characters considered
to be punctuation. Try the following and see what you get.

.. sourcecode:: python
    
    print(string.ascii_lowercase)
    print(string.ascii_uppercase)
    print(string.digits)
    print(string.punctuation)

    

For more information consult the ``string`` module documentaiton (see `Global Module Index <http://docs.python.org/py3k/py-modindex.html>`_).


.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_08_04


