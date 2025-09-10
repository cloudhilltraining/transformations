SELECT
    dept_name,
    city,
    COUNT(*) AS employee_count,
    AVG(age) AS avg_age,
    MIN(age) AS youngest_employee,
    MAX(age) AS oldest_employee
FROM {{ ref('emp_with_department') }}
GROUP BY dept_name, city
ORDER BY dept_name, city
