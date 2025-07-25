select item_id::number as item_id,
    sale_id::number as sale_id,
    product_id::number as product_id,
    quantity::integer as quantity,
    original_price::numeric(5,2) as original_price,
    unit_price::numeric(10,2) as unit_price,
    discount_applied::numeric(5,2) as discount_applied,
    discount_percent::string as discount_percent,
    discounted::integer as discounted,
    item_total::number as item_total,
    sale_date::date as sale_date,
    channel::varchar as channel,
    channel_campaigns::varchar as channel_campaigns from
{{ source('European_Fashion','salesitems') }}