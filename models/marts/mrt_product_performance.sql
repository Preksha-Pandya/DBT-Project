select * from {{ref('int_product_sales')}}
order by total_quantity_sold desc