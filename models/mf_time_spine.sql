{{ config(materialized='table') }}

-- Adjustable window via vars (see step 3)
with base as (

  -- Use dbt_utils to generate a row per day
  select
    cast(date_spine as date) as date_day
  from {{ dbt_utils.date_spine(
        datepart = 'day',
        start_date = "to_date('{{ var('time_spine_start', '2010-01-01') }}')",
        end_date   = "to_date('{{ var('time_spine_end',   '2035-12-31') }}')"
  ) }}

)

select date_day
from base
