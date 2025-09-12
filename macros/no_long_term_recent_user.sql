{% test no_long_term_recent_user(relation, column_name) %}

select *
from {{ relation }}
where {{ column_name }} = 'long_term'
  and datediff(day, signup_date, current_date) < 30

{% endtest %}
