select customer_id::integer as customer_id,
    country::varchar(100) as country,
    age_range::varchar as age_range,
    signup_date::date as signup_date from
{{ source('European_Fashion','customers') }}