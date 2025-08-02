with product_inventory as (
    select * from {{ ref('int_product_inventory') }}
),
product_sales as (
    select
        product_id,
        sum(quantity) as total_sold_last_180_days
    from {{ ref('int_sales_data') }}
    where sale_date >= dateadd('day', -180, current_date)
    group by product_id
)

select
    pi.product_id,
    pi.product_name,
    pi.category,
    pi.brand,
    pi.stock_country,
    pi.stock_quantity,
    coalesce(ps.total_sold_last_180_days, 0) as sales_last_180_days,
    case
        when pi.stock_quantity < coalesce(ps.total_sold_last_180_days,0) then 'LOW STOCK'
        when pi.stock_quantity = 0 then 'OUT OF STOCK'
        else 'HEALTHY'
    end as stock_status
from product_inventory pi
left join product_sales ps on pi.product_id = ps.product_id
