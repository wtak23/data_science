Advanced Latex Mathematics on Sphinx (``cs_rst.math_part2.rst``)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bunch of stuffs from https://en.wikibooks.org/wiki/LaTeX/Advanced_Mathematics

i wanted to see what renders correctly.

http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference

.. raw:: html

    <style> .red {color:red} </style>

.. role:: red

.. note::

    Stuffs that didn't render will appear :red:`red`

    

#########################
Some self-notes I created
#########################
*************************
bold for lower-case greek
*************************
- use ``\boldsymbol`` to bold lower greek letters (``\mathbf`` doesn't do it)::

    \mathbf{\beta}\\
    \boldsymbol{\beta}

.. math::

    \mathbf{\beta}\\
    \boldsymbol{\beta}

*********************
Defining own function
*********************
I got this on top or the rst file. Then i can use them anywhere in the current rst file (cross-file support seems non-existent).

.. code-block:: latex

    .. math:: 

        \DeclareMathOperator*{\argmax}{arg\,max}
        \DeclareMathOperator*{\argmin}{arg\,min}
        \newcommand{\mybeta}{\boldsymbol{\beta}}
        \newcommand{\bx}{\boldsymbol{x}}
        \newcommand{\bb}[2]{\argmax_{#1}\ell(#1,#2)}


.. math:: 

    \DeclareMathOperator*{\argmax}{arg\,max}
    \DeclareMathOperator*{\argmin}{arg\,min}
    \newcommand{\mybeta}{\boldsymbol{\beta}}
    \newcommand{\bx}{\boldsymbol{x}}
    \newcommand{\bb}[2]{\argmax_{#1}\ell(#1,#2)}


**Default alignment: flush right**

.. code-block:: latex
    
    \argmin_\mybeta \frac{1}{n}\sum_{i=1}^n \ell(\bx_i,\mybeta) 
        + \lambda \Psi(\mybeta)
    \\
    \bb{\mybeta}{\bx}

.. math::

    \argmin_\mybeta \frac{1}{n}\sum_{i=1}^n \ell(\bx_i,\mybeta) 
        + \lambda \Psi(\mybeta)
    \\
    \bb{\mybeta}{\bx}

**Flush left**: Use ``\beglin{align}`` env to align to right (centering? not sure how at the moment)

.. code-block:: latex
    
    \begin{align}
        &\argmin_\mybeta \frac{1}{n}\sum_{i=1}^n \ell(\bx_i,\mybeta) 
            + \lambda \Psi(\mybeta)
        \\
        &\bb{\mybeta}{\bx}
    \end{align}

.. math::

    \begin{align}
        &\argmin_\mybeta \frac{1}{n}\sum_{i=1}^n \ell(\bx_i,\mybeta) 
            + \lambda \Psi(\mybeta)
        \\
        &\bb{\mybeta}{\bx}
    \end{align}

#########
Equations
#########
::

    .. math::

        \begin{equation} 
         f(x)=(x+a)(x+b)
        \end{equation}

    .. important:: **HMMM....NEEDED THESE BLOCK TO BE SEPARARTE....**

    .. math::

        \begin{align}
                B'&=-\nabla \times E,\\
                E'&=\nabla \times B - 4\pi j,
        \end{align}


.. math::

    \begin{equation} 
     f(x)=(x+a)(x+b)
    \end{equation}

.. important:: **HMMM....NEEDED THESE BLOCK TO BE SEPARARTE....**

.. math::

    \begin{align}
            B'&=-\nabla \times E,\\
            E'&=\nabla \times B - 4\pi j,
    \end{align}

The above two block, together, screwed up

.. attention:: This is an intentional screw-up for demonstration purpose. No worries.

    :: 

        .. math::

            \begin{equation} 
             f(x)=(x+a)(x+b)
            \end{equation}

            begin{align}
                        B'&=-\nabla \times E,\\
                        E'&=\nabla \times B - 4\pi j,
            \end{align}

    .. math::

        \begin{equation} 
         f(x)=(x+a)(x+b)
        \end{equation}

        begin{align}
            B'&=-\nabla \times E,\\
            E'&=\nabla \times B - 4\pi j,
        \end{align}

##################
Vertical alignment
##################
.. code-block:: latex
    :linenos:

     A \overset{!}{=} B; A \stackrel{!}{=} B

     \\

     \lim_{x\to 0}{\frac{e^x-1}{2x}}
     \overset{\left[\frac{0}{0}\right]}{\underset{\mathrm{H}}{=}}
     \lim_{x\to 0}{\frac{e^x}{2}}={\frac{1}{2}}

     \\

     z = \overbrace{
       \underbrace{x}_\text{real} + i
       \underbrace{y}_\text{imaginary}
      }^\text{complex number}

    \\

    y = a + f(\underbrace{b x}_{
                       \ge 0 \text{ by assumption}}) 
      = a + f(\underbrace{b x}_{
             \mathclap{\ge 0 \text{ by assumption}}})

    \\

    A \xleftarrow{\text{this way}} B 
      \xrightarrow[\text{or that way}]{ } C

.. math::

     A \overset{!}{=} B; A \stackrel{!}{=} B

     \\

     \lim_{x\to 0}{\frac{e^x-1}{2x}}
     \overset{\left[\frac{0}{0}\right]}{\underset{\mathrm{H}}{=}}
     \lim_{x\to 0}{\frac{e^x}{2}}={\frac{1}{2}}

     \\

     z = \overbrace{
       \underbrace{x}_\text{real} + i
       \underbrace{y}_\text{imaginary}
      }^\text{complex number}

    \\

    y = a + f(\underbrace{b x}_{
                       \ge 0 \text{ by assumption}}) 
      = a + f(\underbrace{b x}_{
             \mathclap{\ge 0 \text{ by assumption}}})

    \\

    A \xleftarrow{\text{this way}} B 
      \xrightarrow[\text{or that way}]{ } C

::

    .. math::
        
        \begin{gather}
         a \xleftrightarrow[under]{over} b\\
         A \xLeftarrow[under]{over} B\\
         B \xRightarrow[under]{over} C\\
         C \xLeftrightarrow[under]{over} D\\
         D \xhookleftarrow[under]{over} E\\
         E \xhookrightarrow[under]{over} F\\
         F \xmapsto[under]{over} G\\
        \end{gather}

.. math::
    
    \begin{gather}
     a \xleftrightarrow[under]{over} b\\
     A \xLeftarrow[under]{over} B\\
     B \xRightarrow[under]{over} C\\
     C \xLeftrightarrow[under]{over} D\\
     D \xhookleftarrow[under]{over} E\\
     E \xhookrightarrow[under]{over} F\\
     F \xmapsto[under]{over} G\\
    \end{gather}


###########
More aligns
###########
::

    \begin{align}
     f(x) &= x^4 + 7x^3 + 2x^2  \\
          &\qquad {} + 10x + 12
    \end{align}

.. math::

    \begin{align}
     f(x) &= x^4 + 7x^3 + 2x^2  \\
          &\qquad {} + 10x + 12
    \end{align}

::

    \begin{align*}
     f(x)  &= a x^2+b x +c   &   g(x)  &= d x^3 \\
     f'(x) &= 2 a x +b       &   g'(x) &= 3 d x^2
    \end{align*}

.. math::

    \begin{align*}
     f(x)  &= a x^2+b x +c   &   g(x)  &= d x^3 \\
     f'(x) &= 2 a x +b       &   g'(x) &= 3 d x^2
    \end{align*}

##############################
Braces spanning multiple lines
##############################
::

    \begin{align}
     f(x) &= \pi \left\{ x^4 + 7x^3 + 2x^2 \right.\nonumber\\
     &\qquad \left. {} + 10x + 12 \right\}
    \end{align}

.. math::

    \begin{align}
     f(x) &= \pi \left\{ x^4 + 7x^3 + 2x^2 \right.\nonumber\\
     &\qquad \left. {} + 10x + 12 \right\}
    \end{align}

::

    \begin{align}
     A &=     \left(\int_t XXX       \right.\nonumber\\
       &\qquad \left.\vphantom{\int_t} YYY \dots \right)
    \end{align}

.. math::

    \begin{align}
     A &=     \left(\int_t XXX       \right.\nonumber\\
       &\qquad \left.\vphantom{\int_t} YYY \dots \right)
    \end{align}


#######################################
Aligning braces for piecewise functions
#######################################
::

    f(x) = \left\{
      \begin{array}{lr}
        x^2 & : x < 0\\
        x^3 & : x \ge 0
      \end{array}
    \right.

.. math::

    f(x) = \left\{
      \begin{array}{lr}
        x^2 & : x < 0\\
        x^3 & : x \ge 0
      \end{array}
    \right.

#########################
The **cases** environment
#########################
::

    u(x) = 
      \begin{cases} 
       \exp{x} & \text{if } x \geq 0 \\
       1       & \text{if } x < 0
      \end{cases}

.. math::

    u(x) = 
      \begin{cases} 
       \exp{x} & \text{if } x \geq 0 \\
       1       & \text{if } x < 0
      \end{cases}

::

    a =
      \begin{dcases}
        \int x\, \mathrm{d} x\\
        b^2
      \end{dcases}

..  warning:: ``\begin{dcases}`` doesn't work


####################
More exotic examples
####################
::

    \begin{equation}
     \left.\begin{aligned}
            B'&=-\partial \times E,\\
            E'&=\partial \times B - 4\pi j,
           \end{aligned}
     \right\}
     \qquad \text{Maxwell's equations}
    \end{equation}

.. math::

    \begin{equation}
     \left.\begin{aligned}
            B'&=-\partial \times E,\\
            E'&=\partial \times B - 4\pi j,
           \end{aligned}
     \right\}
     \qquad \text{Maxwell's equations}
    \end{equation}

::

    \begin{alignat}{2}
     \sigma_1 &= x + y  &\quad \sigma_2 &= \frac{x}{y} \\   
     \sigma_1' &= \frac{\partial x + y}{\partial x} & \sigma_2' 
        &= \frac{\partial \frac{x}{y}}{\partial x}
    \end{alignat}

.. math::

    \begin{alignat}{2}
     \sigma_1 &= x + y  &\quad \sigma_2 &= \frac{x}{y} \\   
     \sigma_1' &= \frac{\partial x + y}{\partial x} & \sigma_2' 
        &= \frac{\partial \frac{x}{y}}{\partial x}
    \end{alignat}


::

    \begin{gather*}
    a_0=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\,\mathrm{d}x\\[6pt]
    \begin{split}
    a_n=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\cos nx\,\mathrm{d}x=\\
    =\frac{1}{\pi}\int\limits_{-\pi}^{\pi}x^2\cos nx\,\mathrm{d}x
    \end{split}\\[6pt]
    \begin{split}
    b_n=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\sin nx\,\mathrm{d}x=\\
    =\frac{1}{\pi}\int\limits_{-\pi}^{\pi}x^2\sin nx\,\mathrm{d}x
    \end{split}\\[6pt]
    \end{gather*}

.. math::

    \begin{gather*}
    a_0=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\,\mathrm{d}x\\[6pt]
    \begin{split}
    a_n=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\cos nx\,\mathrm{d}x=\\
    =\frac{1}{\pi}\int\limits_{-\pi}^{\pi}x^2\cos nx\,\mathrm{d}x
    \end{split}\\[6pt]
    \begin{split}
    b_n=\frac{1}{\pi}\int\limits_{-\pi}^{\pi}f(x)\sin nx\,\mathrm{d}x=\\
    =\frac{1}{\pi}\int\limits_{-\pi}^{\pi}x^2\sin nx\,\mathrm{d}x
    \end{split}\\[6pt]
    \end{gather*}


###############
Boxed equations
###############
::
    
    \begin{equation}
     \boxed{x^2+y^2 = z^2}
    \end{equation}

.. math::

    \begin{equation}
     \boxed{x^2+y^2 = z^2}
    \end{equation}

#############################
Custom operator (ah, argmax!)
#############################
The ``*`` version sets the underscored option underneath.

.. note:: Whoa! ``\DeclareMathOperator`` works! I didn't expect that!

    The following declaration must come before it is used. Inter-document support appears to be missing.

    So put this at the top of ``*.rst`` file that is going to rely on this equation a lot.

    ``.. math:: \DeclareMathOperator*{\argmax}{arg\,max}``
    ``.. math:: \DeclareMathOperator*{\argmin}{arg\,min}``

::
    \operatorname{arg\,max}_a f(a) \\
    \operatorname*{arg\,max}_b f(b)

.. math::

    \operatorname{arg\,max}_a f(a) \\
    \operatorname*{arg\,max}_b f(b)


This one relies on the predefined ``\argmax,\argmin`` function (definition at top of this current source file)

::

    \argmax_\beta \ell(\beta,x) + \lambda \Psi(\beta) \\
    \argmin_\beta \ell(\beta,x) + \lambda \Psi(\beta)

.. math::

    
    \argmax_\beta \ell(\beta,x) + \lambda \Psi(\beta) \\
    \argmin_\beta \ell(\beta,x) + \lambda \Psi(\beta)


###################
Advanced formatting
###################
https://en.wikibooks.org/wiki/LaTeX/Advanced_Mathematics#Advanced_formatting

******
Limits
******
.. note::  Use ``\nolimits`` and ``\limits`` to control **inline** or **displayline**


.. code-block:: latex
    
    \begin{equation}
      \lim_{a\to \infty} \tfrac{1}{a}
    \end{equation}


.. math::

    \begin{equation}
      \lim_{a\to \infty} \tfrac{1}{a}
    \end{equation}

.. code-block:: latex

    \begin{equation}
      \lim\nolimits_{a\to \infty} \tfrac{1}{a}
    \end{equation}

.. math::

    \begin{equation}
      \lim\nolimits_{a\to \infty} \tfrac{1}{a}
    \end{equation}

.. code-block:: latex

    \begin{equation}
      \int_a^b x^2  \mathrm{d} x
    \end{equation}

.. math::
    
    \begin{equation}
      \int_a^b x^2  \mathrm{d} x
    \end{equation}

.. code-block:: latex

    \begin{equation}
      \int\limits_a^b x^2  \mathrm{d} x
    \end{equation}

.. math::

    \begin{equation}
      \int\limits_a^b x^2  \mathrm{d} x
    \end{equation}

.. note:: Use ``\underset`` to create one-sided limit    

.. code-block:: latex

    \begin{equation}
      \lim_{a \underset{>}{\to} 0} \frac{1}{a}
    \end{equation}

.. math::

    \begin{equation}
      \lim_{a \underset{>}{\to} 0} \frac{1}{a}
    \end{equation}

****************************
Subscripts and supterscripts
****************************
.. code-block:: latex

    \begin{equation}
      \sum\nolimits' C_n
    \end{equation}

.. math::

    \begin{equation}
      \sum\nolimits' C_n
    \end{equation}

.. --------------------------..    
.. code-block:: latex

    \begin{equation}
      \sum_{n=1}\nolimits' C_n
    \end{equation}

.. math::

    \begin{equation}
      \sum_{n=1}\nolimits' C_n
    \end{equation}

.. --------------------------..    
.. code-block:: latex

    \begin{equation}
      \sideset{}{'}\sum_{n=1}C_n
    \end{equation}

.. math::

    \begin{equation}
      \sideset{}{'}\sum_{n=1}C_n
    \end{equation}

.. --------------------------..    
.. code-block:: latex

    \begin{equation}
      \sideset{_a^b}{_c^d}\sum
    \end{equation}

.. math::

    \begin{equation}
      \sideset{_a^b}{_c^d}\sum
    \end{equation}

.. --------------------------..    
.. code-block:: latex

    \begin{equation}
      {\sum\limits_{n=1} }'C_n
    \end{equation}    

.. math::
    
    \begin{equation}
      {\sum\limits_{n=1} }'C_n
    \end{equation}    

.. --------------------------..    
.. code-block:: latex

    \begin{equation}
      \prod_{\substack{
                1\le i \le n\\
                1\le j \le m}}
         M_{i,j}
    \end{equation}    

.. math::
    
    \begin{equation}
      \prod_{\substack{
                1\le i \le n\\
                1\le j \le m}}
         M_{i,j}
    \end{equation}    

##################
Changing font size
##################
https://en.wikibooks.org/wiki/LaTeX/Advanced_Mathematics#Changing_font_size

Predefined sizes for math elements:

.. csv-table:: 
    :header: Size command, Description
    :widths: 20,70
    :delim: |

    ``\displaystyle``        |   Size for equations in display mode
    ``\textstyle``           |   Size for equations in text mode
    ``\scriptstyle``         |   Size for first sub/superscripts
    ``\scriptscriptstyle``   |   Size for subsequent sub/superscripts

Here, at each **frac** level, fontsize gets smaller (ends at ``scriptsyle``)

.. code-block:: latex

    \begin{equation}
      x = a_0 + \frac{1}{a_1 + \frac{1}{a_2 + \frac{1}{a_3 + a_4}}}
    \end{equation}

.. math::

    \begin{equation}
      x = a_0 + \frac{1}{a_1 + \frac{1}{a_2 + \frac{1}{a_3 + a_4}}}
    \end{equation}

Use ``\displaystyle`` to keep fontsize the same everywhere

.. code-block:: latex
    
    \begin{equation}
      x = a_0 + \frac{1}{\displaystyle a_1 
              + \frac{1}{\displaystyle a_2 
              + \frac{1}{\displaystyle a_3 + a_4}}}
    \end{equation}

.. math::
    
    \begin{equation}
      x = a_0 + \frac{1}{\displaystyle a_1 
              + \frac{1}{\displaystyle a_2 
              + \frac{1}{\displaystyle a_3 + a_4}}}
    \end{equation}
    