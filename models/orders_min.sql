{{ config(materialized='view') }}

select 
    order_key, 
    year(order_date) as order_year
from 
    {{ source('raw','fact_order') }}