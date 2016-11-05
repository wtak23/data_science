#############
networkx-demo
#############

.. code:: python

    # https://plot.ly/ipython-notebooks/network-graphs/#
    import plotly.plotly as py
    from plotly.graph_objs import *
    
    import networkx as nx

Store position as node attribute data for random\_geometric\_graph and
find node near center (0.5, 0.5)

.. code:: python

    G=nx.random_geometric_graph(200,0.125)
    pos=nx.get_node_attributes(G,'pos')
    
    dmin=1
    ncenter=0
    for n in pos:
        x,y=pos[n]
        d=(x-0.5)**2+(y-0.5)**2
        if d<dmin:
            ncenter=n
            dmin=d
            
    p=nx.single_source_shortest_path_length(G,ncenter)

Add edges as disconnected lines in a single trace and nodes as a scatter
trace

.. code:: python

    
    
    edge_trace = Scatter(
        x=[], 
        y=[], 
        line=Line(width=0.5,color='#888'),
        hoverinfo='none',
        mode='lines')
    
    for edge in G.edges():
        x0, y0 = G.node[edge[0]]['pos']
        x1, y1 = G.node[edge[1]]['pos']
        edge_trace['x'] += [x0, x1, None]
        edge_trace['y'] += [y0, y1, None]
    
    node_trace = Scatter(
        x=[], 
        y=[], 
        text=[],
        mode='markers', 
        hoverinfo='text',
        marker=Marker(
            showscale=True,
            # colorscale options
            # 'Greys' | 'Greens' | 'Bluered' | 'Hot' | 'Picnic' | 'Portland' |
            # Jet' | 'RdBu' | 'Blackbody' | 'Earth' | 'Electric' | 'YIOrRd' | 'YIGnBu'
            colorscale='YIGnBu',
            reversescale=True,
            color=[], 
            size=10,         
            colorbar=dict(
                thickness=15,
                title='Node Connections',
                xanchor='left',
                titleside='right'
            ),
            line=dict(width=2)))
    
    for node in G.nodes():
        x, y = G.node[node]['pos']
        node_trace['x'].append(x)
        node_trace['y'].append(y)
    


**Color node points by the number of connections.**

Another option would be to size points by the number of connections i.e.

.. code:: python

    node_trace['marker']['size'].append(len(adjacencies))





.. parsed-literal::
    :class: myliteral

    <listiterator at 0x7f9b70238750>



.. code:: python

    for node, adjacencies in enumerate(G.adjacency()):
        node_trace['marker']['color'].append(len(adjacencies))
        node_info = '# of connections: '+str(len(adjacencies))
        node_trace['text'].append(node_info)


Create figure and send to Plotly

.. code:: python

    
    
    fig = Figure(data=Data([edge_trace, node_trace]),
                 layout=Layout(
                    title='<br>Network graph made with Python',
                    titlefont=dict(size=16),
                    showlegend=False, 
                    width=650,
                    height=650,
                    hovermode='closest',
                    margin=dict(b=20,l=5,r=5,t=40),
                    annotations=[ dict(
                        text="Python code: <a href='https://plot.ly/ipython-notebooks/network-graphs/'> https://plot.ly/ipython-notebooks/network-graphs/</a>",
                        showarrow=False,
                        xref="paper", yref="paper",
                        x=0.005, y=-0.002 ) ],
                    xaxis=XAxis(showgrid=False, zeroline=False, showticklabels=False),
                    yaxis=YAxis(showgrid=False, zeroline=False, showticklabels=False)))
    
    py.iplot(fig, filename='networkx')
    





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/76.embed" height="650px" width="650px"></iframe>



.. code:: python

    py.iplot(fig, filename='networkx')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/76.embed" height="650px" width="650px"></iframe>



