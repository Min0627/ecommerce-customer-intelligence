# Agent Instructions

## How to Run
- **SQL**: use `psql` to run scripts in order.
  - Example: `psql ecommerce_ci -f sql/02_kpi_queries.sql`
- **Python**: create a virtual environment and install dependencies.
  - Example: `python -m venv .venv && source .venv/bin/activate && pip install -r python/requirements.txt`

## Coding Conventions
- Keep code beginner-friendly with clear comments.
- Use simple, descriptive variable names.
- Avoid overly complex abstractions.

## Security
- Never include secrets, passwords, or API keys in code or documentation.

## Reproducibility
- Ensure outputs are reproducible and steps are clearly documented.
