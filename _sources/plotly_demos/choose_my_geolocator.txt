
Choose my Geolocator
====================

.. contents:: `Contents`
   :depth: 2
   :local:


Given there's so many options on geolocator APIs, here I'm trying a few
options.

The goal is to pinpoint Wharton's `Huntsman
Hall <http://www.facilities.upenn.edu/maps/locations/huntsman-hall-jon-m>`__
from its address, and locate it on `Mapbox <https://www.mapbox.com/>`__
service

.. code:: python

    # get my mapbox token
    from os.path import expanduser
    
    with open(expanduser('~/mapbox-token-tak'), 'r') as f:
        mapbox_access_token = f.read()

Try to pinpoint Huntsman Hall
-----------------------------

.. code:: python

    # address of hunstman hall
    huntsman_address = '3730 Walnut St, Philadelphia, PA' 

.. code:: python

    #https://wiki.openstreetmap.org/wiki/Nominatim
    # (turned out to be the most robust in my experience)
    from geopy.geocoders import Nominatim
    
    geolocator = Nominatim()
    location = geolocator.geocode(huntsman_address)
    print(location.address)
    print((location.latitude, location.longitude))
    lat = location.latitude
    lon = location.longitude
    
    # below threw an exception saying it cannot *locate* Huntsman..
    # from geopy.geocoders import GeocoderDotUS
    # geolocator = GeocoderDotUS(format_string="%s, Philadelphia PA")
    # geolocator.geocode('241 South 49th Street')
    
    # geolocator = GeocoderDotUS(format_string="%s, Cleveland OH")
    # address, (latitude, longitude) = geolocator.geocode("11111 Euclid Ave")
    # print(address, latitude, longitude)


.. parsed-literal::
    :class: myliteral

    Walnut Street, University City, Philadelphia, Philadelphia County, Pennsylvania, 19104, United States of America
    (39.9514112, -75.1808949)


.. code:: python

    import plotly.plotly as py
    from plotly.graph_objs import Data,Scattermapbox,Marker,Layout

.. code:: python

    data = Data([
        Scattermapbox(
            lat=[lat],
            lon=[lon],
            mode='markers',
            marker=Marker(
                size=14
            ),
            text=['Montreal'],
        )
    ])
    layout = Layout(
        autosize=True,
        hovermode='closest',
        mapbox=dict(
            accesstoken=mapbox_access_token,
            bearing=0,
            center=dict(
                lat=lat,
                lon=lon
            ),
            pitch=0,
            zoom=15
        ),
    )
    
    fig1 = dict(data=data, layout=layout)
    py.iplot(fig1, filename='Huntsman-try1', validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/66.embed" height="525px" width="100%"></iframe>



Hmmm...that's pretty off...
---------------------------

Lemme try a different geolocator packages...

URL Request using freegeopi
---------------------------

.. code:: python

    import requests
    import json
    
    send_url = 'http://freegeoip.net/json'
    r = requests.get(send_url)
    j = json.loads(r.text)
    lat = j['latitude']
    lon = j['longitude']
    print "(lat,lon) = ({},{})".format(lat,lon)


.. parsed-literal::
    :class: myliteral

    (lat,lon) = (39.9597,-75.1968)


.. code:: python

    data = Data([
        Scattermapbox(
            lat=[lat],
            lon=[lon],
            mode='markers',
            marker=Marker(
                size=14
            ),
            text=['Huntman'],
        )
    ])
    layout = Layout(
        autosize=True,
        hovermode='closest',
        mapbox=dict(
            accesstoken=mapbox_access_token,
            bearing=0,
            center=dict(
                lat=lat,
                lon=lon
            ),
            pitch=0,
            zoom=15
        ),
    )
    
    fig2 = dict(data=data, layout=layout)
    py.iplot(fig2, validate=False)




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/70.embed" height="525px" width="100%"></iframe>



That's also quite off....
-------------------------

Now starting to wonder if it's the **geolocator** that is off or the
**mapbox** app that is off...

Try geolocation-python
----------------------

https://github.com/slawek87/geolocation-python

.. code:: python

    # %%bash
    # pip install geolocation-python --user

.. code:: python

    from geolocation.main import GoogleMaps
    
    # address = "New York City Wall Street 12"
    
    google_maps = GoogleMaps(api_key='') 
    
    location = google_maps.search(location=huntsman_address) # sends search to Google Maps.
    
    print(location.all()) # returns all locations.
    
    my_location = location.first() # returns only first location.
    
    print(my_location.city)
    print(my_location.route)
    print(my_location.street_number)
    print(my_location.postal_code)
    
    for administrative_area in my_location.administrative_area:
        print("{}: {} ({})".format(administrative_area.area_type, 
                                   administrative_area.name, 
                                   administrative_area.short_name))
    
    print(my_location.country)
    print(my_location.country_shortcut)
    
    print(my_location.formatted_address)
    
    print(my_location.lat)
    print(my_location.lng)
    
    # # reverse geocode
    # lat = 40.7060008
    # lng = -74.0088189
    # my_location = google_maps.search(lat=lat, lng=lng).first()


.. parsed-literal::
    :class: myliteral

    [<LocationModel: Philadelphia>]
    Philadelphia
    Walnut Street
    3730
    19104
    administrative_area_level_1: Pennsylvania (PA)
    administrative_area_level_2: Philadelphia County (Philadelphia County)
    United States
    US
    Jon M. Huntsman Hall, 3730 Walnut St, Philadelphia, PA 19104, USA
    39.9529683
    -75.1982049


.. code:: python

    lat=my_location.lat
    lon=my_location.lng
    data = Data([
        Scattermapbox(
            lat=[lat],
            lon=[lon],
            mode='markers',
            marker=Marker(
                size=14
            ),
            text=['Huntsman Hall'],
        )
    ])
    layout = Layout(
        autosize=True,
        hovermode='closest',
        mapbox=dict(
            accesstoken=mapbox_access_token,
            bearing=0,
            center=dict(
                lat=lat,
                lon=lon
            ),
            pitch=0,
            zoom=15
        ),
    )
    
    fig2 = dict(data=data, layout=layout)
    py.iplot(fig2, filename='Huntsman', validate=False)





.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/64.embed" height="525px" width="100%"></iframe>



Success!
--------

I guess i'll stick with ``geolocation`` package based on this trial run.
Let's save the result in plotly

.. code:: python

    py.plot(fig2, filename='Huntsman', validate=False)




.. parsed-literal::
    :class: myliteral

    u'https://plot.ly/~takanori/64'


