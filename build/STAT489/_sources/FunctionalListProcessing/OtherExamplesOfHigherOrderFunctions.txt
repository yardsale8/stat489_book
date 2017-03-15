..  Copyright (C)  Brad Miller, David Ranum, Jeffrey Elkner, Peter Wentworth, Allen B. Downey, Chris
    Meyers, and Dario Mitchell.  Permission is granted to copy, distribute
    and/or modify this document under the terms of the GNU Free Documentation
    License, Version 1.3 or any later version published by the Free Software
    Foundation; with Invariant Sections being Forward, Prefaces, and
    Contributor List, no Front-Cover Texts, and no Back-Cover Texts.  A copy of
    the license is included in the section entitled "GNU Free Documentation
    License".


Other Examples of Higher Order Functions
========================================

In this section, we will implement some other common higher-order functions

Many of these functions are implemented in the Python libraries ``toolz`` and
``cytoolz`` under the sub module titled ``functoolz``.  These two modules have
exactly the same functionality, but the ``cytoolz`` functions are implemented
with in ``cython``, which means that you get better performance.  Unfortunately,
you need a ``C`` compiler to install ``cytoolz``, but ``toolz`` also has decent
performance approximately equal in performance to similar tools from the
standard library.

.. note::

    You can install these packages using ``pip`` from the command line, as shown
    below,

    .. sourcecode:: python
        
         pip install toolz cytoolz

    or you can run this command inside a jupyter console or notebook.

    .. sourcecode:: python

        !pip install toolz cytoolz

Composition
-----------

Consider the following example, which involves cleaning up a string by removing
punctuation, whitespace and upper-case characters.

.. ipython:: python

    from string import punctuation, whitespace

    s = '''Success is not final, 
           failure is not fatal: 
           it is the courage to continue that counts.'''

    remove_punc = lambda s: "".join([ch for ch in s if ch not in punctuation])
    make_lower_case = lambda s: s.lower()
    fix_whitespace = lambda s: "".join([" " if ch in whitespace else ch for ch in s])

    s = remove_punc(s)
    s = make_lower_case(s)
    s = fix_whitespace(s)
    s


In this imperative example, we are mutating the value stored as ``s`` by
applying one function after the other.  We could have composed these three calls
into one call, as follows.

.. ipython:: python

    s = remove_punc(make_lower_case(fix_whitespace(s)))
    s

What if we want to reuse this code.  Of course, we could use a function to make
this expression reusable.

.. ipython:: python

    clean_up = lambda s: remove_punc(make_lower_case(fix_whitespace(s)))
    s = clean_up(s)
    s


Function composition is so common that it will be useful to abstract the process
of composing and applying a function.  

.. todo:: add a few more analygous examples.

Before we construct this function, it is useful to look at the imperative
solution to the problem.  We can use a for loop to cycle through the functions
and an accumulator to keep track of the latest value of the output.  Also note
that we need to apply the right-most function first, so we will used
``reversed`` to iterate through the list back to front. In addition, we add a
variable number of args to remove the need for using a list as an argument.


.. ipython:: python

    def compose_imperative(*funcs): #*
        def new_func(item):
            output = item
            for func in reversed(funcs):
                output = func(output)
            return output
        return new_func

    clean_up = compose_imperative(remove_punc, make_lower_case, fix_whitespace)
    clean_up(s)

The fact that we are using the accumulator pattern indicates that this operation
is a reduction.  Creating this function adheres to the DRY principle, as we
won't need to explicitly compose functions over and over in our code.  In fact,
we don't even need to give this new function a name, but can call it anonymously
as follows.

.. ipython:: python

    compose_imperative(remove_punc, 
                       make_lower_case, 
                       fix_whitespace)(s)

Now that we have recognized that this process is a reduction, we refactor the
code accordingly.  In this case, it is again important to work through the
reversed list to preserve the order of operation of functional composition.

.. ipython:: python

    from functools import reduce

    def my_compose(*funcs):  #*
        def new_func(item):
            return reduce(lambda acc, next_func: next_func(acc), reversed(funcs), item)
        return new_func

    my_compose(remove_punc, 
               make_lower_case, 
               fix_whitespace)(s)

There is no need to implement this function, as the ``toolz`` library includes
an implementation called ``compose``.

.. ipython:: python

    from toolz import compose
    compose(remove_punc, 
            make_lower_case, 
            fix_whitespace)(s)

.. figure:: Figures/compose.png
    :alt: Composing text cleaning functions.

    ..

    A composition of functions is itself a function that applies each argument from
    right to left.

Other types of composition
--------------------------

One must always remember that ``compose`` passes the input through the functions
from right-to-left.  Another composition function included in ``toolz``,  ``pipe``,
can be used to push an argument through any number of unary functions from
left-to-right.

.. ipython:: python

    from toolz import pipe
    pipe(s , fix_whitespace, make_lower_case, remove_punc)

.. figure:: Figures/pipe.png
    :alt: Piping data through text cleaning transformations.

    ..

    When piping data (first arguments) through a series of transformation functions
    (remaining arguments), the data is *piped* through each transformation from left
    to right with each subsequent transformation getting the result of the last
    transformation as input.

The ``pipe`` function is designed for a sequence of unary (one argument)
functions.  What if we want to perform a similar, left-to-right sequence of
calls, but with functions with arity greater than 1? Use ``tread_first``!    The
first argument of ``thread_first`` is the argument ``val`` that will be passed
through a sequence of functions.  The remaining argument are the functions that
will be allied from left-to-right.  ``thread_first`` allows a function argument
to be replaced with a tuple in the form of ``(func, arg1, arg2, ..., argn)``,
and the subsequent function call will be of the form ``func(val, arg1, arg2,
..., argn)``.  Note that the *first* in ``tread_first`` indicated that the
argument ``val`` will be the *first* argument in each call.

.. ipython:: python

    from operator import add, pow, abs, sub
    from toolz import thread_first

    thread_first(5, (add, 2), (pow, 2), (sub, 6))

    # The above is equivalent to
    sub(pow(add(5, 2), 2), 5)

If, on the other hand, you wish to a pass a value ``val`` through a sequence of
functions *in the last argument*, use ``thread_last``.

.. ipython:: python

    from toolz import thread_last

    thread_last(5, (add, 2), (pow, 2), (sub, 6))

    # The above is equivalent to
    sub(6, pow(2, add(2, 5)))


.. note::

    We will show how to use curried functions with ``pipe`` in the coming
    sections.  Also, you will implement your own versions of ``pipe``,
    ``thread_first`` and ``thread_last`` in the exercises found at the end of
    the chapter.  
    
Partial Functions 
-----------------

In the second chapter, we illustrated how to use a function factory to
generalize the ``apply_tax`` function.

.. ipython:: python

    def make_apply_tax(rate):
        def apply_tax(cost):
            return rate*cost
        return apply_tax

    rate = 1.065
    apply_tax = make_apply_tax(rate)
    apply_tax(1)
    apply_tax(4.55)

A simpler approach to this problem would be to define ``apply_tax`` as a two
parameter function, but this would require us to input the tax rate each time
with make a function call (repeated code).

.. ipython:: python

     def apply_tax(rate, cost):
         return rate*cost
    rate = 1.065
    apply_tax(rate, 1)
    apply_tax(rate, 4.55)

This apply tax function is definitely easier to understand compared to
``make_apply_tax``.  The traditional method for removing this unneeded
replication of one or more arguments is the use of a partial function.  A
**partial function** is used to call a base function, but fixes the values of
some of the arguments of this base function.  We can use ``partial`` from the
``functools`` library to create partial functions.

.. ipython:: python

    from functools import partial

    my_apply_tax = partial(apply_tax, 1.065)
    my_apply_tax(1)
    my_apply_tax(4.55)

This solution provides a nice compromise between the complexity of a function
factory and the unneeded replication of a second parameter.  First, we don't
need to use the more complex nested functions; but we can still save the
replication of the ``rate`` parameter in each function call.

So what is happening here.   Clearly ``partial`` is a higher-order function (it
returns another function).  One way to think about this: a call to a ``partial``
function calls ``apply_tax`` with ``rate`` fixed at 1.065, leaving the ``cost``
parameter as the only remaining formal parameter.

``partial`` makes it easy to fill in the left-most formal parameters, but what
if we had ordered the parameters in reverse?

.. ipython:: python

     def apply_tax_reverse(cost, rate):
         return rate*cost

Using ``partial`` here requires us to wrap our function in a ``lambda`` that
reverses the order of the arguments.

.. ipython:: python

   my_apply_tax = partial(lambda rate, cost: apply_tax_reverse(cost, rate), 1.065) 

   my_apply_tax(1)
   my_apply_tax(4.55)

The ``toolz`` library includes a function called ``flip`` that can be used to
flip the order of the parameters without needing to create a lambda expression.

.. ipython:: python

    from toolz import flip
    my_apply_tax = partial(flip(apply_tax_reverse), 1.065) 

    my_apply_tax(1)
    my_apply_tax(4.55)

Another useful approach is the application of a default parameter.  Then we can
use keyword expansion along with ``partial`` to create a specialized version of
our function with a different default value.  Again, ``partial`` saves us from
having to type the alternative value of the keyword more than once.

.. ipython:: python

    def apply_tax_default(cost, rate=1.05):
         return rate*cost

    my_apply_tax = partial(apply_tax_default, ** {"rate":1.065})

    my_apply_tax(1)
    my_apply_tax(4.55)

.. note::  

    Unfortunately some of the built-in python functions like ``reduce`` do
    not treat optional parameters as keyword arguments and another approach will
    need to be used for these functions.

Decorator Functions
-------------------

``partial`` is an example of a **decorator function**, which is a function that
creates a *wrapper* around another function.  The outer function calls the
original function and then changes or *decorates* the input and/or output.

For example, when processing text, it is often useful to switch all the text to
lower case.  We will create a decorator function that can be used to wrap any
function that returns a string and insure that the output is lower case.

.. ipython:: python

    def lower_out(func):
        def decorated_func(s):
            return func(s).lower()
        return decorated_func

    def emph(s):
        return "**{0}**".format(s)

    decorated_emph = lower_out(emph)

    decorated_emph("HI")

This example should make it clear that the decorator function is a higher-order
function, as it returns another function.  Decorator functions are a core
feature of Python and there is a special ``@`` notation that makes it easy to
apply a decorator function to the definition of another function.

.. sourcecode:: python

    In  [1]: @lower_output
        ...: def emph(s):
        ...:     return "**{0}**".format(s)
        ...:

    In [2]: emph("HI")
    Out[2]: '**hi**'

.. Can't make the @ symbol work in rst/Sphinx

Using the ``@`` notation on the line(s) above a function definition immediately
decorates the function ``emph`` as part of the function definition, removing the
need to use different name for the decorated function.

.. todo:: Add an example for making a decorator that assures that the input is lower.
.. todo:: Make an homework exercise that make both the input and output lower.

Currying
--------

Currying is another popular functional approach to partial application of
functions.  Recall that the **arity** of a function is the number of arguments
the function takes.  We can implement functions with arity higher than 1 using a
single-arith functions with technique called called **currying**, which is
illustrated below.

.. ipython:: python

    curried_pow = lambda x: lambda y: x**y
    curried_pow(2)(3)

In Python, this approach results in replacing the commas between arguments with
multiple function calls, one after the other.  

.. note::

     Functional languages like Haskell and Scala have implemented currying as a
     basic design feature and using this approach in these language is
     considered syntactically cleaner.

The advantage to curried functions is we get partial application for free.

.. ipython:: python

    exp2 = curried_pow(2)
    exp2(1)
    exp2(3)

A better approach to currying in Python is the use of a decorator.  The
``toolz`` and ``cytoolz`` libraries provide a decorator function called
``curry`` that can be used to convert any function definition into a curried
function.

.. sourcecode:: python

    In [1]: from toolz import curry

    In [2]: @curry
       ...: def pow(x,y):
       ...:     return x**y
       ...:

    In [3]: # Partial application is possible

    In [4]: exp2 = pow(2)

    In [5]: exp2(3)
    Out[5]: 8

    In [6]: # But we can also call the function with full arity

    In [7]: pow(3,3)
    Out[7]: 27

    In [8]: # this works for any number of arguments

    In [9]: @curry
       ...: def f(x,y,z):
       ...:     return z*(x + y)
       ...:

    In [10]: g = f(2)

    In [11]: g(3,4)
    Out[11]: 20

    In [12]: h = f(2,3)

    In [13]: h(4)
    Out[13]: 20

Let's implement a simple version of this currying decorator.  We will use the
``signature`` function from the ``inspect`` module to determine the arity of a
function and return a partial function when provided with less then the full
number of arguments.

.. sourcecode:: python

    In [1]: from inspect import signature

    In [2]: from functools import partial

    In [3]: def my_curry(func):
       ...:     arity = len(signature(func).parameters)
       ...:     def dec_func(*myargs):
       ...:         if len(myargs) < arity:
       ...:             return partial(func, *myargs)
       ...:         else:
       ...:             return func(*myargs)
       ...:     return dec_func
       ...:

    In [4]: @my_curry
       ...: def f(x,y,z):
       ...:     return z*(x + y)
       ...:

    In [5]: g = f(2)

    In [6]: g(3,4)
    Out[6]: 20

    In [7]: h = f(2,3)

    In [8]: h(4)
    Out[8]: 20

    In [9]: f(2,3,4)
    Out[9]: 20

.. note::

    As stated, this is a simple version of the function which ignores key Python
    features like variable and keyword unpacking, as well as default parameters.
    Be sure to use ``curry`` decorator from the ``toolz`` in practice.

What if you wanted to to supply the first and third argument for an arity 3
curried function?  In this case, we can make use of the ``flip`` function from
``toolz``.  This function calls a function with the arguments flipped.

.. ipython:: python

    from toolz.functoolz import flip
    from math import pow
    flip(pow, 2, 3)
    pow(2,3)

``flip`` works well with a curried function, as a flip will give access to the
third parameter while leaving the second parameter empty and returning a partial
function.

.. sourcecode:: python

    In [1]: from toolz import curry

    In [2]: from toolz.functoolz import flip

    In [3]: @curry
       ...: def f(x,y,z):
       ...:     return 1*x + 10*y + 100*z
       ...:

    In [4]: h = flip(f(1), 2)

     # Note that is is the middle number/parameter that is changing
    In [5]: h(3)
    Out[5]: 231

    In [6]: h(2)
    Out[6]: 221

    In [7]: h(1)
    Out[7]: 211

.. note::

    You will implement your own version of ``flip`` in the exercises.


Other useful curried functions from ``toolz``
---------------------------------------------

Many of the functions from the ``toolz`` library have been designed with
currying in mind.  Furthermore, curried versions of most functions can be
imported from ``toolz.curried``.

One example such a function is ``get``, which can be used to get one more more
entries from a row of a table.

.. ipython:: python

    from toolz.curried import get

    table = [[1,  2, 3], 
             [4,  5, 6], 
             [7,  8, 9],
             [10, 11,12], 
             [13, 14,15]]
    get(2, table[0])
    col1 = [get(2, row) for row in table]
    col1

``get`` also takes a list in the first position and in this case returns all of
the selected columns of the table.

.. ipython:: python

    mixed_up = [get([2, 0, 1], row) for row in table]
    mixed_up

Using the curried version of this function makes it easy to combine it with
``map``.  The final result is the ability to quickly access a selected columns
from a table.

.. ipython:: python

    list(map(get(2), table))

In the first line, we are passing the partial function ``get(2)``, which will
select the third item when applied to a row.  Then ``map`` is used to apply
``get(2)`` to each row in the matrix.  Similarly, we can make a partial
application or ``get`` by passing in a list of indices.

.. ipython:: python

    list(map(get([2,0,1]), table))

This pattern has been abstracted in the ``toolz`` library in the form of
``pluck``, where ``pluck(2, table)`` is functionally equivalent to ``map(get(2),
table)``.  Similar to combining ``map`` with ``get``, ``pluck`` is a lazy
construct that needs to be forced to completion.

.. ipython:: python

    from toolz.curried import pluck

    list(pluck([2,0,1], table))

The curried version of ``pluck`` can be used to create useful partial functions.

.. ipython:: python

    mixup_table = pluck([2,0,1])
    output = mixup_table(table)
    list(output)

Keep in mind that using ``pipe`` to combine actions on a list or table provides
a readable description of a sequence of transformations.  In particular, an
application of ``pipe`` reads in the natural direction, left-to-right.  Suppose
that we have a table of hours worked for all employees over a period of weeks
and we wish to quickly compute the number of hours worked by a particular
employee, ``Ann``.

.. ipython:: python

     hours = [["Name",  "Week", "Hours Worked"],
              ["Ann",   1,      40],
              ["Bob",   1,      55],
              ["Alice", 1,      22],
              ["Ann",   2,      45],
              ["Bob",   2,      30],
              ["Alice", 2,      32],
              ["Ann",   3,      30],
              ["Bob",   3,      50],
              ["Alice", 3,      42]]

This process can be accomplished in the following way.

1. Pluck the columns of interest from the table, namely hours worked and name.
2. Filter the new table using the name column.
3. Reduce this filtered list to the total hours worked by ``Ann``.

Separately, this can be accomplished as follows.

.. ipython:: python

    pluck_table = pluck([0, 2], hours)
    filt_table = filter(lambda r: r[0] == "Ann", pluck_table)
    tot_hour = reduce(lambda a, r: a + r[-1], filt_table, 0)
    tot_hour

Careful inspection of this solution shows the table *piping* through a series of
transformations, as illustrated in the following figure.

.. figure:: Figures/pipe_table.png
    :alt: Illustration of piping the table through a sequence of functions.

    ..

    The imperative solution *pipes* the table through series of transformations, using a temporary name to save the output of each step.

We can clean up much of the unnecessary complexity created by the temporary
variables using the ``pipe`` function along with curried versions of ``pluck``,
``filter`` and ``reduce``.

.. ipython:: python

    from toolz import pipe
    from toolz.curried import filter, pluck
    from functools import reduce, partial

    # We create a lambda around reduce to input the initial value
    tot_hours = pipe(hours,
                     pluck([0,2]),
                     filter(lambda r: r[0] == "Ann"),
                     lambda table: reduce(lambda a, r: a + r[-1], table, 0))
    tot_hours

.. note::

    Due to the fact that ``reduce`` does not treat the optional parameter
    ``initial`` as a keyword argument, we couldn't use ``partial`` or currying to
    set this value, and were forced to wrap the function in a lambda expression to
    achieve this result.


.. note::

    This is a useful when transitioning from writing imperative programs to
    writing functional programs.  Anytime that you want to write code like this:

    .. sourcecode:: python
         
        x = f(x)
        x = g(x)
        x = h(x)

    transform this pattern using ``pipe`` and curried or partial functions, as
    follows.

    .. sourcecode:: python
         
        pipe(x, 
             f, 
             g, 
             h)

Another mind-bending use of the curried functions from ``toolz`` is the curried
version of ``curry``.  In addition to being used to creating curried functions
as a when applied as a decorator, the curried ``curry`` can be applied to other
functions.  The end result is the ability to create a curried version of a
previously defined function, even the built-in Python functions.

We will illustrate by continuing the example using ``map`` and ``get(2)``.
By constructing a curried ``map``, we can now easily define a partial function
that will make a new table that contains only column 3.

.. ipython:: python

    from toolz.curried import curry
    map = curry(map)

    get_col_3 = map(get(2))
    list(get_col_3(table))


Memiozation (Optional)
----------------------

One of the problems with recursive functions, especially if they are not
tail-recursive or have not been refactored to use an accumulator, is the number
of replicated function calls that get made.  To see this, we create a decorator
function that will use a global dictionary to track the number of calls for each
unique argument.   We then apply this decorator function to a recursive function
that generates the nth `fibonacci number
<https://en.wikipedia.org/wiki/Fibonacci_number>`_.

.. ipython:: python

    call_dict = {}
    def fib_with_call_dict(n):
        call_dict[n] = call_dict.get(n, 0) + 1
        return n if n < 2 else fib_with_call_dict(n-1) + fib_with_call_dict(n-2)


    fib_with_call_dict(12)
    call_dict
    total_calls_to_fib = sum( val for val in call_dict.values())
    total_calls_to_fib

We see that, even for a small value of ``n``, we get a larger number of calls
for each of the number less than ``n``.  One solution to this problem is
**memiozation**, which involves decorating our function and using a dictionary
to remember the output of previous calls.  First, we will implement a closure
that includes a reference to a dictionary.  When ever we know the return value
for a specific argument, we will save it in our dictionary.  Furthermore, we
will query the dictionary each time our function is called, and we will
immediately return the solution if saved in the dictionary.


.. ipython:: python

    def make_fib_with_dict():
        return_dict = {}
        def fib_with_dict(n):
            # immediate return for things we know
            if n in return_dict:
                return return_dict[n]
            else:
                return_dict[n] =  output = n if n < 2 else fib_with_call_dict(n-1) + fib_with_call_dict(n-2)
                return output
        return fib_with_dict

    fib_with_dict = make_fib_with_dict()

    fib_with_dict(12)

Let's add some tooling to this function to track the number of calls that are
immediately satisfied by the dictionary return.

.. ipython:: python

    dict_calls = 0
    recursive_calls = 0
    def make_fib_with_dict():
        return_dict = {}
        def fib_with_dict(n, dict_calls, rec_calls):
            # immediate return for things we know
            if n in return_dict:
                return return_dict[n], dict_calls + 1, rec_calls
            else:
                output, dict_calls, rec_calls = (n, 0, 1) if n < 2 else [sum(a, b) for a, b in zip(fib_with_call_dict(n-1, dict_calls, rec_calls), fib_with_call_dict(n-2, dict_calls, rec_calls))]
                return output, dict_calls, rec_calls + 1
        return fib_with_dict

    fib_with_dict = make_fib_with_dict()

    fib_with_dict(12, 0, 0)

The ``toolz/cytoolz`` modules provide a ``memoize`` function that can be applied
to a function or used as a dictionary.

.. ipython:: python

    from toolz.functoolz import memoize

    # You definite don't want to call this without memoize
    def fib_print(n):
        print("Computing fib({0})".format(n))
        return n if n < 2 else fib_print(n-1) + fib_print(n-2)

    mem_fib = memoize(fib_print)

    mem_fib(12)

Note that ``memoize`` also works as a decorator.

.. sourcecode:: python

    @memoize
    def fib(n)
        return n if n < 2 else fib(n-1) + fib(n-2)

We can then check this dictionary and
immediately return a value that was previously calculated.  Since we need to
mutate the dictionary, it will be defined as an external local variable and
declared using the ``nonlocal`` statement in the inner function.


.. ipython:: python

    def memioze(func):
        return_values = {}
        def dec_func(n):
            nonlocal return_values
            if n in return_values:
                return return_values[n]
            else:
                output = func(n)
                return_values[n] = output
                return output
            return_values[n]
        return dec_func
   
   
    @call_dict
    @memioze
    def fib(n):
        return n if n < 2 else fib(n-1) + fib(n-2)
   
    call_dict = {}
    fib(12)
    call_dict

.. todo:  Implement all of the following (possibly in the exercises)
..   T excepts(exc, func[, handler]) 	A wrapper around a function to catch exceptions and dispatch to a handler.
..   H flip 	Call the function call with the arguments flipped
..   H identity(x) 	Identity function.
.. todo:: Other ideas: reducers and transducers from clojure.
