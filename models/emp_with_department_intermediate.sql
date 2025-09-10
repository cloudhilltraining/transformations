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
            WHEN city IN ('San Francisco', 'Seattle') THEN 2  -- Engineering
            WHEN city IN ('New York', 'Boston') THEN 5       -- Finance
            WHEN age BETWEEN 20 AND 29 THEN
                CASE WHEN id % 2 = 0 THEN 4 ELSE 1 END       -- Marketing or Sales
            WHEN age BETWEEN 30 AND 39 THEN
                CASE WHEN id % 2 = 0 THEN 2 ELSE 5 END       -- Engineering or Finance
            WHEN age >= 40 THEN 3                             -- HR
            ELSE 1                                           -- Default to Sales
        END AS dept_id
    FROM emp
)

SELECT
    a.id,
    a.name,
    a.age,
    a.city,
    d.dept_name
FROM assigned_dept AS a
LEFT JOIN {{ ref('departments') }} AS d
    ON a.dept_id = d.dept_id