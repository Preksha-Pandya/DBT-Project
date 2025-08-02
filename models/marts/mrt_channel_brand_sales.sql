select 
    channel,
    brand,
    sum(item_total) as total_sales,
    round(avg(item_total)) as avg_revenue,
    round(avg(profit_margin)) as avg_margin
from {{ ref('int_campaign_sales') }}
group by channel, brand
