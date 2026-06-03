# Phase 2 Azure SQL Setup Documentation

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Task: CSD-25 — P2-3A Create or Confirm Azure SQL Server and Databases  
Owner: Khairul Rizal  
Last Updated: 29-05-2026

---

## 1. Purpose of This Document

This document records the Azure SQL setup required for The Shirt Bar e-commerce website.

The website requires Azure SQL databases to store product catalogue data, product categories, customer orders, and order items.

This task was added because the original Phase 2 manual assumed that Azure SQL Server and the required databases already existed, but did not clearly assign the actual creation or confirmation step.

---

## 2. Scope

This document covers:

- Confirming the Azure SQL Server
- Creating or confirming the required databases
- Tagging the SQL resources
- Recording team access requirements for the SQL Server and databases
- Preparing firewall and network access checks
- Preparing for schema and seed data execution
- Preparing handover information for the next task, CSD-16

This document does **not** include real passwords, secret keys, or full connection strings.

---

## 3. Azure SQL Server Confirmation

The Azure SQL Server already existed before the required databases were created.

| Item | Value |
|---|---|
| SQL Server Name | `sql-capstone-csd07grp2` |
| SQL Server Address | `sql-capstone-csd07grp2.database.windows.net` |
| Resource Group | `rg-capstone` |
| Region | Southeast Asia |
| Status | Existing server confirmed |
| Purpose | Logical SQL Server container for The Shirt Bar databases |

---

## 4. Existing Databases Found

The following databases were visible under the Azure SQL Server before creating the required project databases.

| Database Name | Purpose | Action |
|---|---|---|
| `master` | Default Azure SQL system database | Do not modify |
| `sql-capstone-CSD07-grp2` | Existing project database with non-standard name | Leave unchanged until the team confirms whether it is still used |

---

## 5. Required Databases Created

The following databases were created for The Shirt Bar website.

| Database Name | Purpose | Status |
|---|---|---|
| `tsb-products-db` | Stores product catalogue, categories, and seed product data | Created |
| `tsb-orders-db` | Stores customer orders and order items | Created |

Final intended SQL structure:

```text
sql-capstone-csd07grp2
├── master
├── sql-capstone-CSD07-grp2
├── tsb-products-db
└── tsb-orders-db
```

The `master` database should not be used for application tables.

The existing `sql-capstone-CSD07-grp2` database should not be deleted unless the team confirms it is no longer required.

---

## 6. Tagging Completion Note

The Azure SQL Server and the two required Azure SQL databases have been tagged using the agreed Phase 2 tagging standard.

Tagged SQL resources:

| Resource Name | Resource Type | Tagging Status | Notes |
|---|---|---|---|
| `sql-capstone-csd07grp2` | Azure SQL Server | Completed | Parent SQL Server for the project databases |
| `tsb-products-db` | Azure SQL Database | Completed | Product catalogue database |
| `tsb-orders-db` | Azure SQL Database | Completed | Orders and order items database |

Applied tags:

| Tag Name | Tag Value |
|---|---|
| `Owner` | `Khairul Rizal` |
| `Project` | `The Shirt Bar` |
| `Course` | `CSD07` |
| `Environment` | `Development` |
| `Phase` | `Phase 2` |
| `ManagedBy` | `CSD07 Capstone Team` |
| `CostControl` | `Student Budget` |

---

## 7. Team Access Note

This is a capstone project, so all active team members should be able to access the shared Azure SQL resources needed for the project.

There are two types of access to be aware of:

1. **Azure resource access** — permission to see and manage the SQL Server resource in Azure Portal.
2. **Database connection access** — permission to connect to the database and run SQL queries.

For this capstone project, all active team members have been added as Contributors to the main resource group and the Azure SQL Server resource.

The two required databases are managed under the SQL Server and resource group access. The database pages may not show a separate **Access control (IAM)** option in the same way as the SQL Server resource. This is acceptable for the current capstone setup.

### Team members requiring Azure SQL resource access

| Team Member | Required Azure Role | Scope | Status |
|---|---|---|---|
| Khairul Rizal | Contributor / Owner as project lead | `rg-capstone` and `sql-capstone-csd07grp2` | Completed |
| Terence | Contributor | `rg-capstone` and `sql-capstone-csd07grp2` | Completed |
| Peng Chou | Contributor | `rg-capstone` and `sql-capstone-csd07grp2` | Completed |
| Faith | Contributor | `rg-capstone` and `sql-capstone-csd07grp2` | Completed |

### SQL resources covered by team Azure access

| Resource Name | Resource Type | Team Access Status |
|---|---|---|
| `rg-capstone` | Azure Resource Group | Team members added as Contributors |
| `sql-capstone-csd07grp2` | Azure SQL Server | Team members added as Contributors |
| `tsb-products-db` | Azure SQL Database | Managed under SQL Server / resource group access |
| `tsb-orders-db` | Azure SQL Database | Managed under SQL Server / resource group access |

### Access notes

- Adding a team member as Contributor in Azure Portal lets them manage Azure resources.
- Azure Contributor access does **not** automatically allow a user to run SQL queries inside the databases.
- Database login credentials or database users are still required for SQL query access.
- Do not commit SQL usernames, passwords, or connection strings to GitHub.
- If a shared SQL login is used for capstone testing, store it privately and rotate it if it is exposed.
- For a production system, each user should have individual database access instead of sharing admin credentials.

---

## 8. Database Purpose Explanation

### `tsb-products-db`

This database is used for product-related information.

It should contain tables such as:

- `categories`
- `products`

It should also contain sample product data loaded from the seed file.

Expected SQL files:

| SQL File | Target Database | Purpose |
|---|---|---|
| `schema_products.sql` | `tsb-products-db` | Creates product and category tables |
| `seed_products.sql` | `tsb-products-db` | Inserts sample product data |

---

### `tsb-orders-db`

This database is used for customer order-related information.

It should contain tables such as:

- `orders`
- `order_items`

Expected SQL files:

| SQL File | Target Database | Purpose |
|---|---|---|
| `schema_orders.sql` | `tsb-orders-db` | Creates order and order item tables |

---

## 9. Security and Secrets Notes

The following values must not be committed to GitHub:

- SQL admin password
- Full database connection string
- `.env` file
- Stripe secret key
- Any Kubernetes secret file containing real values
- Any Azure DevOps secret variable value

The application should use environment variables instead of hardcoded credentials.

Expected environment variable names:

| Environment Variable | Purpose |
|---|---|
| `DB_SERVER` | Azure SQL Server address |
| `DB_NAME_PRODUCTS` | Products database name |
| `DB_NAME_ORDERS` | Orders database name |
| `DB_USERNAME` | SQL username |
| `DB_PASSWORD` | SQL password |

Example placeholder format:

```env
DB_SERVER=sql-capstone-csd07grp2.database.windows.net
DB_NAME_PRODUCTS=tsb-products-db
DB_NAME_ORDERS=tsb-orders-db
DB_USERNAME=<stored-privately>
DB_PASSWORD=<stored-privately>
```

Do not replace the placeholders with real secret values in GitHub documentation.

---

## 10. Firewall and Network Access

Azure SQL uses firewall and networking rules to control who can connect.

The current developer IP address has been added for initial setup and testing.

Additional firewall and team access checks are still required before this task is considered complete.

| Access Type | Purpose | Status |
|---|---|---|
| Current developer IP address | Allows the current developer to test database connection locally | Completed |
| Other team member IP addresses | Allows other team members to test database connection locally if needed | To confirm |
| Azure services access | Allows Azure-hosted services to connect later if enabled | To confirm |
| Future AKS access | Required when the Flask app runs in AKS | To be handled in CSD-16 |

### Firewall notes

The current developer IP address was added to the Azure SQL Server firewall rules so that the database can be accessed from the local development machine.

Other team members may need their own client IP addresses added if they need to connect directly from their laptops.

For a real production environment, firewall rules should be reviewed more strictly and limited to only the required application or network sources.

---

## 11. Schema and Seed Data Checklist

After the databases are created, the schema and seed scripts should be run or verified.

| Step | SQL File | Target Database | Status |
|---|---|---|---|
| Create product/category tables | `schema_products.sql` | `tsb-products-db` | Completed |
| Insert sample product data | `seed_products.sql` | `tsb-products-db` | Completed |
| Create orders/order items tables | `schema_orders.sql` | `tsb-orders-db` | Completed |

These steps may be completed using:

- Azure Data Studio
- SQL Server extension in VS Code
- Azure Query Editor
- A Python database initialization script

---

## 12. Verification Queries

After schema and seed scripts are run, the following checks should be completed.

### Check product tables

Target database:

```text
tsb-products-db
```

Example query:

```sql
SELECT TOP 10 *
FROM products;
```

Expected result:

```text
Product rows should be returned.
```

---

### Check category table

Target database:

```text
tsb-products-db
```

Example query:

```sql
SELECT TOP 10 *
FROM categories;
```

Expected result:

```text
Category rows should be returned.
```

---

### Check order tables

Target database:

```text
tsb-orders-db
```

Example query:

```sql
SELECT TOP 10 *
FROM orders;
```

Expected result:

```text
The table should exist. It may be empty before test orders are created.
```

---

## 13. SQL Script Execution Summary

The required SQL scripts have been run and verified.

| Script | Target Database | Result |
|---|---|---|
| `schema_products.sql` | `tsb-products-db` | Completed successfully |
| `seed_products.sql` | `tsb-products-db` | Completed successfully |
| `schema_orders.sql` | `tsb-orders-db` | Completed successfully |

Verification completed:

| Check | Result |
|---|---|
| `categories` table exists in `tsb-products-db` | Verified |
| `products` table exists in `tsb-products-db` | Verified |
| 12 product records exist in `products` table | Verified |
| `orders` table exists in `tsb-orders-db` | Verified |
| `order_items` table exists in `tsb-orders-db` | Verified |

The `orders` and `order_items` tables may be empty until test orders are created through the website checkout flow.

---

### Check order item table

Target database:

```text
tsb-orders-db
```

Example query:

```sql
SELECT TOP 10 *
FROM order_items;
```

Expected result:

```text
The table should exist. It may be empty before test orders are created.
```

---

## 13. SQL Script Execution Summary

The required SQL scripts have been run and verified.

| Script | Target Database | Result |
|---|---|---|
| `schema_products.sql` | `tsb-products-db` | Completed successfully |
| `seed_products.sql` | `tsb-products-db` | Completed successfully |
| `schema_orders.sql` | `tsb-orders-db` | Completed successfully |

Verification completed:

| Check | Result |
|---|---|
| `categories` table exists in `tsb-products-db` | Verified |
| `products` table exists in `tsb-products-db` | Verified |
| 12 product records exist in `products` table | Verified |
| `orders` table exists in `tsb-orders-db` | Verified |
| `order_items` table exists in `tsb-orders-db` | Verified |

The `orders` and `order_items` tables may be empty until test orders are created through the website checkout flow.

---

## 14. Handover Notes for CSD-16

CSD-16 is responsible for configuring the Flask application connection, firewall approach, and secrets plan.

The following information should be handed over to the CSD-16 owner.

| Item | Value |
|---|---|
| SQL Server Name | `sql-capstone-csd07grp2` |
| SQL Server Address | `sql-capstone-csd07grp2.database.windows.net` |
| Products Database | `tsb-products-db` |
| Orders Database | `tsb-orders-db` |
| Resource Group | `rg-capstone` |
| Region | Southeast Asia |
| Credentials Location | Stored privately, not in GitHub |
| Team Resource Access Status | Completed for resource group and SQL Server Azure resource access |
| Firewall Status | Current developer IP configured; other team access still to confirm |
| Schema Status | Completed and verified |
| Seed Data Status | Completed and verified for products database |

---

## 15. Completion Criteria for CSD-25

CSD-25 is considered complete when:

- Azure SQL Server exists or has been confirmed.
- `tsb-products-db` exists.
- `tsb-orders-db` exists.
- SQL Server is tagged.
- Both required databases are tagged.
- Team members have required Azure resource access to the SQL Server and databases.
- Firewall or network access approach is documented.
- Product and order schema scripts are run or verified.
- Product seed data is loaded or verified.
- No database passwords or secret values are committed to GitHub.
- CSD-16 can proceed with application connection settings and secrets planning.

Current progress:

| Requirement | Status |
|---|---|
| Azure SQL Server confirmed | Completed |
| `tsb-products-db` created | Completed |
| `tsb-orders-db` created | Completed |
| SQL Server tagged | Completed |
| `tsb-products-db` tagged | Completed |
| `tsb-orders-db` tagged | Completed |
| Current developer IP added to SQL firewall | Completed |
| Team Azure resource access confirmed | Completed for resource group and SQL Server Azure resource access |
| Other team member SQL/firewall access confirmed | Pending |
| Product schema verified | Completed |
| Product seed data verified | Completed |
| Order schema verified | Completed |
| Documentation committed to GitHub | Pending |

Status: In Progress — SQL Server, databases, tags, current developer IP, resource group access, SQL Server Azure resource access, schema execution, seed data, and verification completed; final GitHub commit pending  
Prepared by: Khairul Rizal  
Target Completion Date: 29-05-2026
