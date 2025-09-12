with source_data as (
    select * from {{ source('raw', 'user_profiles') }}
)

select
    profile_id,
    user_id,
    profile_name
from source_data