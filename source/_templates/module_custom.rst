{{ fullname }}
{{ underline }}

.. automodule:: {{ fullname }}

   {% block functions %}
   {% if functions %}
   Functions
   ---------
   .. autosummary::
      :toctree:

   {% for item in functions %}
      {{ item }}
   {%- endfor %}
   {% endif %}
   {% endblock %}

   {% block classes %}
   {% if classes %}
   Classes
   ---------
   .. autosummary::
      :toctree:generated/
      :template:class_tak.rst

   {% for item in classes %}
      {{ item }}
   {%- endfor %}
   {% endif %}
   {% endblock %}

   {% block exceptions %}
   {% if exceptions %}
   Exceptions
   ---------
   .. autosummary::
      :toctree:

   .. autosummary::
      :toctree:

   {% for item in exceptions %}
      {{ item }}
   {%- endfor %}
   {% endif %}
   {% endblock %}
