WITH orders_min AS (
  SELECT
    ORDER_KEY,
    ORDER_DATE
  FROM {{ ref('orders_min') }}
), filter_1 AS (
  SELECT
    ORDER_DATE
  FROM orders_min
  WHERE
    ORDER_DATE > '1992-02-27'
), untitled_sql AS (
  SELECT
    ORDER_KEY,
    ORDER_DATE
  FROM filter_1
)
SELECT
  *
FROM untitled_sql