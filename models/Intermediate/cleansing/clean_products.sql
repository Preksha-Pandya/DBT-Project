-- select product_id,product_name,category,brand,color,
-- case when size='36' then 'M'
-- when size='38' then 'L'
-- when size='35' then 'S'
-- when size='40' then 'XL'
-- else size
-- end as size,catalog_price,cost_price,gender from 
-- {{ ref('stg_products')}}

select product_id,product_name,category,brand,color,
case when size_in_alphabet is null then p.size
else size_in_alphabet
end as size,catalog_price,cost_price,gender
 from {{ref('stg_products')}} p 
left join {{ref('sizes')}} s on 
p.size=s.size::varchar