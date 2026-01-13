-- Create schema and tables for the Olist dataset.
-- Uses Power BI friendly data types (timestamp, numeric(12,2), text, int).

CREATE SCHEMA IF NOT EXISTS olist;
SET search_path TO olist;

-- Customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id text PRIMARY KEY,
    customer_unique_id text,
    customer_zip_code_prefix int,
    customer_city text,
    customer_state text
);

-- Sellers
CREATE TABLE IF NOT EXISTS sellers (
    seller_id text PRIMARY KEY,
    seller_zip_code_prefix int,
    seller_city text,
    seller_state text
);

-- Orders
CREATE TABLE IF NOT EXISTS orders (
    order_id text PRIMARY KEY,
    customer_id text REFERENCES customers(customer_id),
    order_status text,
    order_purchase_timestamp timestamp,
    order_approved_at timestamp,
    order_delivered_carrier_date timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

-- Products
CREATE TABLE IF NOT EXISTS products (
    product_id text PRIMARY KEY,
    product_category_name text,
    product_name_lenght int,
    product_description_lenght int,
    product_photos_qty int,
    product_weight_g int,
    product_length_cm int,
    product_height_cm int,
    product_width_cm int
);

-- Product category translation
CREATE TABLE IF NOT EXISTS category_translation (
    product_category_name text PRIMARY KEY,
    product_category_name_english text
);

-- Order items
CREATE TABLE IF NOT EXISTS order_items (
    order_id text REFERENCES orders(order_id),
    order_item_id int,
    product_id text REFERENCES products(product_id),
    seller_id text REFERENCES sellers(seller_id),
    shipping_limit_date timestamp,
    price numeric(12,2),
    freight_value numeric(12,2),
    PRIMARY KEY (order_id, order_item_id)
);

-- Order payments
CREATE TABLE IF NOT EXISTS order_payments (
    order_id text REFERENCES orders(order_id),
    payment_sequential int,
    payment_type text,
    payment_installments int,
    payment_value numeric(12,2),
    PRIMARY KEY (order_id, payment_sequential)
);

-- Optional: order reviews
CREATE TABLE IF NOT EXISTS order_reviews (
    review_id text PRIMARY KEY,
    order_id text REFERENCES orders(order_id),
    review_score int,
    review_comment_title text,
    review_comment_message text,
    review_creation_date timestamp,
    review_answer_timestamp timestamp
);

-- Optional: geolocation
CREATE TABLE IF NOT EXISTS geolocation (
    geolocation_zip_code_prefix int,
    geolocation_lat numeric(12,2),
    geolocation_lng numeric(12,2),
    geolocation_city text,
    geolocation_state text
);
