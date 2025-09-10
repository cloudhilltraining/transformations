{{ config(materialized='view') }}

-- Staging model for emp_json_base
-- Purpose:
--   - Standardize column names and types
--   - Combine city fields from different JSON paths
--   - Prepare clean data for downstream analysis

SELECT
    id,
    name AS employee_name,
    TRY_CAST(TO_VARCHAR(age) AS INT) AS age,
    COALESCE(city_top_level, city_in_address) AS city,
    zip_code
FROM {{ ref('emp_json_base') }}
WHERE name IS NOT NULL