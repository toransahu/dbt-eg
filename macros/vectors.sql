{% macro group_by_col(column_name) %}
SELECT
    {{ column_name }},
    count(1) as total
FROM
    {{ ref("device_event") }}
GROUP BY {{ column_name }}
{% endmacro %}
