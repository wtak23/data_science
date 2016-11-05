##############
plotly-configs
##############

.. code:: python

    import plotly.plotly as py
    from plotly import session
    import plotly.graph_objs as go

.. code:: python

    session.get_session_config()
    session.get_session_credentials()
    session.get_session_plot_options()




.. parsed-literal::
    :class: myliteral

    {}



.. code:: python

    help(session.update_session_plot_options)


.. parsed-literal::
    :class: myliteral

    Help on function update_session_plot_options in module plotly.session:
    
    update_session_plot_options(**kwargs)
        Update the _session plot_options
        
        :param (str|optional) filename: What the file will be named in Plotly
        :param (str|optional) fileopt: 'overwrite', 'append', 'new', or 'extend'
        :param (bool|optional) world_readable: Make public or private.
        :param (dict|optional) sharing: 'public', 'private', 'secret'
        :param (bool|optional) auto_open: For `plot`, open in new browser tab?
        :param (bool|optional) validate: Error locally if data doesn't pass?
    


.. code:: python

    from pprint import pprint
    pprint(session.CONFIG_KEYS)
    pprint(session.CREDENTIALS_KEYS)
    pprint(session.PLOT_OPTIONS)
    pprint(session.SHARING_OPTIONS)
    



.. parsed-literal::
    :class: myliteral

    {'auto_open': <type 'bool'>,
     'plotly_api_domain': (<type 'basestring'>,),
     'plotly_domain': (<type 'basestring'>,),
     'plotly_proxy_authorization': <type 'bool'>,
     'plotly_ssl_verification': <type 'bool'>,
     'plotly_streaming_domain': (<type 'basestring'>,),
     'sharing': (<type 'basestring'>,),
     'world_readable': <type 'bool'>}
    {'api_key': (<type 'basestring'>,),
     'stream_ids': <type 'list'>,
     'username': (<type 'basestring'>,)}
    {'auto_open': <type 'bool'>,
     'filename': (<type 'basestring'>,),
     'fileopt': (<type 'basestring'>,),
     'sharing': (<type 'basestring'>,),
     'validate': <type 'bool'>,
     'world_readable': <type 'bool'>}
    ['public', 'private', 'secret']


.. code:: python

    data = go.Data([
        go.Scatter(
            x=[1, 2, 3],
            y=[1, 3, 1]
        )
    ])
    py.iplot(data,filename='test/mytest')




.. raw:: html

    <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://plot.ly/~takanori/820.embed?share_key=rKsms5CTwwagSZtGPbMMGQ" height="525px" width="100%"></iframe>


