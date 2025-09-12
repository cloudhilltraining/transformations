select
    user_id,
    user_email,
    {{ categorize_user_age('signup_date') }} as user_age_category
from {{ ref('stg_users') }}