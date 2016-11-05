############
range-slider
############

https://plot.ly/python/range-slider/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    %%bash
    pip install pandas_datareader --user


.. parsed-literal::
    :class: myliteral

    Collecting pandas_datareader
      Using cached pandas_datareader-0.2.1-py2.py3-none-any.whl
    Requirement already satisfied (use --upgrade to upgrade): requests in /home/takanori/.local/lib/python2.7/site-packages (from pandas_datareader)
    Requirement already satisfied (use --upgrade to upgrade): pandas in /home/takanori/.local/lib/python2.7/site-packages/pandas-0.18.1+293.g51e6adb-py2.7-linux-x86_64.egg (from pandas_datareader)
    Collecting requests-file (from pandas_datareader)
    Requirement already satisfied (use --upgrade to upgrade): python-dateutil in /home/takanori/.local/lib/python2.7/site-packages (from pandas->pandas_datareader)
    Requirement already satisfied (use --upgrade to upgrade): pytz>=2011k in /home/takanori/.local/lib/python2.7/site-packages (from pandas->pandas_datareader)
    Requirement already satisfied (use --upgrade to upgrade): numpy>=1.7.0 in /home/takanori/anaconda2/lib/python2.7/site-packages (from pandas->pandas_datareader)
    Requirement already satisfied (use --upgrade to upgrade): six in /home/takanori/.local/lib/python2.7/site-packages (from requests-file->pandas_datareader)
    Installing collected packages: requests-file, pandas-datareader
    Successfully installed pandas-datareader-0.2.1 requests-file-1.4


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go 
    
    from datetime import datetime
    # import pandas.io.data as web
    from pandas_datareader import data as web
    
    df = web.DataReader("aapl", 'yahoo',
                        datetime(2007, 10, 1),
                        datetime(2009, 4, 1))

.. code:: python

    df.head()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Open</th>
          <th>High</th>
          <th>Low</th>
          <th>Close</th>
          <th>Volume</th>
          <th>Adj Close</th>
        </tr>
        <tr>
          <th>Date</th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2007-10-01</th>
          <td>154.63</td>
          <td>157.41</td>
          <td>152.93</td>
          <td>156.34</td>
          <td>209267100</td>
          <td>20.4476</td>
        </tr>
        <tr>
          <th>2007-10-02</th>
          <td>156.55</td>
          <td>158.59</td>
          <td>155.89</td>
          <td>158.45</td>
          <td>198017400</td>
          <td>20.7236</td>
        </tr>
        <tr>
          <th>2007-10-03</th>
          <td>157.78</td>
          <td>159.18</td>
          <td>157.01</td>
          <td>157.92</td>
          <td>173129600</td>
          <td>20.6543</td>
        </tr>
        <tr>
          <th>2007-10-04</th>
          <td>158.00</td>
          <td>158.08</td>
          <td>153.50</td>
          <td>156.24</td>
          <td>164239600</td>
          <td>20.4345</td>
        </tr>
        <tr>
          <th>2007-10-05</th>
          <td>158.37</td>
          <td>161.58</td>
          <td>157.70</td>
          <td>161.45</td>
          <td>235867800</td>
          <td>21.1159</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    trace = go.Scatter(x=df.index,
                       y=df.High)
    
    data = [trace]

.. code:: python

    buttons=list([
        dict(count=1,
             label='1m',
             step='month',
             stepmode='backward'),
        dict(count=6,
             label='6m',
             step='month',
             stepmode='backward'),
        dict(count=1,
            label='YTD',
            step='year',
            stepmode='todate'),
        dict(count=1,
            label='1y',
            step='year',
            stepmode='backward'),
        dict(step='all')
    ])
    buttons




.. parsed-literal::
    :class: myliteral

    [{'count': 1, 'label': '1m', 'step': 'month', 'stepmode': 'backward'},
     {'count': 6, 'label': '6m', 'step': 'month', 'stepmode': 'backward'},
     {'count': 1, 'label': 'YTD', 'step': 'year', 'stepmode': 'todate'},
     {'count': 1, 'label': '1y', 'step': 'year', 'stepmode': 'backward'},
     {'step': 'all'}]



.. code:: python

    layout = dict(
        title='Time series with range slider and selectors',
        xaxis=dict(
            rangeselector=dict(buttons=buttons),
            rangeslider=dict(),
            type='date'
        )
    )
    
    fig = dict(data=data, layout=layout)
    py.iplot(fig)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/362.embed" height="525px" width="100%"></iframe>


