with int_channel_performance as (
    select * from {{ ref('int_campaign_sales') }}
)

select
    channel,
    count(distinct sale_id) as total_orders,
    sum(quantity) as total_units_sold,
    sum(item_total) as total_revenue,
    sum(discount_applied) as total_discount_given,
    avg(discount_percent) as avg_discount_percent,
    sum(profit_margin * quantity) as total_estimated_profit
from int_channel_performance
group by channel
order by channel
