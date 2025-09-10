-- This model references the ephemeral model above.
-- Since ephemeral models are inlined, this query compiles into one query.
-- Filtering employees whose city starts with 'N'.

WITH filtered_employees AS (
    SELECT * FROM {{ ref('emp_ephemeral_materialized') }}
)

SELECT
    id,
    name,
    city_top_level
FROM filtered_employees
WHERE city_top_level LIKE 'N%'
