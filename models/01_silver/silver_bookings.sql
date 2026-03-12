{{ config(
    materialized='incremental',
    unique_key='BOOKING_ID'
    )
}}


SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT',2) }} AS TOTAL_AMOUNT_WITHOUT_FEE,
    SERVICE_FEE,
    CLEANING_FEE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT',2) }} + ROUND(SERVICE_FEE,2) +  ROUND(CLEANING_FEE,2) AS TOTAL_AMOUNT,
    BOOKING_STATUS,
    CREATED_AT
FROM 
    {{ ref("bronze_bookings") }}

