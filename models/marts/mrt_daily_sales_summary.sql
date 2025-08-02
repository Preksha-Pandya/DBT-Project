with int_campaign_sales as (
    select * from {{ ref('int_sales_data') }}
)

select
    sale_date as sales_day,
    count(distinct sale_id) as total_orders,
    sum(item_total) as total_revenue,
    sum(quantity) as total_units_sold,
    round(avg(discount_percent)) as avg_discount_percent,
    round(sum(discount_applied),2) as total_discount_given
from int_campaign_sales
group by sales_day
order by sales_day
