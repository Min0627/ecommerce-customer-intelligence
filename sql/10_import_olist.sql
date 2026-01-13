-- Run with:
-- psql -d ecommerce_ci -v data_dir='C:/FULL/PATH/TO/data_raw' -f sql/10_import_olist.sql

SET search_path TO olist;

COPY customers FROM :'data_dir'/olist_customers_dataset.csv WITH (FORMAT csv, HEADER true);
COPY sellers FROM :'data_dir'/olist_sellers_dataset.csv WITH (FORMAT csv, HEADER true);
COPY orders FROM :'data_dir'/olist_orders_dataset.csv WITH (FORMAT csv, HEADER true);
COPY order_items FROM :'data_dir'/olist_order_items_dataset.csv WITH (FORMAT csv, HEADER true);
COPY order_payments FROM :'data_dir'/olist_order_payments_dataset.csv WITH (FORMAT csv, HEADER true);
COPY products FROM :'data_dir'/olist_products_dataset.csv WITH (FORMAT csv, HEADER true);
COPY category_translation FROM :'data_dir'/product_category_name_translation.csv WITH (FORMAT csv, HEADER true);

-- Optional tables: comment out if the files are not available.
COPY order_reviews FROM :'data_dir'/olist_order_reviews_dataset.csv WITH (FORMAT csv, HEADER true);
COPY geolocation FROM :'data_dir'/olist_geolocation_dataset.csv WITH (FORMAT csv, HEADER true);
