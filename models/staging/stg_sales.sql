{{
    config(
        materialized='incremental'
    )
}}
select sale_id::number as sale_id,
    channel::varchar(50) as channel,
    discounted::number as discounted,
    total_amount::varchar(50) as total_amount,
    sale_date::date as sale_date,
    customer_id::number as customer_id,
    country::varchar as country from
{{ source('European_Fashion','sales') }}

{% if is_incremental() %}
where
sale_date >= (select max(sale_date) from {{this}})
{% endif %}