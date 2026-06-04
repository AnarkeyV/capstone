# Monitoring Dashboard Package

This folder contains monitoring guidance and starter queries for The Shirt Bar capstone project.

It supports the future improvement:

```text
Add monitoring dashboards for AKS and application metrics
```

The goal is to give the team a practical monitoring structure for Azure Kubernetes Service, application health checks, and future Log Analytics dashboards.

---

## 1. Files

```text
monitoring/
├── README.md
├── aks_monitoring_queries.kql
├── application_health_queries.kql
└── dashboard_plan.md
```

| File | Purpose |
|---|---|
| `README.md` | Explains how monitoring fits into the project |
| `aks_monitoring_queries.kql` | Starter KQL queries for AKS monitoring |
| `application_health_queries.kql` | Starter KQL queries for app health and endpoint checks |
| `dashboard_plan.md` | Suggested dashboard layout for AKS and app metrics |

---

## 2. Monitoring Scope

This monitoring package covers:

- AKS node health
- Pod status
- Container restarts
- Kubernetes events
- CPU and memory usage
- Application health endpoint checks
- GitHub Actions deployment awareness
- Cost-control awareness when AKS is stopped

---

## 3. Azure Services Involved

The future monitoring setup can use:

| Service | Purpose |
|---|---|
| Azure Monitor | Collects metrics and monitoring data |
| Log Analytics Workspace | Stores logs and queryable telemetry |
| Container Insights | Provides AKS monitoring views |
| Application Insights | Optional future app-level telemetry |
| Azure Dashboards | Displays visual monitoring charts |

---

## 4. Current Project Readiness

The project already includes:

- `/health` endpoint
- Kubernetes liveness probe
- Kubernetes readiness probe
- GitHub Actions test stage
- pytest route coverage
- AKS stop/start cost-control process
- Terraform plan for Log Analytics Workspace

This monitoring folder builds on those foundations.

---

## 5. Important AKS Cost Note

If AKS is stopped, live monitoring data may not appear.

Expected when AKS is stopped:

```text
AKS public site may not load
Kubernetes deployment step may fail
Live pod metrics may stop updating
```

This is expected during cost-control periods and does not mean the application code is broken.

---

## 6. How To Use These Files

When Log Analytics is connected to AKS:

1. Open Azure Portal.
2. Go to the Log Analytics Workspace.
3. Open **Logs**.
4. Copy queries from the `.kql` files.
5. Run the queries.
6. Save useful charts to a dashboard.

---

## 7. Recommended Dashboard Sections

The dashboard should include:

- AKS cluster status
- Pod health
- Container restarts
- CPU usage
- Memory usage
- Kubernetes warning events
- Application health endpoint availability
- Deployment notes and runbook links

---

## 8. Presentation Explanation

Use this explanation:

```text
We added a monitoring package with Azure Monitor and Log Analytics query examples. This gives the team a clear plan for tracking AKS health, pod status, resource usage, and application health. It connects to our existing /health endpoint and Terraform monitoring plan.
```

---

## 9. Final Recommendation

The monitoring dashboard should be implemented after the Terraform-managed Log Analytics Workspace is deployed and connected to AKS.

Recommended order:

```text
Deploy Log Analytics Workspace
        ▼
Connect AKS Container Insights
        ▼
Run KQL queries
        ▼
Create Azure dashboard
        ▼
Set alerts for pod failures and high resource usage
```
