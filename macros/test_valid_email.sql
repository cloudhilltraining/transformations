{% test valid_email(model, column_name) %}
    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} IS NULL
       OR {{ column_name }} NOT LIKE '%_@__%.__%'
{% endtest %}
