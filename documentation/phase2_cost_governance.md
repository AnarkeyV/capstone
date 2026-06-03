# Phase 2 Cost Governance, Naming, Tagging, and Budget Guardrails

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Owner: Khairul Rizal  
Last Updated: 22-05-2026

---

## 1. Purpose of This Document

This document defines the naming, tagging, cost-control, and cleanup rules for Phase 2 of The Shirt Bar capstone project.

Phase 2 involves deploying the website to Azure and using services such as Azure SQL, Azure DevOps, Docker, Kubernetes, Terraform, Jenkins, Ansible, monitoring, and cost management.

The purpose of this document is to help the team avoid confusion, accidental spending, unmanaged resources, and unclear ownership of Azure services.

---

## 2. Scope

This document applies to resources created for the capstone project inside the Azure resource group.

| Item | Value |
|---|---|
| Azure Resource Group | `rg-capstone` |
| Project | The Shirt Bar E-Commerce Capstone |
| Environment | Development / Demo |
| Team | CSD07 Capstone Team |
| Main Azure Region | Southeast Asia |
| Subscription | Azure for Students |

---

## 3. Naming Standard

The team should use clear and consistent names for Azure resources.

Existing resources do not need to be renamed if they are already working, but new resources should follow this standard where possible.

| Resource Type | Naming Standard | Example |
|---|---|---|
| Resource Group | `rg-<project>` | `rg-capstone` |
| AKS Cluster | `aks-<project>` or `<project>-aks` | `capstone-aks` |
| Azure Container Registry | `acr<project><unique>` or existing generated name | `capstonereg047af007` |
| Azure SQL Server | `sql-<project>-<unique>` | `sql-capstone-001` |
| Products Database | fixed name | `tsb-products-db` |
| Orders Database | fixed name | `tsb-orders-db` |
| Log Analytics Workspace | `log-<project>` | `log-capstone` |
| Application Insights | `appi-<project>` | `appi-capstone` |
| Azure DevOps Service Connection | `sc-<scope>-<purpose>` | `sc-rg-capstone-azure` |
| Budget | `budget-<project>` | `budget-capstone` |

### Naming Notes

- Existing resources that are already working do not need to be renamed.
- New resources should follow the naming standard as much as possible.
- Resource names should be simple enough for non-technical team members to understand.
- Avoid random names unless Azure requires a globally unique name.
- Avoid creating duplicate resources with similar names unless approved by the team.

---

## 4. Tagging Standard

Tags help the team identify ownership, project purpose, environment, and cost tracking.

The following tags should be applied to `rg-capstone` and major resources where possible.

| Tag Name | Tag Value | Purpose |
|---|---|---|
| `Owner` | `Khairul Rizal` | Identifies the primary owner |
| `Project` | `The Shirt Bar` | Identifies the project or client |
| `Course` | `CSD07` | Identifies the course cohort |
| `Environment` | `Development` | Shows this is not a production environment |
| `Phase` | `Phase 2` | Shows the current project phase |
| `ManagedBy` | `CSD07 Capstone Team` | Identifies the team managing the resource |
| `CostControl` | `Student Budget` | Reminds the team to control Azure spending |

---

## 4.1 Tagging Completion Note

The `rg-capstone` resource group and all current major Phase 2 Azure resources have been tagged using the agreed tagging standard.

Tagged resources:

| Resource Name | Resource Type | Tagging Status | Notes |
|---|---|---|---|
| `rg-capstone` | Resource Group | Completed | Main project resource group |
| `capstone-aks` | Kubernetes Service / AKS | Completed | AKS was temporarily started so tags could be applied |
| `capstonereg047af007` | Azure Container Registry | Completed | Used to store Docker images for deployment |
| `MSCI-southeastasia-capstone-aks` | Data Collection Rule | Completed | Monitoring-related resource linked to AKS |

The AKS cluster was temporarily started to allow tag updates because Azure does not allow some management operations while the cluster is stopped. After tagging was completed, the AKS cluster should be stopped again when it is not actively needed to reduce Azure student subscription cost.

Current agreed tagging standard:

| Tag Name | Tag Value |
|---|---|
| `Owner` | `Khairul Rizal` |
| `Project` | `The Shirt Bar` |
| `Course` | `CSD07` |
| `Environment` | `Development` |
| `Phase` | `Phase 2` |
| `ManagedBy` | `CSD07 Capstone Team` |
| `CostControl` | `Student Budget` |

Tagging is considered complete for the currently provisioned Phase 2 resources.

---

## 5. Azure Budget Guardrails

A budget has been configured to alert the team before Azure spending becomes too high.

| Budget Setting | Configured Value |
|---|---|
| Budget Name | `budget-capstone` |
| Scope | `rg-capstone` |
| Reset Period | Monthly |
| Amount | Based on Azure student subscription budget |
| Alert 1 | 50% actual cost |
| Alert 2 | 80% actual cost |
| Alert Recipient | Project lead email |
| Status | Completed |

### Budget Purpose

The budget is not meant to stop the project. It is meant to warn the team early if Azure spending is increasing too quickly.

Budget alerts help the team:

- notice unexpected Azure spending
- avoid using up student subscription credits too quickly
- identify resources that may be running unnecessarily
- control costs before final deployment
- explain cost management during the final presentation

### Budget Alert Notes

The budget alert has been configured with two alert thresholds:

| Alert Threshold | Purpose |
|---|---|
| 50% | Early warning to review spending |
| 80% | Strong warning to take action before costs increase further |

Additional 90% and 100% alerts may be added later if required, but the current 50% and 80% alerts are sufficient for Phase 2 cost guardrails.

---

## 6. Cost Management Rules

The team should follow these rules during Phase 2:

- Do not create resources outside `rg-capstone` unless agreed by the team.
- Do not use high-cost SKUs unless required for the demo.
- Prefer low-cost or free-tier options where possible.
- Review Azure Cost Management at least twice per week.
- Delete failed test resources after troubleshooting.
- Stop or scale down resources that are not needed.
- Keep only the resources required for the final demo.
- Do not deploy duplicate AKS, ACR, SQL, or monitoring resources unless approved.
- Do not commit secrets, passwords, or `.env` files to GitHub.
- Stop the AKS cluster when it is not actively needed for deployment or testing.
- Avoid running test workloads overnight unless required.

---

## 7. Resource Review Checklist

The team should regularly review the following resources.

| Resource | Required for Demo? | Cost Risk | Action |
|---|---|---|---|
| AKS Cluster | Yes | Medium / High | Keep only if needed for final deployment; stop when not in use |
| Azure Container Registry | Yes | Low / Medium | Keep for Docker images |
| Azure SQL Database | Yes | Medium | Use only required databases |
| Log Analytics / Data Collection Rule | Yes | Medium | Monitor ingestion cost |
| Application Insights | Optional / Useful | Low / Medium | Enable if useful for presentation |
| Test VMs | Usually No | High | Delete if not needed |
| Extra Storage Accounts | Usually No | Low / Medium | Delete if unused |
| Duplicate Resource Groups | No | Medium / High | Avoid creating duplicate resource groups |

---

## 8. AKS Cost-Control Note

The `capstone-aks` cluster may consume Azure credit when running because it uses compute resources through its node pool.

For cost-control purposes:

- AKS should only be started when needed for deployment, testing, or demonstration.
- AKS should be stopped after testing if it is not needed.
- Team members should avoid creating additional node pools unless approved.
- The team should avoid scaling the cluster unless required for testing.
- AKS status should be checked before and after deployment work.

Recommended AKS process:

1. Start AKS only when deployment or testing is required.
2. Run deployment or validation tasks.
3. Capture screenshots or logs needed for evidence.
4. Stop AKS after testing if no further work is required.
5. Confirm the cluster shows `Stopped` in Azure Portal.

---

## 9. Cleanup Rules After Final Presentation

After the final presentation, the team should:

1. Take screenshots or export evidence needed for the report.
2. Save final architecture diagrams and deployment notes.
3. Confirm whether the website needs to remain online.
4. Delete unused test resources.
5. Remove unnecessary duplicate resources.
6. Review Azure Cost Management one final time.
7. Decide whether to delete or keep:
   - AKS
   - Azure Container Registry
   - Azure SQL Database
   - Log Analytics
   - Application Insights
   - Any test VMs
   - Any unused storage accounts
8. Keep documentation in GitHub for reference.

---

## 10. Team Responsibilities

| Responsibility | Owner |
|---|---|
| Budget setup | Khairul Rizal |
| Tagging review | Khairul Rizal |
| Cost Management review | Khairul Rizal / assigned teammate |
| AKS start/stop review | Khairul Rizal / assigned teammate |
| Cleanup after presentation | Whole team |
| Final confirmation | Project lead |

---

## 11. Evidence to Capture

The following screenshots or evidence should be captured for the final report or presentation:

| Evidence | Purpose |
|---|---|
| `rg-capstone` resource group overview | Shows all project resources |
| Resource group tags | Shows governance and ownership |
| AKS tags | Shows tagging was applied to core hosting resource |
| ACR tags | Shows tagging was applied to image registry |
| Data collection rule tags | Shows monitoring-related resource tagging |
| Cost Management budget screen | Shows budget guardrail |
| Budget alert settings | Shows threshold planning |
| AKS stopped/running status | Shows cost-control practice |
| Azure DevOps service connection | Shows deployment integration |
| Azure Pipeline successful run | Shows CI/CD progress |

---

## 12. Completion Criteria for CSD-14

CSD-14 is considered complete when:

- Resource naming standard is documented.
- Tags are added or confirmed on `rg-capstone`.
- Major resources have appropriate tags where possible.
- Azure budget or cost alert is configured.
- Cost-control rules are documented.
- Cleanup rules are documented.
- This document is committed to the GitHub repository.

Current progress:

| Requirement | Status |
|---|---|
| Naming standard documented | Completed |
| Resource group tags added | Completed |
| Major resource tags added | Completed |
| AKS tags added | Completed |
| ACR tags added | Completed |
| Monitoring/data collection resource tags added | Completed |
| Budget alert configured | Completed |
| Cleanup rules documented | Completed |
| Documentation committed to GitHub | Pending |

Status: In Progress — Azure governance completed, GitHub commit pending  
Prepared by: Khairul Rizal  
Target Completion Date: 25-05-2026