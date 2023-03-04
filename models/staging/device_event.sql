-- IoT device & event consolidated model

SELECT
    device.mac,
    event.timestamp,
    device.name,
    device.model,
    device.fw_version,
    device.vendor_name,
    event.event_type,
    event.event_data
FROM
    {{ source(var('source_iot_telemetry'), var('table_device')) }} device
JOIN
    {{ source(var('source_iot_telemetry'), var('table_event')) }} event
ON
    device.mac = event.mac
