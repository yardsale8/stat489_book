
..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".


.. qnum::
   :prefix: intro-3-
   :start: 1

What is Python?
===============

.. The Python Programming Language
.. -------------------------------

The programming language you will be learning is Python. Python is an example
of a **high-level language**; other high-level languages you might have heard
of are C++, PHP, and Java.

.. As you might infer from the name high-level language, there are also
.. **low-level languages**, sometimes referred to as machine languages or assembly
.. languages. Machine language is the encoding of instructions in binary so that
.. they can be directly executed by the computer.  Assembly language uses a
.. slightly easier format to refer to the low level instructions.
.. Loosely speaking, computers can only execute programs written in
.. low-level languages.  To be exact, computers can actually only execute
.. programs written in machine language. Thus, programs written in a high-level
.. language (and even those in assembly language) have to be
.. processed before they can run. This extra processing takes some time, which is
.. a small disadvantage of high-level languages.
.. However, the advantages to high-level languages are enormous.
.. 
.. First, it 
.. It is much easier to program in a high-level language. Programs
.. written in a high-level language take less time to write, they are shorter and
.. easier to read, and they are more likely to be correct. Second, high-level
.. languages are **portable**, meaning that they can run on different kinds of
.. computers with few or no modifications. Low-level programs can run on only one
.. kind of computer and have to be rewritten to run on another.
.. 
.. Due to these advantages, almost all programs are written in high-level
.. languages. Low-level languages are used only for a few specialized
.. applications.

Two kinds of programs process high-level languages into low-level languages:
**interpreters** and **compilers**. An interpreter reads a high-level program
and executes it, meaning that it does what the program says. It processes the
program a little at a time, alternately reading lines and performing
computations.

.. image:: Figures/interpret.png
   :alt: Interpret illustration

A compiler reads the program and translates it completely before the program
starts running. In this case, the high-level program is called the **source
code**, and the translated program is called the **object code** or the
**executable**. Once a program is compiled, you can execute it repeatedly
without further translation.

.. image:: Figures/compile.png
   :alt: Compile illustration

Many modern languages use both processes. They are first compiled into a lower
level language, called **byte code**, and then interpreted by a program called
a **virtual machine**. Python uses both processes, but because of the way
programmers interact with it, it is usually considered an interpreted language.

There are three ways to use the Python interpreter: *shell mode,* *program mode*
and the *IPython/Jupyter notebook.* In shell mode, you type Python expressions
into the **Python shell** or **IPython shell**, and the interpreter immediately
shows the result.  The shell has many the advantages, including direct and
immediate interaction with our data.   Furthermore, we can work with a shell in
our programming environment, often called an Integrated Development Environment
(IDE), or on a remote session with a server.

.. The example below shows the Python shell at work.  
.. 
.. ::
.. 
..     $ python3
..     Python 3.2 (r32:88445, Mar 25 2011, 19:28:28)
..     [GCC 4.5.2] on linux2
..     Type "help", "copyright", "credits" or "license" for more information.
..     >>> 2 + 3
..     5
..     >>>
.. 
.. The ``>>>`` is called the **Python prompt**. The interpreter uses the prompt to
.. indicate that it is ready for instructions. We typed ``2 + 3``.  The interpreter
.. evaluated our expression and replied ``5``. On the next line it gave a new
.. prompt indicating that it is ready for more input.
.. 
.. Working directly in the interpreter is convenient for testing short bits of
.. code because you get immediate feedback. Think of it as scratch paper used to
.. help you work out problems.
.. 
.. An alternative to the regular python shell is the *IPython/Jupyter* shell, which
.. makes many "quality-of-life" improvements, making it the preferred choice for
.. interactive sessions in python (if available).  The following example illustrates
.. code evaluated in the IPython shell.  
.. 
.. .. ipython:: python
.. 
..     2 + 3
.. 
.. The ``In [1]:`` is called the **IPython prompt**.  We typed ``2 + 3``.  The
.. interpreter evaluated our expression and replied ``Out[1]: 5``. The numbering of
.. lines as well as distinguishing between input and output are two small
.. advantages to this shell.  Other advantages include code completion, simplified
.. help commands, and the ability to call other languages such as bash and R using
.. magic commands.
.. 
.. Alternatively, you can write an entire program by placing lines of Python
.. instructions in a file and then use the interpreter to execute the contents of
.. the file as a whole. Such a file is often referred to as **source code**.  Not
.. only can a python file be executed as a program, it can also be used to share
.. code with other programs, and this case we refer to the file as a *module*.  By
.. convention, files that contain Python code have names that end with ``.py`` .
.. Following this convention will help your operating system and other programs
.. identify a file as containing python code. We will illustrate constructing
.. python and modules in a later chapters.

.. For example, we used a text editor to create a source code file named
.. ``firstprogram.py`` with the following contents:
..
.. .. sourcecode:: python
.. 
..     print("My first program adds two numbers, 2 and 3:")
..     print(2 + 3)
.. 
.. 
.. Finally, we will also explore a hybrid of the shell mode called the **Jupyter
.. notebook,** which will allow use to execute code in a web browser, as well
.. allowing us to combine our code with supporting documentation.

.. admonition:: IPython and Jupyter

   The name(s) for the IPython tools are currently in transition.  Ipython was
   originally written with Python as the sole focus, but it was quickly
   recognized that this framework works well with many language.  Recently,
   IPython was split into two parts, Jupyter and Ipython proper.  Project
   Jupyter includes all of the machinery that is used to make shells and
   notebooks, allowing easy creation of tools in other language.  Ipython
   contains the Python-specific interface with Jupyter.  Because this name
   change is relatively new, there can be some confusion on naming, so be aware
   the "Ipython" might refer to wither or both of Jupyter and Ipython. 

.. These examples show Python being run from a Unix command line. In other
.. development environments, the details of executing programs may differ. Also,
.. most programs are more interesting than this one.
.. 
.. 
.. .. admonition:: Want to learn more about Python?
.. 
.. 	If you would like to learn more about installing and using Python, here are some video links.
.. 	`Installing Python for Windows <http://youtu.be/9EfGpN1Pnsg>`__ shows you how to install the Python environment under
.. 	Windows Vista,
.. 	`Installing Python for Mac <http://youtu.be/MEmEJCLLI2k>`__ shows you how to install under Mac OS/X, and
.. 	`Installing Python for Linux <http://youtu.be/RLPYBxfAud4>`__ shows you how to install from the Linux
.. 	command line.
.. 	`Using Python <http://youtu.be/kXbpB5_ywDw>`__ shows you some details about the Python shell and source code.

.. **Check your understanding**
.. 
.. .. mchoice:: question1_2_1
..    :answer_a: the instructions in a program, stored in a file.
..    :answer_b: the language that you are programming in (e.g., Python).
..    :answer_c: the environment/tool in which you are programming.
..    :answer_d: the number (or "code") that you must input at the top of each program to tell the computer how to execute your program.
..    :correct: a
..    :feedback_a: The file that contains the instructions written in the high level language is called the source code file.
..    :feedback_b: This language is simply called the programming language, or simply the language.
..    :feedback_c: The environment may be called the IDE, or integrated development environment, though not always.
..    :feedback_d: There is no such number that you must type in at the start of your program.
.. 
..    Source code is another name for:
.. 
.. .. mchoice:: question1_2_2
..    :answer_a: It is high-level if you are standing and low-level if you are sitting.
..    :answer_b: It is high-level if you are programming for a computer and low-level if you are programming for a phone or mobile device.
..    :answer_c: It is high-level if the program must be processed before it can run, and low-level if the computer can execute it without additional processing.
..    :answer_d: It is high-level if it easy to program in and is very short; it is low-level if it is really hard to program in and the programs are really long.
..    :correct: c
..    :feedback_a: In this case high and low have nothing to do with altitude.
..    :feedback_b: High and low have nothing to do with the type of device you are programming for.  Instead, look at what it takes to run the program written in the language.
..    :feedback_c: Python is a high level language but must be interpreted into machine code (binary) before it can be executed.
..    :feedback_d: While it is true that it is generally easier to program in a high-level language and programs written in a high-level language are usually shorter, this is not always the case.
.. 
.. 
..     What is the difference between a high-level programming language and a low-level programming language?
.. 
.. .. mchoice:: question1_2_3
..    :answer_a: 1 = a process, 2 = a function
..    :answer_b: 1 = translating an entire book, 2 = translating a line at a time
..    :answer_c: 1 = software, 2 = hardware
..    :answer_d: 1 = object code, 2 = byte code
..    :correct: b
..    :feedback_a: Compiling is a software process, and running the interpreter is invoking a function, but how is a process different than a function?
..    :feedback_b: Compilers take the entire source code and produce object code or the executable and interpreters execute the code line by line.
..    :feedback_c: Both compilers and interpreters are software.
..    :feedback_d: Compilers can produce object code or byte code depending on the language.  An interpreter produces neither.
.. 
..    Pick the best replacements for 1 and 2 in the following sentence: When comparing compilers and interpreters, a compiler is like 1 while an interpreter is like 2.
.. 

.. qnum::
   :prefix: intro-12-
   :start: 1

A Typical First Program
-----------------------

Traditionally, the first program written in a new language is called *Hello,
World!* because all it does is display the words, Hello, World!  In Python, the source code
looks like this.

.. sourcecode:: python

    print("Hello, World!")

This is an example of using the **print function**, which doesn't actually
print anything on paper. It displays a value on the screen. In this case, the result is the phrase:

::

    Hello, World!

Here is the example in activecode.  Give it a try!

.. activecode:: ch01_2

    print("Hello, World!")

.. note:: 

    The quotation marks in the program mark the beginning and end of the value.
    They don't appear in the result.

Some people judge the quality of a programming language by the simplicity of
the Hello World program. By this standard, Python does about as well as
possible.

When working with data, it is natural to work *interactively*, e.g. execute a
command or two and then observe the outcome.  To aid in exploring data
interactively, we will be using python packages `Jupyter` and `Ipython` for this
purpose.  Below you see the output of evaluating and printing ``"Hello,
World!"``.  

.. ipython:: python

    "Hello, World!"
    print("Hello, World!")

Notice that when we type a value such as ``"Hello, World!"`` and press enter,
python returns the value, which we could save for later.  On the other hand, the
print function has no output.  This is due to the fact that ``print`` sends its
output to the operating system (and not Python).  

Consequently, we don't need the print statements when working interactively, and
in fact, print statements can be a common source of errors for programmers that
are new to python. 


.. caution::

    You should try to limit the use of print statements in your code.  In the
    interactive code blocks in the book, we are forced to use ``print`` to see
    the output of our code, but you should try to limit your use of the
    ``print`` function.
    
.. admonition:: When to use `print` 

    Use `print` ...

    1. as a temparary debugging toy.  In this case, the print calls should be removed after the bugs are fixed.
    2. when writing python shell scripts that interact with other programs (We will show examples of this techniques later in the book.)
    3. To log information to a file.  This is a useful development tool, but **will not** play a role in this book.

**Check your understanding**

.. mchoice:: question1_11_1
   :answer_a: sends information to the printer to be printed on paper.
   :answer_b: displays a value on the screen.
   :answer_c: tells the computer to put the information in print, rather than cursive, format.
   :answer_d: tells the computer to speak the information.
   :correct: b
   :feedback_a: Within the Python programming language, the print function has nothing to do with the printer.
   :feedback_b: Yes, the print function is used to display the value of the thing being printed.
   :feedback_c: The format of the information is called its font and has nothing to do with the print function.
   :feedback_d: That would be a different function.

   The print function:


Comments
--------

As programs get bigger and more complicated, they get more difficult to read.
Formal languages are dense, and it is often difficult to look at a piece of
code and figure out what it is doing, or why.
For this reason, it is a good idea to add notes to your programs to explain in
natural language what the program is doing.  These notes are called comments.

A **comment** in a computer program is text that is intended only for the human
reader - it is completely ignored by the interpreter.
In Python, the `#` token starts a comment.  The rest of the line is ignored.
Here is a new version of *Hello, World!*.

.. activecode:: ch01_3

    #---------------------------------------------------
    # This demo program shows off how elegant Python is!
    # Written by Joe Soap, December 2010.
    # Anyone may freely copy or modify this program.
    #---------------------------------------------------

    print("Hello, World!")     # Isn't this easy!

Notice that when you run this program, it still only prints the phrase Hello, World!  None of the comments appear.
You'll also notice that we've left a blank line in the program.  Blank lines
are also ignored by the interpreter, but comments and blank lines can make your
programs much easier for humans to parse.  Use them liberally!

**Check your understanding**

.. mchoice:: question1_12_1
   :answer_a: To tell the computer what you mean in your program.
   :answer_b: For the people who are reading your code to know, in natural language, what the program is doing.
   :answer_c: Nothing, they are extraneous information that is not needed.
   :answer_d: Nothing in a short program.  They are only needed for really large programs.
   :correct: b
   :feedback_a: Comments are ignored by the computer.
   :feedback_b: The computer ignores comments.  It's for the humans that will "consume" your program.
   :feedback_c: Comments can provide much needed information for anyone reading the program.
   :feedback_d: Even small programs benefit from comments.

   What are comments for?


.. note::

   This workspace is provided for your convenience.  You can use this activecode window to try out anything you like.

   .. activecode:: scratch_01

.. The Jupyter/IPython Notebook
.. ----------------------------
.. 
..  .. include:: IPythonNotebook_Introduction.rst
.. 
