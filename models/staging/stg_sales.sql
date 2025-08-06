{{
    config(
        materialized='incremental',
        unique_key='sale_id',
        merge_update_column='updated_at'
    )
}}
select sale_id::number as sale_id,
    channel::varchar(50) as channel,
    discounted::number as discounted,
    total_amount::varchar(50) as total_amount,
    sale_date::date as sale_date,
    customer_id::number as customer_id,
    country::varchar as country,
    current_timestamp() as created_at,
    current_timestamp() as updated_at from
{{ source('European_Fashion','sales') }}

{% if is_incremental() %}
where
sale_date >= (select max(sale_date) from {{this}})
{% endif %}