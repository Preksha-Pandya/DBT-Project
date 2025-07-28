with cltv as (
    select * from {{ ref('int_customer_orders') }}
)

select
    customer_id,
    customer_country,
    total_orders,
    total_items,
    total_spent,
    avg_order_value as avg_order_value,
    last_purchase_date as most_recent_purchase,
    days_since_last_purchase
from cltv

