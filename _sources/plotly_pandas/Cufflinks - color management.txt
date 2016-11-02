############################
Cufflinks - color management
############################

http://nbviewer.jupyter.org/gist/santosjorge/00ca17b121fa2463e18b

.. contents:: `Contents`
   :depth: 2
   :local:


Cufflinks Colors
================

Cufflinks also provides a wide set of tools for color managements;
including color conversion across multiple spectrums and color table
generation.

.. code:: python

    import cufflinks as cf
    
    cf.set_config_file(offline=False)

Colors can be represented as strings:

| **HEX** ``"#db4052"``
| **RGB** ``"rgb(219, 64, 82)"``
| **RGBA** ``"rgba(219, 64, 82, 1.0)"``

Color Conversions
=================

.. code:: python

    # The colors module includes a pre-defined set of commonly used colors
    cf.colors.cnames




.. parsed-literal::
    :class: myliteral

    {'aliceblue': '#F0F8FF',
     'antiquewhite': '#FAEBD7',
     'aqua': '#00FFFF',
     'aquamarine': '#7FFFD4',
     'azure': '#F0FFFF',
     'beige': '#F5F5DC',
     'bisque': '#FFE4C4',
     'black': '#000000',
     'blanchedalmond': '#FFEBCD',
     'blue': '#3780bf',
     'bluegray': '#565656',
     'bluepurple': '#6432AB',
     'blueviolet': '#8A2BE2',
     'brick': '#E24A33',
     'brightblue': '#0000FF',
     'brightred': '#FF0000',
     'brown': '#A52A2A',
     'burlywood': '#DEB887',
     'cadetblue': '#5F9EA0',
     'charcoal': '#151516',
     'chartreuse': '#7FFF00',
     'chocolate': '#D2691E',
     'coral': '#FF7F50',
     'cornflowerblue': '#6495ED',
     'cornsilk': '#FFF8DC',
     'crimson': '#DC143C',
     'cyan': '#00FFFF',
     'darkblue': '#00008B',
     'darkcyan': '#008B8B',
     'darkgoldenrod': '#B8860B',
     'darkgray': '#A9A9A9',
     'darkgreen': '#006400',
     'darkgrey': '#A9A9A9',
     'darkkhaki': '#BDB76B',
     'darkmagenta': '#8B008B',
     'darkolivegreen': '#556B2F',
     'darkorange': '#FF8C00',
     'darkorchid': '#9932CC',
     'darkred': '#8B0000',
     'darksalmon': '#E9967A',
     'darkseagreen': '#8FBC8F',
     'darkslateblue': '#483D8B',
     'darkslategray': '#2F4F4F',
     'darkslategrey': '#2F4F4F',
     'darkturquoise': '#00CED1',
     'darkviolet': '#9400D3',
     'deeppink': '#FF1493',
     'deepskyblue': '#00BFFF',
     'dimgray': '#696969',
     'dimgrey': '#696969',
     'dodgerblue': '#1E90FF',
     'firebrick': '#B22222',
     'floralwhite': '#FFFAF0',
     'forestgreen': '#228B22',
     'fuchsia': '#FF00FF',
     'gainsboro': '#DCDCDC',
     'ghostwhite': '#F8F8FF',
     'gold': '#FFD700',
     'goldenrod': '#DAA520',
     'grassgreen': '#32ab60',
     'gray': '#808080',
     'green': '#008000',
     'greenyellow': '#ADFF2F',
     'grey': '#808080',
     'grey01': '#0A0A0A',
     'grey02': '#151516',
     'grey03': '#1A1A1C',
     'grey04': '#1E1E21',
     'grey05': '#252529',
     'grey06': '#36363C',
     'grey07': '#3C3C42',
     'grey08': '#434343',
     'grey09': '#666570',
     'grey10': '#666666',
     'grey11': '#8C8C8C',
     'grey12': '#C2C2C2',
     'grey13': '#E2E2E2',
     'grey14': '#E5E5E5',
     'henanigans_bg': '#242424',
     'henanigans_blue1': '#5F95DE',
     'henanigans_blue2': '#93B6E6',
     'henanigans_cyan1': '#7EC4CF',
     'henanigans_cyan2': '#B6ECF3',
     'henanigans_dark1': '#040404',
     'henanigans_dark2': '#141414',
     'henanigans_dialog1': '#444459',
     'henanigans_dialog2': '#5D5D7A',
     'henanigans_green1': '#8BD155',
     'henanigans_green2': '#A0D17B',
     'henanigans_grey1': '#343434',
     'henanigans_grey2': '#444444',
     'henanigans_light1': '#A4A4A4',
     'henanigans_light2': '#F4F4F4',
     'henanigans_orange1': '#EB9E58',
     'henanigans_orange2': '#EBB483',
     'henanigans_purple1': '#C98FDE',
     'henanigans_purple2': '#AC92DE',
     'henanigans_red1': '#F77E70',
     'henanigans_red2': '#DE958E',
     'henanigans_yellow1': '#E8EA7E',
     'henanigans_yellow2': '#E9EABE',
     'honeydew': '#F0FFF0',
     'hotpink': '#FF69B4',
     'indianred': '#CD5C5C',
     'indigo': '#4B0082',
     'ivory': '#FFFFF0',
     'khaki': '#F0E68C',
     'lavender': '#E6E6FA',
     'lavenderblush': '#FFF0F5',
     'lawngreen': '#7CFC00',
     'lemonchiffon': '#FFFACD',
     'lightblue': '#ADD8E6',
     'lightblue2': '#80b1d3',
     'lightcoral': '#F08080',
     'lightcyan': '#E0FFFF',
     'lightgoldenrodyellow': '#FAFAD2',
     'lightgray': '#D3D3D3',
     'lightgreen': '#90EE90',
     'lightgrey': '#D3D3D3',
     'lightivory': '#F6F6F6',
     'lightpink': '#FFB6C1',
     'lightpink2': '#fccde5',
     'lightpurple': '#bc80bd',
     'lightsalmon': '#FFA07A',
     'lightseagreen': '#20B2AA',
     'lightskyblue': '#87CEFA',
     'lightslategray': '#778899',
     'lightslategrey': '#778899',
     'lightsteelblue': '#B0C4DE',
     'lightteal': '#8dd3c7',
     'lightviolet': '#8476CA',
     'lightyellow': '#FFFFE0',
     'lime': '#00FF00',
     'lime2': '#8EBA42',
     'limegreen': '#32CD32',
     'linen': '#FAF0E6',
     'magenta': '#FF00FF',
     'maroon': '#800000',
     'mediumaquamarine': '#66CDAA',
     'mediumblue': '#0000CD',
     'mediumgray': '#656565',
     'mediumorchid': '#BA55D3',
     'mediumpurple': '#9370DB',
     'mediumseagreen': '#3CB371',
     'mediumslateblue': '#7B68EE',
     'mediumspringgreen': '#00FA9A',
     'mediumturquoise': '#48D1CC',
     'mediumvioletred': '#C71585',
     'midnightblue': '#191970',
     'mintcream': '#F5FFFA',
     'mistyrose': '#FFE4E1',
     'moccasin': '#FFE4B5',
     'mustard': '#FBC15E',
     'navajowhite': '#FFDEAD',
     'navy': '#000080',
     'oldlace': '#FDF5E6',
     'olive': '#808000',
     'olivedrab': '#6B8E23',
     'orange': '#ff9933',
     'orangered': '#FF4500',
     'orchid': '#DA70D6',
     'palegoldenrod': '#EEE8AA',
     'palegreen': '#98FB98',
     'paleolive': '#b3de69',
     'paleturquoise': '#AFEEEE',
     'palevioletred': '#DB7093',
     'papayawhip': '#FFEFD5',
     'peachpuff': '#FFDAB9',
     'pearl': '#D9D9D9',
     'pearl02': '#F5F6F9',
     'pearl03': '#E1E5ED',
     'pearl04': '#9499A3',
     'pearl05': '#6F7B8B',
     'pearl06': '#4D5663',
     'peru': '#CD853F',
     'pink': '#ff0088',
     'pinksalmon': '#FFB5B8',
     'plum': '#DDA0DD',
     'polar': '#ACAFB5',
     'polarblue': '#0080F0',
     'polarbluelight': '#46A0F0',
     'polarcyan': '#ADFCFC',
     'polardark': '#484848',
     'polardiv': '#D5D8DB',
     'polardust': '#F2F3F7',
     'polargreen': '#309054',
     'polargrey': '#505050',
     'polarorange': '#EE7600',
     'polarpurple': '#6262DE',
     'polarred': '#D94255',
     'powderblue': '#B0E0E6',
     'purple': '#800080',
     'red': '#db4052',
     'rose': '#FFC0CB',
     'rosybrown': '#BC8F8F',
     'royalblue': '#4169E1',
     'saddlebrown': '#8B4513',
     'salmon': '#fb8072',
     'sandybrown': '#FAA460',
     'seaborn': '#EAE7E4',
     'seagreen': '#2E8B57',
     'seashell': '#FFF5EE',
     'sienna': '#A0522D',
     'silver': '#C0C0C0',
     'skyblue': '#87CEEB',
     'slateblue': '#6A5ACD',
     'slategray': '#708090',
     'slategrey': '#708090',
     'smurf': '#3E6FB0',
     'snow': '#FFFAFA',
     'springgreen': '#00FF7F',
     'steelblue': '#4682B4',
     'tan': '#D2B48C',
     'teal': '#008080',
     'thistle': '#D8BFD8',
     'tomato': '#FF6347',
     'turquoise': '#40E0D0',
     'violet': '#EE82EE',
     'wheat': '#F5DEB3',
     'white': '#FFFFFF',
     'whitesmoke': '#F5F5F5',
     'yellow': '#ffff33',
     'yellowgreen': '#9ACD32'}



.. code:: python

    # HEX to RGB
    cf.colors.hex_to_rgb('red')




.. parsed-literal::
    :class: myliteral

    'rgb(219, 64, 82)'



.. code:: python

    # RGB to HEX
    cf.colors.rgb_to_hex('rgb(219, 64, 82)')




.. parsed-literal::
    :class: myliteral

    '#DB4052'



.. code:: python

    # RGB or HEX to RGBA (transparency)
    cf.colors.to_rgba('#3780bf',.5), cf.colors.to_rgba('rgb(219, 64, 82)',.4)




.. parsed-literal::
    :class: myliteral

    ('rgba(55, 128, 191, 0.5)', 'rgba(219, 64, 82, 0.4)')



.. code:: python

    # RGBA to RGB (flatten transparency)
    # By default assumes that the transparency color is *white*, however this can be also passed as a parameter. 
    cf.colors.rgba_to_rgb('rgba(219, 64, 82, 0.4)','white')




.. parsed-literal::
    :class: myliteral

    'rgb(240, 178, 185)'



Normalization
=============

.. code:: python

    # Cufflinks.colors.normalize will always return the an hex value for all types of colors
    colors=['#f08','rgb(240, 178, 185)','rgba(219, 64, 82, 0.4)','green']
    [cf.colors.normalize(c) for c in colors]




.. parsed-literal::
    :class: myliteral

    ['#ff0088', '#F0B2B9', '#F0B2B9', '#008000']



Color Ranges
============

A range of colors can be generated using a base color and varying the
saturation.

.. code:: python

    # 10 different tones of pink
    cf.colors.color_range('pink',10)





.. parsed-literal::
    :class: myliteral

    ['#000000',
     '#33001b',
     '#660036',
     '#990051',
     '#cc006c',
     '#ff0088',
     '#ff329f',
     '#ff65b7',
     '#ff99cf',
     '#ffcce7',
     '#ffffff']



Color Tables
============

This function is meant to be used in an **iPython Notebook**. It
generates an HTML table to display either a defined list of colors or to
automatically generate a range of colors.

.. code:: python

    colors = cf.colors.color_range('pink',10)
    print colors
    cf.colors.color_table(colors[::-1])


.. parsed-literal::
    :class: myliteral

    ['#000000', '#33001b', '#660036', '#990051', '#cc006c', '#ff0088', '#ff329f', '#ff65b7', '#ff99cf', '#ffcce7', '#ffffff']



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#ffffff;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFFFFF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffcce7;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFCCE7</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff99cf;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF99CF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff65b7;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF65B7</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff329f;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF329F</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff0088;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF0088</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#cc006c;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#CC006C</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#990051;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#990051</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#660036;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#660036</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#33001b;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#33001B</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#000000;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#000000</span>
    			</li></ul>


.. code:: python

    # Displaying a table of defined colors (list)
    colors=['#f08', 'rgb(240, 178, 185)', 'blue' , '#32ab60']
    cf.colors.color_table(colors)



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#ff0088;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF0088</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#F0B2B9;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#F0B2B9</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#3780bf;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#3780BF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#32ab60;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#32AB60</span>
    			</li></ul>


.. code:: python

    # Generating 15 shades of orange
    cf.colors.color_table('orange',15)



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#ffffff;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFFFFF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffeedd;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFEEDD</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffddbb;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFDDBB</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffcc99;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFCC99</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffbb77;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFBB77</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ffaa55;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFAA55</span>
    			</li><li style="text-align:center; border: 1px solid #ffffff;line-height:30px;background-color:#ff9933;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF9933</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff9932;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF9932</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ff8810;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF8810</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#ee8e2f;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#EE8E2F</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#cc7a28;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#CC7A28</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#aa6521;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#AA6521</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#88511b;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#88511B</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#663d14;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#663D14</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#44280d;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#44280D</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#221406;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#221406</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#000000;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#000000</span>
    			</li></ul>


Color Generators
================

A color generator can be used to produce shades of colors in an
iterative form. For example when plotting N timeseries so the color used
are as distinctive as possible.

.. code:: python

    # Create a generator using 3 defined base colors
    colors=['green','orange','blue']
    gen=cf.colors.colorgen(colors)
    outputColors=[gen.next() for _ in range(15)]
    cf.colors.color_table(outputColors)



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#008000;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#008000</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FF9933;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF9933</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#3780BF;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#3780BF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#4B8CC5;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#4B8CC5</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#198C19;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#198C19</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFA347;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFA347</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFAD5B;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFAD5B</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#5F99CB;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#5F99CB</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#339933;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#339933</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#4CA64C;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#4CA64C</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFB770;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFB770</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#73A6D2;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#73A6D2</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#87B2D8;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#87B2D8</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#66B266;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#66B266</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFC184;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFC184</span>
    			</li></ul>


.. code:: python

    # Create a generator with default set of colors
    gen=cf.colors.colorgen()
    outputColors=[gen.next() for _ in range(15)]
    cf.colors.color_table(outputColors)



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#FF9933;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FF9933</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#3780BF;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#3780BF</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#32AB60;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#32AB60</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#800080;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#800080</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#DB4052;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#DB4052</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#008080;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#008080</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFFF33;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFFF33</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#808000;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#808000</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FB8072;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FB8072</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#80B1D3;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#80B1D3</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#8CB8D7;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#8CB8D7</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFA347;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFA347</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#4B8CC5;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#4B8CC5</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#46B36F;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#46B36F</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#8C198C;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#8C198C</span>
    			</li></ul>


.. code:: python

    import cufflinks as cf
    print(sorted(cf.get_scales().keys()))


.. parsed-literal::
    :class: myliteral

    ['accent', 'blues', 'brbg', 'bugn', 'bupu', 'dark2', 'dflt', 'ggplot', 'gnbu', 'greens', 'greys', 'oranges', 'orrd', 'paired', 'pastel1', 'pastel2', 'piyg', 'polar', 'prgn', 'pubu', 'pubugn', 'puor', 'purd', 'purples', 'rdbu', 'rdgy', 'rdpu', 'rdylbu', 'rdylgn', 'reds', 'set1', 'set2', 'set3', 'spectral', 'ylgn', 'ylgnbu', 'ylorbr', 'ylorrd']


.. code:: python

    from pprint import pprint
    
    # We can see all available scales with
    pprint(cf.get_scales()['accent'])
    pprint(sorted(cf.get_scales().keys()))


.. parsed-literal::
    :class: myliteral

    ['rgb(127,201,127)',
     'rgb(190,174,212)',
     'rgb(253,192,134)',
     'rgb(255,255,153)',
     'rgb(56,108,176)',
     'rgb(240,2,127)',
     'rgb(191,91,23)',
     'rgb(102,102,102)']
    ['accent',
     'blues',
     'brbg',
     'bugn',
     'bupu',
     'dark2',
     'dflt',
     'ggplot',
     'gnbu',
     'greens',
     'greys',
     'oranges',
     'orrd',
     'paired',
     'pastel1',
     'pastel2',
     'piyg',
     'polar',
     'prgn',
     'pubu',
     'pubugn',
     'puor',
     'purd',
     'purples',
     'rdbu',
     'rdgy',
     'rdpu',
     'rdylbu',
     'rdylgn',
     'reds',
     'set1',
     'set2',
     'set3',
     'spectral',
     'ylgn',
     'ylgnbu',
     'ylorbr',
     'ylorrd']


.. code:: python

    # Other color scales can be also seen here
    cf.colors.scales()



.. raw:: html

    <div style="display:inline-block;padding:10px;"><div>accent</div><div style="background-color:rgb(127,201,127);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(190,174,212);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,192,134);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,153);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(56,108,176);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(240,2,127);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(191,91,23);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,102,102);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>blues</div><div style="background-color:rgb(247,251,255);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(222,235,247);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(198,219,239);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(158,202,225);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(107,174,214);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(66,146,198);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(33,113,181);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(8,81,156);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(8,48,107);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>brbg</div><div style="background-color:rgb(84,48,5);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(140,81,10);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(191,129,45);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(223,194,125);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(246,232,195);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(245,245,245);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(199,234,229);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128,205,193);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(53,151,143);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(1,102,94);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,60,48);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>bugn</div><div style="background-color:rgb(247,252,253);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(229,245,249);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,236,230);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(153,216,201);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,194,164);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(65,174,118);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(35,139,69);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,109,44);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,68,27);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>bupu</div><div style="background-color:rgb(247,252,253);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(224,236,244);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(191,211,230);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(158,188,218);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(140,150,198);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(140,107,177);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(136,65,157);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(129,15,124);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(77,0,75);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>dark2</div><div style="background-color:rgb(27,158,119);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,95,2);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(117,112,179);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(231,41,138);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,166,30);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(230,171,2);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,118,29);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,102,102);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>dflt</div><div style="background-color:rgb(255, 153, 51);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(55, 128, 191);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(50, 171, 96);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128, 0, 128);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(219, 64, 82);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0, 128, 128);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255, 255, 51);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128, 128, 0);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(251, 128, 114);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128, 177, 211);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>ggplot</div><div style="background-color:rgb(226, 74, 51);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(62, 111, 176);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(132, 118, 202);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(101, 101, 101);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(251, 193, 94);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(142, 186, 66);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255, 181, 184);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>gnbu</div><div style="background-color:rgb(247,252,240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(224,243,219);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,235,197);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(168,221,181);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(123,204,196);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(78,179,211);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(43,140,190);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(8,104,172);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(8,64,129);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>greens</div><div style="background-color:rgb(247,252,245);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(229,245,224);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(199,233,192);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(161,217,155);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(116,196,118);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(65,171,93);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(35,139,69);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,109,44);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,68,27);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>greys</div><div style="background-color:rgb(255,255,255);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(240,240,240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,217,217);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(189,189,189);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(150,150,150);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(115,115,115);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(82,82,82);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(37,37,37);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,0,0);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>oranges</div><div style="background-color:rgb(255,245,235);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,230,206);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,208,162);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,174,107);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,141,60);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(241,105,19);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,72,1);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,54,3);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(127,39,4);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>orrd</div><div style="background-color:rgb(255,247,236);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,232,200);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,212,158);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,187,132);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,141,89);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(239,101,72);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(215,48,31);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(179,0,0);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(127,0,0);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>paired</div><div style="background-color:rgb(166,206,227);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(31,120,180);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(178,223,138);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(51,160,44);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(251,154,153);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(227,26,28);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,191,111);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,127,0);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(202,178,214);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(106,61,154);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,153);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(177,89,40);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>pastel1</div><div style="background-color:rgb(251,180,174);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(179,205,227);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,235,197);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(222,203,228);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,217,166);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,204);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(229,216,189);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,218,236);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(242,242,242);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>pastel2</div><div style="background-color:rgb(179,226,205);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,205,172);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(203,213,232);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,202,228);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(230,245,201);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,242,174);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(241,226,204);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,204,204);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>piyg</div><div style="background-color:rgb(142,1,82);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(197,27,125);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(222,119,174);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(241,182,218);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,224,239);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,247,247);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(230,245,208);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(184,225,134);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(127,188,65);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(77,146,33);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(39,100,25);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>polar</div><div style="background-color:rgb(0, 128, 240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(238, 118, 0);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(48, 144, 84);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(98, 98, 222);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217, 66, 85);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(173, 252, 252);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(70, 160, 240);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>prgn</div><div style="background-color:rgb(64,0,75);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(118,42,131);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(153,112,171);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(194,165,207);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(231,212,232);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,247,247);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,240,211);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,219,160);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(90,174,97);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(27,120,55);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,68,27);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>pubu</div><div style="background-color:rgb(255,247,251);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(236,231,242);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(208,209,230);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,189,219);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(116,169,207);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(54,144,192);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(5,112,176);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(4,90,141);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(2,56,88);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>pubugn</div><div style="background-color:rgb(255,247,251);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(236,226,240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(208,209,230);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,189,219);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(103,169,207);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(54,144,192);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(2,129,138);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(1,108,89);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(1,70,54);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>puor</div><div style="background-color:rgb(127,59,8);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(179,88,6);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(224,130,20);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,184,99);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,224,182);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,247,247);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(216,218,235);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(178,171,210);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128,115,172);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(84,39,136);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(45,0,75);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>purd</div><div style="background-color:rgb(247,244,249);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(231,225,239);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(212,185,218);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(201,148,199);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(223,101,176);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(231,41,138);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(206,18,86);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(152,0,67);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(103,0,31);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>purples</div><div style="background-color:rgb(252,251,253);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(239,237,245);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(218,218,235);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(188,189,220);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(158,154,200);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128,125,186);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(106,81,163);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(84,39,143);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(63,0,125);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>rdbu</div><div style="background-color:rgb(103,0,31);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(178,24,43);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(214,96,77);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,165,130);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,219,199);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,247,247);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(209,229,240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(146,197,222);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(67,147,195);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(33,102,172);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(5,48,97);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>rdgy</div><div style="background-color:rgb(103,0,31);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(178,24,43);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(214,96,77);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,165,130);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,219,199);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,255);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(224,224,224);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(186,186,186);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(135,135,135);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(77,77,77);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(26,26,26);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>rdpu</div><div style="background-color:rgb(255,247,243);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,224,221);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,197,192);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(250,159,181);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,104,161);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(221,52,151);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(174,1,126);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(122,1,119);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(73,0,106);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>rdylbu</div><div style="background-color:rgb(165,0,38);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(215,48,39);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,109,67);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,174,97);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,224,144);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,191);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(224,243,248);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(171,217,233);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(116,173,209);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(69,117,180);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(49,54,149);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>rdylgn</div><div style="background-color:rgb(165,0,38);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(215,48,39);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,109,67);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,174,97);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,224,139);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,191);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,239,139);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,217,106);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,189,99);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(26,152,80);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,104,55);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>reds</div><div style="background-color:rgb(255,245,240);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,224,210);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,187,161);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,146,114);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(251,106,74);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(239,59,44);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(203,24,29);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(165,15,21);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(103,0,13);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>set1</div><div style="background-color:rgb(228,26,28);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(55,126,184);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(77,175,74);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(152,78,163);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,127,0);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,51);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,86,40);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,129,191);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(153,153,153);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>set2</div><div style="background-color:rgb(102,194,165);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,141,98);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(141,160,203);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(231,138,195);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(166,216,84);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,217,47);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(229,196,148);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(179,179,179);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>set3</div><div style="background-color:rgb(141,211,199);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,179);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(190,186,218);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(251,128,114);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128,177,211);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,180,98);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(179,222,105);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,205,229);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,217,217);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(188,128,189);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,235,197);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,237,111);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>spectral</div><div style="background-color:rgb(158,1,66);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(213,62,79);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(244,109,67);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,174,97);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,224,139);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,255,191);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(230,245,152);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(171,221,164);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,194,165);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(50,136,189);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(94,79,162);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>ylgn</div><div style="background-color:rgb(255,255,229);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(247,252,185);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(217,240,163);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(173,221,142);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(120,198,121);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(65,171,93);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(35,132,67);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,104,55);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(0,69,41);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>ylgnbu</div><div style="background-color:rgb(255,255,217);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(237,248,177);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(199,233,180);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(127,205,187);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(65,182,196);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(29,145,192);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(34,94,168);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(37,52,148);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(8,29,88);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>ylorbr</div><div style="background-color:rgb(255,255,229);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,247,188);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,227,145);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,196,79);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,153,41);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(236,112,20);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(204,76,2);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(153,52,4);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(102,37,6);height:20px;width:20px;display:inline-block;"></div></div><div style="display:inline-block;padding:10px;"><div>ylorrd</div><div style="background-color:rgb(255,255,204);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(255,237,160);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,217,118);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(254,178,76);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(253,141,60);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(252,78,42);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(227,26,28);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(189,0,38);height:20px;width:20px;display:inline-block;"></div><div style="background-color:rgb(128,0,38);height:20px;width:20px;display:inline-block;"></div></div>


.. code:: python

    colorscale=cf.colors.get_scales('accent')
    cf.colors.color_table(colorscale)



.. raw:: html

    <ul style="list-style-type: none;"><li style="text-align:center;line-height:30px;background-color:#7FC97F;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#7FC97F</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#BEAED4;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#BEAED4</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FDC086;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FDC086</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#FFFF99;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#FFFF99</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#386CB0;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#386CB0</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#F0027F;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#F0027F</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#BF5B17;"> 
    			<span style=" text-shadow:0 1px 0 rgba(255,255,255,0.6); color:#000000;">#BF5B17</span>
    			</li><li style="text-align:center;line-height:30px;background-color:#666666;"> 
    			<span style=" text-shadow:0 1px 0 #000; color:#ffffff;">#666666</span>
    			</li></ul>

