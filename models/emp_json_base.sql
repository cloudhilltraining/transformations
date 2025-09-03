SELECT
    id,
    json_data,
    json_data:name::STRING AS name,
    json_data:age AS age,
    json_data:city::STRING AS city_top_level,
    json_data:address.city::STRING AS city_in_address,
    json_data:address.zip_code::STRING AS zip_code
FROM raw_sample.raw_sc.emp_json