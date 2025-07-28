{% macro profit_margin(col1,col2)%}
round({{col1}}-{{col2}})
{%endmacro%}