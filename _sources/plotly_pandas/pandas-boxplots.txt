###############
pandas-boxplots
###############

https://plot.ly/pandas/box-plots/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import string
    import pandas as pd
    import numpy as np
    import plotly.plotly as py
    import plotly.graph_objs as go
    
    N = 100
    y_vals = {}
    for letter in list(string.ascii_uppercase):
         y_vals[letter] = np.random.randn(N)+(3*np.random.randn())
            
    df = pd.DataFrame(y_vals)
    df.head()
    
    data = []
    
    for col in df.columns:
        data.append(  go.Box( y=df[col], name=col, showlegend=False ) )
    
    data.append( go.Scatter( x = df.columns, y = df.mean(), mode='lines', name='mean' ) )
    
    # IPython notebook
    # py.iplot(data, filename='pandas-box-plot')
    
    url = py.iplot(data, filename='pandas-box-plot')


Pandas boxplot with cufflinks
=============================

.. code:: python

    import plotly.plotly as py
    import cufflinks as cf
    import pandas as pd
    import numpy as np
    
    cf.set_config_file(offline=False, world_readable=True, theme='ggplot')
    
    df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])
    df.iplot(kind='box')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/530.embed" height="525px" width="100%"></iframe>


