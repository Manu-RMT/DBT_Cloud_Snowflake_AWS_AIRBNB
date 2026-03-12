-- Macro qui multiplie deux colonnes et arrondit le résultat
-- x : première colonne ou expression SQL
-- y : deuxième colonne ou expression SQL
-- precision_res : nombre de décimales pour l'arrondi
-- Exemple : round(NIGHTS_BOOKED * BOOKING_AMOUNT, 2)

{% macro multiply(x, y, precision_res) %}
    round({{ x }} * {{ y }}, {{ precision_res }})
{% endmacro %}


-- Macro qui nettoie une colonne texte
-- column_name : nom de la colonne à transformer
-- trim : supprime les espaces au début et à la fin
-- upper : transforme le texte en majuscules
-- Exemple généré : upper(trim(customer_name))

{% macro trimmer(column_name) %}
    {{ column_name | trim | upper }}
{% endmacro %}


-- Macro qui catégorise un prix en fonction de sa valeur
-- column_name : colonne numérique contenant le prix
-- Retourne une catégorie : Low / Medium / High
-- Génère un CASE WHEN dans le SQL final

{% macro tag_price(column_name) %}
    case
        when {{ column_name }} < 100 then 'Low'
        when {{ column_name }} < 200 then 'Medium'
        else 'High'
    end
{% endmacro %}

{% macro tag_response_rate(column_name) %}
    case
        when {{ column_name }} > 95 then 'VERY GOOD'
        when {{ column_name }} > 75 then 'GOOD'
        when {{ column_name }} > 50 then 'FAIR'
        else 'POOR'
    end
{% endmacro %}