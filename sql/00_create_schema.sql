-- Schema for ecommerce customer intelligence project
-- Adjust data types as needed for your source system.

CREATE TABLE IF NOT EXISTS customers (
    customer_id      VARCHAR(64) PRIMARY KEY,
    created_at       TIMESTAMP,
    city             TEXT,
    state            TEXT,
    country          TEXT
);

CREATE TABLE IF NOT EXISTS orders (
    order_id         VARCHAR(64) PRIMARY KEY,
    customer_id      VARCHAR(64) REFERENCES customers(customer_id),
    order_status     TEXT,
    order_date       DATE,
    order_timestamp  TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id       VARCHAR(64) PRIMARY KEY,
    category         TEXT,
    brand            TEXT
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id    VARCHAR(64) PRIMARY KEY,
    order_id         VARCHAR(64) REFERENCES orders(order_id),
    product_id       VARCHAR(64) REFERENCES products(product_id),
    quantity         INTEGER,
    unit_price       NUMERIC(12, 2)
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id       VARCHAR(64) PRIMARY KEY,
    order_id         VARCHAR(64) REFERENCES orders(order_id),
    payment_type     TEXT,
    payment_amount   NUMERIC(12, 2),
    payment_date     DATE
);

-- Helpful indexes for analytics
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_payments_order_id ON payments(order_id);
