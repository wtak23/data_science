##########################
plotly-layout-options-axes
##########################

https://plot.ly/python/axes/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go

Toggling Axes Lines, Ticks, Labels, and Autorange
=================================================

.. code:: python

    trace1 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[8, 7, 6, 5, 4, 3, 2, 1, 0])
    trace2 = go.Scatter(x=[0, 1, 2, 3, 4, 5, 6, 7, 8],y=[0, 1, 2, 3, 4, 5, 6, 7, 8])
    data = [trace1, trace2]
    
    layout = go.Layout(
        xaxis=dict(autorange=True,showgrid=False,zeroline=False,showline=False,
            autotick=True,ticks='',showticklabels=False),
        yaxis=dict(autorange=True,showgrid=False,zeroline=False,showline=False,
            autotick=True,ticks='',showticklabels=False)
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/986.embed?share_key=DhIT1CULNSuDefWSKv2b8S" height="525px" width="100%"></iframe>



Tick Placement, Color, and Style
================================

.. code:: python

    layout = go.Layout(
        xaxis=dict(autotick=False,ticks='outside',tick0=0,dtick=0.25,
            ticklen=8,tickwidth=4,tickcolor='#000'),
        yaxis=dict(autotick=False,ticks='outside',tick0=0,dtick=0.25,
            ticklen=8,tickwidth=4,tickcolor='#000')
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/988.embed?share_key=PlfhkIWUbibMoqgKV0HJzM" height="525px" width="100%"></iframe>



Set and Style Axes Title Labels and Ticks
=========================================

.. code:: python

    xaxis = dict(title='AXIS TITLE',showticklabels=True,tickangle=45,
                 titlefont=dict(family='Arial, sans-serif',size=18,color='lightgrey'),
                 tickfont=dict(family='Old Standard TT, serif',size=14,color='black'),
                 exponentformat='e',showexponent='All')
    yaxis=dict(title='AXIS TITLE',showticklabels=True,tickangle=45,
            titlefont=dict(family='Arial, sans-serif',size=18,color='lightgrey'),      
            tickfont=dict(family='Old Standard TT, serif',size=14,color='black'),
            exponentformat='e',showexponent='All')

.. code:: python

    layout = go.Layout(xaxis=xaxis,yaxis=yaxis)
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/990.embed?share_key=HZ01TMwAFmKPrCchnZAbyU" height="525px" width="100%"></iframe>



Styling and Coloring Axes and the Zero-Line
===========================================

.. code:: python

    xaxis=dict(
        showgrid=True,
        zeroline=True,
        showline=True,
        mirror='ticks',
        gridcolor='#bdbdbd',
        gridwidth=2,
        zerolinecolor='#969696',
        zerolinewidth=4,
        linecolor='#636363',
        linewidth=6
    )
    yaxis=dict(
        showgrid=True,
        zeroline=True,
        showline=True,
        mirror='ticks',
        gridcolor='#bdbdbd',
        gridwidth=2,
        zerolinecolor='#969696',
        zerolinewidth=4,
        linecolor='#636363',
        linewidth=6
    )
    layout = go.Layout(xaxis=xaxis,yaxis=yaxis)
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/994.embed?share_key=LS4aeMkakO0nfVtWCjvqZ8" height="525px" width="100%"></iframe>



Setting the Range of Axes Manually
==================================

.. code:: python

    layout = go.Layout(xaxis=dict(range=[2, 5]),
                       yaxis=dict(range=[2, 5]))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/996.embed?share_key=zhkLWm7ILl3nVb7sgxQ1y9" height="525px" width="100%"></iframe>



Logarithmic Axes
================

.. code:: python

    layout = go.Layout(
        xaxis=dict(type='log',autorange=True),
        yaxis=dict(type='log',autorange=True)
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/998.embed?share_key=MaLma1RW4sxnWra60XLFJV" height="525px" width="100%"></iframe>



Reversed Axes
=============

.. code:: python

    data = [go.Scatter(x=[1, 2],y=[1, 2])]
    layout = go.Layout(xaxis=dict(autorange='reversed'))
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1000.embed?share_key=vPeRqrrpWoqrSOZ31jsrIC" height="525px" width="100%"></iframe>



Reversed Axes with Range ( Min/Max ) Specified
==============================================

.. code:: python

    import numpy as np
    
    x = np.linspace(0, 10, 100)
    y = np.random.randint(1, 100, 100)
    
    data = [go.Scatter(x=x, y=y, mode='markers')]
    layout = go.Layout(title='Reversed Axis with Min/Max',xaxis=dict(autorange='reversed', range=[0, 10]))
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1002.embed?share_key=d61ST7uK5cCTIotqFX3nsa" height="525px" width="100%"></iframe>



nonnegative, tozero, and normal Rangemode
=========================================

.. code:: python

    data = [go.Scatter(x=[2, 4, 6],y=[-3, 0, 3])]
    layout = go.Layout(
        showlegend=False,
        xaxis=dict(rangemode='tozero',autorange=True),
        yaxis=dict(rangemode='nonnegative',autorange=True)
    )
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1004.embed?share_key=lq08aNl1BDWd0wG4Oh58Ur" height="525px" width="100%"></iframe>



Enumerated Ticks with Tickvals and Ticktext
===========================================

couldn't run...i can't find the data file they are using...

See

https://plot.ly/python/axes/#enumerated-ticks-with-tickvals-and-ticktext

.. code:: python

    %%bash
    pip install pymatgen --user


.. parsed-literal::
    :class: myliteral

    Collecting pymatgen
      Downloading pymatgen-4.4.0.tar.gz (1.3MB)
    Requirement already satisfied (use --upgrade to upgrade): numpy>=1.9 in /home/takanori/anaconda2/lib/python2.7/site-packages (from pymatgen)
    Requirement already satisfied (use --upgrade to upgrade): six in /home/takanori/.local/lib/python2.7/site-packages (from pymatgen)
    Collecting atomicfile (from pymatgen)
      Downloading atomicfile-1.0.tar.gz
    Requirement already satisfied (use --upgrade to upgrade): requests in /home/takanori/.local/lib/python2.7/site-packages (from pymatgen)
    Collecting pybtex (from pymatgen)
      Downloading pybtex-0.20.1.tar.bz2 (283kB)
    Requirement already satisfied (use --upgrade to upgrade): pyyaml in /home/takanori/anaconda2/lib/python2.7/site-packages (from pymatgen)
    Collecting monty>=0.9.5 (from pymatgen)
      Downloading monty-0.9.5.tar.gz
    Requirement already satisfied (use --upgrade to upgrade): scipy>=0.14 in /home/takanori/anaconda2/lib/python2.7/site-packages (from pymatgen)
    Requirement already satisfied (use --upgrade to upgrade): tabulate in /home/takanori/.local/lib/python2.7/site-packages (from pymatgen)
    Requirement already satisfied (use --upgrade to upgrade): enum34 in /home/takanori/anaconda2/lib/python2.7/site-packages (from pymatgen)
    Collecting spglib (from pymatgen)
      Downloading spglib-1.9.5.tar.gz (167kB)
    Collecting latexcodec>=1.0.2 (from pybtex->pymatgen)
      Downloading latexcodec-1.0.4-py2.py3-none-any.whl
    Building wheels for collected packages: pymatgen, atomicfile, pybtex, monty, spglib
      Running setup.py bdist_wheel for pymatgen: started
      Running setup.py bdist_wheel for pymatgen: finished with status 'done'
      Stored in directory: /home/takanori/.cache/pip/wheels/39/9d/de/ef8c146c4681c50635b8b92c3a34eb45dabf85cb5290b71146
      Running setup.py bdist_wheel for atomicfile: started
      Running setup.py bdist_wheel for atomicfile: finished with status 'done'
      Stored in directory: /home/takanori/.cache/pip/wheels/c8/fd/ba/ccb101cecf251001181bad3e32df3374f48d3b0912aeb37bd9
      Running setup.py bdist_wheel for pybtex: started
      Running setup.py bdist_wheel for pybtex: finished with status 'done'
      Stored in directory: /home/takanori/.cache/pip/wheels/4f/fd/05/9971ed5117841d9e673a0428feca51f383dd3da5d951ac29b1
      Running setup.py bdist_wheel for monty: started
      Running setup.py bdist_wheel for monty: finished with status 'done'
      Stored in directory: /home/takanori/.cache/pip/wheels/88/b2/a7/c6d34c49d56e0ee2abc300c976271710ac28c6db1d37b1e9e7
      Running setup.py bdist_wheel for spglib: started
      Running setup.py bdist_wheel for spglib: finished with status 'done'
      Stored in directory: /home/takanori/.cache/pip/wheels/f0/a8/d8/6b4ec1f4bdb9ef681ebc565754325007c01b7858ff725b4f8f
    Successfully built pymatgen atomicfile pybtex monty spglib
    Installing collected packages: atomicfile, latexcodec, pybtex, monty, spglib, pymatgen
    Successfully installed atomicfile-1.0 latexcodec-1.0.4 monty-0.9.5 pybtex-0.20.1 pymatgen-4.4.0 spglib-1.9.5


.. code:: python

    import plotly.tools as tls
    from pymatgen.io.vasp import Vasprun
    from pymatgen.electronic_structure.core import Spin


.. code:: python

    dosrun = Vasprun("Si_bands/DOS/vasprun.xml")
    spd_dos = dosrun.complete_dos.get_spd_dos()
    run = Vasprun("Si_bands/Bandes/vasprun.xml", parse_projected_eigen = True)
    bands = run.get_band_structure("Si_bands/Bandes/KPOINTS", line_mode=True, efermi=dosrun.efermi)


::


    ---------------------------------------------------------------------------

    IOError                                   Traceback (most recent call last)

    <ipython-input-19-2934f9c31924> in <module>()
    ----> 1 dosrun = Vasprun("Si_bands/DOS/vasprun.xml")
          2 spd_dos = dosrun.complete_dos.get_spd_dos()
          3 run = Vasprun("Si_bands/Bandes/vasprun.xml", parse_projected_eigen = True)
          4 bands = run.get_band_structure("Si_bands/Bandes/KPOINTS", line_mode=True, efermi=dosrun.efermi)


    /home/takanori/.local/lib/python2.7/site-packages/pymatgen/io/vasp/outputs.pyc in __init__(self, filename, ionic_step_skip, ionic_step_offset, parse_dos, parse_eigen, parse_projected_eigen, parse_potcar_file, occu_tol, exception_on_bad_xml)
        355         self.exception_on_bad_xml = exception_on_bad_xml
        356 
    --> 357         with zopen(filename, "rt") as f:
        358             if ionic_step_skip or ionic_step_offset:
        359                 # remove parts of the xml file and parse the string


    /home/takanori/.local/lib/python2.7/site-packages/monty/io.pyc in zopen(filename, *args, **kwargs)
         58         return gzip.open(filename, *args, **kwargs)
         59     else:
    ---> 60         return open(filename, *args, **kwargs)
         61 
         62 


    IOError: [Errno 2] No such file or directory: 'Si_bands/DOS/vasprun.xml'


.. code:: python

    emin = 1e100
    emax = -1e100
    for spin in bands.bands.keys():
        for band in range(bands.nb_bands):
            emin = min(emin, min(bands.bands[spin][band]))
            emax = max(emax, max(bands.bands[spin][band]))
    emin = emin - bands.efermi - 1
    emax = emax - bands.efermi + 1
    
    kptslist = range(len(bands.kpoints))
    bandTraces = list()
    for band in range(bands.nb_bands):
        bandTraces.append(
            go.Scatter(
                x=kptslist,
                y=[e - bands.efermi for e in bands.bands[Spin.up][band]],
                mode="lines",
                line=go.Line(color="#666666"),
                showlegend=False
            )
        )
    
    labels = [r"$L$", r"$\Gamma$", r"$X$", r"$U,K$", r"$\Gamma$"]
    step = len(bands.kpoints) / (len(labels) - 1)
    # vertical lines
    vlines = list()
    for i, label in enumerate(labels):
        vlines.append(
            go.Scatter(
                x=[i * step, i * step],
                y=[emin, emax],
                mode="lines",
                line=go.Line(color="#111111", width=1),
                showlegend=False
            )
        )
    
    bandxaxis = go.XAxis(
        title="k-points",
        range=[0, len(bands.kpoints)],
        showgrid=True,
        showline=True,
        ticks="", 
        showticklabels=True,
        mirror=True,
        linewidth=2,
        ticktext=labels,
        tickvals=[i * step for i in range(len(labels))]
    )
    bandyaxis = go.YAxis(
        title="$E - E_f \quad / \quad \\text{eV}$",
        range=[emin, emax],
        showgrid=True,
        showline=True,
        zeroline=True,
        mirror="ticks",
        ticks="inside",
        linewidth=2,
        tickwidth=2,
        zerolinewidth=2
    )
    bandlayout = go.Layout(
        title="Bands diagram of Silicon",
        xaxis=bandxaxis,
        yaxis=bandyaxis,
    )
    
    bandfig = go.Figure(data=bandTraces + vlines, layout=bandlayout)
    py.iplot(bandfig, filename="Bands_Si", auto_open=False)
