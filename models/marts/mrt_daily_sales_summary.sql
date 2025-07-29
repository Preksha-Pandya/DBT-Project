with int_campaign_sales as (
    select * from {{ ref('int_campaign_sales') }}
)

select
    sale_date as sales_day,
    count(distinct sale_id) as total_orders,
    sum(item_total) as total_revenue,
    sum(quantity) as total_units_sold,
    avg(discount_percent) as avg_discount_percent,
    sum(discount_applied) as total_discount_given
from int_campaign_sales
group by sales_day
order by sales_day
