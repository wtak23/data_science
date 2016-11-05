#################
Plotly and SQLite
#################

.. contents:: `Contents`
   :depth: 2
   :local:


This notebook demo is a modified version of the demo from plotly site (`link <https://plot.ly/python/big-data-analytics-with-pandas-and-sqlite/>`__)

.. code:: python

    import pandas as pd
    import datetime as dt
    from IPython.display import display
    
    import plotly.plotly as py # interactive graphing
    from plotly.graph_objs import Bar, Scatter, Marker, Layout 

.. code:: python

    from os import path

.. code:: python

    %%sh
    ls -l ~/Downloads/*.csv
    # a 9gb file!


.. parsed-literal::
    :class: myliteral

    -rw-r--r-- 1 takanori takanori 9087741962 Sep 15 02:28 /home/takanori/Downloads/311_Service_Requests_from_2010_to_Present.csv


.. code:: python

    filepath = path.expanduser('~/Downloads/311_Service_Requests_from_2010_to_Present.csv')

.. code:: python

    pd.read_csv(filepath,nrows=2).head()





.. raw:: html

    <div>
    <table border="1" class="table table-striped table-condensed table-bordered">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Unique Key</th>
          <th>Created Date</th>
          <th>Closed Date</th>
          <th>Agency</th>
          <th>Agency Name</th>
          <th>Complaint Type</th>
          <th>Descriptor</th>
          <th>Location Type</th>
          <th>Incident Zip</th>
          <th>Incident Address</th>
          <th>Street Name</th>
          <th>Cross Street 1</th>
          <th>Cross Street 2</th>
          <th>Intersection Street 1</th>
          <th>Intersection Street 2</th>
          <th>Address Type</th>
          <th>City</th>
          <th>Landmark</th>
          <th>Facility Type</th>
          <th>Status</th>
          <th>Due Date</th>
          <th>Resolution Description</th>
          <th>Resolution Action Updated Date</th>
          <th>Community Board</th>
          <th>Borough</th>
          <th>X Coordinate (State Plane)</th>
          <th>Y Coordinate (State Plane)</th>
          <th>Park Facility Name</th>
          <th>Park Borough</th>
          <th>School Name</th>
          <th>School Number</th>
          <th>School Region</th>
          <th>School Code</th>
          <th>School Phone Number</th>
          <th>School Address</th>
          <th>School City</th>
          <th>School State</th>
          <th>School Zip</th>
          <th>School Not Found</th>
          <th>School or Citywide Complaint</th>
          <th>Vehicle Type</th>
          <th>Taxi Company Borough</th>
          <th>Taxi Pick Up Location</th>
          <th>Bridge Highway Name</th>
          <th>Bridge Highway Direction</th>
          <th>Road Ramp</th>
          <th>Bridge Highway Segment</th>
          <th>Garage Lot Name</th>
          <th>Ferry Direction</th>
          <th>Ferry Terminal Name</th>
          <th>Latitude</th>
          <th>Longitude</th>
          <th>Location</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>33504340</td>
          <td>06/03/2016 08:51:27 PM</td>
          <td>06/09/2016 12:41:22 PM</td>
          <td>HPD</td>
          <td>Department of Housing Preservation and Develop...</td>
          <td>UNSANITARY CONDITION</td>
          <td>MOLD</td>
          <td>RESIDENTIAL BUILDING</td>
          <td>10469</td>
          <td>3471 MICKLE AVENUE</td>
          <td>MICKLE AVENUE</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>ADDRESS</td>
          <td>BRONX</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>Closed</td>
          <td>NaN</td>
          <td>The Department of Housing Preservation and Dev...</td>
          <td>06/09/2016 12:41:22 PM</td>
          <td>12 BRONX</td>
          <td>BRONX</td>
          <td>1026814</td>
          <td>259342</td>
          <td>Unspecified</td>
          <td>BRONX</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>40.8784</td>
          <td>-73.8461</td>
          <td>(40.87840550821806, -73.84608300411983)</td>
        </tr>
        <tr>
          <th>1</th>
          <td>33504341</td>
          <td>06/02/2016 03:55:00 PM</td>
          <td>06/06/2016 12:00:00 PM</td>
          <td>DSNY</td>
          <td>A - Illegal Posting Staten Island, Queens and ...</td>
          <td>Dirty Conditions</td>
          <td>E15 Illegal Postering</td>
          <td>Sidewalk</td>
          <td>11228</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>15 AVENUE</td>
          <td>BAY RIDGE PARKWAY</td>
          <td>INTERSECTION</td>
          <td>BROOKLYN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>Closed</td>
          <td>NaN</td>
          <td>The Department of Sanitation has removed illeg...</td>
          <td>06/06/2016 12:00:00 PM</td>
          <td>11 BROOKLYN</td>
          <td>BROOKLYN</td>
          <td>983410</td>
          <td>164301</td>
          <td>Unspecified</td>
          <td>BROOKLYN</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>40.6176</td>
          <td>-74.0030</td>
          <td>(40.61764469366998, -74.00302568205309)</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    pd.read_csv(filepath,nrows=2).tail()




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Unique Key</th>
          <th>Created Date</th>
          <th>Closed Date</th>
          <th>Agency</th>
          <th>Agency Name</th>
          <th>Complaint Type</th>
          <th>Descriptor</th>
          <th>Location Type</th>
          <th>Incident Zip</th>
          <th>Incident Address</th>
          <th>Street Name</th>
          <th>Cross Street 1</th>
          <th>Cross Street 2</th>
          <th>Intersection Street 1</th>
          <th>Intersection Street 2</th>
          <th>Address Type</th>
          <th>City</th>
          <th>Landmark</th>
          <th>Facility Type</th>
          <th>Status</th>
          <th>Due Date</th>
          <th>Resolution Description</th>
          <th>Resolution Action Updated Date</th>
          <th>Community Board</th>
          <th>Borough</th>
          <th>X Coordinate (State Plane)</th>
          <th>Y Coordinate (State Plane)</th>
          <th>Park Facility Name</th>
          <th>Park Borough</th>
          <th>School Name</th>
          <th>School Number</th>
          <th>School Region</th>
          <th>School Code</th>
          <th>School Phone Number</th>
          <th>School Address</th>
          <th>School City</th>
          <th>School State</th>
          <th>School Zip</th>
          <th>School Not Found</th>
          <th>School or Citywide Complaint</th>
          <th>Vehicle Type</th>
          <th>Taxi Company Borough</th>
          <th>Taxi Pick Up Location</th>
          <th>Bridge Highway Name</th>
          <th>Bridge Highway Direction</th>
          <th>Road Ramp</th>
          <th>Bridge Highway Segment</th>
          <th>Garage Lot Name</th>
          <th>Ferry Direction</th>
          <th>Ferry Terminal Name</th>
          <th>Latitude</th>
          <th>Longitude</th>
          <th>Location</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>33504340</td>
          <td>06/03/2016 08:51:27 PM</td>
          <td>06/09/2016 12:41:22 PM</td>
          <td>HPD</td>
          <td>Department of Housing Preservation and Develop...</td>
          <td>UNSANITARY CONDITION</td>
          <td>MOLD</td>
          <td>RESIDENTIAL BUILDING</td>
          <td>10469</td>
          <td>3471 MICKLE AVENUE</td>
          <td>MICKLE AVENUE</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>ADDRESS</td>
          <td>BRONX</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>Closed</td>
          <td>NaN</td>
          <td>The Department of Housing Preservation and Dev...</td>
          <td>06/09/2016 12:41:22 PM</td>
          <td>12 BRONX</td>
          <td>BRONX</td>
          <td>1026814</td>
          <td>259342</td>
          <td>Unspecified</td>
          <td>BRONX</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>40.8784</td>
          <td>-73.8461</td>
          <td>(40.87840550821806, -73.84608300411983)</td>
        </tr>
        <tr>
          <th>1</th>
          <td>33504341</td>
          <td>06/02/2016 03:55:00 PM</td>
          <td>06/06/2016 12:00:00 PM</td>
          <td>DSNY</td>
          <td>A - Illegal Posting Staten Island, Queens and ...</td>
          <td>Dirty Conditions</td>
          <td>E15 Illegal Postering</td>
          <td>Sidewalk</td>
          <td>11228</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>15 AVENUE</td>
          <td>BAY RIDGE PARKWAY</td>
          <td>INTERSECTION</td>
          <td>BROOKLYN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>Closed</td>
          <td>NaN</td>
          <td>The Department of Sanitation has removed illeg...</td>
          <td>06/06/2016 12:00:00 PM</td>
          <td>11 BROOKLYN</td>
          <td>BROOKLYN</td>
          <td>983410</td>
          <td>164301</td>
          <td>Unspecified</td>
          <td>BROOKLYN</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>Unspecified</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>NaN</td>
          <td>40.6176</td>
          <td>-74.0030</td>
          <td>(40.61764469366998, -74.00302568205309)</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    %%bash
    DATA_FILE="${HOME}/Downloads/311_Service_Requests_from_2010_to_Present.csv"
    #wc -l < ${DATA_FILE}


.. parsed-literal::
    :class: myliteral

    Process is interrupted.


.. code:: python

    from sqlalchemy import create_engine
    disk_engine = create_engine('sqlite:///mytest.db') # Initializes database with filename mytest.db in current directory

.. code:: python

    !ls


.. parsed-literal::
    :class: myliteral

    bokeh-try-movies.ipynb	    plotly_js
    Choose my geolocator.ipynb  plotly-sql.ipynb
    ipywidgets		    readme.rst
    matplotlib-demo		    RFXATDASL0S2I8PD3YMI4G53TBDSYK78.png
    nilearn			    sklearn
    old-stuffs		    sqlite3
    Pandas-snippets.ipynb	    streaming
    plotly


Create database file on disk by reading in subset of data
=========================================================

-  above file too big, so let's process subset of it

.. code:: python

    start = dt.datetime.now()
    chunksize = 2000
    j = 0
    index_start = 1
    
    for df in pd.read_csv(filepath, chunksize=chunksize, iterator=True, encoding='utf-8'):
        
        df = df.rename(columns={c: c.replace(' ', '') for c in df.columns}) # Remove spaces from columns
    
        df['CreatedDate'] = pd.to_datetime(df['CreatedDate']) # Convert to datetimes
        df['ClosedDate'] = pd.to_datetime(df['ClosedDate'])
    
        df.index += index_start
    
        # Remove the un-interesting columns
        columns = ['Agency', 'CreatedDate', 'ClosedDate', 'ComplaintType', 'Descriptor',
                   'CreatedDate', 'ClosedDate', 'TimeToCompletion',
                   'City']
    
        for c in df.columns:
            if c not in columns:
                df = df.drop(c, axis=1)    
    
        
        j+=1
        print '{} seconds: completed {} rows'.format((dt.datetime.now() - start).seconds, j*chunksize)
    
        df.to_sql('data', disk_engine, if_exists='append')
        index_start = df.index[-1] + 1
        if j*chunksize >= 10000:
            # i don't want it to get TOO big for this prototype purpose
            break


.. parsed-literal::
    :class: myliteral

    0 seconds: completed 2000 rows
    2 seconds: completed 4000 rows
    3 seconds: completed 6000 rows
    4 seconds: completed 8000 rows
    5 seconds: completed 10000 rows


.. code:: python

    !du -h mytest.db


.. parsed-literal::
    :class: myliteral

    2.8M	mytest.db


Alright, let's preview the table
================================

.. code:: python

    pd.read_sql_query('SELECT * FROM data LIMIT 1', disk_engine).columns.tolist()




.. parsed-literal::
    :class: myliteral

    [u'index',
     u'CreatedDate',
     u'ClosedDate',
     u'Agency',
     u'ComplaintType',
     u'Descriptor',
     u'City']



.. code:: python

    pd.read_sql_query('SELECT * FROM data LIMIT 3', disk_engine)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>index</th>
          <th>CreatedDate</th>
          <th>ClosedDate</th>
          <th>Agency</th>
          <th>ComplaintType</th>
          <th>Descriptor</th>
          <th>City</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1</td>
          <td>2016-06-03 20:51:27.000000</td>
          <td>2016-06-09 12:41:22.000000</td>
          <td>HPD</td>
          <td>UNSANITARY CONDITION</td>
          <td>MOLD</td>
          <td>BRONX</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2</td>
          <td>2016-06-02 15:55:00.000000</td>
          <td>2016-06-06 12:00:00.000000</td>
          <td>DSNY</td>
          <td>Dirty Conditions</td>
          <td>E15 Illegal Postering</td>
          <td>BROOKLYN</td>
        </tr>
        <tr>
          <th>2</th>
          <td>3</td>
          <td>2016-06-03 06:24:00.000000</td>
          <td>2016-06-03 12:00:00.000000</td>
          <td>DSNY</td>
          <td>Dirty Conditions</td>
          <td>E3 Dirty Sidewalk</td>
          <td>STATEN ISLAND</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    pd.read_sql_query('SELECT ComplaintType, Descriptor, Agency '
                      'FROM data '
                      'LIMIT 10', disk_engine)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>ComplaintType</th>
          <th>Descriptor</th>
          <th>Agency</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>UNSANITARY CONDITION</td>
          <td>MOLD</td>
          <td>HPD</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Dirty Conditions</td>
          <td>E15 Illegal Postering</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Dirty Conditions</td>
          <td>E3 Dirty Sidewalk</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Missed Collection (All Materials)</td>
          <td>1 Missed Collection</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Missed Collection (All Materials)</td>
          <td>1 Missed Collection</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>5</th>
          <td>Missed Collection (All Materials)</td>
          <td>2 Bulk-Missed Collection</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>6</th>
          <td>Derelict Vehicles</td>
          <td>14 Derelict Vehicles</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>7</th>
          <td>Noise - Residential</td>
          <td>Loud Music/Party</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>8</th>
          <td>Sanitation Condition</td>
          <td>15 Street Cond/Dump-Out/Drop-Off</td>
          <td>DSNY</td>
        </tr>
        <tr>
          <th>9</th>
          <td>Sanitation Condition</td>
          <td>15 Street Cond/Dump-Out/Drop-Off</td>
          <td>DSNY</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    pd.read_sql_query('SELECT ComplaintType, Descriptor, Agency '
                      'FROM data '
                      'WHERE Agency = "NYPD" '
                      'LIMIT 10', disk_engine)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>ComplaintType</th>
          <th>Descriptor</th>
          <th>Agency</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Noise - Residential</td>
          <td>Loud Music/Party</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Vending</td>
          <td>Unlicensed</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Blocked Driveway</td>
          <td>No Access</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Derelict Vehicle</td>
          <td>With License Plate</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Illegal Parking</td>
          <td>Blocked Hydrant</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>5</th>
          <td>Urinating in Public</td>
          <td>None</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>6</th>
          <td>Noise - Commercial</td>
          <td>Car/Truck Horn</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>7</th>
          <td>Noise - Vehicle</td>
          <td>Car/Truck Horn</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>8</th>
          <td>Illegal Parking</td>
          <td>Commercial Overnight Parking</td>
          <td>NYPD</td>
        </tr>
        <tr>
          <th>9</th>
          <td>Noise - Street/Sidewalk</td>
          <td>Loud Music/Party</td>
          <td>NYPD</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    pd.read_sql_query('SELECT ComplaintType, Descriptor, Agency '
                           'FROM data '
                           'WHERE Agency IN ("NYPD", "DOB")'
                           'LIMIT 50', disk_engine).T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
          <th>21</th>
          <th>22</th>
          <th>23</th>
          <th>24</th>
          <th>25</th>
          <th>26</th>
          <th>27</th>
          <th>28</th>
          <th>29</th>
          <th>30</th>
          <th>31</th>
          <th>32</th>
          <th>33</th>
          <th>34</th>
          <th>35</th>
          <th>36</th>
          <th>37</th>
          <th>38</th>
          <th>39</th>
          <th>40</th>
          <th>41</th>
          <th>42</th>
          <th>43</th>
          <th>44</th>
          <th>45</th>
          <th>46</th>
          <th>47</th>
          <th>48</th>
          <th>49</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>ComplaintType</th>
          <td>Noise - Residential</td>
          <td>Vending</td>
          <td>Blocked Driveway</td>
          <td>Derelict Vehicle</td>
          <td>Illegal Parking</td>
          <td>Urinating in Public</td>
          <td>Noise - Commercial</td>
          <td>Noise - Vehicle</td>
          <td>Illegal Parking</td>
          <td>Noise - Street/Sidewalk</td>
          <td>Illegal Parking</td>
          <td>Noise - Street/Sidewalk</td>
          <td>Non-Emergency Police Matter</td>
          <td>Illegal Parking</td>
          <td>Noise - Residential</td>
          <td>Homeless Encampment</td>
          <td>Noise - Residential</td>
          <td>Noise - Residential</td>
          <td>Blocked Driveway</td>
          <td>Illegal Parking</td>
          <td>Blocked Driveway</td>
          <td>Blocked Driveway</td>
          <td>Illegal Parking</td>
          <td>Illegal Parking</td>
          <td>Noise - Residential</td>
          <td>Noise - Residential</td>
          <td>Noise - Residential</td>
          <td>Noise - Street/Sidewalk</td>
          <td>Blocked Driveway</td>
          <td>Derelict Vehicle</td>
          <td>Noise - Residential</td>
          <td>Blocked Driveway</td>
          <td>General Construction/Plumbing</td>
          <td>Noise - Residential</td>
          <td>Noise - Street/Sidewalk</td>
          <td>Noise - Residential</td>
          <td>Elevator</td>
          <td>General Construction/Plumbing</td>
          <td>General Construction/Plumbing</td>
          <td>Noise - Residential</td>
          <td>Noise - Residential</td>
          <td>Plumbing</td>
          <td>Building/Use</td>
          <td>Special Enforcement</td>
          <td>Building/Use</td>
          <td>General Construction/Plumbing</td>
          <td>General Construction/Plumbing</td>
          <td>General Construction/Plumbing</td>
          <td>Noise - Residential</td>
          <td>Noise - Street/Sidewalk</td>
        </tr>
        <tr>
          <th>Descriptor</th>
          <td>Loud Music/Party</td>
          <td>Unlicensed</td>
          <td>No Access</td>
          <td>With License Plate</td>
          <td>Blocked Hydrant</td>
          <td>None</td>
          <td>Car/Truck Horn</td>
          <td>Car/Truck Horn</td>
          <td>Commercial Overnight Parking</td>
          <td>Loud Music/Party</td>
          <td>Blocked Hydrant</td>
          <td>Loud Music/Party</td>
          <td>Trespassing</td>
          <td>Overnight Commercial Storage</td>
          <td>Loud Talking</td>
          <td>None</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>No Access</td>
          <td>Blocked Sidewalk</td>
          <td>No Access</td>
          <td>No Access</td>
          <td>Double Parked Blocking Traffic</td>
          <td>Blocked Hydrant</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>No Access</td>
          <td>With License Plate</td>
          <td>Loud Music/Party</td>
          <td>No Access</td>
          <td>Cons - Contrary/Beyond Approved Plans/Permits</td>
          <td>Loud Talking</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>Elevator - Defective/Not Working</td>
          <td>Egress - Doors Locked/Blocked/Improper/No Seco...</td>
          <td>Working Contrary To Stop Work Order</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
          <td>Failure To Retain Water/Improper Drainage- (LL...</td>
          <td>Illegal Conversion Of Residential Building/Space</td>
          <td>SEP - Professional Certification Compliance Audit</td>
          <td>Illegal Conversion Of Residential Building/Space</td>
          <td>Site Conditions Endangering Workers</td>
          <td>Working Contrary To Stop Work Order</td>
          <td>Sidewalk Shed/Pipe Scafford - Inadequate Defec...</td>
          <td>Loud Music/Party</td>
          <td>Loud Music/Party</td>
        </tr>
        <tr>
          <th>Agency</th>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>DOB</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>NYPD</td>
          <td>NYPD</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>DOB</td>
          <td>NYPD</td>
          <td>NYPD</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    # unique values with DISTINCT (recall pyspark)
    pd.read_sql_query('SELECT DISTINCT City FROM data', disk_engine).T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
          <th>21</th>
          <th>22</th>
          <th>23</th>
          <th>24</th>
          <th>25</th>
          <th>26</th>
          <th>27</th>
          <th>28</th>
          <th>29</th>
          <th>30</th>
          <th>31</th>
          <th>32</th>
          <th>33</th>
          <th>34</th>
          <th>35</th>
          <th>36</th>
          <th>37</th>
          <th>38</th>
          <th>39</th>
          <th>40</th>
          <th>41</th>
          <th>42</th>
          <th>43</th>
          <th>44</th>
          <th>45</th>
          <th>46</th>
          <th>47</th>
          <th>48</th>
          <th>49</th>
          <th>50</th>
          <th>51</th>
          <th>52</th>
          <th>53</th>
          <th>54</th>
          <th>55</th>
          <th>56</th>
          <th>57</th>
          <th>58</th>
          <th>59</th>
          <th>60</th>
          <th>61</th>
          <th>62</th>
          <th>63</th>
          <th>64</th>
          <th>65</th>
          <th>66</th>
          <th>67</th>
          <th>68</th>
          <th>69</th>
          <th>70</th>
          <th>71</th>
          <th>72</th>
          <th>73</th>
          <th>74</th>
          <th>75</th>
          <th>76</th>
          <th>77</th>
          <th>78</th>
          <th>79</th>
          <th>80</th>
          <th>81</th>
          <th>82</th>
          <th>83</th>
          <th>84</th>
          <th>85</th>
          <th>86</th>
          <th>87</th>
          <th>88</th>
          <th>89</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>City</th>
          <td>BRONX</td>
          <td>BROOKLYN</td>
          <td>STATEN ISLAND</td>
          <td>South Richmond Hill</td>
          <td>NEW YORK</td>
          <td>Rego Park</td>
          <td>CORONA</td>
          <td>Maspeth</td>
          <td>WOODHAVEN</td>
          <td>ROCKAWAY PARK</td>
          <td>None</td>
          <td>QUEENS VILLAGE</td>
          <td>FAR ROCKAWAY</td>
          <td>ASTORIA</td>
          <td>Jamaica</td>
          <td>HOLLIS</td>
          <td>Richmond Hill</td>
          <td>SAINT ALBANS</td>
          <td>EAST ELMHURST</td>
          <td>Corona</td>
          <td>Astoria</td>
          <td>Whitestone</td>
          <td>Queens Village</td>
          <td>Elmhurst</td>
          <td>Bayside</td>
          <td>Fresh Meadows</td>
          <td>Middle Village</td>
          <td>Flushing</td>
          <td>Jackson Heights</td>
          <td>Arverne</td>
          <td>Rosedale</td>
          <td>Saint Albans</td>
          <td>Woodside</td>
          <td>Sunnyside</td>
          <td>Forest Hills</td>
          <td>FRESH MEADOWS</td>
          <td>ELMHURST</td>
          <td>SOUTH OZONE PARK</td>
          <td>WOODSIDE</td>
          <td>FLUSHING</td>
          <td>LONG ISLAND CITY</td>
          <td>RICHMOND HILL</td>
          <td>RIDGEWOOD</td>
          <td>LITTLE NECK</td>
          <td>OZONE PARK</td>
          <td>MIDDLE VILLAGE</td>
          <td>HOWARD BEACH</td>
          <td>FOREST HILLS</td>
          <td>South Ozone Park</td>
          <td>SUNNYSIDE</td>
          <td>JAMAICA</td>
          <td>BAYSIDE</td>
          <td>Far Rockaway</td>
          <td>KEW GARDENS</td>
          <td>OAKLAND GARDENS</td>
          <td>Long Island City</td>
          <td>Woodhaven</td>
          <td>Cambria Heights</td>
          <td>SOUTH RICHMOND HILL</td>
          <td>FLORAL PARK</td>
          <td>Springfield Gardens</td>
          <td>East Elmhurst</td>
          <td>Bellerose</td>
          <td>Little Neck</td>
          <td>Ozone Park</td>
          <td>MASPETH</td>
          <td>Ridgewood</td>
          <td>Glen Oaks</td>
          <td>WHITESTONE</td>
          <td>CAMBRIA HEIGHTS</td>
          <td>JACKSON HEIGHTS</td>
          <td>SPRINGFIELD GARDENS</td>
          <td>COLLEGE POINT</td>
          <td>Oakland Gardens</td>
          <td>Hollis</td>
          <td>College Point</td>
          <td>ROSEDALE</td>
          <td>GLEN OAKS</td>
          <td>REGO PARK</td>
          <td>Howard Beach</td>
          <td>ARVERNE</td>
          <td>Kew Gardens</td>
          <td>BELLEROSE</td>
          <td>NEW HYDE PARK</td>
          <td>Rockaway Park</td>
          <td>NEWARK</td>
          <td>Floral Park</td>
          <td>BELLMORE</td>
          <td>PARSIPPANY</td>
          <td>PELHAM MANOR</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    pd.read_sql_query('SELECT Agency, COUNT(*) as `num_complaints`'
                      'FROM data '
                      'GROUP BY Agency ', disk_engine).T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Agency</th>
          <td>3-1-1</td>
          <td>DCA</td>
          <td>DEP</td>
          <td>DFTA</td>
          <td>DHS</td>
          <td>DOB</td>
          <td>DOE</td>
          <td>DOF</td>
          <td>DOHMH</td>
          <td>DOITT</td>
          <td>DOT</td>
          <td>DPR</td>
          <td>DSNY</td>
          <td>EDC</td>
          <td>FDNY</td>
          <td>HPD</td>
          <td>HRA</td>
          <td>NYCEM</td>
          <td>NYPD</td>
          <td>OPS</td>
          <td>TLC</td>
        </tr>
        <tr>
          <th>num_complaints</th>
          <td>21</td>
          <td>183</td>
          <td>1673</td>
          <td>59</td>
          <td>514</td>
          <td>716</td>
          <td>22</td>
          <td>503</td>
          <td>739</td>
          <td>20</td>
          <td>2290</td>
          <td>1053</td>
          <td>1945</td>
          <td>4</td>
          <td>87</td>
          <td>3230</td>
          <td>181</td>
          <td>2</td>
          <td>8989</td>
          <td>2</td>
          <td>267</td>
        </tr>
      </tbody>
    </table>
    </div>



K, let's do some plotly
=======================

Housing and Development Dept receives the most complaints
=========================================================

.. code:: python

    df = pd.read_sql_query('SELECT Agency, COUNT(*) as `num_complaints`'
                           'FROM data '
                           'GROUP BY Agency '
                           'ORDER BY -num_complaints', disk_engine)
    df.T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Agency</th>
          <td>NYPD</td>
          <td>HPD</td>
          <td>DOT</td>
          <td>DSNY</td>
          <td>DEP</td>
          <td>DPR</td>
          <td>DOHMH</td>
          <td>DOB</td>
          <td>DHS</td>
          <td>DOF</td>
          <td>TLC</td>
          <td>DCA</td>
          <td>HRA</td>
          <td>FDNY</td>
          <td>DFTA</td>
          <td>DOE</td>
          <td>3-1-1</td>
          <td>DOITT</td>
          <td>EDC</td>
          <td>NYCEM</td>
          <td>OPS</td>
        </tr>
        <tr>
          <th>num_complaints</th>
          <td>8989</td>
          <td>3230</td>
          <td>2290</td>
          <td>1945</td>
          <td>1673</td>
          <td>1053</td>
          <td>739</td>
          <td>716</td>
          <td>514</td>
          <td>503</td>
          <td>267</td>
          <td>183</td>
          <td>181</td>
          <td>87</td>
          <td>59</td>
          <td>22</td>
          <td>21</td>
          <td>20</td>
          <td>4</td>
          <td>2</td>
          <td>2</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    py.iplot([Bar(x=df.Agency, y=df.num_complaints)], filename='311/most common complaints by agency')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/159.embed" height="525px" width="100%"></iframe>



Heat / Hot Water is the most common complaint
=============================================

.. code:: python

    df = pd.read_sql_query('SELECT ComplaintType, COUNT(*) as `num_complaints`, Agency '
                           'FROM data '
                           'GROUP BY `ComplaintType` '
                           'ORDER BY -num_complaints', disk_engine)
    
    
    most_common_complaints = df # used later

.. code:: python

    py.iplot({
        'data': [Bar(x=df['ComplaintType'], y=df.num_complaints)],
        'layout': { 
            'margin': {'b': 150}, # Make the bottom margin a bit bigger to handle the long text
            'xaxis': {'tickangle': 40}} # Angle the labels a bit
        }, filename='311/most common complaints by complaint type')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/161.embed" height="525px" width="100%"></iframe>



What's the most complain in each city?
======================================

.. code:: python

    # number of cities recorded in the data
    len(pd.read_sql_query('SELECT DISTINCT City FROM data', disk_engine))




.. parsed-literal::
    :class: myliteral

    90



.. code:: python

    pd.read_sql_query('SELECT City, COUNT(*) as `num_complaints` '
                      'FROM data '
                      'GROUP BY `City` '
                      'ORDER BY -num_complaints '
                      'LIMIT 25 ', disk_engine).T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
          <th>21</th>
          <th>22</th>
          <th>23</th>
          <th>24</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>City</th>
          <td>BROOKLYN</td>
          <td>NEW YORK</td>
          <td>BRONX</td>
          <td>None</td>
          <td>STATEN ISLAND</td>
          <td>ASTORIA</td>
          <td>JAMAICA</td>
          <td>FLUSHING</td>
          <td>Jamaica</td>
          <td>RIDGEWOOD</td>
          <td>CORONA</td>
          <td>OZONE PARK</td>
          <td>Astoria</td>
          <td>Flushing</td>
          <td>ELMHURST</td>
          <td>WOODSIDE</td>
          <td>SOUTH RICHMOND HILL</td>
          <td>LONG ISLAND CITY</td>
          <td>RICHMOND HILL</td>
          <td>QUEENS VILLAGE</td>
          <td>Ridgewood</td>
          <td>SOUTH OZONE PARK</td>
          <td>EAST ELMHURST</td>
          <td>FRESH MEADOWS</td>
          <td>JACKSON HEIGHTS</td>
        </tr>
        <tr>
          <th>num_complaints</th>
          <td>6793</td>
          <td>4655</td>
          <td>3571</td>
          <td>1071</td>
          <td>1036</td>
          <td>296</td>
          <td>249</td>
          <td>227</td>
          <td>215</td>
          <td>205</td>
          <td>172</td>
          <td>153</td>
          <td>145</td>
          <td>144</td>
          <td>125</td>
          <td>117</td>
          <td>107</td>
          <td>106</td>
          <td>104</td>
          <td>102</td>
          <td>96</td>
          <td>95</td>
          <td>91</td>
          <td>91</td>
          <td>89</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    # repeat above but with case insentivitiy
    df = pd.read_sql_query('SELECT City, COUNT(*) as `num_complaints` '
                            'FROM data '
                            'GROUP BY `City` '
                            'COLLATE NOCASE '
                            'ORDER BY -num_complaints '
                            'LIMIT 11 ', disk_engine)
    df




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>City</th>
          <th>num_complaints</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>BROOKLYN</td>
          <td>6793</td>
        </tr>
        <tr>
          <th>1</th>
          <td>NEW YORK</td>
          <td>4655</td>
        </tr>
        <tr>
          <th>2</th>
          <td>BRONX</td>
          <td>3571</td>
        </tr>
        <tr>
          <th>3</th>
          <td>None</td>
          <td>1071</td>
        </tr>
        <tr>
          <th>4</th>
          <td>STATEN ISLAND</td>
          <td>1036</td>
        </tr>
        <tr>
          <th>5</th>
          <td>JAMAICA</td>
          <td>464</td>
        </tr>
        <tr>
          <th>6</th>
          <td>ASTORIA</td>
          <td>441</td>
        </tr>
        <tr>
          <th>7</th>
          <td>FLUSHING</td>
          <td>371</td>
        </tr>
        <tr>
          <th>8</th>
          <td>RIDGEWOOD</td>
          <td>301</td>
        </tr>
        <tr>
          <th>9</th>
          <td>CORONA</td>
          <td>253</td>
        </tr>
        <tr>
          <th>10</th>
          <td>OZONE PARK</td>
          <td>221</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    cities = list(df.City)
    print cities


.. parsed-literal::
    :class: myliteral

    [u'BROOKLYN', u'NEW YORK', u'BRONX', None, u'STATEN ISLAND', u'JAMAICA', u'ASTORIA', u'FLUSHING', u'RIDGEWOOD', u'CORONA', u'OZONE PARK']


.. code:: python

    # oh, remove NONE!
    cities.remove(None)
    from pprint import pprint
    pprint(cities)


.. parsed-literal::
    :class: myliteral

    [u'BROOKLYN',
     u'NEW YORK',
     u'BRONX',
     u'STATEN ISLAND',
     u'JAMAICA',
     u'ASTORIA',
     u'FLUSHING',
     u'RIDGEWOOD',
     u'CORONA',
     u'OZONE PARK']


.. code:: python

    traces = [] # the series in the graph - one trace for each city
    
    for city in cities:
        df = pd.read_sql_query('SELECT ComplaintType, COUNT(*) as `num_complaints` '
                               'FROM data '
                               'WHERE City = "{}" COLLATE NOCASE '
                               'GROUP BY `ComplaintType` '
                               'ORDER BY -num_complaints'.format(city), disk_engine)
    
        traces.append(Bar(x=df['ComplaintType'], y=df.num_complaints, name=city.capitalize()))

.. code:: python

    py.iplot({'data': traces, 
              'layout': Layout(barmode='stack', 
                               xaxis={'tickangle': 40}, 
                               margin={'b': 150})}, 
             filename='311/complaints by city stacked')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/163.embed" height="525px" width="100%"></iframe>



.. code:: python

    # normalize the counts
    for trace in traces:
        trace['y'] = 100.*trace['y']/sum(trace['y'])

.. code:: python

    py.iplot({'data': traces, 
              'layout': Layout(
                    barmode='group',
                    xaxis={'tickangle': 40, 'autorange': False, 'range': [-0.5, 16]},
                    yaxis={'title': 'Percent of Complaints by City'},
                    margin={'b': 150},
                    title='Relative Number of 311 Complaints by City')
             }, filename='311/relative complaints by city', validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/165.embed" height="525px" width="100%"></iframe>



Conclusion
==========

::

    New York is loud
    Staten Island is moldy, wet, and vacant
    Flushing's muni meters are broken
    Trash collection is great in the Bronx
    Woodside doesn't like its graffiti

Part2: Slite3 timeseries with pandas
====================================

Filter SQLite rows with timestamp strings: YYYY-MM-DD hh:mm:ss

.. code:: python

    pd.read_sql_query('SELECT ComplaintType, CreatedDate, City '
                           'FROM data '
                           'WHERE CreatedDate < "2014-11-16 23:47:00" '
                           'AND CreatedDate > "2014-11-16 23:45:00"', disk_engine)




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>ComplaintType</th>
          <th>CreatedDate</th>
          <th>City</th>
        </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
    </div>



.. code:: python

    # Pull out the hour unit from timestamps with strftime
    df = pd.read_sql_query('SELECT CreatedDate, '
                                  'strftime(\'%H\', CreatedDate) as hour, '
                                  'ComplaintType '
                           'FROM data '
                           'LIMIT 5 ', disk_engine)
    df.head()
    





.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>CreatedDate</th>
          <th>hour</th>
          <th>ComplaintType</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2016-06-03 20:51:27.000000</td>
          <td>20</td>
          <td>UNSANITARY CONDITION</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2016-06-02 15:55:00.000000</td>
          <td>15</td>
          <td>Dirty Conditions</td>
        </tr>
        <tr>
          <th>2</th>
          <td>2016-06-03 06:24:00.000000</td>
          <td>06</td>
          <td>Dirty Conditions</td>
        </tr>
        <tr>
          <th>3</th>
          <td>2016-06-03 09:10:00.000000</td>
          <td>09</td>
          <td>Missed Collection (All Materials)</td>
        </tr>
        <tr>
          <th>4</th>
          <td>2016-06-03 10:39:00.000000</td>
          <td>10</td>
          <td>Missed Collection (All Materials)</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    df = pd.read_sql_query('SELECT CreatedDate, '
                           'strftime(\'%H\', CreatedDate) as hour,  '
                           'count(*) as `Complaints per Hour`'
                           'FROM data '
                           'GROUP BY hour', disk_engine)
    df.T




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>0</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>10</th>
          <th>11</th>
          <th>12</th>
          <th>13</th>
          <th>14</th>
          <th>15</th>
          <th>16</th>
          <th>17</th>
          <th>18</th>
          <th>19</th>
          <th>20</th>
          <th>21</th>
          <th>22</th>
          <th>23</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>CreatedDate</th>
          <td>2016-06-05 00:00:00.000000</td>
          <td>2016-06-05 01:26:07.000000</td>
          <td>2016-06-05 02:03:50.000000</td>
          <td>2016-06-04 03:51:13.000000</td>
          <td>2016-06-04 04:38:14.000000</td>
          <td>2016-06-04 05:40:45.000000</td>
          <td>2016-06-04 06:30:39.000000</td>
          <td>2016-06-04 07:59:53.000000</td>
          <td>2016-06-04 08:33:42.000000</td>
          <td>2016-06-04 09:17:24.000000</td>
          <td>2016-06-04 10:20:14.000000</td>
          <td>2016-06-04 11:52:55.000000</td>
          <td>2016-06-04 12:42:13.000000</td>
          <td>2016-06-04 13:19:24.000000</td>
          <td>2016-06-04 14:36:15.000000</td>
          <td>2016-06-04 15:33:31.000000</td>
          <td>2016-06-04 16:21:14.000000</td>
          <td>2016-06-04 17:32:36.000000</td>
          <td>2016-06-04 18:29:05.000000</td>
          <td>2016-06-04 19:24:21.000000</td>
          <td>2016-06-03 20:25:00.000000</td>
          <td>2016-06-04 21:00:38.000000</td>
          <td>2016-06-04 22:21:44.000000</td>
          <td>2016-06-04 23:22:55.000000</td>
        </tr>
        <tr>
          <th>hour</th>
          <td>00</td>
          <td>01</td>
          <td>02</td>
          <td>03</td>
          <td>04</td>
          <td>05</td>
          <td>06</td>
          <td>07</td>
          <td>08</td>
          <td>09</td>
          <td>10</td>
          <td>11</td>
          <td>12</td>
          <td>13</td>
          <td>14</td>
          <td>15</td>
          <td>16</td>
          <td>17</td>
          <td>18</td>
          <td>19</td>
          <td>20</td>
          <td>21</td>
          <td>22</td>
          <td>23</td>
        </tr>
        <tr>
          <th>Complaints per Hour</th>
          <td>1622</td>
          <td>889</td>
          <td>377</td>
          <td>186</td>
          <td>146</td>
          <td>176</td>
          <td>287</td>
          <td>599</td>
          <td>995</td>
          <td>1224</td>
          <td>1613</td>
          <td>1430</td>
          <td>1319</td>
          <td>1027</td>
          <td>1185</td>
          <td>1078</td>
          <td>1241</td>
          <td>1087</td>
          <td>870</td>
          <td>722</td>
          <td>866</td>
          <td>1002</td>
          <td>1262</td>
          <td>1297</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: python

    py.iplot({
        'data': [Bar(x=df['hour'], y=df['Complaints per Hour'])],
        'layout': Layout(xaxis={'title': 'Hour in Day'},
                         yaxis={'title': 'Number of Complaints'})}, filename='311/complaints per hour')
    





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/167.embed" height="525px" width="100%"></iframe>



Filter noise complaints by hour
===============================

.. code:: python

    df = pd.read_sql_query('SELECT CreatedDate, '
                                   'strftime(\'%H\', CreatedDate) as `hour`,  '
                                   'count(*) as `Complaints per Hour`'
                           'FROM data '
                           'WHERE ComplaintType IN ("Noise", '
                                                   '"Noise - Street/Sidewalk", '
                                                   '"Noise - Commercial", '
                                                   '"Noise - Vehicle", '
                                                   '"Noise - Park", '
                                                   '"Noise - House of Worship", '
                                                   '"Noise - Helicopter", '
                                                   '"Collection Truck Noise") '
                           'GROUP BY hour', disk_engine)
    
    display(df.head(n=2))
    
    py.iplot({
        'data': [Bar(x=df['hour'], y=df['Complaints per Hour'])],
        'layout': Layout(xaxis={'title': 'Hour in Day'},
                         yaxis={'title': 'Number of Complaints'},
                         title='Number of Noise Complaints in NYC by Hour in Day'
                        )}, filename='311/noise complaints per hour')



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>CreatedDate</th>
          <th>hour</th>
          <th>Complaints per Hour</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2016-06-05 00:15:44.000000</td>
          <td>00</td>
          <td>383</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2016-06-05 01:51:56.000000</td>
          <td>01</td>
          <td>291</td>
        </tr>
      </tbody>
    </table>
    </div>




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/169.embed" height="525px" width="100%"></iframe>



Segregate complaints by hour
============================

.. code:: python

    complaint_traces = {} # Each series in the graph will represent a complaint
    complaint_traces['Other'] = {}
    
    for hour in range(1, 24):
        hour_str = '0'+str(hour) if hour < 10 else str(hour)
        df = pd.read_sql_query('SELECT  CreatedDate, '
                                       'ComplaintType ,'
                                       'strftime(\'%H\', CreatedDate) as `hour`,  '
                                       'COUNT(*) as num_complaints '
                               'FROM data '
                               'WHERE hour = "{}" '
                               'GROUP BY ComplaintType '
                               'ORDER BY -num_complaints'.format(hour_str), disk_engine)
        
        complaint_traces['Other'][hour] = sum(df.num_complaints)
        
        # Grab the 7 most common complaints for that hour
        for i in range(7):
            complaint = df.get_value(i, 'ComplaintType')
            count = df.get_value(i, 'num_complaints')
            complaint_traces['Other'][hour] -= count
            if complaint in complaint_traces:
                complaint_traces[complaint][hour] = count
            else:
                complaint_traces[complaint] = {hour: count}

.. code:: python

    traces = []
    for complaint in complaint_traces:
        traces.append({
            'x': range(25),
            'y': [complaint_traces[complaint].get(i, None) for i in range(25)],
            'name': complaint,
            'type': 'bar'
        })
    
    py.iplot({
        'data': traces, 
        'layout': {
            'barmode': 'stack',
            'xaxis': {'title': 'Hour in Day'},
            'yaxis': {'title': 'Number of Complaints'},
            'title': 'The 7 Most Common 311 Complaints by Hour in a Day'
        }}, filename='311/most common complaints by hour')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/171.embed" height="525px" width="100%"></iframe>



Aggregate time series
=====================

.. code:: python

    # First, create a new column with timestamps rounded to the previous 15 minute interval
    
    
    minutes = 15
    seconds = 15*60
    
    df = pd.read_sql_query('SELECT CreatedDate, '
                                   'datetime(('
                                       'strftime(\'%s\', CreatedDate) / {seconds}) * {seconds}, \'unixepoch\') interval '
                           'FROM data '
                           'LIMIT 10 '.format(seconds=seconds), disk_engine)
    
    display(df.head())
    




.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>CreatedDate</th>
          <th>interval</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2016-06-03 20:51:27.000000</td>
          <td>2016-06-03 20:45:00</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2016-06-02 15:55:00.000000</td>
          <td>2016-06-02 15:45:00</td>
        </tr>
        <tr>
          <th>2</th>
          <td>2016-06-03 06:24:00.000000</td>
          <td>2016-06-03 06:15:00</td>
        </tr>
        <tr>
          <th>3</th>
          <td>2016-06-03 09:10:00.000000</td>
          <td>2016-06-03 09:00:00</td>
        </tr>
        <tr>
          <th>4</th>
          <td>2016-06-03 10:39:00.000000</td>
          <td>2016-06-03 10:30:00</td>
        </tr>
      </tbody>
    </table>
    </div>


.. code:: python

    # Then, GROUP BY that interval and COUNT(*)
    
    minutes = 15
    seconds = minutes*60
    
    df = pd.read_sql_query('SELECT datetime(('
                                       'strftime(\'%s\', CreatedDate) / {seconds}) * {seconds}, \'unixepoch\') interval ,'
                                   'COUNT(*) as "Complaints / interval"'
                           'FROM data '
                           'GROUP BY interval '
                           'ORDER BY interval '
                           'LIMIT 500'.format(seconds=seconds), disk_engine)
    
    display(df.head())
    display(df.tail())



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>interval</th>
          <th>Complaints / interval</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2016-05-25 00:00:00</td>
          <td>2</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2016-05-31 20:30:00</td>
          <td>2</td>
        </tr>
        <tr>
          <th>2</th>
          <td>2016-05-31 22:30:00</td>
          <td>3</td>
        </tr>
        <tr>
          <th>3</th>
          <td>2016-06-01 08:00:00</td>
          <td>4</td>
        </tr>
        <tr>
          <th>4</th>
          <td>2016-06-01 08:45:00</td>
          <td>3</td>
        </tr>
      </tbody>
    </table>
    </div>



.. raw:: html

    <div>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>interval</th>
          <th>Complaints / interval</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>249</th>
          <td>2016-06-05 01:30:00</td>
          <td>103</td>
        </tr>
        <tr>
          <th>250</th>
          <td>2016-06-05 01:45:00</td>
          <td>77</td>
        </tr>
        <tr>
          <th>251</th>
          <td>2016-06-05 02:00:00</td>
          <td>57</td>
        </tr>
        <tr>
          <th>252</th>
          <td>2016-06-05 12:45:00</td>
          <td>2</td>
        </tr>
        <tr>
          <th>253</th>
          <td>2016-06-05 17:15:00</td>
          <td>2</td>
        </tr>
      </tbody>
    </table>
    </div>


.. code:: python

    # === too dense of a data ... ===
    # py.iplot(
    #     {
    #         'data': [{
    #             'x': df.interval,
    #             'y': df['Complaints / interval'],
    #             'type': 'bar'
    #         }],
    #         'layout': {
    #             'title': 'Number of 311 Complaints per 15 Minutes'
    #         }
    # }, filename='311/complaints per 15 minutes')

