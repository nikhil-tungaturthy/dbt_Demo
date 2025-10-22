with
    fact_order as (
        select order_date, order_count, clerk_name
        from {{ source("raw", "fact_order") }}
    ),
    filter_1 as (
        select *
        from fact_order
        where date_part(year, order_date) = 1992 and order_count > 0
    ),
    order_1 as (select * from filter_1 order by order_date desc),
    largeorders1992_sql as (select * from order_1)
select *
from largeorders1992_sql
