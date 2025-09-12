with source_data as (
    select * from {{ source('raw', 'users') }}
)

select
    user_id,
    user_email,
    signup_date,
    user_status,
    {{ calculate_user_age('signup_date') }} as days_since_signup
from source_data