##########################
igraph-networkx-comparison
##########################

https://plot.ly/python/igraph-networkx-comparison/

.. contents:: `Contents`
   :depth: 2
   :local:


Download data from UCI
======================

.. code:: python

    # %%bash
    # wget http://networkdata.ics.uci.edu/data/netscience/netscience.gml


.. parsed-literal::
    :class: myliteral

    --2016-09-14 20:36:27--  http://networkdata.ics.uci.edu/data/netscience/netscience.gml
    Resolving networkdata.ics.uci.edu (networkdata.ics.uci.edu)... 128.195.1.95
    Connecting to networkdata.ics.uci.edu (networkdata.ics.uci.edu)|128.195.1.95|:80... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 247464 (242K) [text/plain]
    Saving to: ‘netscience.gml’
    
         0K .......... .......... .......... .......... .......... 20%  122M 0s
        50K .......... .......... .......... .......... .......... 41%  133M 0s
       100K .......... .......... .......... .......... .......... 62%  176M 0s
       150K .......... .......... .......... .......... .......... 82%  182M 0s
       200K .......... .......... .......... .......... .         100%  156M=0.002s
    
    2016-09-14 20:36:27 (150 MB/s) - ‘netscience.gml’ saved [247464/247464]
    


igraph
======

.. code:: python

    import igraph as ig
    G=ig.Graph.Read_GML('netscience.gml')

.. code:: python

    labels=list(G.vs['label'])
    N=len(labels)
    E=[e.tuple for e in G.es]# list of edges
    layt=G.layout('kk') #kamada-kawai layout
    type(layt)




.. parsed-literal::
    :class: myliteral

    igraph.layout.Layout



.. code:: python

    import plotly.plotly as py
    from plotly.graph_objs import *
    
    Xn=[layt[k][0] for k in range(N)]
    Yn=[layt[k][1] for k in range(N)]
    Xe=[]
    Ye=[]
    for e in E:
        Xe+=[layt[e[0]][0],layt[e[1]][0], None]
        Ye+=[layt[e[0]][1],layt[e[1]][1], None] 
        
    trace1=Scatter(x=Xe,
                   y=Ye,
                   mode='lines',
                   line=Line(color='rgb(210,210,210)', width=1),
                   hoverinfo='none'
                   )
    trace2=Scatter(x=Xn,
                   y=Yn,
                   mode='markers',
                   name='ntw',
                   marker=Marker(symbol='dot',
                                 size=5, 
                                 color='#6959CD',
                                 line=Line(color='rgb(50,50,50)', width=0.5)
                                 ),
                   text=labels,
                   hoverinfo='text'
                   )
    
    axis=dict(showline=False, # hide axis line, grid, ticklabels and  title
              zeroline=False,
              showgrid=False,
              showticklabels=False,
              title='' 
              )
    
    width=800
    height=800
    layout=Layout(title= "Coauthorship network of scientists working on network theory and experiment"+\
                  "<br> Data source: <a href='https://networkdata.ics.uci.edu/data.php?id=11'> [1]</a>",  
        font= Font(size=12),
        showlegend=False,
        autosize=False,
        width=width,
        height=height,
        xaxis=XAxis(axis),
        yaxis=YAxis(axis),          
        margin=Margin(
            l=40,
            r=40,
            b=85,
            t=100,
        ),
        hovermode='closest',
        annotations=Annotations([
               Annotation(
               showarrow=False, 
                text='This igraph.Graph has the Kamada-Kawai layout',  
                xref='paper',     
                yref='paper',     
                x=0,  
                y=-0.1,  
                xanchor='left',   
                yanchor='bottom',  
                font=Font(
                size=14 
                )     
                )
            ]),           
        )
    
    data=Data([trace1, trace2])
    fig=Figure(data=data, layout=layout)
    py.iplot(fig, filename='Coautorship-network-igraph') 




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/570.embed" height="800px" width="800px"></iframe>



Networkx
========

Now let us read the same gml file, define the network as a
networkx.Graph, and plot it with Fruchterman Reingold layout (networkx
does not provide the Kamada-Kawai layout).

Because networkx cannot read the gml file (why?!!), we define the
networkx.Graph from data provided by the igraph approach above.

.. code:: python

    import networkx as nx
    
    V=range(N)# list of vertices
    g=nx.Graph()
    g.add_nodes_from(V)
    g.add_edges_from(E)# E is the list of edges
    
    pos=nx.fruchterman_reingold_layout(g) 

.. code:: python

    Xv=[pos[k][0] for k in range(N)]
    Yv=[pos[k][1] for k in range(N)]
    Xed=[]
    Yed=[]
    for edge in E:
        Xed+=[pos[edge[0]][0],pos[edge[1]][0], None]
        Yed+=[pos[edge[0]][1],pos[edge[1]][1], None] 
        
    trace3=Scatter(x=Xed,
                   y=Yed,
                   mode='lines',
                   line=Line(color='rgb(210,210,210)', width=1),
                   hoverinfo='none'
                   )
    trace4=Scatter(x=Xv,
                   y=Yv,
                   mode='markers',
                   name='net',
                   marker=Marker(symbol='dot',
                                 size=5, 
                                 color='#6959CD',
                                 line=Line(color='rgb(50,50,50)', width=0.5)
                                 ),
                   text=labels,
                   hoverinfo='text'
                   )
    
    annot="This networkx.Graph has the Fruchterman-Reingold layout<br>Code:"+\
    "<a href='http://nbviewer.ipython.org/gist/empet/07ea33b2e4e0b84193bd'> [2]</a>"
    
    data1=Data([trace3, trace4])
    fig1=Figure(data=data1, layout=layout)
    fig1['layout']['annotations'][0]['text']=annot
    py.iplot(fig1, filename='Coautorship-network-nx')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/48.embed" height="800px" width="800px"></iframe>



Repeat with different pos
=========================

.. code:: python

    #pos=nx.fruchterman_reingold_layout(g) #<- the layout we used above
    pos=nx.spring_layout(g)
    Xv=[pos[k][0] for k in range(N)]
    Yv=[pos[k][1] for k in range(N)]
    Xed=[]
    Yed=[]
    for edge in E:
        Xed+=[pos[edge[0]][0],pos[edge[1]][0], None]
        Yed+=[pos[edge[0]][1],pos[edge[1]][1], None] 
        
    trace3=Scatter(x=Xed,
                   y=Yed,
                   mode='lines',
                   line=Line(color='rgb(210,210,210)', width=1),
                   hoverinfo='none'
                   )
    trace4=Scatter(x=Xv,
                   y=Yv,
                   mode='markers',
                   name='net',
                   marker=Marker(symbol='dot',
                                 size=5, 
                                 color='#6959CD',
                                 line=Line(color='rgb(50,50,50)', width=0.5)
                                 ),
                   text=labels,
                   hoverinfo='text'
                   )
    
    annot="This networkx.Graph has the Fruchterman-Reingold layout<br>Code:"+\
    "<a href='http://nbviewer.ipython.org/gist/empet/07ea33b2e4e0b84193bd'> [2]</a>"
    
    data1=Data([trace3, trace4])
    fig1=Figure(data=data1, layout=layout)
    fig1['layout']['annotations'][0]['text']=annot
    py.iplot(fig1)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/572.embed" height="800px" width="800px"></iframe>


