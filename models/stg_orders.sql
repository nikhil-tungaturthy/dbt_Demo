config(
    materialized='view'   -- start as a view; you can switch to 'table' later
) 

with src as (
    select
        order_id,
        customer_id,
        order_ts,
        order_status,
        subtotal_amount,
        tax_amount,
        shipping_amount,
        discount_amount,
        currency_code
    from  source('raw', 'fact_order') 
),

typed as (
    select
        cast(order_id as number)               as order_id,
        cast(customer_id as number)            as customer_id,
        try_to_timestamp(order_ts)             as order_ts,
        upper(trim(order_status))              as order_status,
        cast(subtotal_amount as number(38,2))  as subtotal_amount,
        cast(tax_amount as number(38,2))       as tax_amount,
        cast(shipping_amount as number(38,2))  as shipping_amount,
        cast(coalesce(discount_amount, 0) as number(38,2)) as discount_amount,
        upper(trim(currency_code))             as currency_code
    from src
),

final as (
    select
        order_id,
        customer_id,
        order_ts,
        to_date(order_ts)                       as order_date,
        order_status,
        currency_code,
        -- simple business calc
        subtotal_amount + tax_amount + shipping_amount - discount_amount as gross_order_amount,
        -- convenience flags
        case when upper(order_status) in ('CANCELLED', 'CANCELED') then 1 else 0 end as is_canceled,
        case when upper(order_status) in ('SHIPPED', 'DELIVERED', 'COMPLETED') then 1 else 0 end as is_fulfilled
    from typed
)

select * from final;