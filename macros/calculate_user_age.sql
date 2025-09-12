{% macro calculate_user_age(signup_date_column) %}
    datediff(day, {{ signup_date_column }}, current_date)
{% endmacro %}