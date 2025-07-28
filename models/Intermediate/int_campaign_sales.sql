with sales_base as (
  select * from {{ref('stg_sales')}}
),
items_base as (
  select * from {{ref('clean_salesitems')}}
),
customers_base as (
  select * from {{ref('stg_customers')}}
),
products_base as (
  select *, round((catalog_price - cost_price)) as profit_margin from {{ref('clean_products')}}
),
campaigns_base as (
  select * from {{ref('clean_campaigns')}}
)

select
  sb.sale_id,
  sb.sale_date,
  sb.channel,
  cb.customer_id,
  cb.country as customer_country,
  pb.product_id,
  pb.product_name,
  pb.category,
  pb.brand,
  pb.gender as product_gender,
  ib.quantity,
  ib.unit_price,
  ib.discount_applied,
  ib.discount_percent,
  ib.item_total,
  camp.campaign_name as active_campaign,
  pb.profit_margin
from sales_base sb
join customers_base cb 
on sb.customer_id = cb.customer_id
join items_base ib 
on sb.sale_id = ib.sale_id
join products_base pb 
on ib.product_id = pb.product_id
join campaigns_base camp 
on sb.channel = camp.channel
where sb.sale_date between camp.start_date and camp.end_date