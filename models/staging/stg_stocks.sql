select country::string as country,
product_id::integer as product_id,
stock_quantity::integer as stock_quantity from
{{ source('European_Fashion','stocks') }}