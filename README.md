# Ecommerce Customer Intelligence (MY/SG)

## Goals
- Build a job-ready Data Analyst portfolio project for Malaysia/Singapore.
- Use PostgreSQL for storage + SQL analysis.
- Use Python for RFM segmentation + optional KMeans clustering.
- Output a Power BI dashboard (pbix created locally; repo includes queries + modeling guide).

## Business Problem Statement
Retail and ecommerce teams in Malaysia/Singapore need a clear view of revenue drivers, customer retention, and high-value segments. This project builds a reproducible analytics pipeline to store transactional data in PostgreSQL, derive KPIs and RFM segments, and surface insights in a Power BI dashboard.

## Dataset Expectation
The project expects CSV extracts with the following logical tables:
- `customers` (customer_id, created_at, city, state, country)
- `orders` (order_id, customer_id, order_status, order_date, order_timestamp)
- `order_items` (order_item_id, order_id, product_id, quantity, unit_price)
- `products` (product_id, category, brand)
- `payments` (payment_id, order_id, payment_type, payment_amount, payment_date)

> Note: Column names can vary by dataset. The SQL schema and import scripts can be adjusted to match your CSV headers.

## Tech Stack
- **Database**: PostgreSQL
- **SQL**: KPI calculations + RFM view
- **Python**: RFM scoring + optional KMeans clustering
- **BI**: Power BI dashboard (pbix created locally)

## Project Workflow
1. **SQL**: Create schema, import raw data, and compute KPI + RFM views.
2. **Python**: Pull RFM view, score customers, and write segments back to Postgres.
3. **Power BI**: Build a dashboard from the SQL views and segment table.

## KPI List
- Total Revenue
- Total Orders
- Average Order Value (AOV)
- Repeat Rate
- RFM Segments

## How to Run

### 1) PostgreSQL Setup
```bash
createdb ecommerce_ci
psql -d ecommerce_ci -f sql/00_create_schema_olist.sql
psql -d ecommerce_ci -v data_dir='C:/.../data_raw' -f sql/10_import_olist.sql
psql -d ecommerce_ci -f sql/20_kpi_queries_olist.sql
```
