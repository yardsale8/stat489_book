..  Copyright (C)  Todd Iverson.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".

Working with Strings and Lists
==============================

Data wrangling involves transforming data from some raw form to another more
useful form.  Often this raw form is text saved in a text file, which
corresponds to the Python string data structure.  In this section, we will
illustrate the process of converting and transforming textual data list
comprehensions and the ``split``, ``join`` and ``format`` methods.


.. include:: CharacterClassification.rst

More on working with strings and lists
--------------------------------------

There are two common patterns that are applied when processing strings.  Both
patterns start by using the string ``split`` method to split the string into a
list of strings.  Then a list comprehension is used to transform the list of
strings and some post-processing is applied.

The first pattern is used when computing statistics about a string.  The
following figure illustrates this process.

.. figure:: Figures/string_statistic_diagram.png
    :alt: The process of computing statistics about a string

    ..

    The process for computing a statistic about a string envolves splitting
    the string into a list of strings, tranforming the string into another
    list and then reducing that list to a value.

Let's start by counting the number of vowels in a word.

.. ipython:: python

    vowels = "aeiou"
    word = "Mississippi"
    num_vowels = len([ch for ch in word if ch.lower() in vowels])
    num_vowels

We generalized this expression with lambda expression.
    
.. ipython:: python

    num_vowels = lambda word: len([ch for ch in word if ch.lower() in vowels])
    num_vowels("Minnesota")

This illustrates an important pattern when working with expression.  

1. Work with an example until an expression is developed to accomplish a task.
2. Package that expression in a function.
3. Update your example and move to the next task.

**Task: Find the average number of vowels in the words in a string**

Next, we will use this function to compute the average number of words in a
sentence.  We start by going through the process step-by-step.

First, we need to remove punctuation so that it doesn't add artificial length to
the strings.  We will accomplish this be removing any punctuation (determined by
importing punctuation from string and checking each character.)

.. ipython:: python

    from string import punctuation
    punctuation
    quote = '''I know something ain't right.
        Sweetie, we're crooks. If everything were right, we'd be in jail.'''
    characters_no_punc = [ch.lower() for ch in quote if ch not in punctuation]
    characters_no_punc[:10]

Notice that this returns a list of (lower case) characters, skipping the
punctuations marks.  To make this back into a string, we ``join`` the strings in
the list back together.

.. ipython:: python

    str_no_punc = "".join(characters_no_punc)
    str_no_punc

Let's combine these two steps into one expression

.. ipython:: python

    s_no_punc = "".join([ch.lower() for ch in quote if ch not in punctuation])
    s_no_punc

and turn this expression into a general function by replacing ``quote`` with a
most general variable (``S`` for string.)  This function is tested on the quote
to make sure it still works.
    
.. ipython:: python

    remove_punc = lambda S: "".join([ch.lower() for ch in S if ch not in punctuation])
    s_no_punc = remove_punc(quote)

Since we are interested in the words in the string, we split by whitespace
(default action of ``split``).

.. ipython:: python

    words = s_no_punc.split()
    words

This list of words is then transformed into a list that givens the number of
vowels using the function defined above.  Finally the mean function is applied.

.. ipython:: python


    nums = [num_vowels(word) for word in words]
    nums
    mean = lambda L: sum(L)/len(L)
    average_num_vowels = mean(nums)
    average_num_vowels

Finally, we generalize this process with a little refactoring.

.. ipython:: python

    remove_punc = lambda s: "".join([ch.lower() for ch in s if ch not in punctuation])
    clean_and_split = lambda s: remove_punc(s).split()
    average_num_vowels = lambda s: mean([num_vowels(word) for word in clean_and_split(s)])
    average_num_vowels("Long, long ago in a galaxy far, far away.")


A second string processing pattern that is commonly applied involves
transforming one string into another.  This pattern appeared in the
``remove_punc`` function from the last example.  This pattern illustrate the
process with a diagram.

.. figure:: Figures/building_a_string_diagram.png
    :alt: The process of computing statistics about a string

    ..

    The process for computing a statistic about a string envolves splitting
    the string into a list of strings, tranforming the string into another
    list and then reducing that list to a value.

We can use list comprehensions to describe a new string, but we need to convert
the result back to a string using the ``str`` conversion function.  For example,
let's remove all of the punctuation from a string.

.. ipython:: python

    zen_of_python = '''The Zen of Python, by Tim Peters
    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!'''

    zen_list_no_punc = [ch for ch in zen_of_python if ch not in string.punctuation]
    print(zen_list_no_punc)
    zen_string_no_punc = ''.join(zen_list_no_punc)
    print(zen_string_no_punc)

Finally, let's count how many of the lines in the Zen of Python start with a
vowel.  Recall that we want to make everything lowercase, split the list into
pieces (this time by line using ``"\n"``), filter out the lines that start with
a vowel, and using ``len`` to process.

First, make the list lowercase, 

.. ipython:: python

    zen_lower = zen_string_no_punc.lower()

then split it into lines,

.. ipython:: python

    lines = zen_lower.split('\n')
    lines[:5]

use a comprehension to filter out the lines that start with vowels,

.. ipython:: python

    lines_no_vowels = [line for line in lines if line[0] in vowels]
    lines_no_vowels[:5]

and use the ``len`` function to count the result.

.. ipython:: python

    num_lines = len(lines_no_vowels)
    num_lines

Let's combine these steps into one overall expression.

.. ipython:: python

    num_lines = len([line for line in zen_string_no_punc.lower().split('\n') if line[0] in vowels])
    num_lines
    
and make this into a general function.

.. ipython:: python

    num_lines = lambda S: len([line for line in S.lower().split('\n') if line[0] in vowels])
    num_lines(zen_string_no_punc)

Anytime that we create a function, we should evaluate it, looking for parts that
are overly complex.  In this case, the ``S.lower().split('\n')`` is complicated.
Let's refactor by making this a different function with a better name.

.. ipython:: python
    lower_and_split = lambda S: S.lower().split('\n') 
    num_lines = lambda S: len([line for line in lower_and_split(S) if line[0] in vowels])
    num_lines(zen_string_no_punc)

.. note::

    You can contemplate the zen of Python anytime by executing ``import this``.

    .. ipython:: python

        import this

Installing Project Gutenberg texts with NLTK
--------------------------------------------

We can access a large number of freely available books using the ``nltk`` python
library.  First, use ``conda`` to install/update the ``nltk`` library.

.. sourcecode:: bash

     $ conda install nltk

The you will need to ``import`` and download the books from a python console.

.. sourcecode:: python

     import nltk
     nltk.download()

This will open another window that can be used to download part of the ``nltk``
module.  At the very least you should download ``gutenberg`` from the *Corpora*
table.

.. image:: Figures/nltk_download_gutenberg.png

Now we can access the full content of novels such as Jane Austen's Emma.

.. sourcecode:: python

    In [1]: from nltk.corpus import gutenberg

    In [2]: emma = gutenberg.raw('austen-emma.txt')

    In [3]: emma[:1000]
    Out[3]: "[Emma by Jane Austen 1816]\n\nVOLUME I\n\nCHAPTER I\n\n\nEmma Woodhouse, handsome, clever, and rich, with a comfortable home\nand happy disposition, seemed to unite some of the best blessings\nof existence; and had lived nearly twenty-one years in the world\nwith very little to distress or vex her.\n\nShe was the youngest of the two daughters of a most affectionate,\nindulgent father; and had, in consequence of her sister's marriage,\nbeen mistress of his house from a very early period.  Her mother\nhad died too long ago for her to have more than an indistinct\nremembrance of her caresses; and her place had been supplied\nby an excellent woman as governess, who had fallen little short\nof a mother in affection.\n\nSixteen years had Miss Taylor been in Mr. Woodhouse's family,\nless as a governess than a friend, very fond of both daughters,\nbut particularly of Emma.  Between _them_ it was more the intimacy\nof sisters.  Even before Miss Taylor had ceased to hold the nominal\noffice of governess, the mildness o"


Once we have the novel imported into Python, it can be processed to answer
questions about the text.  Suppose that we want to know the average word length
in Emma.  First, the text is preprocessed to clean and remove unwanted
characters, in this case any punctuation or whitespace.  (We also make all of the
text lowercase out of habit.)

.. sourcecode:: python

	In [4]: from string import punctuation, whitespace

	In [5]: remove_punc = lambda s: "".join([ch for ch in s if ch not in
	punctuation])

	In [6]: make_lower_case = lambda s: s.lower()
	   ...:

	In [7]: fix_whitespace = lambda s: "".join([" " if ch in whitespace else ch for
	ch in s])

	In [8]: emma = remove_punc(make_lower_case(fix_whitespace(emma)))

	In [9]: emma[:100]
	Out[9]: 'emma by jane austen 1816  volume i  chapter i   emma woodhouse handsome
	clever and rich with a comfo'

Next, the text is split into a list of words and the statistic is computed.

.. sourcecode:: python

	In [10]: emma_words = emma.split()

	In [11]: mean = lambda L: sum(L)/len(L)

	In [12]: average_word_length = mean([len(word) for word in emma_words])

	In [13]: average_word_length
	Out[13]: 4.327759895276701

.. caution:: 

    We were pretty careless in our preprocessing in this example.  For example,
    the first portion of the text should be removed and we might have given
    separate consideration to chapter titles.

.. The ``nltk`` is an acronym for *Natural Language Toolkit* and consists of a
.. large collection of utilities for natural language processing.  For example, the
.. submodule ``nltk.sentiment`` can be used to score the sentiment of a text.
.. Below, we illustrate by computing the average sentiment of all sentences in
.. Emma.
.. 
.. .. note::
.. 
..     You will need to download the ``opinion lexicon`` corpus the run this
..     example using ``nltk.download()`` from a Python console.
.. 

.. .. ipython:: python
..  
..      from nltk.sentiment.util  import demo_liu_hu_lexicon as lex
..      from nltk.corpus import gutenberg
..      emma = gutenberg.raw('austen-emma.txt')
..      sents = emma.split('.')
..      flatten = lambda table: [item for row in table for item in row]
..      sents = flatten([portion.split('?') for portion in sents])
..      sents = flatten([portion.split('!') for portion in sents])
.. 
..      mean = lambda L: sum(L)/len(L)
..      average_sentiment = mean([lex(sent) for sent in sents])
..      average_sentiment
.. 

.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_08_04

