{% macro categorize_user_age(signup_date_column) %}
    case
        when {{ calculate_user_age(signup_date_column) }} < 30 then 'new'
        when {{ calculate_user_age(signup_date_column) }} < 180 then 'intermediate'
        else 'long_term'
    end
{% endmacro %}