{{ config(materialized='table') }}

select order_key, order_date
from {{ source('raw','fact_order') }}

