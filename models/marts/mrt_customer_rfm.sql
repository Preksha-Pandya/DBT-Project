with customer_orders as (
    select
        customer_id,
        last_purchase_date,
        total_orders as frequency,
        total_spent as monetary
    from {{ ref('int_customer_orders') }}
)

select
    customer_id,
    datediff('day', last_purchase_date, current_date) as recency,
    frequency,
    monetary
from customer_orders
