with customer_orders as (
    select * 
    from {{ ref('int_sales_data') }}
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



