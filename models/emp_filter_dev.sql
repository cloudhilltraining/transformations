SELECT
    id,
    json_data:name::STRING AS name,
    json_data:age AS age,
    json_data:city::STRING AS city,
    json_data:address.city::STRING AS nested_city,
    json_data:address.zip_code::STRING AS zip_code
FROM {{ source('raw_sc', 'emp_json') }}
WHERE json_data:city::STRING = 'San Francisco'