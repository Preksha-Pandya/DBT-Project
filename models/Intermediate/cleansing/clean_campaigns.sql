select campaign_id,campaign_name,start_date,end_date,channel,discount_type,
case when discount_type='Percentage' then round((replace(discount_value,'%',' ')))
else discount_value
end as discount_value from {{ ref('stg_campaigns') }}