SELECT
    id,
    {{ clean_column("json_data:name::STRING") }} AS cleaned_name,
    {{ clean_column("json_data:city::STRING") }} AS cleaned_city,
    {{ clean_column("json_data:address.city::STRING") }} AS cleaned_nested_city,
    {{ clean_column("json_data:address.zip_code::STRING") }} AS cleaned_zip
FROM {{ source('raw_sc', 'emp_json') }}