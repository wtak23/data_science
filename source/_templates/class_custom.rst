{{ fullname }}
{{ underline }}

.. currentmodule:: {{ module }}

:func:`{{ objname }}.__init__`

.. autoclass:: {{ objname }}
    :members: __init__
{% block methods %}
{% if methods %}
.. autosummary::
   :toctree:
   :hidden:

{% for item in methods %}
   ~{{ name }}.{{ item }}
{%- endfor %}
{% endif %}
{% endblock %}

{% block attributes %}
{% if attributes %}


.. autosummary::
  :toctree:
  :hidden:

{% for item in attributes %}
   ~{{ name }}.{{ item }}
{%- endfor %}
{% endif %}
{% endblock %}
