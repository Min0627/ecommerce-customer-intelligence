# Import Instructions (PostgreSQL COPY)

> Update file paths to match your local CSV locations.

```sql
-- Customers
COPY customers
FROM '/absolute/path/to/customers.csv'
DELIMITER ','
CSV HEADER;

-- Orders
COPY orders
FROM '/absolute/path/to/orders.csv'
DELIMITER ','
CSV HEADER;

-- Products
COPY products
FROM '/absolute/path/to/products.csv'
DELIMITER ','
CSV HEADER;

-- Order Items
COPY order_items
FROM '/absolute/path/to/order_items.csv'
DELIMITER ','
CSV HEADER;

-- Payments
COPY payments
FROM '/absolute/path/to/payments.csv'
DELIMITER ','
CSV HEADER;
```

## Tips
- Ensure date/time formats match PostgreSQL defaults (ISO 8601).
- For large files, consider `COPY ... FROM STDIN` or `\copy` in `psql`.
