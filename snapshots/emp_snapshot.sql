{% snapshot emp_snapshot %}

{{
  config(
    target_schema='transform',
    unique_key='id',
    strategy='check',
    check_cols=['name', 'city']
  )
}}

SELECT
    id,
    json_data:"name"::STRING AS name,
    json_data:"city"::STRING AS city,
    json_data:"age" AS age,
    CURRENT_TIMESTAMP() AS dbt_snapshot_at
FROM {{ source('raw_sc', 'emp_json') }}

{% endsnapshot %}
