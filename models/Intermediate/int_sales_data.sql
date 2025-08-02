with sales as (
    select * from {{ ref('stg_sales') }}
),
items as (
    select * from {{ ref('clean_salesitems') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
),
products as (
    select *,
           {{profit_margin('catalog_price','cost_price')}} as profit_margin
    from {{ ref('clean_products') }}
),
campaigns as (
    select * from {{ ref('clean_campaigns') }}
),
channels as (
    select * from {{ ref('stg_channels') }}
)

select
    s.sale_id,
    s.sale_date,
    s.channel,
    ch.description as channel_description,
    c.customer_id,
    c.country as customer_country,
    p.product_id,
    p.category,
    p.brand,
    p.gender as product_gender,
    i.quantity,
    i.unit_price,
    i.discount_applied,
    i.discount_percent,
    i.item_total,
    camp.campaign_name as active_campaign,
    p.profit_margin
from sales s
left join customers c on s.customer_id = c.customer_id
left join items i on s.sale_id = i.sale_id
left join products p on i.product_id = p.product_id
left join campaigns camp 
       on s.channel = camp.channel
      and s.sale_date between camp.start_date and camp.end_date
left join channels ch on s.channel = ch.channel
