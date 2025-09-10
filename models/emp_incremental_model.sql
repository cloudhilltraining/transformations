{{ config(
    materialized='incremental'
) }}

WITH source_data AS (
    SELECT
        id AS ID,
        json_data:name::STRING AS NAME,
        json_data:age::STRING AS AGE,
        json_data:city::STRING AS CITY,  -- assuming you have a top-level city (might not exist)
        json_data:address.city::STRING AS NESTED_CITY,
        json_data:address.zip_code::STRING AS ZIP_CODE,
        updated_at AS UPDATED_AT
    FROM raw_sample.raw_sc.emp_json

    {% if is_incremental() %}
      WHERE updated_at > (
          SELECT COALESCE(MAX(updated_at), '1900-01-01') FROM {{ this }}
      )
    {% endif %}
)

SELECT * FROM source_data
