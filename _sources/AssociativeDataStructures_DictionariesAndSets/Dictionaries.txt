..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Mapping One Value to Another with Dictionaries
==============================================

All of the compound data types we have studied in detail so far --- strings,
lists, and tuples --- are sequential collections.  This means that the items in
the collection are ordered from left to right and they use integers as indices
to access the values they contain.

**Dictionaries** and **Sets** are a different kinds of collections. They are
Python's built-in associative data types.  The dictionary associates one value
with another, whereas the set associates a value with membership in some
collection or group.  In this chapter, we will introduce these two data
structures and discuss their application in data wrangling and analysis.

Dictionaries
============

The dictionary is a **mapping type**.  A map is an unordered, associative
collection.  The association, or mapping, is from a **key**, which can be any
immutable type, to a **value**, which can be any Python data object.  As an
example, we will create a dictionary to translate English words into Spanish.
For this dictionary, the keys are strings and the values will also be strings.


We can create a dictionary by providing a list of key-value pairs separated by
``:`` between the keys and values and ``,`` between each pair.

.. ipython:: python
    
    eng2sp = {'three': 'tres', 'one': 'uno', 'two': 'dos'}
    eng2sp

It doesn't matter what order we write the pairs. The values in a dictionary are
accessed with keys, not with indices, so there is no need to care about
ordering.

Here is how we use a key to look up the corresponding value.

.. ipython:: python

    eng2sp = {'three': 'tres', 'one': 'uno', 'two': 'dos'}

    eng2sp['two']


The key ``'two'`` yields the value ``'dos'``.


.. note::

    This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

    .. activecode:: scratch_11_01


**Check your understanding**

.. mchoice:: test_question11_1_1
   :answer_a: False
   :answer_b: True
   :correct: b
   :feedback_a: Dictionaries associate keys with values but there is no assumed order for the entries.
   :feedback_b: Yes, dictionaries are associative collections meaning that they store key-value pairs.

   A dictionary is an unordered collection of key-value pairs.


.. mchoice:: test_question11_1_2
   :answer_a: 12
   :answer_b: 6
   :answer_c: 23
   :answer_d: Error, you cannot use the index operator with a dictionary.
   :correct: b
   :feedback_a: 12 is associated with the key cat.
   :feedback_b: Yes, 6 is associated with the key dog.
   :feedback_c: 23 is associated with the key elephant.
   :feedback_d: The [ ] operator, when used with a dictionary, will look up a value based on its key.
   
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23}
     print(mydict["dog"])



Dictionary Operations
---------------------


Dictionaries are mutable.  As we've seen before with lists, this means that
the dictionary can be modified by referencing an association on the left hand
side of the assignment statement.  In the previous example, instead of deleting
the entry for ``pears``, we could have set the inventory to ``0``.

.. codelens:: ch12_dict4a
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}
    
    inventory['pears'] = 0

Similarily, a new shipment of 200 bananas arriving could be handled like this.

.. codelens:: ch12_dict5

    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}    
    inventory['bananas'] = inventory['bananas'] + 200


    numItems = len(inventory)

Notice that there are now 512 bananas---the dictionary has been modified.  Note
also that the ``len`` function also works on dictionaries.  It returns the
number of key-value pairs:


**Check your understanding**

.. mchoice:: test_question11_2_1
   :answer_a: 12
   :answer_b: 0
   :answer_c: 18
   :answer_d: Error, there is no entry with mouse as the key.
   :correct: c
   :feedback_a: 12 is associated with the key cat.
   :feedback_b: The key mouse will be associated with the sum of the two values.
   :feedback_c: Yes, add the value for cat and the value for dog (12 + 6) and create a new entry for mouse.
   :feedback_d: Since the new key is introduced on the left hand side of the assignment statement, a new key-value pair is added to the dictionary.
   
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23}
     mydict["mouse"] = mydict["cat"] + mydict["dog"]
     print(mydict["mouse"])

Dictionary Methods
------------------

Dictionaries have a number of useful built-in methods.
The following table provides a summary and more details can be found in the 
`Python Documentation <http://docs.python.org/py3k/library/stdtypes.html#mapping-types-dict>`_.

==========  ==============      =======================================================
Method      Parameters          Description
==========  ==============      =======================================================
keys        none                Returns a view of the keys in the dictionary
values      none                Returns a view of the values in the dictionary
items       none                Returns a view of the key-value pairs in the dictionary
get         key                 Returns the value associated with key; None otherwise
get         key,alt             Returns the value associated with key; alt otherwise
==========  ==============      =======================================================

The ``keys`` method returns what Python 3 calls a **view** over its
underlying keys.  An view is an example of an **iterable**. 

.. ipython:: python
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}  

    ks = inventory.keys()
    type(ks)
    ks

We can turn the iterable item into an iterator using the ``iter`` function.  An
**iterator** is a lazy construction that allows through the keys, one after the
other using the ``next`` function.

.. ipython:: python
    
    iter_ks = iter(ks)
    type(iter_ks)
    next(iter_ks)
    next(iter_ks)
    next(iter_ks)
    next(iter_ks)
    next(iter_ks)

An exception will be thrown once we reach the end of the iterator.  After the
iterator has stepped through the sequence once, it is empty and can't be used
again.

While understanding this gives a deeper insight into how Python works, Python
takes care of all of the details for us.  When we process an iterable value in a
list comprehension, Python hides the detail of making the iterator, using
``next`` to step through the sequence and stopping when the exception is thrown.

.. note:: 

     It is important to note that there is no guarentee the order of the keys
     will be returned!  Dictionaries are unorder sets.  If order is important
     either sort or use a sequence data structure.

We can use the iterator to iterate through the keys using a
list comprehension or by converting the view into a list.

.. ipython:: python
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}  
  
    keys = [akey for akey in inventory.keys()]
    keys 
    ks = list(inventory.keys())
    ks
    [akey for akey in inventory]

As we saw earlier with strings and lists, dictionary methods use dot notation,
which specifies the name of the method to the right of the dot and the name of
the object on which to apply the method immediately to the left of the dot. The
empty parentheses in the case of ``keys`` indicate that this method takes no
parameters.   Finally, we note that iterating over the dictionary name iterates
over the keys.

The ``values`` and ``items`` methods are similar to ``keys``. They return  view
objects which can be turned into lists or iterated over directly.  Note that the
items are shown as tuples containing the key and the associated value.

.. ipython:: python
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}  
    
    list(inventory.values())

    pairs = [(k,v) for k,v in inventory.items()]
    
Note that tuples are often useful for getting both the key and the value at the
same time while you are looping.  
    
The ``in`` and ``not in`` operators can test if a key is in the dictionary:

.. ipython:: python
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}
    'apples' in inventory
    'cherries' in inventory

    inventory['bananas'] if 'bananas' in inventory "We have no bananas"
     

This operator can be very useful since looking up a non-existent key in a
dictionary causes a runtime error.

The ``get`` method allows us to access the value associated with a key, similar
to the ``[ ]`` operator.  The important difference is that ``get`` will not
cause a runtime error if the key is not present.  It will instead return None.
There exists a variation of ``get`` that allows a second parameter that serves
as an alternative return value in the case where the key is not present.  This
can be seen in the final example below.  In this case, since "cherries" is not a
key, return 0 (instead of None).

.. ipython:: python
    
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}
    
    inventory.get("apples")
    inventory.get("cherries")
    inventory.get("cherries", 0)



**Check your understanding**

.. mchoice:: test_question11_3_1
   :answer_a: cat
   :answer_b: dog
   :answer_c: elephant
   :answer_d: bear
   :correct: c
   :feedback_a: keylist is a list of all the keys which is then sorted.  cat would be at index 1.
   :feedback_b: keylist is a list of all the keys which is then sorted.  dog would be at index 2.
   :feedback_c: Yes, the list of keys is sorted and the item at index 3 is printed.
   :feedback_d: keylist is a list of all the keys which is then sorted.  bear would be at index 0.
   
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
     keylist = list(mydict.keys())
     keylist.sort()
     print(keylist[3])
   
   
   
.. mchoice:: test_question11_3_2
   :answer_a: 2
   :answer_b: 0.5
   :answer_c: bear
   :answer_d: Error, divide is not a valid operation on dictionaries.
   :correct: a
   :feedback_a: get returns the value associated with a given key so this divides 12 by 6.
   :feedback_b: 12 is divided by 6, not the other way around.
   :feedback_c: Take another look at the example for get above.  get returns the value associated with a given key.
   :feedback_d: The integer division operator is being used on the values returned from the get method, not on the dictionary.
   
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
     answer = mydict.get("cat") // mydict.get("dog")
     print(answer)

   
   
.. mchoice:: test_question11_3_3
   :answer_a: True
   :answer_b: False
   :correct: a
   :feedback_a: Yes, dog is a key in the dictionary.
   :feedback_b: The in operator returns True if a key is in the dictionary, False otherwise.
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
     print("dog" in mydict)



.. mchoice:: test_question11_3_4
   :answer_a: True
   :answer_b: False
   :correct: b
   :feedback_a: 23 is a value in the dictionary, not a key.  
   :feedback_b: Yes, the in operator returns True if a key is in the dictionary, False otherwise.
   
   What is printed by the following statements?
   
   .. sourcecode:: python

      mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
      print(23 in mydict)



.. mchoice:: test_question11_3_5
   :answer_a: 18
   :answer_b: 43
   :answer_c: 0
   :answer_d: 61
   :correct: b
   :feedback_a: Add the values that have keys greater than 3, not equal to 3.
   :feedback_b: Yes, the for statement iterates over the keys.  It adds the values of the keys that have length greater than 3.
   :feedback_c: This is the accumulator pattern.  total starts at 0 but then changes as the iteration proceeds.
   :feedback_d: Not all the values are added together.  The if statement only chooses some of them.
   
   
   What is printed by the following statements?
   
   .. sourcecode:: python

      mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
      total = sum([mydict[akey] for akey in mydict if len(akey) > 3])
      print(total)
   

Aliasing and Copying
--------------------

Because dictionaries are mutable, you need to be aware of aliasing (as we saw
with lists).  Whenever two variables refer to the same dictionary object,
changes to one affect the other.  For example, ``opposites`` is a dictionary
that contains pairs of opposites.

.. ipython:: python
    
    opposites = {'up': 'down', 'right': 'wrong', 'true': 'false'}
    alias = opposites

    alias is opposites

    alias['right'] = 'left'
    opposites['right']


As you can see from the ``is`` operator, ``alias`` and ``opposites`` refer to
the same object.

If you want to modify a dictionary and keep a copy of the original, use the
dictionary ``copy`` method.  Since *acopy* is a copy of the dictionary, changes
to it will not effect the original.

.. sourcecode:: python
    
    acopy = opposites.copy()
    acopy['right'] = 'left'    # does not change opposites

**Check your understanding**

.. mchoice:: test_question11_4_1
   :answer_a: 23
   :answer_b: None
   :answer_c: 999
   :answer_d: Error, there are two different keys named elephant.
   :correct: c
   :feedback_a: mydict and yourdict are both names for the same dictionary.  
   :feedback_b: The dictionary is mutable so changes can be made to the keys and values.
   :feedback_c: Yes, since yourdict is an alias for mydict, the value for the key elephant has been changed.
   :feedback_d: There is only one dictionary with only one key named elephant.  The dictionary has two different names, mydict and yourdict.
   
   What is printed by the following statements?
   
   .. sourcecode:: python

     mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
     yourdict = mydict
     yourdict["elephant"] = 999
     print(mydict["elephant"])

