..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Dictionaries
============

All of the compound data types we have studied in detail so far --- strings,
lists, and tuples --- are sequential collections.  This means that the items in
the collection are ordered from left to right and they use integers as indices
to access the values they contain.

**Dictionaries** and **Sets** are a different kinds of collections. They are
Python's built-in associative data types.  The dictionary associates one value
with another, whereas the set associates a value with membership in some
collection or group.  In this chapter, we will introduce these two data
structures and discuss their application in data wrangling and analysis.

Mapping One Value to Another with Dictionaries
----------------------------------------------

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

You may recall that we introduced ``get`` function from the ``toolz`` module in
the chapter on sequences.  A functional alternative to using the ``get``
operator (``name[key]``) is applying the same ``get`` function to a dictionary.


.. ipython:: python

    from toolz import get

    get('two', eng2sp)

Using the ``get`` function has a couple of advantages.  First, we can use a
common api for getting values from both sequences and lists.

.. ipython:: python

    L = [1,2,3]
    get(1, L)
    D = {1:"a", 2:"b"}
    get(1, D)

Second, ``get`` allows us to get the values for a number of keys simulaneously.

.. ipython:: python

    get([2,1], L)
    get(['one', 'two'], eng2sp)

Finally, we can assign an optional default value for keys that are not in the
dictionary.

.. ipython:: python

    get(['one', 'two', 'four'], eng2sp, default=None)

This flexibility makes ``get`` out go-to method for accessing data from a
dictionary.

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

     from toolz import get
     mydict = {"cat":12, "dog":6, "elephant":23}
     print(get("dog",mydict))

Why Dictionary Keys Must Be Immutable
-------------------------------------

The dictionary uses the built-in function ``hash`` to quickly look-up the value
for a given key (discussed in detail in :ref:`_dict_complexity`).  A requirement
of this process is that all keys be unique.  


.. ipython:: python

    hash('a')
    hash(1)
    hash(2.5)
    hash((1,2))

If we allowed mutable object to be
keys, how would we handle changes that confuse the ``hash`` function?  For
example, if ``[1]`` was a key and this value was mutated by aappending anothe
value, say ``2``, the new list ``[1, 2]`` would have a different hash value.
This could lead to the value being lost or two values in the dictionary having
the same hash.  Consequently, mutable items are not hashable, meaning that
``hash`` will throw an exception when given a mutable object.

.. ipython:: python

    hash([1,2])
    hash({1:'z'})

For this reason, all keys in a dictionary much be *immutable object*.  Examples
of eligable values are strings, number or tuples.  

.. ipython:: python

    d = {1:'int', 2.5:'float', 's':'string', (1,2):'tuple'} 
    d

Mutable objects, like lists and dictionaries, cannot be dictionary keys.

.. ipython:: python

    from toolz import assoc
    assoc(d, [1, 2], 'list')
    assoc(d, {'a':5}, 'list')

Note that the error message is pointing out that a list and dictionary are not
hashable (can't be converted to a number using ``hash``).  This is due to the
fact that they are both mutable.

Dictionary Operations
---------------------


Dictionaries are mutable. As mentioned earlier, the functional style of
programming involves returning new copies of a data structure instead of
mutating a data structure in place.  The easiest way to accomplish this is using
two functions from the ``toolz.dicttoolz`` module, namely ``assoc`` and
``dissoc``.

The function ``assoc`` is used to *associate* a value with a key, which can be a
new key or updating the value of an existing key.  In the next example, we will
update the value *associated* with ``'pears'`` and ``'peaches'`` to 0.
We verify that the dictionary that is returned is not the same as the old
dictionary.

.. ipython:: python
    
    from toolz.dicttoolz import assoc, dissoc
    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}
    new_inventory = assoc(inventory, 'pears', 0) 
    new_inventory = assoc(new_inventory, 'peaches', 0) 
    new_inventory
    inventory is new_inventory

Similarily, a new shipment of 200 bananas arriving could be handled like this.

.. ipython:: python

    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}    
    updated_bananas = get('bananas',inventory) + 200
    inventory = assoc(inventory, 'bananas', updated_bananas)
    inventory
    len(inventory)

Notice that there are now 512 bananas---the dictionary has been modified.  Note
also that the ``len`` function also works on dictionaries.  It returns the
number of key-value pairs:

The function ``dissoc`` is used to remove a key (and its value) from a
dictionary.  As with ``assoc``, a new dictionary is returned.

.. ipython:: python

    inventory = {'apples': 430, 'bananas': 312, 'oranges': 525, 'pears': 217}    
    new_dict = dissoc(inventory, 'pears')
    new_dict
    inventory is new_dict

.. todo:: Add something comparing the speeds of mutation, assoc, and assoc from cttoolz

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
     mouse_val = sum(get(["cat", "dog"], mydict))
     mydict = assoc(mydict, "mouse", mouse_val) 
     print(get("mouse", mydict)

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
     answer = get( "cat", mydict) // get("dog",mydict)
     print(answer)

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

    'bananas'.upper()+3*'!' if 'bananas' in inventory else "We have no bananas"
     

This operator can be very useful since looking up a non-existent key in a
dictionary causes a runtime error.

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

     from toolz import get
     mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
     keylist = list(mydict.keys())
     keylist.sort()
     print(get(3, keylist)
   
   
   

   
   
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

      from toolz import get
      mydict = {"cat":12, "dog":6, "elephant":23, "bear":20}
      total = sum([get(akey, mydict) for akey in mydict if len(akey) > 3])
      print(total)
   

.. admonition:: Aliasing and Copying

    Because dictionaries are mutable, you need to be aware of aliasing when
    mutating values (as we saw with lists).  Whenever two variables refer to the
    same dictionary object, changes to one affect the other.  For example,
    ``opposites`` is a dictionary that contains pairs of opposites.

    .. ipython:: python
        
        opposites = {'up': 'down', 'right': 'wrong', 'true': 'false'}
        alias = opposites

        alias is opposites

        alias['right'] = 'left'
        opposites['right']


    As you can see from the ``is`` operator, ``alias`` and ``opposites`` refer to
    the same object.  This illustrates another reason that we prefer to use
    ``assoc`` and ``dissoc`` to update a dictionary: returning fresh copies of a
    dictionary eliminates any problems cause by aliasing and mutation.

    .. ipython:: python
        
        opposites = {'up': 'down', 'right': 'wrong', 'true': 'false'}
        alias = opposites

        alias is opposites

        not_alias = assoc(alias, 'right', 'left')
        not_alias is opposites
        get('right', opposites)
        get('right', alias)
        get('right', not_alias)

Immutable and Persistent Dictionaries
-------------------------------------

In the last section, the functions ``assoc`` and ``dissoc`` where used to create
new copies of dictionaries with updated values.  We would expect that copying a
dictionary would add some complexity to the process.  We will take a closer look
at the relative efficiency of a number of approaches to building a dictionary in
the next chapter, but in the mean time we note that the ``pyrsistent`` module
contains a persistent dictionary/map that should reduce the penalty for copying
the contents of a dictionary over and over.

.. ipython:: python

    from pyrsistent import pmap
    opposites = pmap({'up': 'down', 'right': 'wrong', 'true': 'false'})
    type(opposites)
    not_alias = assoc(alias, 'right', 'left')
    not_alias
    not_alias is opposites
    get('up', not_alias)
    also_not_alias = dissoc(not_alias, 'up')
    also_not_alias
    also_not_alias is not_alias
    also_not_alias is alias

Notice that the same semantics that we use to work with dictionaries, i.e. using
``assoc``, ``dissoc`` and ``get`` also work with a ``pmap``. 

It should also be noted that, because all of the data types in ``pyrsistent``
are immutable, these data structures can be used as keys in a dictionary!

.. ipython:: python

    from pyrsistent import pmap, pvector
    d = {pmap({'a':1}):'pmap', pvector([1,2]):'pvector'}
    d

