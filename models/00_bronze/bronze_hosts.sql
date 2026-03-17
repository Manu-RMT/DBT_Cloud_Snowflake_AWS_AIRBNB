{{ config(
   materialize='incremental',unique_key='HOST_ID'      
   ) }}


WITH cleaned AS (
   SELECT *,
          ROW_NUMBER() OVER (PARTITION BY HOST_ID ORDER BY CREATED_AT DESC) AS rn
   FROM {{ source('staging_schema','hosts') }} 
)

SELECT 
    HOST_ID,
    HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE,
    CREATED_AT
FROM cleaned
WHERE rn = 1

{% if is_incremental() %}
   AND CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}
