-- IoT device & event consolidated but trimmed & fast model

SELECT
    mac,
    timestamp,
    event_type
FROM
    {{ ref("device_event") }}
