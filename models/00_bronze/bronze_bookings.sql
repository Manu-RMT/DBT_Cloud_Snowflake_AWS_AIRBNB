{{ config(materialize='incremental', unique_key='BOOKING_ID') }}

WITH cleaned AS (
   SELECT *,
          ROW_NUMBER() OVER (PARTITION BY BOOKING_ID ORDER BY CREATED_AT DESC) AS rn
   FROM {{ source('staging_schema','bookings') }}
)

SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    NIGHTS_BOOKED,
    BOOKING_AMOUNT,
    CLEANING_FEE,
    SERVICE_FEE,
    BOOKING_STATUS,
    CREATED_AT
FROM cleaned
WHERE rn = 1

{% if is_incremental() %}
   AND CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}

 