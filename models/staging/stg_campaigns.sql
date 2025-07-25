select 
campaign_id::integer as campaign_id,campaign_name::varchar(255) as campaign_name,
    start_date::date as start_date,
    end_date::date as end_date,
    channel::varchar as channel,
    discount_type::varchar as discount_type,
    discount_value::varchar as discount_value from
{{ source('European_Fashion','campaigns') }}