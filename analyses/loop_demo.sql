{% 
    set cols = ['BOOKING_AMOUNT','BOOKING_DATE','BOOKING_ID','NIGHTS_BOOKED']
%}

select 
    {% for col in cols %}
        {{ col }}
        {% if not loop.last %}, {% endif %} 
    {% endfor %}
FROM {{ ref("bronze_bookings") }}