{% macro dept_assignment_basic(emp_id) %}
    CASE
        WHEN {{ emp_id }} % 5 + 1 IN (1, 2, 3, 4, 5) THEN {{ emp_id }} % 5 + 1
        ELSE 1
    END
{% endmacro %}

{% macro dept_assignment_age_based(age, emp_id) %}
    CASE
        WHEN {{ age }} BETWEEN 20 AND 29 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 4 ELSE 1 END
        WHEN {{ age }} BETWEEN 30 AND 39 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 2 ELSE 5 END
        WHEN {{ age }} >= 40 THEN 3
        ELSE 1
    END
{% endmacro %}


{% macro dept_assignment_city_override(city, age, emp_id) %}
    CASE
        WHEN {{ city }} IN ('San Francisco', 'Seattle') THEN 2
        WHEN {{ city }} IN ('New York', 'Boston') THEN 5
        ELSE {{ dept_assignment_age_based(age, emp_id) }}
    END
{% endmacro %}


{% macro dept_assignment_full_logic(city, age, emp_id) %}
    CASE
        WHEN {{ city }} IN ('San Francisco', 'Seattle') THEN 2
        WHEN {{ city }} IN ('New York', 'Boston') THEN 5
        WHEN {{ age }} BETWEEN 20 AND 29 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 4 ELSE 1 END
        WHEN {{ age }} BETWEEN 30 AND 39 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 2 ELSE 5 END
        WHEN {{ age }} >= 40 THEN 3
        ELSE 1
    END
{% endmacro %}


{% macro dept_assignment_dynamic(city, age, emp_id) %}
    {% set city_depts = {
        'San Francisco': 2,
        'Seattle': 2,
        'New York': 5,
        'Boston': 5
    } %}

    CASE
        WHEN {{ city }} IN ({{ city_depts.keys() | map('string') | join(', ') }}) THEN
            CASE {{ city }}
                {% for c, d in city_depts.items() %}
                    WHEN '{{ c }}' THEN {{ d }}
                {% endfor %}
                ELSE 1
            END
        WHEN {{ age }} BETWEEN 20 AND 29 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 4 ELSE 1 END
        WHEN {{ age }} BETWEEN 30 AND 39 THEN
            CASE WHEN {{ emp_id }} % 2 = 0 THEN 2 ELSE 5 END
        WHEN {{ age }} >= 40 THEN 3
        ELSE 1
    END
{% endmacro %}