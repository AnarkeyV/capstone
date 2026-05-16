# Azure SQL Database Setup & Initialization

This document outlines the architecture, configuration steps, and automated deployment instructions for the project's relational database layer.

## Database Architecture
The backend services share a single Azure SQL Database instance containing two logical domain domains:
1. **Products Domain (`schema_products.sql`)**: Tracks catalogs, individual products, inventory variants, and warehouse stock levels.
2. **Orders Domain (`schema_orders.sql`)**: Tracks customer user profiles, shipping addresses, transactions, invoices, and fulfillment line details.

Performance indexes are included across common filter and look-up operations (`SKU`, `Email`, `Handle`, `OrderDate`) to optimize CPU loads.

## Prerequisites
Ensure your local host machine or deployment runner has the following packages:
* **Python 3.8+**
* **Visual C++ v14 Redistributable or latest**
* **Microsoft ODBC Driver for SQL Server** (Version 17 or 18 recommended)

Install the required automation runtime drivers:
```bash
pip install pyodbc python-dotenv
```

## Security & Environment Variables
Credentials must never be hardcoded into source code. Copy the configuration fields below into a local file named `.env` in the root directory:

```env
DB_SERVER=projectshirtbar.database.windows.net
DB_NAME=shirtbar
DB_USER=<your_discovered_properties_admin_name>
DB_PASSWORD=<your_reset_password_string>
```

> ⚠️ **Important**: `.env` is listed in `.gitignore` and must never be committed to source control.

### Network Firewall Configuration
Before running the deployment script, ensure your environment's public IPv4 address is added to the Azure SQL Server's Networking access list via the Azure Portal.

## Deployment Automation
To cleanly reset, build tables, map cross-schema foreign keys, and provision indexing vectors, execute the master wrapper initialization script:

```bash
python init_db.py
```

### Verification
Connect to the database instance using Azure Query Editor or SQL Server Management Studio (SSMS) and verify that 9 schema base tables compile as expected.
