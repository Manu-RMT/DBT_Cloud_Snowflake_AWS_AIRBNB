{{ config(
   materialize='incremental',unique_key='LISTING_ID'      
   ) }}

{# -- Étape 1 : nettoyer les doublons dans la source #}
WITH cleaned AS (
   SELECT *,
         {# -- ROW_NUMBER() classe les lignes par LISTING_ID #}
         {# -- La ligne la plus récente (selon CREATED_AT) reçoit rn = 1 #}
          ROW_NUMBER() OVER (PARTITION BY LISTING_ID ORDER BY CREATED_AT DESC) AS rn
   FROM {{ source('staging_schema','listings') }}  {# -- Source brute : staging_schema.listings #}
)

{# -- Étape 2 : ne garder que la ligne principale pour chaque LISTING_ID #}
SELECT 
    LISTING_ID,
    HOST_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    PRICE_PER_NIGHT,
    CREATED_AT
FROM cleaned
WHERE rn = 1  {# -- Garde uniquement la ligne la plus récente pour chaque LISTING_ID #}

{% if is_incremental() %}
  {# -- Étape 3 : filtrage incrémental #}
  {# -- Ne récupérer que les lignes dont CREATED_AT est plus récent que le max existant #}
   AND CREATED_AT > (
       SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') 
       FROM {{ this }}  {# -- {{ this }} fait référence à la table cible du modèle #}
   )
{% endif %}

 