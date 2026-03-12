{% macro m_multiply(x,y,precision_res) %}
    round({{x}} * {{y}}, {{precision_res}})
{% endmacro %}