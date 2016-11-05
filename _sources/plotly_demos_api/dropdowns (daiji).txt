#################
dropdowns (daiji)
#################

https://plot.ly/python/dropdowns/

.. contents:: `Contents`
   :depth: 2
   :local:


Simple Dropdown Menu
====================

Dropdown Menus can now be used in Plotly to change the data displayed or
style of a plot!

.. code:: python

    import plotly.plotly as py
    from plotly.graph_objs import *
    
    countries = ['United States', 'China', 'South Korea', 'Hungary', 'Austraila', 'Canada']
    gold = [10, 8, 4, 4, 4, 0]
    silver = [8, 3, 2, 1, 0, 1]
    bronze = [9, 6, 1, 1, 5, 4]
    total = [27, 17, 7, 6, 9, 5]
    
    trace1 = Scatter(x=countries, y=gold,   name='Gold',   line=Line(color='#FFD700',width=3))
    trace2 = Scatter(x=countries, y=silver, name='Silver', line=Line(color='#C0C0C0',width=3))
    trace3 = Scatter(x=countries, y=bronze, name='Bronze', line=Line(color='#BA8651',width=3))
    trace4 = Scatter(x=countries, y=total,  name='total',  line=Line(color='#000000',width=4))
    data = Data([trace1, trace2, trace3, trace4])

.. code:: python

    buttons=list([
        dict(args=['visible', [True, True, True, True]],    label='All',    method='restyle'),
        dict(args=['visible', [True, False, False, False]], label='Gold',   method='restyle'),
        dict(args=['visible', [False, True, False, False]], label='Silver', method='restyle'),
        dict(args=['visible', [False, False, True, False]], label='Bronze', method='restyle'),
        dict(args=['visible', [False, False, False, True]], label='Total',  method='restyle')])

.. code:: python

    updatemenus=list([dict(x=-0.05,y=1,yanchor='top',buttons=buttons)])

.. code:: python

    layout = Layout(title='2016 Summer Olympic Medal Count',updatemenus=updatemenus)
    fig = Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1070.embed" height="525px" width="100%"></iframe>



Add Multiple Dropdown Menus
===========================

.. code:: python

    y1=[0.9811517321019101, 0.1786216491876189, 0.914448712848716, 
        0.6304173657769527, 0.8523920330052668, 0.6441693787052116, 
        0.026608139127452413, 0.5533894498601162, 0.3984403467889206, 
        0.4041165335437975]
    y2=[0.585710785814439, 0.3430887677330601, 0.4584226994722529, 
        0.2765770916324737, 0.3799651357341245, 0.08327961475466394, 
        0.13306360933716, 0.6468040257640011, 0.3574845623367817, 
        0.6906963617910844]
    y3=[0.8730924772005504, 0.2502287847221978, 0.4977706549396861, 
        0.8697548378149877, 0.2764916236291508, 0.9321797368391336, 
        0.668390989554607, 0.3190700540510323, 0.5551541121285288, 
        0.9220083303110946]
    y4=[0.5007964550744415, 0.5433206590323669, 0.5566315092423986, 
        0.17269775092493655, 0.06952350531583895, 0.8606722243359786, 
        0.8772074711040978, 0.20259890631699906, 0.43977313616572666, 
        0.8856663080881806]

.. code:: python

    trace1 = Scatter(y=y1,line=Line(color='red',shape='spline'),name='Data Set 1')
    trace2 = Scatter(y=y2,line=Line(color='red',shape='spline'),name='Data Set 2',visible=False)
    trace3 = Scatter(y=y3,line=Line(color='red',shape='spline'),name='Data Set 3',visible=False)
    trace4 = Scatter(y=y4,line=Line(color='red',shape='spline'),name='Data Set 4',visible=False)
    data = Data([trace1, trace2, trace3, trace4])

.. code:: python

    buttons1=list([
        dict(args=['line.color', 'red'],   label='red',method='restyle'),
        dict(args=['line.color', 'blue'],  label='blue',method='restyle'),
        dict(args=['line.color', 'green'], label='green',method='restyle')
    ])
    
    buttons2=list([
        dict(args=['visible', [True, False, False, False]],label='Data Set 1',method='restyle'),
        dict(args=['visible', [False, True, False, False]],label='Data Set 2',method='restyle'),
        dict(args=['visible', [False, False, True, False]],label='Data Set 3',method='restyle'),
        dict(args=['visible', [False, False, False, True]],label='Data Set 4',method='restyle')
    ])

.. code:: python

    layout = Layout(
        updatemenus=list([dict(x=-0.05,y=0.8,buttons=buttons1,yanchor='top'),
                          dict(x=-0.05,y=1,  buttons=buttons2,yanchor='top')]),
    )
    fig = Figure(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1076.embed" height="525px" width="100%"></iframe>



