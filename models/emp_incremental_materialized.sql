{{ config(
    materialized='incremental',
    unique_key='id'
) }}

WITH source_data AS (

    SELECT
        id,
        json_data,
        json_data:name::STRING AS name,
        json_data:age AS age,
        json_data:city::STRING AS city_top_level,
        json_data:address.city::STRING AS city_in_address,
        json_data:address.zip_code::STRING AS zip_code,
        
        -- Simulate updated_at using id (for demo only!)
        DATEADD(day, id, '2023-01-01'::DATE) AS updated_at

    FROM raw_sample.raw_sc.emp_json

    {% if is_incremental() %}
    WHERE DATEADD(day, id, '2023-01-01'::DATE) > (SELECT MAX(updated_at) FROM {{ this }})
    {% endif %}
)

SELECT * FROM source_data

{% if is_incremental() %}

UNION ALL

SELECT * FROM {{ this }}
WHERE updated_at <= (SELECT MAX(updated_at) FROM source_data)

{% endif %}
