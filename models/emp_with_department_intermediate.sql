{{ config(materialized='view') }}

WITH emp AS (
    SELECT
        id,
        json_data:name::STRING AS name,
        json_data:age AS age,
        json_data:city::STRING AS city
    FROM {{ source('raw_sc', 'emp_json') }}
),

assigned_dept AS (
    SELECT
        *,
        CASE
            WHEN city IN ('San Francisco', 'Seattle') THEN 2
            WHEN city IN ('New York', 'Boston') THEN 5
            WHEN age BETWEEN 20 AND 29 THEN CASE WHEN id % 2 = 0 THEN 4 ELSE 1 END
            WHEN age BETWEEN 30 AND 39 THEN CASE WHEN id % 2 = 0 THEN 2 ELSE 5 END
            WHEN age >= 40 THEN 3
            ELSE 1
        END AS dept_id
    FROM emp
)

SELECT * FROM assigned_dept