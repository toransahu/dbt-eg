{% macro date_by_zone(column_name, zone) %}
    (date({{ column_name }}, '{{ zone }}'))
{% endmacro %}
