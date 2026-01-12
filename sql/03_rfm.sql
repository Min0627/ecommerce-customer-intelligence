-- RFM (Recency, Frequency, Monetary) view
-- Uses orders + order_items to compute customer-level metrics.

CREATE OR REPLACE VIEW rfm_base AS
WITH order_values AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 1, 2, 3
)
SELECT
    customer_id,
    MAX(order_date) AS last_order_date,
    COUNT(DISTINCT order_id) AS frequency,
    SUM(order_value) AS monetary
FROM order_values
GROUP BY customer_id;

-- Recency in days from a chosen analysis date (max order date).
CREATE OR REPLACE VIEW rfm AS
WITH anchor AS (
    SELECT MAX(order_date) AS max_order_date FROM orders
)
SELECT
    r.customer_id,
    (a.max_order_date - r.last_order_date) AS recency_days,
    r.frequency,
    r.monetary
FROM rfm_base r
CROSS JOIN anchor a;
