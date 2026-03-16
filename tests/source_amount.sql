{{ config(
    severity='warn'
) }}

WITH booking_source AS (

    SELECT
        SUM(BOOKING_AMOUNT) AS total_booking
    FROM 
        {{ source('staging_schema', 'bookings') }}

),

booking_bronze AS (

    SELECT
        SUM(BOOKING_AMOUNT) AS total_booking
    FROM {{ ref('bronze_bookings') }}

)

SELECT *
FROM booking_source AS s
CROSS JOIN booking_bronze AS d
WHERE s.total_booking <> d.total_booking
 