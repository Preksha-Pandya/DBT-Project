select item_id,sale_id,product_id,quantity,original_price,unit_price,
replace(discount_percent,'%',' ')::number(5,2) as discount_percent,discounted,
item_total,sale_date,
channel,channel_campaigns
from {{ref('stg_salesitems')}}