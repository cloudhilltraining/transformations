SELECT id,json_data, NAME, AGE, city_top_level
FROM {{ ref('emp_json_base') }}
WHERE city_top_level IS NOT NULL
ORDER BY id