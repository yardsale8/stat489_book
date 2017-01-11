Getting started with Python and the IPython notebook
====================================================

The IPython notebook is an interactive, web-based environment that
allows one to combine code, text and graphics into one unified document.
All of the lectures in this course have been developed using this tool.
In this lecture, we will introduce the notebook interface and
demonstrate some of its features.

Cells
=====

The IPython notebook has two types of cells:

::

    * Markdown
    * Code

Markdown is for text, and even allows some typesetting of mathematics,
while the code cells allow for coding in Python and access to many other
packages, compilers, etc.

Markdown
--------

To enter a markdown cell, just choose the cell tab and set the type to
'Markdown'.

.. image:: screenshot.png

The current cell is now in Markdown mode, and whatever is entered is
assumed to be markdown code. For example, text can be put into *italics*
or **bold**. A bulleted list can be entered as follows:

Bulleted List 
  
   \* Item 1 
   \* Item 2

Markdown has many features, and a good reference is located at:

http://daringfireball.net/projects/markdown/syntax

Code Cells
----------

Code cells take Python syntax as input. We will see a lot of those
shortly, when we begin our introduction to Python. For the moment, we
will highlight additional uses for code cells.

Magic Commands
~~~~~~~~~~~~~~

Magic commands work a lot like OS command line calls - and in fact, some
are just that. To get a list of available magics:

.. notebook-cell:: python

    %lsmagic

Notice there are line and cell magics. Line magics take the entire line
as argument, while cell magics take the cell. As 'automagic' is on, we
can omit the % when making calls to line magics.

.. notebook-cell:: python

    ls 

.. notebook-cell:: python

    cp _source/IntroductionToPython/WhatIsPython.rst WIP.rst

.. notebook-cell:: python

    ls _source/IntroductionToPython

.. notebook-cell:: python

    rm _source/IntroductionToPython/WIP.rst

.. notebook-cell:: python

    ls _source/IntroductionToPython

We can make all the above system calls in one cell, by using the cell
magic, %%system

.. notebook-cell:: python

    %%system
    cp IntroductionToPython.ipynb  IP2.ipynb
    ls
    rm IP2.ipynb
    ls

Using ``R`` in the IPython notebook
-----------------------------------

But magics are much more than system calls! We can even use R from
within the IPython notebook if you install the rpy2 package

.. code:: bash

    pip install rpy2

.. notebook-cell:: python

    %load_ext rpy2.ipython 

.. notebook-cell:: python

    %matplotlib inline

.. notebook-cell:: python

    %%R
    library(lattice) 
    attach(mtcars)

    # scatterplot matrix 
    splom(mtcars[c(1,3,4,5,6)], main="MTCARS Data")

We hope these give you an idea of the power and flexibility this
notebook environment provides!

This notebook is adapted (with permission) on the original work by
Cliburn Chan (cliburn.chan@duke.edu) and Janice McCarthy
(janice.mccarthy@duke.edu), which can be found
`here <http://people.duke.edu/~ccc14/sta-663-2015/>`__

