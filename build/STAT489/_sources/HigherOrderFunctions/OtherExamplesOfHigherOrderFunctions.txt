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
In this section, we will implement some of the common higher-order functions

that are common in functional programming.  All of these functions are
implemented in the Python libraries ``toolz`` and ``cytoolz`` under the sub
module titled ``functoolz``.  These two modules have exactly the same
functionality, but the ``cytoolz`` functions are implemented with in ``cython``,
which means that you get better performance.   Unfortunately, you need a ``C``
compiler to install ``cytoolz``, but ``toolz`` also has decent performance
approximately equal in performance to similar tools from the standard library.

.. note::

    You can install these packages using ``pip`` from the command line, as shown
    below,

    .. sourcecode:: python
        
         pip install toolz cytoolz

    or you can run this command inside a jupyter console or notebook.

    .. sourcecode:: python

         !pip install toolz cytoolz

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
replication of one or more arguments is the use of a partial function.

.. ipython:: python

    from functools import partial

    my_apply_tax = partial(apply_tax, 1.065)
    my_apply_tax(1)
    my_apply_tax(4.55)

This solution provides the best of both worlds.  First, we don't need to use the
more complex nested functions; but we can still save the replication of the
``rate`` parameter in each function call.

So what is happening here.   Clearly ``partial`` is a higher-order function, as
it returns another function.  One way to think about this is the ``partial``
call is making a new function with ``rate`` fixed at 1.065, leaving the ``cost``
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


Decorator Functions
-------------------

A decorator function is a function that creates a *wrapper* around another
function.  The outer function calls the original function and then changes or
*decorates* the input or output.

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

Using the ``@`` notation immediately decorates the function ``emph`` as part of
the function definition, removing the need to use different name for the
decorated function.

.. todo:: Add an example for making a decorator that assures that the input is lower.
.. todo:: Make an homework exercise that make both the input and output lower.

Currying
--------

Currying is another popular functional approach to partial application of
functions.  The **arity** of a function is the number of arguments the function
takes.  We can implement functions with arity higher than 1 using a using
single-arith functions with technique called called **currying**, which is
illustrated below.

.. ipython:: python

    curried_pow = lambda x: lambda y: x**y
    curried_pow(2)(3)

In Python, this approach results in replacing the commons between arguments with
multiple function calls, one after the other.  

.. note::

     Functional languages like Haskell and Scala have implemented currying as a
     basic design feature and using this approach in these language is
     syntactically cleaner.

The advantage to this approach is we get partial application for free.

.. ipython:: python

    exp2 = curried_pow(2)
    exp2(1)
    exp2(3)

A better approach to currying in Python is the use of a decorator.  The
``toolz`` and ``cytoolz`` packages provide such a decorator function called
``curry`` that can be used to convert any function to a curried function.

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
    Be sure to use the ``toolz`` decorator in practice.

What if you wanted to to supply the first and third argument for an arity 3
curryied function?  In this case, we can make use of the ``flip`` function from
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

    In [5]: h(3)
    Out[5]: 231

    In [6]: h(2)
    Out[6]: 221

    In [7]: h(1)
    Out[7]: 211

You will implement your own version of ``flip`` in the exercises.

Memiozation
-----------

One of the problems with recursive functions, especially if they are not
tail-recursive or have not been refactored to use an accumulator, is the number
of replicated function calls that get made.  To see this, we create a decorator
function that will use a global dictionary to track the number of calls for each
unique argument.   We then apply this decorator function to a recursive function
ther generates the nth `fibonacci number
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

The ``toolz/cytoolz`` modules provide
a ``memoize`` function that can be applied to a function or used as a
dictionary.

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
``reversed`` to iterate through the list back to front.

.. ipython:: python

    def compose_imperative(funcs):
        def new_func(item):
            output = item
            for func in reversed(funcs):
                output = func(output)
            return output
        return new_func

    clean_up = compose_imperative([remove_punc, make_lower_case, fix_whitespace])
    clean_up(s)

The fact that we are using the accumulator pattern indicates that this operation
is a reduction.  Creating this function adheres to the DRY principle, as we
won't need to explicitly compose functions over and over in our code.  In fact,
we don't even need to give this new function a name, but can call it anonymously
as follows.

.. ipython:: python

    compose_imperative([remove_punc, 
                        make_lower_case, 
                        fix_whitespace])(s)

Now that we have recognized that this process is a reduction, we refactor the
code accordingly.


.. ipython:: python
    from functools import reduce

    def my_compose(funcs):
        def new_func(item):
            return reduce(lambda acc, next_func: next_func(acc), reversed(funcs), item)
        return new_func

    my_compose([remove_punc, 
                make_lower_case, 
                fix_whitespace])(s)

We can clean up ``my_compose`` by using the ``*`` operator instead of requiring
the user input a list.  This way the ``my_compose`` function will work with any
number of functions, which will be entered as regular arguments.

.. ipython:: python

    from functools import reduce

    def my_compose(*funcs):
        def new_func(item):
            return reduce(lambda acc, next_func: next_func(acc), funcs, item)
        return new_func

    my_compose(remove_punc, make_lower_case, fix_whitespace)(s)

.. admonition:: See also

     An exercise at the end of the chapter involves creating a ``left_comp`` composition
     operator that applies the functions from left to right, which is similar to
     `Clojures -> thread-first macro.
     <https://clojuredocs.org/clojure.core/-%3E>`_

.. note:: 

    For a better approach to cleaning up Twitter data, see `Marco
    Bonzanini's blog
    <https://marcobonzanini.com/2015/03/09/mining-twitter-data-with-python-part-2/>`_,
    which is shared under `Creative Commons Attribution 4.0 International License. <http://creativecommons.org/licenses/by/4.0/>`_.

.. todo:: design ``juxt`` see https://clojuredocs.org/clojure.core/juxt
.. todo:: design complement see http://clojure.github.io/clojure/clojure.core-api.html#clojure.core/complement
.. todo:: design ``curry`` 
.. todo:: include discussion on toolz and cytoolz, including performance and a discussion on cython(?)
.. todo:  Implement all of the following (possibly in the exercises)
..   H complement(func) 	Convert a predicate function to its logical complement.
..   I compose(*funcs) 	Compose functions to operate in series. DONE
..   I curry(*args, **kwargs) 	Curry a callable function
..   H do(func, x) 	Runs func on x, returns x
..   T excepts(exc, func[, handler]) 	A wrapper around a function to catch exceptions and dispatch to a handler.
..   H flip 	Call the function call with the arguments flipped
..   H identity(x) 	Identity function.
..   H juxt(*funcs) 	Creates a function that calls several functions with the same arguments
..   T memoize 	Cache a function’s result for speedy future evaluation
..   T pipe(data, *funcs) 	Pipe a value through a sequence of functions
..   T thread_first(val, *forms) 	Thread value through a sequence of functions/forms
..   H thread_last(val, *forms) 	Thread value through a sequence of functions/forms
.. todo:: Other ideas: reducers and transducers from clojure.
