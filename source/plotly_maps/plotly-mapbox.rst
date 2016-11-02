#############
plotly-mapbox
#############

https://plot.ly/python/scattermapbox/

.. contents:: `Contents`
   :depth: 2
   :local:


.. code:: python

    import plotly.plotly as py
    import plotly.graph_objs as go
    import plotly.tools as tls
    from plotly.tools import FigureFactory as FF
    
    import cufflinks as cf
    from IPython.display import display

Basic Example
=============

.. code:: python

    # get my mapbox token
    from os.path import expanduser
    
    with open(expanduser('~/mapbox-token-tak'), 'r') as f:
        mapbox_access_token = f.read()

Define trace (Scattermapbox object)
===================================

.. code:: python

    trace= go.Scattermapbox(
            lat=['45.5017'],
            lon=['-73.5673'],
            mode='markers',
            marker=go.Marker(size=14),
            text=['Montreal'],
        )
    data = [trace]

Define layout
=============

.. code:: python

    mapbox=dict(accesstoken=mapbox_access_token,
                bearing=0,
                pitch=0,
                zoom=5,
                center=dict(lat=45,lon=-73))

.. code:: python

    layout = go.Layout(
        autosize=True,
        hovermode='closest',
        mapbox=mapbox,
    )


Plot!
=====

.. code:: python

    fig = dict(data=data, layout=layout)
    py.iplot(fig, filename='Montreal Mapbox', validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1147.embed?share_key=mlrXSKjkW2N8PE8zJeyXqD" height="525px" width="100%"></iframe>



Multiple Markers
================

.. code:: python

    data = [
        go.Scattermapbox(
            lat=['38.91427','38.91538','38.91458',
                 '38.92239','38.93222','38.90842',
                 '38.91931','38.93260','38.91368',
                 '38.88516','38.921894','38.93206',
                 '38.91275'],
            lon=['-77.02827','-77.02013','-77.03155',
                 '-77.04227','-77.02854','-77.02419',
                 '-77.02518','-77.03304','-77.04509',
                 '-76.99656','-77.042438','-77.02821',
                 '-77.01239'],
            mode='markers',
            marker=go.Marker(size=9),
            text=["The coffee bar","Bistro Bohem","Black Cat",
                 "Snap","Columbia Heights Coffee","Azi's Cafe",
                 "Blind Dog Cafe","Le Caprice","Filter",
                 "Peregrine","Tryst","The Coupe",
                 "Big Bear Cafe"],
        )
    ]

.. code:: python

    layout = go.Layout(
        autosize=True,
        hovermode='closest',
        mapbox=dict(
            accesstoken=mapbox_access_token,
            bearing=0,
            center=dict(lat=38.92,lon=-77.07),
            pitch=0,
            zoom=10
        ),
    )

.. code:: python

    fig = dict(data=data, layout=layout)
    py.iplot(fig, filename='Multiple Mapbox', validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1149.embed?share_key=Uffqb5p6dJv5dHTIFXkMhF" height="525px" width="100%"></iframe>



County-level
============

.. code:: python

    import urllib
    import requests
    import json

.. code:: python

    url = 'http://catalog.civicdashboards.com/dataset/'
    url += 'cda82e8b-7a8b-411e-95ba-1200b921c35d/resource/5c5d19a0-b817-49e6-b76e-ea63a8e2c0f6/'
    url += 'download/fd880c1e4d23463ca869f1122109b3eftemp.geojson'
    url




.. parsed-literal::

    'http://catalog.civicdashboards.com/dataset/cda82e8b-7a8b-411e-95ba-1200b921c35d/resource/5c5d19a0-b817-49e6-b76e-ea63a8e2c0f6/download/fd880c1e4d23463ca869f1122109b3eftemp.geojson'



.. code:: python

    request_ = requests.get(url)
    print request_


.. parsed-literal::

    <Response [200]>


.. code:: python

    florida_data = request_.json()
    # print florida_data

.. code:: python

    repub_democ_counties_url = 'http://dos.myflorida.com/elections/data-statistics/voter-registration-statistics/voter-registration-monthly-reports/voter-registration-current-by-county/'
    repub_democ_counties = urllib.urlopen(repub_democ_counties_url).read()

Since we want to separate the counties into Republican and Democratic
for the seperate coloring, and since the county names in the GeoJSON are
fuller text descriptions of each county on the website, we need to parse
through and convert the names in the GeoJSON to the website format

.. code:: python

    county_names = []
    county_names_dict = {}
    
    for county in florida_data['features']:
        for m in range(len(county['properties']['name'])):
            if county['properties']['name'][m:m+6] == 'County':
                county_names.append(county['properties']['name'][0:m-1])
                county_names_dict[county['properties']['name'][0:m-1]] = county['properties']['name']
                
    print county_names


.. parsed-literal::

    [u'Charlotte', u'Seminole', u'Baker', u'DeSoto', u'Levy', u'Alachua', u'Pasco', u'Hendry', u'Okeechobee', u'Broward', u'St. Johns', u'Gulf', u'Glades', u'Marion', u'Duval', u'Madison', u'Osceola', u'Lee', u'Volusia', u'Sarasota', u'Indian River', u'Clay', u'Putnam', u'Wakulla', u'Holmes', u'Escambia', u'Flagler', u'Union', u'Brevard', u'Suwannee', u'Orange', u'Martin', u'Nassau', u'Jefferson', u'Santa Rosa', u'Hamilton', u'Calhoun', u'Hernando', u'Miami-Dade', u'Pinellas', u'Palm Beach', u'Hillsborough', u'Collier', u'Gilchrist', u'Dixie', u'Bay', u'Gadsden', u'Okaloosa', u'Citrus', u'Lafayette', u'Manatee', u'Monroe', u'Columbia', u'Sumter', u'Washington', u'St. Lucie', u'Polk', u'Taylor', u'Leon', u'Lake', u'Highlands', u'Hardee', u'Bradford', u'Liberty', u'Franklin', u'Walton', u'Jackson']


Color the Counties
==================

We now run a script to color our counties based on political party. This
involves parsing through our list of counties, finding their
cooresponding Republican/Democratic votes on the website, and place our
data into the cooresponding list red\_counties or blue\_counties, based
on which party has more votes

.. code:: python

    red_counties = []
    blue_counties = []
    
    for k, county in enumerate(county_names):
        for j in range(len(repub_democ_counties)):
            county_len = len(county)
            if repub_democ_counties[j:j+county_len] == string.upper(county):
                new_j = j
    
                while True:
                    try:
                        int(repub_democ_counties[new_j])
                        break
                    except ValueError:
                        new_j += 1
    
        repub_votes = ''
        while repub_democ_counties[new_j] != '<':
            if repub_democ_counties[new_j] != ',':
                repub_votes += repub_democ_counties[new_j]
            new_j += 1
        
        # advance to next set of numbers
        new_j += 11
    
        democ_votes = ''
        while repub_democ_counties[new_j] != '<':
            if repub_democ_counties[new_j] != ',':
                democ_votes += repub_democ_counties[new_j]
            new_j += 1
    
        repub_votes = int(repub_votes)
        democ_votes = int(democ_votes)
    
        if repub_votes >= democ_votes:
            red_counties.append(florida_data['features'][k])
        else:
            blue_counties.append(florida_data['features'][k])


.. parsed-literal::

    /home/takanori/anaconda2/lib/python2.7/site-packages/ipykernel/__main__.py:7: UnicodeWarning:
    
    Unicode equal comparison failed to convert both arguments to Unicode - interpreting them as being unequal
    


Create JSON Files
=================

.. code:: python

    red_data = {"type": "FeatureCollection"}
    red_data['features'] = red_counties
    
    blue_data = {"type": "FeatureCollection"}
    blue_data['features'] = blue_counties
    
    with open('florida-red-data.json', 'w') as f:
        f.write(json.dumps(red_data))
    with open('florida-blue-data.json', 'w') as f:
        f.write(json.dumps(blue_data))

.. code:: python

    !ls -lh


.. parsed-literal::

    total 360K
    -rw-r--r-- 1 takanori takanori  29K Sep 29 15:40 Choropleth Maps.ipynb
    -rw-r--r-- 1 takanori takanori 140K Sep 29 16:04 florida-blue-data.json
    -rw-r--r-- 1 takanori takanori 160K Sep 29 16:04 florida-red-data.json
    -rw-r--r-- 1 takanori takanori 9.6K Sep 29 16:03 plotly-mapbox.ipynb


Define data (easy part)
=======================

.. code:: python

    data = [go.Scattermapbox(lat=['45.5017'],lon=['-73.5673'],mode='markers')]

Define layout (hard part)
=========================

.. code:: python

    layers=[
        dict(
            sourcetype = 'geojson',
            #source = 'https://raw.githubusercontent.com/plotly/datasets/master/florida-red-data.json',
            #source = 'florida-red-data.json', # <- nope, doesn't work
            source = red_data,
            type = 'fill',
            color = 'rgba(163,22,19,0.8)'
        ),
        dict(
            sourcetype = 'geojson',
            source = blue_data,
            #source = 'florida-blue-data.json',
            #source = 'https://raw.githubusercontent.com/plotly/datasets/master/florida-blue-data.json',
            type = 'fill',
            color = 'rgba(40,0,113,0.8)'
        )
    ]

.. code:: python

    layout = go.Layout(
        height=600,
        autosize=True,
        hovermode='closest',
        mapbox=dict(
            layers=layers,
            accesstoken=mapbox_access_token,
            bearing=0,
            center=dict(lat=27.8,lon=-83),
            pitch=0,
            zoom=5.2,
            style='light'
        ),
    )
    
    fig = dict(data=data, layout=layout)
    py.iplot(fig, filename='county-level-choropleths-python')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/1151.embed?share_key=zh5NeBIdvi4hHSTlr0qNXF" height="600px" width="100%"></iframe>


