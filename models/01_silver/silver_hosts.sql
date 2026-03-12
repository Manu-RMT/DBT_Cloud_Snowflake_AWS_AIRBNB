{{ config(
    materialized='incremental',
    unique_key='HOST_ID'
    )
}}

SELECT 
    HOST_ID,
    REPLACE(HOST_NAME,'  ', ' ') as HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST AS IS_SUPERHOST,
    RESPONSE_RATE,
    {{ tag_response_rate('RESPONSE_RATE') }} AS RESPONSE_RATE_QUALITY,
    CREATED_AT
FROM 
    {{ ref("bronze_hosts") }}