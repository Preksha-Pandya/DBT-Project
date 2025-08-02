with int_campaign_sales as (
    select * from {{ ref('int_sales_data') }}
)

select 
    active_campaign,
    sale_id,
    sale_date,
    channel,
    product_id,
    category,
    brand,
    item_total,
    discount_applied,
    discount_percent,
    profit_margin
from int_campaign_sales
where active_campaign is not null
