WITH emp AS (
    SELECT
        id,
        json_data:name::STRING AS name,
        json_data:age AS age,
        json_data:city::STRING AS city
    FROM {{ source('raw_sc', 'emp_json') }}
)

SELECT
    id,
    name,
    age,
    city,
    {{ dept_assignment_full_logic('city', 'age', 'id') }} AS dept_id
FROM emp
