{% set incremental_flag = 1 %}
{% set incremental_col = 'created_at' %}

select * from {{ source('staging_schema','bookings') }} 

{% if incremental_flag == 1 %}
    WHERE {{ incremental_col }} > (SELECT COALESCE(MAX({{ incremental_col }}), '1900-01-01') FROM {{ this }})
{% endif %}