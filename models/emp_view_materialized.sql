{{ config(materialized='view') }}

-- Materialization: View
-- Description:
-- Creates a database view (virtual table).
-- Data is queried in real-time, no storage cost.
-- Good for simple transformations or small datasets.
SELECT
    id,
    json_data:name AS name,
    json_data:city::STRING AS city_top_level
FROM {{ source('raw_sc', 'emp_json') }}
WHERE json_data:city IS NOT NULL