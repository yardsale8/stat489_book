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

.. question:: files_ex_1
   :number: 1

   .. tabbed:: q1

        .. tab:: Question

            The following sample file called ``studentdata.txt`` contains one line for each student in an imaginary class.  The
            student's name is the first thing on each line, followed by some exam scores.
            The number of scores might be different for each student.

            .. datafile:: studentdata.txt

                joe 10 15 20 30 40
                bill 23 16 19 22
                sue 8 22 17 14 32 17 24 21 2 9 11 17
                grace 12 28 21 45 26 10
                john 14 32 25 16 89

            Using the text file ``studentdata.txt`` write a program that creates
            a new data table that contains the names of students that have more
            than six quiz scores.


            .. actex:: ex_6_1
               :nocodelens:
               :available_files: studentdata.txt


        .. tab:: Answer

            .. activecode:: ch_files_q1answer
                :nocodelens:

                with open("studentdata.txt", "r") as f:
                     lines = [line for line in f]
                words = [line.split() for line in lines]
                new_data = [row[0] for row in words if len(row[1:]) > 6]
                new_data


.. question:: files_ex_2

   Using the text file ``studentdata.txt`` (shown in exercise 1) write a program
   that calculates the average grade for each student, and print out the
   student's name along with their average grade.  Use list comprehensions and
   lambda functions while paying attention to the levels of abstraction.

   .. actex:: ex_10_2
      :nocodelens:
      :available_files: studentdata.txt



.. question:: files_ex_3

   .. tabbed:: q3

        .. tab:: Question


            Using the text file ``studentdata.txt`` (shown in exercise 1) write
            a program that creates a new data table that contains the students'
            names along with the minimum and maximum score for each student.



            .. actex:: ex_6_3
               :nocodelens:
               :available_files: studentdata.txt


        .. tab:: Answer

            .. activecode:: ch_files_q3answer
                :nocodelens:

                with open("studentdata.txt", "r") as f:
                    table = [line.split() for line in f]
                process_row = lambda row: (row[0], max(row), min(row))
                new_table = [process_row(row) for row in table]
                new_table

.. question:: files_ex_4

    `SeanLahman.com
    <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_
    provides a database of baseball statistics.  Download, unzip and extract the
    file titled **Batting.csv**.

    Write each of the following functions and apply them to the related task.  Each
    function should consist of a lambda expression and list comprehension.  You will
    need to use the following function in your program.

    .. sourcecode:: python

        def read_csv(filename, delimiter=','):
            from csv import reader
            with open(filename) as infile:
                inreader = reader(infile)
                table = [row for row in reader]
            return table

    1.  Write a function that takes a year and table of batting data as input
        and returns the average number of runs scored in that year.  Call
        this function **average_runs_year**.
    2.  Write a function takes a list of years and a table of batting data and
        returns of list of tuples of the form `(year, averages_runs)`.  Call
        this function **average_runs_years** Use a list comprehension
        and the function from the last step.
    3.  Write a program that includes the above functions and reads
        **Batting.csv** and compute the average number of runs for the
        following years: 1900, 1910, ..., 2000, 2010.  Assume that the
        Batting.csv file is the same directory as your program.

.. question:: files_ex_5

    Determine the time complexity of each of the functions the last question
    (read_csv, average_runs_year, average_runs_years).


.. question:: files_ex_6

    Download, unzip and extract the file titled **Salaries.csv** and
    **AllstarFull.csv** from `seanlahman.com <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_
    .

    Write a program that computes the average salary of all players in the all
    star game in 2010.

.. question:: files_ex_7

    Download, unzip and extract the file titled **Salaries.csv** and
    **Batting.csv**.  from `seanlahman.com <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_

    Write a program that computes the current salary of the player with the
    highest batting average in the last 5 years. 

.. question:: files_ex_8

    Download, unzip and extract the file titled **Master.csv** and
    **BattingPost.csv**.  from `seanlahman.com <http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip>`_

    Write a program that computes the total runs scored in the post season by
    all players from Minnesota (all time). 
