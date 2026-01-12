-- KPI views for revenue, orders, AOV, and repeat rate

CREATE OR REPLACE VIEW kpi_revenue AS
SELECT
    DATE_TRUNC('month', o.order_date)::date AS month,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;

CREATE OR REPLACE VIEW kpi_orders AS
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;

CREATE OR REPLACE VIEW kpi_aov AS
SELECT
    r.month,
    r.total_revenue,
    o.total_orders,
    CASE
        WHEN o.total_orders = 0 THEN 0
        ELSE r.total_revenue / o.total_orders
    END AS average_order_value
FROM kpi_revenue r
JOIN kpi_orders o ON r.month = o.month
ORDER BY 1;

CREATE OR REPLACE VIEW kpi_repeat_rate AS
WITH customer_orders AS (
    SELECT customer_id, COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) FILTER (WHERE order_count > 1)::numeric / COUNT(*) AS repeat_rate
FROM customer_orders;
