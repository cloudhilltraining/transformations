{{ config(
    materialized='incremental',
    unique_key='id'
) }}


{% set fields = ['name', 'age', 'city', 'address.city', 'address.zip_code'] %}

WITH source_data AS (
    SELECT
        id,
        {{ select_json_fields(fields) | replace('address.city', 'nested_city') | replace('address.zip_code', 'zip_code') }},
        -- Simulate updated_at timestamp
        DATEADD(day, id, '2023-01-01') AS updated_at
    FROM {{ source('raw_sc', 'emp_json') }}

    {% if is_incremental() %}
        WHERE DATEADD(day, id, '2023-01-01') > (SELECT MAX(updated_at) FROM {{ this }})
    {% endif %}
)

SELECT * FROM source_data