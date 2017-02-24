..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Working with Nested Data Structures
===================================

Storing information in a nested data structure has become a common practice. 
This allows information to be collected in one structure while still allowing the
most appropriate data structure for storing each different types of information
internally.

One popular standard format for storing such information is `JSON
<https://en.wikipedia.org/wiki/JSON>`_, which stands for JavaScript Object
Notation.  An example of data stored in the JSON format is presented below.

.. sourcecode:: javascript

    {
      "firstName": "John",
      "lastName": "Smith",
      "isAlive": true,
      "age": 25,
      "address": {
        "streetAddress": "21 2nd Street",
        "city": "New York",
        "state": "NY",
        "postalCode": "10021-3100"
      },
      "phoneNumbers": {
        "home":   {
                    "type": "home",
                    "number": "212 555-1234"
                  },
        "office":{
                   "type": "office",
                   "number": "646 555-4567"
                 },
        "modile":{
                   "type": "mobile",
                   "number": "123 456-7890"
                 }
      },
      "children": ["Alice", "Ben"],
      "spouse": null
    }

.. admonition:: Source

    This example was adapted from `the Wikipedia JSON page
    <https://en.wikipedia.org/wiki/JSON#Example>`_ which is shared under the `Creative Commons Attribution-ShareAlike License <https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License>`_.


Notice that the JSON data structure consists of literal values (string, numbers,
JavaScript booleans, null, etc.) inside of data structures that look remarkably
similar to Python lists and dictionaries.  

.. note:: 

    The ``json`` module also has functions for reading and writing JSON to a file
    (``load`` and ``dump``, repectively).

Reading JSON data into Python
-----------------------------

Python can read a JSON file with only a few changes to the data.  This is
typically accomplished using the `json standard module
<https://docs.python.org/3.5/library/json.html>`_.  In this case, we will use
the ``loads`` function from ``json`` to load the JSON data using a (multiline)
string.


.. ipython:: python

    from json import loads
    s = '''
    {
      "firstName": "John",
      "lastName": "Smith",
      "isAlive": true,
      "age": 25,
      "address": {
        "streetAddress": "21 2nd Street",
        "city": "New York",
        "state": "NY",
        "postalCode": "10021-3100"
      },
      "phoneNumbers": {
        "home":   {
                    "type": "home",
                    "number": "212 555-1234"
                  },
        "office":{
                   "type": "office",
                   "number": "646 555-4567"
                 },
        "mobile":{
                   "type": "mobile",
                   "number": "123 456-7890"
                 }
      },
      "children": ["Alice", "Ben"],
      "spouse": null
    }'''
    data = loads(s)
    type(data)
    data

Note that the only changes that needed to be made where

1. changing the JavaScript ``true`` to ``True``, and
2. changing the Javascript ``null`` value to ``None``

Furthermore, there was no change to the literal data structure sytnax, as Python's list and
dictionaries are similar enough to JavaScript's arrays and objects that direct
substitution works in this case.

Getting values from a nested data structure
-------------------------------------------

The standard method for getting data from a nested data structure with nested
applications of Python's get syntax.  For example, if we want to get the state
from Johns address, we would use ``data['address']['state']``.  This pulls the
address dictionary (``data['address']``) from ``data`` and then pulls the state
(``data['address']['state']``) from that dictionary.  


.. ipython:: python

    data['address']['state']


Just as we have been using ``get`` as a common API for getting values from a
single list or dictionary, the ``toolz`` package provides ``get_in`` for
accessing data from nested data.

.. ipython:: python

    from toolz import get_in
    get_in(['address', 'state'], data)

The code block below shows two more examples of using ``get_in`` to get data
from this nested structure.

.. ipython:: python

    # Getting data three levels deep
    get_in(['phoneNumbers', 'mobile', 'number'], data)
    # Getting data from an embedded list
    get_in(['children',0], data)

It is important to note that the default behavior of ``get_in`` is to return
``None`` for any missing data.  You should either get in the habit of checking
if a value ``is None`` or change the default to force an exception on missing
data.

.. ipython:: python

    # Missing data return None
    get_in(['phoneNumbers', 'car', 'number'], data) is None
    # Changing the default behavior to throw an exception
    get_in(['phoneNumbers', 'car', 'number'], data, no_default=True)

Updating values in a nested data structure
------------------------------------------

If you want to update the data in a nested structure without mutating the data,
use ``assoc_in`` from ``toolz``, which will return a new data structure with the
associated changes.

We would use the following expression to change John's mobile number.

.. ipython:: python

    from toolz import assoc_in
    assoc_in(data, ['phoneNumbers', 'car', 'number'], '507 867 5309')

Since we are not changing the original data, we need to make sure to save a
reference to the new data structure, or we will miss the changes.

.. ipython:: python

    # The last change was not saved
    get_in(['phoneNumbers', 'mobile', 'number'], data)
    # save a reference to have access to the new data
    data1 = assoc_in(data, ['phoneNumbers', 'car', 'number'], '507 867 5309')
    data1 is data
    get_in(['phoneNumbers', 'car', 'number'], data1)

.. note::  ``toolz`` provides ``update_in`` which is similar to ``assoc_in``, but mutates the values in place.  This function will can also be used to create the initial shell of a nested structure.  See the ``toolz`` `documentation <http://toolz.readthedocs.io/en/latest/api.html#toolz.dicttoolz.update_in>`_.
