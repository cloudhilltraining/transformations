SELECT *
FROM {{ ref('customers') }}
WHERE email NOT LIKE '%@%'