SELECT
    id,
    json_data:name::STRING AS name,
    json_data:age AS age,
    json_data:city::STRING AS city_top_level
FROM {{ source('raw_sc', 'emp_json') }}