-- IoT device & event consolidated (full) model

SELECT * FROM {{ ref("device_event") }}
