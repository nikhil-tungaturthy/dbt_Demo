with 

source as (

    select * from {{ source('raw', 'fact_order') }}

),

renamed as (

    select
        order_key,
        order_date,
        customer_key,
        status_code,
        priority_code,
        clerk_name,
        ship_priority,
        order_count,
        gross_item_sales_amount,
        item_discount_amount,
        item_tax_amount,
        net_item_sales_amount

    from source

)

select * from renamed