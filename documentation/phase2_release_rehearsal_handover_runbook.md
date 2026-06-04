# Phase 2 Release Rehearsal and Handover Runbook

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Task: CSD-23 — P2-11 Complete Azure Release Rehearsal and Handover Runbook  
Owner: Khairul Rizal  
Status: Updated after P10 — ready for final rehearsal  
Last Updated: 03-06-2026

---

## 1. Purpose of This Runbook

This runbook explains how the team should prepare for the final Azure release rehearsal and final project handover.

The goal is to make sure the team can:

- Confirm the website is deployed successfully.
- Test the main customer journey.
- Check that monitoring and deployment checks are available.
- Understand what to do if the website does not work during the final demo.
- Know which resources should remain running and which resources should be stopped after testing.
- Follow the agreed Azure cost-control and cleanup rules.

---

## 2. Current Status

| Area | Status |
|---|---|
| Azure Resource Group | Created |
| AKS Cluster | Created |
| ACR | Created |
| Azure SQL Server | Created |
| Product Database | Created |
| Orders Database | Created |
| Flask Website Deployment to AKS | Completed |
| CI/CD Release Workflow | Completed |
| Ansible Deployment Check | Completed |
| Azure Monitoring | Completed |
| Cost Controls and Cleanup Checklist | Completed in P10 |
| Final Release Rehearsal | Pending final run |
| Final Handover Runbook | Updated after P10 |

---

## 3. Important Azure Resources

| Resource | Name |
|---|---|
| Resource Group | `rg-capstone` |
| AKS Cluster | `capstone-aks` |
| ACR | `capstonereg047af007` |
| ACR Login Server | `capstonereg047af007.azurecr.io` |
| Azure SQL Server | `sql-capstone-csd07grp2` |
| Product Database | `tsb-products-db` |
| Orders Database | `tsb-orders-db` |
| Legacy / leftover database | `sql-capstone-CSD07-grp2` |
| AKS Service | `capstone-service` |
| AKS Service Type | `LoadBalancer` |
| Current External IP | `20.184.58.23` |
| Current Website URL | `http://20.184.58.23` |

Important note: the external IP may change if the service or deployment is recreated. Always confirm the latest IP using `kubectl get svc`.

---

## 4. Required Access Before Final Rehearsal

Before running the final rehearsal, confirm that the team has access to:

- GitHub repository
- Azure Portal
- Azure CLI
- AKS cluster
- ACR
- Azure SQL resources
- Azure DevOps or GitHub release workflow
- Stripe test environment, if checkout is being tested
- Monitoring/logs area in Azure

No passwords or secrets should be written in this runbook.

Secrets should be stored only in the correct private platform, such as Azure, GitHub secrets, Azure DevOps variables, Jenkins credentials, or local `.env` files that are not committed to GitHub.

---

## 5. P10 Cost-Control Summary

P10 has been completed and documented in:

    documentation/P2-10_Cost_Controls_and_Cleanup.docx

Key P10 outcomes:

| Item | Confirmed Detail |
|---|---|
| Azure budget | `$20/month` |
| Budget scope | `rg-capstone` |
| Alert thresholds | `50%`, `80%`, `100%` |
| Alert recipients | All four team members |
| Cost owner | Khairul Rizal |
| Main scale-down action | Stop AKS when idle |
| Tagging status | Completed across SQL resources |
| Leftover database | `sql-capstone-CSD07-grp2` |
| Leftover database action | Flagged as deletion candidate after confirmation |
| Cleanup checklist | Documented in P10 file |

The leftover database `sql-capstone-CSD07-grp2` has been tagged using the full project tag set but should be treated as a cleanup candidate because it appears unused.

Do not delete it before the final demo unless the team confirms it is safe to remove.

---

## 6. Final Demo Required Resource List

The following resources should remain available for the final rehearsal and presentation:

| Resource | Required for Demo? | Notes |
|---|---|---|
| `rg-capstone` | Yes | Main Azure resource group |
| `capstone-aks` | Yes | Required to host the deployed website |
| `capstonereg047af007` | Yes | Required for container image storage |
| `sql-capstone-csd07grp2` | Yes | Required for Azure SQL databases |
| `tsb-products-db` | Yes | Product database |
| `tsb-orders-db` | Yes | Orders database |
| `capstone-service` | Yes | Public LoadBalancer service |
| Monitoring/log resources | Yes | Required for P9 monitoring explanation |
| `sql-capstone-CSD07-grp2` | No / cleanup candidate | Keep until final confirmation |

---

## 7. Pre-Rehearsal Checklist

Before starting the final release rehearsal, confirm the following:

| Check | Status |
|---|---|
| Team has pulled latest `main` branch | Pending |
| AKS cluster is running | Pending |
| Correct Azure subscription is selected | Pending |
| `kubectl` is connected to `capstone-aks` | Pending |
| Website external IP is confirmed | Pending |
| Latest deployment workflow has completed | Pending |
| Website homepage loads | Pending |
| Product pages load | Pending |
| Cart works | Pending |
| Checkout test flow works | Pending |
| Success page works | Pending |
| Failed/cancelled flow works | Pending |
| Ansible health check passes | Pending |
| Azure monitoring/logs checked | Pending |
| P10 cleanup/cost-control checklist confirmed | Completed |

---

## 8. Start AKS Cluster

If the AKS cluster is stopped, start it before testing:

    az aks start \
      --resource-group rg-capstone \
      --name capstone-aks

Check the AKS status:

    az aks show \
      --resource-group rg-capstone \
      --name capstone-aks \
      --query "{name:name, powerState:powerState.code, provisioningState:provisioningState}" \
      --output table

Expected result:

    PowerState    Running
    Succeeded

---

## 9. Refresh AKS Credentials

After starting AKS, refresh local Kubernetes credentials:

    az aks get-credentials \
      --resource-group rg-capstone \
      --name capstone-aks \
      --overwrite-existing

Confirm the current Kubernetes context:

    kubectl config current-context

Then check services:

    kubectl get svc

Look for:

| Field | Expected Value |
|---|---|
| Service Name | `capstone-service` |
| Type | `LoadBalancer` |
| External IP | Public IP address |
| Port | `80` |

---

## 10. Website Smoke Test

Open the website URL in a browser:

    http://20.184.58.23

Test the following pages and flows:

| Test Area | Expected Result | Result |
|---|---|---|
| Homepage | Page loads successfully | Pending |
| Product listing | Products are visible | Pending |
| Product detail page | Product information loads | Pending |
| Add to cart | Item is added to cart | Pending |
| Cart page | Cart shows correct item | Pending |
| Checkout page | Checkout loads correctly | Pending |
| Stripe test payment | Test payment flow works | Pending |
| Success page | Success message is shown | Pending |
| Failed/cancelled page | Failed/cancelled flow is shown | Pending |

---

## 11. Run Ansible Deployment Check

The Ansible playbook provides a repeatable health check for the deployed website.

Run:

    ansible-playbook -i ansible/inventory.ini ansible/deployment_check.yml

Expected result:

    Website responded with HTTP status 200
    failed=0

If the playbook fails, check:

- AKS cluster is running.
- External IP is correct.
- Website is reachable in the browser.
- `app_url` in `ansible/deployment_check.yml` uses the latest external IP.
- Local internet connection is working.

---

## 12. Check Azure Monitoring

Check monitoring after the release rehearsal.

Areas to review:

| Area | What to Check | Result |
|---|---|---|
| AKS metrics | Cluster and pod health | Pending |
| Logs | Any deployment or application errors | Pending |
| Alerts | Whether alerts are configured or visible | Pending |
| Resource usage | CPU/memory usage during testing | Pending |

Monitoring should be checked after the website smoke test so that the team can confirm the deployed application generated visible activity.

---

## 13. Azure SQL Check

Azure SQL resources used by the project:

| Database | Purpose |
|---|---|
| `tsb-products-db` | Stores product/category data |
| `tsb-orders-db` | Stores order/order item data |
| `sql-capstone-CSD07-grp2` | Legacy / leftover database, flagged as cleanup candidate |

Known database setup completed:

- Product database schema created.
- Product seed data inserted.
- Orders database schema created.
- SQL resources tagged.
- Legacy database tagged and flagged as a deletion candidate.
- No SQL credentials are stored in this runbook.

During final rehearsal, confirm whether the deployed application is reading from Azure SQL or using local/static data, depending on the latest application configuration.

---

## 14. Rollback / Recovery Notes

If the website fails during the final demo, follow this order:

1. Confirm AKS is running.
2. Confirm the external IP using `kubectl get svc`.
3. Try opening the website in a browser.
4. Run the Ansible health check.
5. Check Azure monitoring/logs.
6. Confirm the latest image exists in ACR.
7. Redeploy using the release workflow if needed.
8. Fall back to explaining the documented architecture and screenshots if Azure is temporarily unavailable.

---

## 15. Cost-Control and Cleanup Rules

The team has confirmed the Azure budget and cleanup approach in P10.

### Budget and Alerts

| Item | Value |
|---|---|
| Monthly budget | `$20/month` |
| Scope | `rg-capstone` |
| Alert thresholds | `50%`, `80%`, `100%` |
| Alert recipients | All four team members |
| Cost owner | Khairul Rizal |

### Main Cost-Control Rule

Stop AKS when the team is not actively testing or presenting.

AKS should be running only when needed for:

- Final rehearsal
- Team testing
- Presentation/demo
- Troubleshooting deployment issues

### Resources Not to Delete Before Final Demo

Do not delete the following before the final presentation:

- `rg-capstone`
- `capstone-aks`
- `capstonereg047af007`
- `sql-capstone-csd07grp2`
- `tsb-products-db`
- `tsb-orders-db`
- Kubernetes deployment/service files
- Monitoring/logging resources required for explanation

### Cleanup Candidate

The database below appears unused and has been flagged as a deletion candidate:

    sql-capstone-CSD07-grp2

Action: keep it until the team confirms it is safe to delete after the final demo.

---

## 16. Stop AKS After Testing

If no team member needs the website running, stop AKS to reduce Azure cost:

    az aks stop \
      --resource-group rg-capstone \
      --name capstone-aks

Confirm it stopped:

    az aks show \
      --resource-group rg-capstone \
      --name capstone-aks \
      --query "{name:name, powerState:powerState.code, provisioningState:provisioningState}" \
      --output table

Expected result:

    PowerState    Stopped
    Succeeded

Important note: when AKS is stopped, the public website may not be reachable. This is expected.

---

## 17. Post-Presentation Cleanup Checklist

After the final capstone presentation, the team should review and clean up resources carefully.

| Cleanup Item | Action |
|---|---|
| AKS cluster | Stop when no longer needed |
| ACR images | Keep until final submission is confirmed |
| SQL databases | Keep required databases until final submission is confirmed |
| Legacy database | Review and delete only if team confirms it is unused |
| Budget alerts | Keep until all Azure resources are cleaned up |
| Documentation | Keep in GitHub |
| Secrets | Do not commit; remove from local machines if no longer needed |
| Resource group | Delete only after final confirmation from the team and lecturer |

Do not delete the full resource group until the team is certain that no further demo, grading, screenshot, or evidence collection is required.

---

## 18. Final Rehearsal Sign-Off

This section should be completed after the full rehearsal has been run.

| Item | Status | Notes |
|---|---|---|
| Deployment workflow completed | Pending |  |
| Website loads from AKS | Pending |  |
| Homepage tested | Pending |  |
| Product flow tested | Pending |  |
| Cart flow tested | Pending |  |
| Checkout flow tested | Pending |  |
| Success/failure pages tested | Pending |  |
| Ansible health check passed | Pending |  |
| Monitoring checked | Pending |  |
| Cost-control/cleanup confirmed | Completed | Based on P10 |
| Known issues documented | Pending |  |
| Team handover completed | Pending |  |

---

## 19. Known Issues / Pending Items

| Item | Owner | Status |
|---|---|---|
| P10 cost-control and cleanup checklist | Faith | Completed |
| Final release rehearsal | Khairul Rizal | Pending |
| Final runbook update after rehearsal | Khairul Rizal | Pending |
| Final team sign-off | Team | Pending |
| Confirm deletion of `sql-capstone-CSD07-grp2` after demo | Team | Pending |

---

## 20. Final Notes

This runbook is designed to help the team avoid confusion during the final presentation.

The team should use it as a checklist before the final demo, during the rehearsal, and after testing is completed.

The P10 cost-control and cleanup information has now been added. The remaining work is to run the final rehearsal, record the results, and complete the final sign-off table.

Prepared by: Khairul Rizal  
Status: Updated after P10 — pending final rehearsal
