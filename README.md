# Ecommerce Customer Intelligence (MY/SG)

## Business Problem Statement
Retail and ecommerce teams in Malaysia/Singapore need a clear view of revenue drivers, customer retention, and high-value segments. This project builds a reproducible analytics pipeline to store transactional data in PostgreSQL, derive KPIs and RFM segments, and surface insights in a Power BI dashboard.

## Dataset Expectation
The project expects CSV extracts with the following logical tables:
- `customers` (customer_id, created_at, city, state, country)
- `orders` (order_id, customer_id, order_status, order_date, order_timestamp)
- `order_items` (order_item_id, order_id, product_id, quantity, unit_price)
- `products` (product_id, category, brand)
- `payments` (payment_id, order_id, payment_type, payment_amount, payment_date)

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
psql ecommerce_ci -f sql/00_create_schema.sql
```

### 2) Import Data
Follow `sql/01_import_instructions.md` for COPY examples and file paths.

### 3) Create KPI + RFM Views
```bash
psql ecommerce_ci -f sql/02_kpi_queries.sql
psql ecommerce_ci -f sql/03_rfm.sql
```

### 4) Python Environment
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r python/requirements.txt
```

Run the notebook in `python/rfm_segmentation.ipynb` and export segments to PostgreSQL.

## Power BI Dashboard (Placeholder)
- **Data Model**: build relationships on `customer_id` and `order_id`.
- **Measures**: use SQL views for KPIs and RFM segment tables for slicing.
- **Screenshot Placeholder**: add an image here once the report is built.

## Insights (Placeholder)
- Example: "Top 20% of customers contribute 70% of revenue."
- Example: "Repeat rate improved after a targeted campaign."
