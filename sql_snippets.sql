/* =====================================================================
   E-Commerce Sales & Customer Retention Analytics (Snowflake)
   Two example queries from the project.
   ===================================================================== */


/* ---------------------------------------------------------------------
   1. Building one row per order without inflating revenue

   Orders can have several items and several payments. Joining the raw
   tables directly would multiply rows and overcount revenue, so each
   table is first aggregated to one row per order.
   --------------------------------------------------------------------- */
WITH items AS (
  SELECT order_id, COUNT(*) AS n_items, SUM(price) AS items_revenue
  FROM order_items
  GROUP BY order_id
),
payments AS (
  SELECT order_id, SUM(payment_value) AS payment_total
  FROM order_payments
  GROUP BY order_id
)
SELECT o.order_id,
       c.customer_unique_id,
       i.items_revenue,
       p.payment_total,
       DATEDIFF('day', o.order_purchase_timestamp,
                       o.order_delivered_customer_date) AS delivery_days
FROM orders o
JOIN customers c      ON o.customer_id = c.customer_id
LEFT JOIN items i     ON o.order_id = i.order_id
LEFT JOIN payments p  ON o.order_id = p.order_id;


/* ---------------------------------------------------------------------
   2. Cohort retention

   Each customer is assigned to the month of their first delivered order.
   The query then counts how many of them ordered again in each later month.
   Retention % = customers in that month / cohort size in month 0.

   fact_orders is the one-row-per-order view built from query 1 (it also
   carries order_date and order_status).
   --------------------------------------------------------------------- */
WITH orders_m AS (
  SELECT DISTINCT customer_unique_id,
         DATE_TRUNC('month', order_date) AS order_month
  FROM fact_orders
  WHERE order_status = 'delivered'
),
cohorts AS (
  SELECT customer_unique_id,
         order_month,
         MIN(order_month) OVER (PARTITION BY customer_unique_id) AS cohort_month
  FROM orders_m
)
SELECT cohort_month,
       DATEDIFF('month', cohort_month, order_month) AS months_since_first_order,
       COUNT(DISTINCT customer_unique_id)           AS customers
FROM cohorts
GROUP BY 1, 2;
