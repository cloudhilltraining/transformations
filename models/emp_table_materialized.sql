{{ config(materialized='table') }}

-- Materialization: Table
-- Description:
-- Creates a physical table that stores employee data with age filter.
-- Useful for large or complex datasets where repeated query performance is important.
-- Data is persisted and must be refreshed explicitly.
SELECT
    id,
    json_data:name AS name,
    json_data:age AS age,
    json_data:city::STRING AS city_top_level
FROM {{ source('raw_sc', 'emp_json') }}
WHERE json_data:age > 25