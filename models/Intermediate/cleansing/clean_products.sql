select product_id,product_name,category,brand,color,
case when size='36' then 'M'
when size='38' then 'L'
when size='35' then 'S'
when size='40' then 'XL'
else size
end as size,catalog_price,cost_price,gender from 
{{ ref('stg_products')}}