{{ config(materialized='view') }}

SELECT
    a.id,
    a.name,
    a.age,
    a.city,
    a.dept_id,
    d.dept_name
FROM {{ ref('emp_with_department_intermediate') }} AS a
LEFT JOIN {{ ref('departments') }} AS d
    ON a.dept_id = d.dept_id