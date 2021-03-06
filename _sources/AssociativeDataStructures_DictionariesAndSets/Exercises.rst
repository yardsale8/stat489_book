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


.. question:: dict_ex_1

   Give the Python interpreter's response to each of the following from a
   continuous interpreter session:

   a.
      .. sourcecode:: python

          >>> from toolz import get, assoc, dissoc
          >>> d = {'apples': 15, 'bananas': 35, 'grapes': 12}
          >>> get('bananas',d) 

   b.
      .. sourcecode:: python

          >>> d = assoc(d, 'oranges', 20)
          >>> len(d)

   c.
      .. sourcecode:: python

          >>> 'grapes' in d

   d.
      .. sourcecode:: python

          >>> get('pears', d)

   e.
      .. sourcecode:: python

          >>> get('pears', d, 0)

   f.
      .. sourcecode:: python

          >>> fruits = sorted(list(d.keys()))
          >>> fruits

   g.
      .. sourcecode:: python

          >>> d = dissoc(d, 'apples')
          >>> 'apples' in d




.. question:: dict_ex_2

   .. tabbed:: q3

        .. tab:: Question

           Write a function takes a body of text as input and returns a
           dictionary that maps each unique word in the text to its last
           position in the text, where the position is the based on word order.
           Apply this function to the text version of `Alice's Adventures in
           Wonderland`.  (You can obtain a free plain text version of the book,
           along with many others, from http://www.gutenberg.org.)            
           
           What is the last position of the word, ``alice``, occur in the book?

           .. actex:: ex_11_02

        .. tab:: Answer

            .. ipython:: python

                # be sure to clean up the string first 
                # (lowercase and no punctuation).
                s = "the only thing we have to fear is fear itself"
                words = s.split()

                # You should compose this function with your functions for
                # cleaning the text
                position_to_end = lambda words: {word: index 
                                                 for index, word in enumerate(words)}

                position_to_end(words)

.. question:: dict_ex_3

       Refer to the last problem. This time write a function that maps each
       unique word in the text to its first position in the text.  Apply
       this function to the text version of `Alice's Adventures in Wonderland`.
       Your solution should use a dictinary comprehension along with
       ``enumerate``.
       
       What is the first position of the word, ``alice``, occur in the book?

.. question:: dict_ex_4

       Refer to the last two problems.  This time we will map each unique word
       to a tuple that gives the line number and word position on the line for
       the first occurance of a word. For example ``(3,5)`` means that the
       corresponding word is first occurs as the 5th word on line 3. Write a
       function that creates this dictionary.  Apply this function to the text
       version of `Alice's Adventures in Wonderland`.         

       **Hint:** You will need to apply the dictionary comprehension trick from
       problem 2 twice, once for lines and again for words.

       Find the line-word pair for ``alice``.

.. question:: dict_ex_5

   Write a function that uses a set comprehension to determine how many unique
   words are in the body of a text.  
   
   Apply this function to  `Alice's Adventures in Wonderland`.


.. question:: dict_ex_6


    Here's a table of English to Pirate translations

    ==========  ==============
    English     Pirate
    ==========  ==============
    sir	        matey
    hotel	    fleabag inn
    student	    swabbie
    boy	        matey
    madam	    proud beauty
    professor	foul blaggart
    restaurant	galley
    your	    yer
    excuse	    arr
    students	swabbies
    are	        be
    lawyer	    foul blaggart
    the	        th'
    restroom	head
    my	        me
    hello	    avast
    is	        be
    man	        matey
    ==========  ==============

    Write a function that takes a sentence in English as input and
    returns the sentence translated to Pirate.

    .. actex:: ex_11_04


.. question:: dict_ex_7

    Consider the following set of keys.

    .. sourcecode:: python

        keys = [1, 'a', 2.5]

    Use the hash function to determine the hash value for each key then construct a
    diagram of a balanced binary search tree based on these hash values.
    Submit a pdf of your image.


.. question:: dict_ex_8

    Determine the computational complexity of associating a new value to a key that
    already exists in a dictionary.  You can assume that the dictionary always
    consists of a perfectly balanced binary tree (which is not true in practice).

.. question:: dict_ex_9

   .. tabbed:: q3

        .. tab:: Question

           Consider the JSON examples given on `json.org
           <http://json.org/example.html>`_.  Read the JSON data from the first
           example (starts with "glossary" key) into python and use a call to
           ``get_in`` to extract the string "XML" from this data structure.

           .. actex:: ex_11_02

        .. tab:: Answer

            .. sourcecode:: python

                s = '''
                <paste JSON here>
                '''
                from toolz import get_in
                from json import loads
                data = loads(s)
                get_in(["glossary", "GlossDiv", "GlossEntry", "GlossDef", "GlossSeeAlso", 2], data)


.. question:: dict_ex_10

   Consider the JSON examples given on `json.org
   <http://json.org/example.html>`_.  Read the JSON data from the third example
   (starts with "menu" key) into python and use a call to ``get_in`` to
   extract the string "CloseDoc()" from this data structure.

.. question:: dict_ex_11

   Consider the JSON examples given on `json.org
   <http://json.org/example.html>`_.  Read the JSON data from the fourth example
   (starts with "web-app" key) into python and use a call to ``get_in`` to
   extract the string "toolstemplates/" from this data structure.
