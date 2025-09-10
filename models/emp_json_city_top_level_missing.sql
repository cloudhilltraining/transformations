SELECT id,json_data, NAME, AGE, city_top_level, city_in_address, zip_code
FROM {{ ref('emp_json_base') }}
WHERE city_top_level IS NULL
ORDER BY id