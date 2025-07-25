select product_id::integer as product_id,
    product_name::varchar(255) as product_name,
    category::varchar(100) as category,
    brand::varchar as brand,
    color::varchar as color,
    size::varchar as size,
    catalog_price::float as catalog_price,
    cost_price::float as cost_price,
    gender::varchar as gender from
{{ source('European_Fashion','products') }}