-- with customer_orders as (
--     select * from {{ ref('int_campaign_sales') }}
-- )

-- select 
--     customer_id,
--     customer_country,
--     count(distinct sale_id) as total_orders,
--     count(*) as total_items,
--     sum(item_total) as total_spent,
--     round(avg(item_total)) as avg_order_value,
--     max(sale_date) as last_purchase_date,
--     datediff('day', max(sale_date), current_date) as days_since_last_purchase
-- from customer_orders
-- group by customer_id, customer_country
-- order by customer_id

{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge'
) }}

with customer_orders as (
    select * 
    from {{ ref('int_campaign_sales') }}
    {% if is_incremental() %}
    where sale_date > (select max(last_purchase_date) from {{ this }})
    {% endif %}
)

select 
    customer_id,
    customer_country,
    count(distinct sale_id) as total_orders,
    count(*) as total_items,
    sum(item_total) as total_spent,
    round(avg(item_total)) as avg_order_value,
    max(sale_date) as last_purchase_date,
    datediff('day', max(sale_date), current_date) as days_since_last_purchase
from customer_orders
group by customer_id, customer_country
order by customer_id
