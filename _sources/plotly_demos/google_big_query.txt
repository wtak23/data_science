Google Big Query Demo
=====================
Demo from https://plot.ly/python/google\_big\_query/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import pandas as pd
    
    # to communicate with Google BigQuery
    from pandas.io import gbq

.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    from plotly.tools import FigureFactory as FF

.. code:: python

    top10_active_users_query = """
    SELECT
      author AS User,
      count(author) as Stories
    FROM
      [fh-bigquery:hackernews.stories]
    GROUP BY
      User
    ORDER BY
      Stories DESC
    LIMIT
      10
    """

.. code:: python

    project_id = 'tak2016-144221'

To get below running, needed this library:

https://github.com/google/google-api-python-client

.. code:: bash

    $ pip install google-api-python-client --user

.. code:: python

    top10_active_users_df = gbq.read_gbq(top10_active_users_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 18.1 Mb
    
    Retrieving results...
    Got 10 rows.
    
    Total time taken 1.97 s.
    Finished at 2016-09-22 17:24:16.


.. code:: python

    
    
    top10_active_users_df




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>User</th>
          <th>Stories</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>cwan</td>
          <td>7077</td>
        </tr>
        <tr>
          <th>1</th>
          <td>shawndumas</td>
          <td>6602</td>
        </tr>
        <tr>
          <th>2</th>
          <td>evo_9</td>
          <td>5659</td>
        </tr>
        <tr>
          <th>3</th>
          <td>nickb</td>
          <td>4322</td>
        </tr>
        <tr>
          <th>4</th>
          <td>iProject</td>
          <td>4266</td>
        </tr>
        <tr>
          <th>5</th>
          <td>bootload</td>
          <td>4212</td>
        </tr>
        <tr>
          <th>6</th>
          <td>edw519</td>
          <td>3844</td>
        </tr>
        <tr>
          <th>7</th>
          <td>ColinWright</td>
          <td>3766</td>
        </tr>
        <tr>
          <th>8</th>
          <td>nreece</td>
          <td>3724</td>
        </tr>
        <tr>
          <th>9</th>
          <td>tokenadult</td>
          <td>3659</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    top_10_users_table = FF.create_table(top10_active_users_df)
    py.iplot(top_10_users_table, filename='plotly/top-10-active-users')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/198.embed" height="380px" width="100%"></iframe>



Top 10 Hacker News Submissions (by score)
-----------------------------------------

.. code:: python

    top10_story_query = """
    SELECT
      title,
      score,
      time_ts AS timestamp
    FROM
      [fh-bigquery:hackernews.stories]
    ORDER BY
      score DESC
    LIMIT
      10
    """

.. code:: python

    top10_story_df = gbq.read_gbq(top10_story_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 113.1 Mb
    
    Retrieving results...
    Got 10 rows.
    
    Total time taken 1.5 s.
    Finished at 2016-09-22 17:26:09.


.. code:: python

    # Create a table figure from the DataFrame
    top10_story_figure = FF.create_table(top10_story_df)
    
    # Scatter trace for the bubble chart timeseries
    story_timeseries_trace = go.Scatter(
        x=top10_story_df['timestamp'],
        y=top10_story_df['score'],
        xaxis='x2',
        yaxis='y2',
        mode='markers',
        text=top10_story_df['title'],
        marker=dict(
            color=[80 + i*5 for i in range(10)],
            size=top10_story_df['score']/50,
            showscale=False
        )
    )
    
    # Add the trace data to the figure
    top10_story_figure['data'].extend(go.Data([story_timeseries_trace]))
    
    # Subplot layout
    top10_story_figure.layout.yaxis.update({'domain': [0, .45]})
    top10_story_figure.layout.yaxis2.update({'domain': [.6, 1]})
    
    # Y-axis of the graph should be anchored with X-axis
    top10_story_figure.layout.yaxis2.update({'anchor': 'x2'})
    top10_story_figure.layout.xaxis2.update({'anchor': 'y2'})
    
    # Add the height and title attribute
    top10_story_figure.layout.update({'height':900})
    top10_story_figure.layout.update({'title': 'Highest Scoring Submissions on Hacker News'})
    
    # Update the background color for plot and paper
    top10_story_figure.layout.update({'paper_bgcolor': 'rgb(243, 243, 243)'})
    top10_story_figure.layout.update({'plot_bgcolor': 'rgb(243, 243, 243)'})
    
    # Add the margin to make subplot titles visible
    top10_story_figure.layout.margin.update({'t':75, 'l':50})
    top10_story_figure.layout.yaxis2.update({'title': 'Upvote Score'})
    top10_story_figure.layout.xaxis2.update({'title': 'Post Time'})

.. code:: python

    py.image.save_as(top10_story_figure, filename='top10-posts.png')
    py.iplot(top10_story_figure, filename='plotly/highest-scoring-submissions')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/200.embed" height="900px" width="100%"></iframe>



From which Top-level domain (TLD) most of the stories come?
-----------------------------------------------------------

-  Here we have used the url-function
   `TLD <https://cloud.google.com/bigquery/query-reference#tld>`__ from
   BigQuery's query syntax.
-  We collect the domain for all URLs with their respective count, and
   group them by it.

.. code:: python

    tld_share_query = """
    SELECT
      TLD(url) AS domain,
      count(score) AS stories
    FROM
      [fh-bigquery:hackernews.stories]
    GROUP BY
      domain
    ORDER BY
      stories DESC
    LIMIT 10
    """

.. code:: python

    tld_share_df = gbq.read_gbq(tld_share_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 134.6 Mb
    
    Retrieving results...
    Got 10 rows.
    
    Total time taken 4.13 s.
    Finished at 2016-09-22 17:27:28.


.. code:: python

    tld_share_df




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>domain</th>
          <th>stories</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>.com</td>
          <td>1324329</td>
        </tr>
        <tr>
          <th>1</th>
          <td>.org</td>
          <td>120716</td>
        </tr>
        <tr>
          <th>2</th>
          <td>None</td>
          <td>111744</td>
        </tr>
        <tr>
          <th>3</th>
          <td>.net</td>
          <td>58754</td>
        </tr>
        <tr>
          <th>4</th>
          <td>.co.uk</td>
          <td>43955</td>
        </tr>
        <tr>
          <th>5</th>
          <td>.io</td>
          <td>23507</td>
        </tr>
        <tr>
          <th>6</th>
          <td>.edu</td>
          <td>14727</td>
        </tr>
        <tr>
          <th>7</th>
          <td>.co</td>
          <td>10692</td>
        </tr>
        <tr>
          <th>8</th>
          <td>.me</td>
          <td>10565</td>
        </tr>
        <tr>
          <th>9</th>
          <td>.info</td>
          <td>8121</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    labels = tld_share_df['domain']
    values = tld_share_df['stories']
    
    tld_share_trace = go.Pie(labels=labels, values=values)
    data = [tld_share_trace]
    
    layout = go.Layout(
        title='Submissions shared by Top-level domains'
    )
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='plotly/toplevel-domains')





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/202.embed" height="525px" width="100%"></iframe>



Public response to the "Who Is Hiring?" posts
---------------------------------------------

-  There is an account on Hacker News by the name
   `whoishiring <https://news.ycombinator.com/user?id=whoishiring>`__.
-  This account automatically submits a 'Who is Hiring?' post at 11 AM
   Eastern time on the first weekday of every month.

.. code:: python

    wih_query = """
    SELECT
      id,
      title,
      score,
      time_ts
    FROM
      [fh-bigquery:hackernews.stories]
    WHERE
      author == 'whoishiring' AND
      LOWER(title) contains 'who is hiring?'
    ORDER BY
      time
    """

.. code:: python

    wih_df = gbq.read_gbq(wih_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 146.1 Mb
    
    Retrieving results...
    Got 52 rows.
    
    Total time taken 1.83 s.
    Finished at 2016-09-22 17:28:45.


.. code:: python

    trace = go.Scatter(
        x=wih_df['time_ts'],
        y=wih_df['score'],
        mode='markers+lines',
        text=wih_df['title'],
        marker=dict(
            size=wih_df['score']/50
        )
    )
    
    layout = go.Layout(
        title='Public response to the "Who Is Hiring?" posts',
        xaxis=dict(
            title="Post Time"
        ),
        yaxis=dict(
            title="Upvote Score"
        )
    )
    
    data = [trace]
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='plotly/whoishiring-public-response')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/204.embed" height="525px" width="100%"></iframe>



Submission Traffic Volume in a Week
-----------------------------------

.. code:: python

    week_traffic_query = """
    SELECT
      DAYOFWEEK(time_ts) as Weekday,
      count(DAYOFWEEK(time_ts)) as story_counts
    FROM
      [fh-bigquery:hackernews.stories]
    GROUP BY
      Weekday
    ORDER BY
      Weekday
    """


.. code:: python

    week_traffic_df = gbq.read_gbq(week_traffic_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 14.8 Mb
    
    Retrieving results...
    Got 8 rows.
    
    Total time taken 2.45 s.
    Finished at 2016-09-22 17:29:14.


.. code:: python

    week_traffic_df['Day'] = ['NULL', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    week_traffic_df = week_traffic_df.drop(week_traffic_df.index[0])

.. code:: python

    trace = go.Scatter(
        x=week_traffic_df['Day'],
        y=week_traffic_df['story_counts'],
        mode='lines',
        text=week_traffic_df['Day']
    )
    
    layout = go.Layout(
        title='Submission Traffic Volume (Week Days)',
        xaxis=dict(
            title="Day of the Week"
        ),
        yaxis=dict(
            title="Total Submissions"
        )
    )
    
    data = [trace]
    
    fig = go.Figure(data=data, layout=layout)
    py.iplot(fig, filename='plotly/submission-traffic-volume')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/206.embed" height="525px" width="100%"></iframe>



Programming Language Trend on HackerNews
----------------------------------------

We will compare the trends for the Python and PHP programming languages,
using the Hacker News post titles.

.. code:: python

    python_query = """
    SELECT
      YEAR(time_ts) as years,
      COUNT(YEAR(time_ts )) as trends
    FROM
      [fh-bigquery:hackernews.stories]
    WHERE
      LOWER(title) contains 'python'
    GROUP BY
      years
    ORDER BY
      years
    """
    
    php_query = """
    SELECT
      YEAR(time_ts) as years,
      COUNT(YEAR(time_ts )) as trends
    FROM
      [fh-bigquery:hackernews.stories]
    WHERE
      LOWER(title) contains 'php'
    GROUP BY
      years
    ORDER BY
      years
    """

.. code:: python

    python_df = gbq.read_gbq(python_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 99.0 Mb
    
    Retrieving results...
    Got 9 rows.
    
    Total time taken 1.79 s.
    Finished at 2016-09-22 17:29:58.


.. code:: python

    php_df = gbq.read_gbq(php_query, project_id=project_id)


.. parsed-literal::
    :class: myliteral

    Requesting query... ok.
    Query running...
    Query done.
    Processed: 99.0 Mb
    
    Retrieving results...
    Got 9 rows.
    
    Total time taken 2.9 s.
    Finished at 2016-09-22 17:30:04.


.. code:: python

    trace1 = go.Scatter(
        x=python_df['years'],
        y=python_df['trends'],
        mode='lines',
        line=dict(color='rgba(115,115,115,1)', width=4),
        connectgaps=True,
    )
    
    trace2 = go.Scatter(
        x=[python_df['years'][0], python_df['years'][8]],
        y=[python_df['trends'][0], python_df['trends'][8]],
        mode='markers',
        marker=dict(color='rgba(115,115,115,1)', size=8)
    )
    
    trace3 = go.Scatter(
        x=php_df['years'],
        y=php_df['trends'],
        mode='lines',
        line=dict(color='rgba(189,189,189,1)', width=4),
        connectgaps=True,
    )
    
    trace4 = go.Scatter(
        x=[php_df['years'][0], php_df['years'][8]],
        y=[php_df['trends'][0], php_df['trends'][8]],
        mode='markers',
        marker=dict(color='rgba(189,189,189,1)', size=8)
    )
    
    traces = [trace1, trace2, trace3, trace4]
    
    layout = go.Layout(
        xaxis=dict(
            showline=True,
            showgrid=False,
            showticklabels=True,
            linecolor='rgb(204, 204, 204)',
            linewidth=2,
            autotick=False,
            ticks='outside',
            tickcolor='rgb(204, 204, 204)',
            tickwidth=2,
            ticklen=5,
            tickfont=dict(
                family='Arial',
                size=12,
                color='rgb(82, 82, 82)',
            ),
        ),
        yaxis=dict(
            showgrid=False,
            zeroline=False,
            showline=False,
            showticklabels=False,
        ),
        autosize=False,
        margin=dict(
            autoexpand=False,
            l=100,
            r=20,
            t=110,
        ),
        showlegend=False,
    )
    
    annotations = []
    
    annotations.append(
        dict(xref='paper', x=0.95, y=python_df['trends'][8],
        xanchor='left', yanchor='middle',
        text='Python',
        font=dict(
            family='Arial',
            size=14,
            color='rgba(49,130,189, 1)'
        ),
        showarrow=False)
    )
    
    annotations.append(
        dict(xref='paper', x=0.95, y=php_df['trends'][8],
        xanchor='left', yanchor='middle',
        text='PHP',
        font=dict(
            family='Arial',
            size=14,
            color='rgba(49,130,189, 1)'
        ),
        showarrow=False)
    )
    
    annotations.append(
        dict(xref='paper', yref='paper', x=0.5, y=-0.1,
        xanchor='center', yanchor='top',
        text='Source: Hacker News submissions with the title containing Python/PHP',
        font=dict(
            family='Arial',
            size=12,
            color='rgb(150,150,150)'
        ),
        showarrow=False)
    )
    
    layout['annotations'] = annotations
    
    fig = go.Figure(data=traces, layout=layout)
    py.iplot(fig, filename='plotly/programming-language-trends')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/208.embed" height="525px" width="100%"></iframe>


