-- KPI views for the Olist dataset.

CREATE SCHEMA IF NOT EXISTS olist;
SET search_path TO olist;

-- Overall KPI summary
CREATE OR REPLACE VIEW v_kpi_overview AS
WITH customer_order_counts AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    COALESCE(SUM(p.payment_value), 0) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    CASE
        WHEN COUNT(DISTINCT o.order_id) = 0 THEN 0
        ELSE COALESCE(SUM(p.payment_value), 0) / COUNT(DISTINCT o.order_id)
    END AS aov,
    CASE
        WHEN COUNT(*) = 0 THEN 0
        ELSE SUM(CASE WHEN c.order_count > 1 THEN 1 ELSE 0 END)::numeric / COUNT(*)
    END AS repeat_rate
FROM orders o
LEFT JOIN order_payments p ON p.order_id = o.order_id
LEFT JOIN customer_order_counts c ON c.customer_id = o.customer_id;

-- Monthly revenue and order volume
CREATE OR REPLACE VIEW v_revenue_monthly AS
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
    COALESCE(SUM(p.payment_value), 0) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders,
    CASE
        WHEN COUNT(DISTINCT o.order_id) = 0 THEN 0
        ELSE COALESCE(SUM(p.payment_value), 0) / COUNT(DISTINCT o.order_id)
    END AS aov
FROM orders o
LEFT JOIN order_payments p ON p.order_id = o.order_id
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;

-- Top products by revenue and units
CREATE OR REPLACE VIEW v_top_products AS
WITH payment_totals AS (
    SELECT
        order_id,
        SUM(payment_value) AS order_revenue
    FROM order_payments
    GROUP BY order_id
),
item_totals AS (
    SELECT
        order_id,
        SUM(price) AS items_price
    FROM order_items
    GROUP BY order_id
)
SELECT
    COALESCE(ct.product_category_name_english, p.product_category_name) AS product_category_name_english,
    SUM(
        CASE
            WHEN it.items_price IS NULL OR it.items_price = 0 THEN 0
            ELSE COALESCE(pt.order_revenue, 0) * (oi.price / it.items_price)
        END
    ) AS revenue,
    COUNT(*) AS units,
    COUNT(DISTINCT o.order_id) AS orders
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
LEFT JOIN payment_totals pt ON pt.order_id = oi.order_id
LEFT JOIN item_totals it ON it.order_id = oi.order_id
LEFT JOIN products p ON p.product_id = oi.product_id
LEFT JOIN category_translation ct ON ct.product_category_name = p.product_category_name
GROUP BY COALESCE(ct.product_category_name_english, p.product_category_name)
ORDER BY revenue DESC;
