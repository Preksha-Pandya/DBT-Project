with products as (
    select * from {{ ref('clean_products') }}
),
stocks as (
    select * from {{ ref('stg_stocks') }}
)

select 
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.gender,
    s.country as stock_country,
    s.stock_quantity,
    p.catalog_price,
    p.cost_price,
    {{profit_margin('catalog_price','cost_price')}} as profit_margin
from products p
left join stocks s on p.product_id = s.product_id
