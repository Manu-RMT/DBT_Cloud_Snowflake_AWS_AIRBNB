{% set configs_fact = [
    {
        "table" : "AIRBNB_DB.GOLD.OBT",
        "columns" : "GOLD_obt.BOOKING_ID,GOLD_obt.LISTING_ID,GOLD_obt.HOST_ID,
                     GOLD_obt.TOTAL_AMOUNT,GOLD_obt.TOTAL_AMOUNT_WITHOUT_FEE, GOLD_obt.SERVICE_FEE,GOLD_obt.CLEANING_FEE,
                     GOLD_obt.ACCOMMODATES,GOLD_obt.BEDROOMS,GOLD_obt.BATHROOMS,GOLD_obt.PRICE_PER_NIGHT,
                     GOLD_obt.RESPONSE_RATE
                    ",
        "alias" : "GOLD_obt"
    }
]
%}

SELECT 
    {{ configs_fact[0].columns }}
FROM 
    {{ configs_fact[0].table }} as {{ configs_fact[0].alias }}