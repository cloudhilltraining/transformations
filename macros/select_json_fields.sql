{% macro select_json_fields(fields) %}
    {% for field in fields %}
        json_data:{{ field }}::STRING AS {{ field }}{% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}