# AKS and Application Metrics Dashboard Plan

This document describes the recommended monitoring dashboard layout for The Shirt Bar capstone project.

---

## 1. Dashboard Purpose

The dashboard should help the team answer:

- Is AKS running?
- Are pods healthy?
- Is the application responding?
- Are containers restarting?
- Are there warning events?
- Is CPU or memory usage too high?
- Is the `/health` route available?
- Did a deployment cause errors?

---

## 2. Recommended Dashboard Layout

### Section 1 — AKS Overview

| Tile | Purpose |
|---|---|
| Cluster name | Confirms the monitored AKS cluster |
| Node status | Shows whether nodes are ready |
| Pod count | Shows total running pods |
| Warning events | Highlights Kubernetes issues |

---

### Section 2 — Application Health

| Tile | Purpose |
|---|---|
| `/health` response | Confirms the Flask app is alive |
| Homepage check | Confirms the shop page loads |
| Product page check | Confirms product route works |
| Cart page check | Confirms cart route works |

---

### Section 3 — Pod and Container Health

| Tile | Purpose |
|---|---|
| Pod status table | Shows Running, Pending, Failed, or CrashLoopBackOff |
| Container restarts | Detects unstable app containers |
| Latest pod events | Shows deployment or scheduling issues |
| Current image version | Helps confirm the deployed image tag |

---

### Section 4 — Resource Usage

| Tile | Purpose |
|---|---|
| CPU usage | Shows whether pods are CPU constrained |
| Memory usage | Shows whether pods are using too much memory |
| Node CPU | Shows AKS node pressure |
| Node memory | Shows AKS node pressure |

---

### Section 5 — Deployment Awareness

| Tile | Purpose |
|---|---|
| GitHub Actions status note | Explains CI/CD result |
| AKS stopped note | Explains cost-control behaviour |
| Last known working image | Records stable rollback version |
| Runbook links | Links to verification and monitoring guides |

---

## 3. Suggested Alerts

Future Azure Monitor alerts:

| Alert | Trigger | Action |
|---|---|---|
| Pod not running | Pod status is not Running | Notify team |
| Container restarting | Restart count > 3 | Investigate logs |
| High memory usage | Memory above threshold | Check resource limits |
| High CPU usage | CPU above threshold | Check scaling needs |
| Health check failure | `/health` does not return 200 | Investigate deployment |
| Kubernetes warning events | Warning events detected | Review pod/service events |

---

## 4. Dashboard Implementation Steps

1. Deploy or connect Log Analytics Workspace.
2. Enable AKS Container Insights.
3. Open Azure Portal.
4. Go to Log Analytics Workspace.
5. Run KQL queries from the monitoring folder.
6. Save useful query results as dashboard tiles.
7. Add notes for AKS cost-control behaviour.
8. Add links to README and verification checklist.

---

## 5. Cost-Control Note

Live monitoring depends on AKS running.

When AKS is stopped:

```text
The application may not respond.
Pod metrics may stop updating.
GitHub Actions deployment may fail.
```

This is expected when AKS is intentionally stopped to reduce Azure cost.

---

## 6. Final Recommendation

For the capstone, the monitoring dashboard should focus on practical operational visibility:

```text
AKS health
Pod status
Container restarts
Application /health route
CPU and memory usage
Deployment troubleshooting
Cost-control awareness
```

This is enough to show a realistic DevOps monitoring approach without overcomplicating the project.
