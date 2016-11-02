##########################
A whirlwind tour to sqlite
##########################

Just as a quick refresher.

Codes from https://docs.python.org/2/library/sqlite3.html

.. contents:: `Contents`
   :depth: 2
   :local:


Beginning
=========

.. code:: python

    import sqlite3
    from IPython.display import display
    from pandas import DataFrame as DF

.. code:: python

    def mydisp(arg1):
        display(DF(arg1))

.. code:: python

    conn = sqlite3.connect('example.db')
    
    c = conn.cursor()
    
    c.execute('''DROP TABLE IF EXISTS stocks''')
    
    # Create table
    c.execute('''CREATE TABLE stocks
                 (date text, trans text, symbol text, qty real, price real)''')
    
    # Insert a row of data
    c.execute("INSERT INTO stocks VALUES ('2006-01-05','BUY','RHAT',100,35.14)")
    
    # Save (commit) the changes
    conn.commit()
    
    # We can also close the connection if we are done with it.
    # Just be sure any changes have been committed or they will be lost.
    conn.close()

.. code:: python

    whos


.. parsed-literal::
    :class: myliteral

    Variable   Type          Data/Info
    ----------------------------------
    DF         type          <class 'pandas.core.frame.DataFrame'>
    c          Cursor        <sqlite3.Cursor object at 0x7f8f7d8af1f0>
    conn       Connection    <sqlite3.Connection object at 0x7f8f7cd25940>
    display    function      <function display at 0x7f8faffaded8>
    mydisp     function      <function mydisp at 0x7f8f7d8ad938>
    sqlite3    module        <module 'sqlite3' from '/<...>.7/sqlite3/__init__.pyc'>


Insert data
===========

-  use ``?`` syntax, not ``%s`` printf syntax (SQL Injection threat)

.. code:: python

    conn = sqlite3.connect('example.db')
    c = conn.cursor()

.. code:: python

    # Do this instead
    t = ('RHAT',)
    c.execute('SELECT * FROM stocks WHERE symbol=?', t)
    print c.fetchone()
    
    # Larger example that inserts many records at a time
    purchases = [('2006-03-28', 'BUY', 'IBM', 1000, 45.00),
                 ('2006-04-05', 'BUY', 'MSFT', 1000, 72.00),
                 ('2006-04-06', 'SELL', 'IBM', 500, 53.00),
                ]
    c.executemany('INSERT INTO stocks VALUES (?,?,?,?,?)', purchases)


.. parsed-literal::
    :class: myliteral

    (u'2006-01-05', u'BUY', u'RHAT', 100.0, 35.14)




.. parsed-literal::
    :class: myliteral

    <sqlite3.Cursor at 0x7f8f7cc4e730>



Get data
========

To retrieve data after executing a SELECT statement, you can either 1.
treat the cursor as an iterator, 2. call the cursor’s ``fetchone()``
method to retrieve a single matching row, or 3. call ``fetchall()`` to
get a list of the matching rows.

.. code:: python

    # iterator form
    for row in c.execute('SELECT * FROM stocks ORDER BY price'):
        print row


.. parsed-literal::
    :class: myliteral

    (u'2006-01-05', u'BUY', u'RHAT', 100.0, 35.14)
    (u'2006-03-28', u'BUY', u'IBM', 1000.0, 45.0)
    (u'2006-04-06', u'SELL', u'IBM', 500.0, 53.0)
    (u'2006-04-05', u'BUY', u'MSFT', 1000.0, 72.0)


.. code:: python

    # fetch all form
    c.execute('SELECT * FROM stocks ORDER BY price').fetchall()




.. parsed-literal::
    :class: myliteral

    [(u'2006-01-05', u'BUY', u'RHAT', 100.0, 35.14),
     (u'2006-03-28', u'BUY', u'IBM', 1000.0, 45.0),
     (u'2006-04-06', u'SELL', u'IBM', 500.0, 53.0),
     (u'2006-04-05', u'BUY', u'MSFT', 1000.0, 72.0)]



Row factory
===========

-  to use dict like syntx

.. code:: python

    def dict_factory(cursor, row):
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d
    
    con = sqlite3.connect(":memory:")
    con.row_factory = dict_factory
    cur = con.cursor()
    cur.execute("select 1 as a")
    print cur.fetchone()["a"]


.. parsed-literal::
    :class: myliteral

    1


iterdump
========

.. code:: python

    # Convert file existing_db.db to SQL dump file dump.sql
    import sqlite3, os
    
    con = sqlite3.connect('example.db')
    with open('dump.sql', 'w') as f:
        for line in con.iterdump():
            f.write('%s\n' % line)

.. code:: python

    %%bash
    cat dump.sql


.. parsed-literal::
    :class: myliteral

    BEGIN TRANSACTION;
    CREATE TABLE stocks
                 (date text, trans text, symbol text, qty real, price real);
    INSERT INTO "stocks" VALUES('2006-01-05','BUY','RHAT',100.0,35.14);
    COMMIT;


Cursor object
=============

https://docs.python.org/2/library/sqlite3.html#cursor-objects

.. code:: python

    con = sqlite3.connect(":memory:")
    cur = con.cursor()
    cur.execute("create table people (name_last, age)")
    
    who = "Yeltsin"
    age = 72
    
    # This is the qmark style:
    cur.execute("insert into people values (?, ?)", (who, age))
    
    # And this is the named style:
    cur.execute("select * from people where name_last=:who and age=:age", {"who": who, "age": age})
    
    print cur.fetchone()


.. parsed-literal::
    :class: myliteral

    (u'Yeltsin', 72)


.. code:: python

    class IterChars:
        def __init__(self):
            self.count = ord('a')
    
        def __iter__(self):
            return self
    
        def next(self):
            if self.count > ord('z'):
                raise StopIteration
            self.count += 1
            return (chr(self.count - 1),) # this is a 1-tuple
    
    con = sqlite3.connect(":memory:")
    cur = con.cursor()
    cur.execute("create table characters(c)")
    
    theIter = IterChars()
    cur.executemany("insert into characters(c) values (?)", theIter)
    
    cur.execute("select c from characters")
    print cur.fetchall()


.. parsed-literal::
    :class: myliteral

    [(u'a',), (u'b',), (u'c',), (u'd',), (u'e',), (u'f',), (u'g',), (u'h',), (u'i',), (u'j',), (u'k',), (u'l',), (u'm',), (u'n',), (u'o',), (u'p',), (u'q',), (u'r',), (u's',), (u't',), (u'u',), (u'v',), (u'w',), (u'x',), (u'y',), (u'z',)]


.. code:: python

    con = sqlite3.connect(":memory:")
    cur = con.cursor()
    cur.executescript("""
        create table person(
            firstname,
            lastname,
            age
        );
    
        create table book(
            title,
            author,
            published
        );
    
        insert into book(title, author, published)
        values (
            'Dirk Gently''s Holistic Detective Agency',
            'Douglas Adams',
            1987
        );
        """)
    cur.fetchall()




.. parsed-literal::
    :class: myliteral

    []



Row objects
===========

.. code:: python

    conn = sqlite3.connect(":memory:")
    c = conn.cursor()
    c.execute('''create table stocks
    (date text, trans text, symbol text,
     qty real, price real)''')
    c.execute("""insert into stocks
              values ('2006-01-05','BUY','RHAT',100,35.14)""")
    conn.commit()
    c.close()

.. code:: python

    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute('select * from stocks')
    
    r = c.fetchone()
    type(r)
    
    r
    
    len(r)
    
    r[2]
    
    r.keys()
    
    r['qty']
    
    for member in r:
        print member



.. parsed-literal::
    :class: myliteral

    2006-01-05
    BUY
    RHAT
    100.0
    35.14


