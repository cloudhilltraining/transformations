{{ config(materialized='ephemeral') }}

-- Materialization: Ephemeral
-- Description:
-- No physical table or view is created.
-- Acts as a CTE inline in downstream models.
-- Useful for reusable logic or intermediate transformations.
SELECT
    id,
    json_data:name AS name,
    json_data:city::STRING AS city_top_level
FROM {{ source('raw_json', 'emp_json') }}
WHERE json_data:city IS NOT NULL