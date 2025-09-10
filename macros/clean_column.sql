{% macro clean_column(col_name) %}
    TRIM(UPPER({{ col_name }}))
{% endmacro %}