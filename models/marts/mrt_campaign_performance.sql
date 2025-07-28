with campaign_sales as (
    select * from {{ ref('int_campaign_sales') }}
)

select
    active_campaign as campaign_name,
    count(distinct sale_id) as total_orders,
    sum(item_total) as total_revenue,
    avg(discount_percent) as avg_discount_percent,
    sum(discount_applied) as total_discount_given
from campaign_sales
group by active_campaign
