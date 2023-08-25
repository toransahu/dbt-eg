{% set timezones = ["UTC", "GMT"] %}

SELECT
    mac,
    {% for zone in timezones %}
        {{ date_by_zone('timestamp', zone) }} as timestamp_{{ zone }},
    {% endfor %}
    event_type,
FROM
    {{ ref("device_event") }}
