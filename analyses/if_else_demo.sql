{% set night_booked = 100 %}

select *
from
    {{ ref("bronze_bookings") }}
where
{% if night_booked == 5 %}
    NIGHTS_BOOKED = {{ night_booked }}
{% else %}
    NIGHTS_BOOKED between 6 and 100
{% endif %}
order by 
    NIGHTS_BOOKED asc