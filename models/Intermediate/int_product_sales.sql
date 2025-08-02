with int_product_sales as (
    select * from {{ ref('int_sales_data') }}
)

select
    product_id,
    category,
    brand,
    product_gender,
    sum(quantity) as total_quantity_sold,
    sum(item_total) as total_revenue,
    sum(quantity * profit_margin) as total_profit_margin,
    avg(unit_price) as avg_selling_price
from int_product_sales
group by product_id, category, brand, product_gender
