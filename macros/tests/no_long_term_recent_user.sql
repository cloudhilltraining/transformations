{% test no_long_term_recent_user(model, column_name) %}

select *
from {{ model }}
where {{ column_name }} = 'long_term'
  and datediff(day, signup_date, current_date) < 30

{% endtest %}