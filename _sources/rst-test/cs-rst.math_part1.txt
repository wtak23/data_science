Latex mathematics on sphinx (``cs-rst.math_part1.rst``)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bunch of stuffs to see what renders from: https://en.wikibooks.org/wiki/LaTeX/Mathematics

#######
Symbols
#######
.. code-block:: latex

    + - = ! / ( ) [ ] < > | ' :                     \\
    \forall x \in X, \quad \exists y \leq \epsilon

.. math::

    + - = ! / ( ) [ ] < > | ' :                     \\
    \forall x \in X, \quad \exists y \leq \epsilon

#############
Greek letters
#############
.. code-block:: latex

    \alpha, \Alpha, \beta, \Beta, \gamma, \Gamma, \\
    \pi, \Pi, \phi, \varphi, \mu, \Phi

.. math::

    \alpha, \Alpha, \beta, \Beta, \gamma, \Gamma, \\
    \pi, \Pi, \phi, \varphi, \mu, \Phi


#########
Operators
#########
.. code-block:: latex
    :linenos:

    \cos (2\theta) = \cos^2 \theta - \sin^2 \theta  \\
    \lim_{x \to \infty} \exp(-x) = 0                \\
    a \bmod b                                       \\
    x \equiv a \pmod{b}                             \\
    k_{n+1} = n^2 + k_n^2 - k_{n-1}                 \\
    n^{22}                                          \\
    f(n) = n^5 + 4n^2 + 2 |_{n=17}

.. math::

    \cos (2\theta) = \cos^2 \theta - \sin^2 \theta  \\
    \lim_{x \to \infty} \exp(-x) = 0                \\
    a \bmod b                                       \\
    x \equiv a \pmod{b}                             \\
    k_{n+1} = n^2 + k_n^2 - k_{n-1}                 \\
    n^{22}                                          \\
    f(n) = n^5 + 4n^2 + 2 |_{n=17}

#######################
Fractions and Binomials
#######################
.. code-block:: latex
    :linenos:

    .. math::

        \frac{n!}{k!(n-k)!} = \binom{n}{k}      \\
        \frac{\frac{1}{x}+\frac{1}{y}}{y-z}     \\
        ^3/_7

    Take :math:`\frac{1}{2}` cup of sugar, :math:`\dots3\times\frac{1}{2}=1\frac{1}{2}`

.. math::

    \frac{n!}{k!(n-k)!} = \binom{n}{k}      \\
    \frac{\frac{1}{x}+\frac{1}{y}}{y-z}     \\
    ^3/_7

Take :math:`\frac{1}{2}` cup of sugar, :math:`\dots3\times\frac{1}{2}=1\frac{1}{2}`
 
############
Square roots
############
::

    \sqrt{\frac{a}{b}}              \\
    \sqrt[n]{1+x+x^2+x^3+\dots+x^n}

.. math::

    \sqrt{\frac{a}{b}}              \\
    \sqrt[n]{1+x+x^2+x^3+\dots+x^n}

#################
Sum and integrals
#################
.. code-block:: latex
    :linenos:

    .. math::

        \sum_{i=1}^{10} t_i                         \\
        \displaystyle\sum_{i=1}^{10} t_i            \\
        \int_0^\infty \mathrm{e}^{-x}\,\mathrm{d}x  \\
         \int\limits_a^b                            \\

        \sum_{\substack{
           0<i<m \\
           0<j<n
          }} 
         P(i,j)

.. math::

    \sum_{i=1}^{10} t_i                         \\
    \displaystyle\sum_{i=1}^{10} t_i            \\
    \int_0^\infty \mathrm{e}^{-x}\,\mathrm{d}x  \\
     \int\limits_a^b                            \\

    \sum_{\substack{
       0<i<m \\
       0<j<n
      }} 
     P(i,j)

****************
**BIG** commands
****************
.. code-block:: latex
    :linenos:

    .. math::

        \sum        \quad   \prod       \quad       \coprod    \\
        \bigoplus   \quad   \bigotimes  \quad       \bigodot   \\
        \bigcup     \quad   \bigcap     \quad       \bigoplus  \\
        \bigsqcup   \quad   \bigvee     \quad       \bigwedge  \\
        \int        \quad   \oint       \quad       \iint      \\
        \iiint      \quad   \iiiint     \quad       \idotsint

.. math::

     \sum        \quad   \prod       \quad       \coprod    \\
     \bigoplus   \quad   \bigotimes  \quad       \bigodot   \\
     \bigcup     \quad   \bigcap     \quad       \bigoplus  \\
     \bigsqcup   \quad   \bigvee     \quad       \bigwedge  \\
     \int        \quad   \oint       \quad       \iint      \\
     \iiint      \quad   \iiiint     \quad       \idotsint

###############################
Brackets, braces and delimiters
###############################
.. code-block:: latex

    .. math::

        ( a ),             [ b ],      \{ c \},             \\
        | d |,              \| e \|,    \langle f \rangle,  \\
        \lfloor g \rfloor,  \lceil h \rceil, \ulcorner i \urcorner

.. math::

    ( a ),             [ b ],      \{ c \},             \\
    | d |,              \| e \|,    \langle f \rangle,  \\
    \lfloor g \rfloor,  \lceil h \rceil, \ulcorner i \urcorner

****************
Automatic sizing
****************
.. code-block:: latex
    
    .. math::

        \left(\frac{x^2}{y^3}\right)                \\
        P\left(A=2\middle|\frac{A^2}{B}>4\right)    \\
        \left\{\frac{x^2}{y^3}\right\}              \\
        \left.\frac{x^3}{3}\right|_0^1


.. math::

    \left(\frac{x^2}{y^3}\right)                \\
    P\left(A=2\middle|\frac{A^2}{B}>4\right)    \\
    \left\{\frac{x^2}{y^3}\right\}              \\
    \left.\frac{x^3}{3}\right|_0^1

*************
Manual sizing
*************
.. code-block:: latex

    .. math::

        ( \big( \Big( \bigg( \Bigg(                             \\
        \frac{\mathrm d}{\mathrm d x} \left( k g(x) \right)     \\
        \frac{\mathrm d}{\mathrm d x} \big( k g(x) \big)

.. math::

    ( \big( \Big( \bigg( \Bigg(                             \\
    \frac{\mathrm d}{\mathrm d x} \left( k g(x) \right)     \\
    \frac{\mathrm d}{\mathrm d x} \big( k g(x) \big)

*********************
Typesetting intervals
*********************
.. code-block:: latex

    x \in [-1,1]    \\
    x \in {[-1,1]}  \\
    x \in {[{-1},1]}

.. math::

    x \in [-1,1]    \\
    x \in {[-1,1]}  \\
    x \in {[{-1},1]}

##################
Matrices and array
##################
.. warning:: This won't run (remove ``*`` and ``[r]``)

    (so can't play around with alignment of columns)

    ::

        \begin{matrix*}[r]
         -1 & 3 \\
         2 & -4
        \end{matrix*}

.. ================================================== ..

.. code-block:: latex

     \begin{matrix}
      a & b & c \\
      d & e & f \\
      g & h & i
     \end{matrix}

.. math::

     \begin{matrix}
      a & b & c \\
      d & e & f \\
      g & h & i
     \end{matrix}

.. ================================================== ..

.. code-block:: latex

     \begin{bmatrix}
      a & b & c \\
      d & e & f \\
      g & h & i
     \end{bmatrix}

.. math::

     \begin{bmatrix}
      a & b & c \\
      d & e & f \\
      g & h & i
     \end{bmatrix}

.. ================================================== ..

.. code-block:: latex

     \begin{pmatrix}
       -1 & 3 \\
       2 & -4
      \end{pmatrix}
      =
      \begin{Bmatrix}
       -1 & 3 \\
       2 & -4
      \end{Bmatrix}

.. math::

     \begin{pmatrix}
       -1 & 3 \\
       2 & -4
      \end{pmatrix}
      =
      \begin{Bmatrix}
       -1 & 3 \\
       2 & -4
      \end{Bmatrix}

.. ================================================== ..

.. code-block:: latex

     \begin{vmatrix}
       -1 & 3 \\
       2 & -4
      \end{vmatrix}
      =
      \begin{Vmatrix}
       -1 & 3 \\
       2 & -4
      \end{Vmatrix}

.. math::

     \begin{vmatrix}
       -1 & 3 \\
       2 & -4
      \end{vmatrix}
      =
      \begin{Vmatrix}
       -1 & 3 \\
       2 & -4
      \end{Vmatrix}

***************
More fancy ones
***************
.. warning:: derp, won't work

    ::

        M = \bordermatrix{~ & x & y \cr
                      A & 1 & 0 \cr
                      B & 0 & 1 \cr}

.. code-block:: latex

    A_{m,n} = 
     \begin{pmatrix}
      a_{1,1} & a_{1,2} & \cdots & a_{1,n} \\
      a_{2,1} & a_{2,2} & \cdots & a_{2,n} \\
      \vdots  & \vdots  & \ddots & \vdots  \\
      a_{m,1} & a_{m,2} & \cdots & a_{m,n} 
     \end{pmatrix}

.. math::

    A_{m,n} = 
     \begin{pmatrix}
      a_{1,1} & a_{1,2} & \cdots & a_{1,n} \\
      a_{2,1} & a_{2,2} & \cdots & a_{2,n} \\
      \vdots  & \vdots  & \ddots & \vdots  \\
      a_{m,1} & a_{m,2} & \cdots & a_{m,n} 
     \end{pmatrix}


.. code-block:: latex

    M = \begin{bmatrix}
           \frac{5}{6} & \frac{1}{6} & 0           \\[0.3em]
           \frac{5}{6} & 0           & \frac{1}{6} \\[0.3em]
           0           & \frac{5}{6} & \frac{1}{6}
         \end{bmatrix}


.. math::

    M = \begin{bmatrix}
           \frac{5}{6} & \frac{1}{6} & 0           \\[0.3em]
           \frac{5}{6} & 0           & \frac{1}{6} \\[0.3em]
           0           & \frac{5}{6} & \frac{1}{6}
         \end{bmatrix}

########################
Adding text to equations
########################
.. code-block:: latex

    50 apples \times 100 apples = lots of apples^2                          \\
    50 \text{apples} \times 100 \text{apples} = \text{lots of apples}^2     \\
    50 \text{ apples} \times 100 \text{ apples} = \text{lots of apples}^2   \\
    50 \textrm{ apples} \times 100 \textbf{ apples} = \textit{lots of apples}^2

.. math::

    50 apples \times 100 apples = lots of apples^2                          \\
    50 \text{apples} \times 100 \text{apples} = \text{lots of apples}^2     \\
    50 \text{ apples} \times 100 \text{ apples} = \text{lots of apples}^2   \\
    50 \textrm{ apples} \times 100 \textbf{ apples} = \textit{lots of apples}^2


##############################
Formatting mathematics symbols
##############################
https://en.wikibooks.org/wiki/LaTeX/Mathematics#Formatting_mathematics_symbols

.. note::

    To bold lowercase Greek or other symbols use the ``\boldsymbol`` command


.. code-block:: latex
    :linenos:

    \boldsymbol{\beta} = (\beta_1,\beta_2,\dotsc,\beta_n) \\
    \mathnormal{ABCDEF abcdef 123456}   \\
    \mathrm{ABCDEF abcdef 123456}   \\
    \mathit{ABCDEF abcdef 123456}   \\
    \mathbf{ABCDEF abcdef 123456}   \\
    \mathsf{ABCDEF abcdef 123456}   \\
    \mathtt{ABCDEF abcdef 123456}   \\
    \mathfrak{ABCDEF abcdef 123456}   \\
    \mathcal{ABCDEF abcdef 123456}   \\
    \mathbb{ABCDEF abcdef 123456}   \\
    \mathscr{ABCDEF abcdef 123456}   \\


.. math::

    \boldsymbol{\beta} = (\beta_1,\beta_2,\dotsc,\beta_n) \\
    \mathnormal{ABCDEF abcdef 123456}   \\
    \mathrm{ABCDEF abcdef 123456}   \\
    \mathit{ABCDEF abcdef 123456}   \\
    \mathbf{ABCDEF abcdef 123456}   \\
    \mathsf{ABCDEF abcdef 123456}   \\
    \mathtt{ABCDEF abcdef 123456}   \\
    \mathfrak{ABCDEF abcdef 123456}   \\
    \mathcal{ABCDEF abcdef 123456}   \\
    \mathbb{ABCDEF abcdef 123456}   \\
    \mathscr{ABCDEF abcdef 123456}   \\

*******
Accents
*******
.. code-block:: latex
    :linenos:

    a^{\prime}              \quad       a''        \\
    \hat{a}                 \quad       \bar{a}    \\
    \grave{a}               \quad       \acute{a}  \\
    \dot{a}                 \quad       \ddot{a}   \\
    \not{a}                 \quad       \mathring{a} \\
    \overrightarrow{AB}     \quad       \overleftarrow{AB} \\
    a'''                    \quad       a''''      \\
    \overline{aaa}          \quad       \check{a}  \\
    \breve{a}               \quad       \vec{a}    \\
    \dddot{a}               \quad       \ddddot{a} \\
    \widehat{AAA}           \quad       \widetilde{AAA} \\
    \stackrel\frown{AAA}                                \\
    \tilde{a}               \quad       \underline{a}

.. math::

    a^{\prime}              \quad       a''             \\
    \hat{a}                 \quad       \bar{a}         \\
    \grave{a}               \quad       \acute{a}         \\
    \dot{a}                 \quad       \ddot{a}         \\
    \not{a}                 \quad       \mathring{a}         \\
    \overrightarrow{AB}     \quad       \overleftarrow{AB}         \\
    a'''                    \quad       a''''      \\
    \overline{aaa}          \quad       \check{a}   \\
    \breve{a}               \quad       \vec{a}     \\
    \dddot{a}               \quad       \ddddot{a}  \\
    \widehat{AAA}           \quad       \widetilde{AAA} \\
    \stackrel\frown{AAA} \\
    \tilde{a}               \quad       \underline{a}

##############
Color (works!)
##############
``\mathbin`` environment used since ``-`` is a binary operator (see `link <https://en.wikibooks.org/wiki/LaTeX/Mathematics#Color>`__)

.. code-block:: latex

    .. math::

        k = {\color{red}x} \mathbin{\color{blue}-} {\color{orange}{2}}

.. math::

    k = {\color{red}x} \mathbin{\color{purple}-} {\color{orange}{2}}

##############
Plus and minus
##############
::

    \pm \quad \mp


.. math::

    \pm \quad \mp

##############################
Controlling horizontal spacing
##############################
.. csv-table:: 
    :header: Command, Description, Size
    :delim: |

    \,  |   small space     |   3/18 of a quad
    \:  |   medium space    |   4/18 of a quad
    \;  |   large space     |   5/18 of a quad
    \!  |   negative space  |   -3/18 of a quad

.. ==================== ..
.. code-block:: latex

    f(n) =
      \begin{cases}
        n/2       & \quad \text{if } n \text{ is even}\\
        -(n+1)/2  & \quad \text{if } n \text{ is odd}\\
      \end{cases}

.. math::    

    f(n) =
      \begin{cases}
        n/2       & \quad \text{if } n \text{ is even}\\
        -(n+1)/2  & \quad \text{if } n \text{ is odd}\\
      \end{cases}
    
.. ==================== ..
.. code-block:: latex

    \int y \mathrm{d}x      \\
    \int y\, \mathrm{d}x    \\
    \int y\: \mathrm{d}x    \\
    \int y\; \mathrm{d}x    \\

.. math::    

    \int y \mathrm{d}x      \\
    \int y\, \mathrm{d}x    \\
    \int y\: \mathrm{d}x    \\
    \int y\; \mathrm{d}x    \\

.. ==================== ..
.. code-block:: latex

    \left(
        \begin{array}{c}
          n \\
          r
        \end{array}
      \right) = \frac{n!}{r!(n-r)!}

.. math::    

    \left(
        \begin{array}{c}
          n \\
          r
        \end{array}
      \right) = \frac{n!}{r!(n-r)!}

.. ==================== ..
.. code-block:: latex

    \left(\!
        \begin{array}{c}
          n \\
          r
        \end{array}
      \!\right) = \frac{n!}{r!(n-r)!}

.. math::    

    \left(\!
        \begin{array}{c}
          n \\
          r
        \end{array}
      \!\right) = \frac{n!}{r!(n-r)!}



####
Dots
####
.. code-block:: latex
    :linenos:

    \dots,  \ldots, \cdots  \\
    \vdots, \ddots, ,\iddots, \hdotsfor{10} 

    A_1,A_2,\dotsc, \\
    A_1+\dotsb+A_N  \\
    A_1 \dotsm A_N  \\
    \int_a^b \dotsi \\
    A_1\dotso A_N

.. math::

    \dots,  \ldots, \cdots  \\
    \vdots, \ddots, ,\iddots, \hdotsfor{10} 

    A_1,A_2,\dotsc, \\
    A_1+\dotsb+A_N  \\
    A_1 \dotsm A_N  \\
    \int_a^b \dotsi \\
    A_1\dotso A_N


############################
List of Mathematical Symbols
############################
https://en.wikibooks.org/wiki/LaTeX/Mathematics#List_of_Mathematical_Symbols

.. note::
    
    meh, most of these run fine. go for it.

*************
Other symbols
*************
.. code-block:: latex
    
    \partial,   \imath,     \Re,    \nabla,     \aleph,     \\
    \eth,       \jmath,     \Im,    \Box,       \beth,      \\
    \hbar,      \ell,       \wp,    \infty,     \gimel

.. math::

    \partial,   \imath,     \Re,    \nabla,     \aleph,     \\
    \eth,       \jmath,     \Im,    \Box,       \beth,      \\
    \hbar,      \ell,       \wp,    \infty,     \gimel

*************
Trigonemtrics
*************
.. code-block:: latex

    \sin, \arcsin, \sinh, \sec          \\
    \cos, \arccos, \cosh, \csc          \\
    \tan, \arctan, \tanh                \\
    \cot, \arccot, \coth

.. math::

    \sin, \arcsin, \sinh, \sec          \\
    \cos, \arccos, \cosh, \csc          \\
    \tan, \arctan, \tanh                \\
    \cot, \arccot, \coth
    
    
