WITH fact_order AS (
  SELECT
    ORDER_DATE,
    ORDER_COUNT,
    CLERK_NAME
  FROM {{ source('raw', 'fact_order') }}
), filter_1 AS (
  SELECT
    *
  FROM fact_order
  WHERE
    DATE_PART(YEAR, ORDER_DATE) = 1992 AND ORDER_COUNT > 0
), order_1 AS (
  SELECT
    *
  FROM filter_1
  ORDER BY
    ORDER_DATE DESC
), "1992largeorders_sql" AS (
  SELECT
    *
  FROM order_1
)
SELECT
  *
FROM "1992largeorders_sql"