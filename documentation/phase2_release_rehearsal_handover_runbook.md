# Phase 2 Release Rehearsal and Handover Runbook

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Task: CSD-23 — P2-11 Complete Azure Release Rehearsal and Handover Runbook  
Owner: Khairul Rizal  
Status: Draft — pending P10 cost-control and cleanup confirmation  
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

This runbook is currently a draft because P10 cost-control and cleanup work is still pending.

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
| Cost Controls and Cleanup Checklist | Pending P10 |
| Final Release Rehearsal | Pending |
| Final Handover Runbook | Draft in progress |

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

## 5. Pre-Rehearsal Checklist

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
| P10 cleanup/cost-control checklist confirmed | Pending P10 |

---

## 6. Start AKS Cluster

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

## 7. Refresh AKS Credentials

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

## 8. Website Smoke Test

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

## 9. Run Ansible Deployment Check

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

## 10. Check Azure Monitoring

Check monitoring after the release rehearsal.

Areas to review:

| Area | What to Check | Result |
|---|---|---|
| AKS metrics | Cluster and pod health | Pending |
| Logs | Any deployment or application errors | Pending |
| Alerts | Whether alerts are configured or visible | Pending |
| Resource usage | CPU/memory usage during testing | Pending |

Notes from P9 monitoring task should be added here after final confirmation.

---

## 11. Azure SQL Check

Azure SQL resources used by the project:

| Database | Purpose |
|---|---|
| `tsb-products-db` | Stores product/category data |
| `tsb-orders-db` | Stores order/order item data |

Known database setup completed:

- Product database schema created.
- Product seed data inserted.
- Orders database schema created.
- No SQL credentials are stored in this runbook.

During final rehearsal, confirm whether the deployed application is reading from Azure SQL or using local/static data, depending on the latest application configuration.

---

## 12. Rollback / Recovery Notes

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

## 13. Cost-Control and Cleanup Section

This section is pending P10.

To be completed after P10 confirms:

- Which resources must remain running for the final presentation.
- Which resources can be stopped after testing.
- Whether AKS should be stopped after each rehearsal.
- Whether any unused resources should be removed.
- Budget alert or cost-monitoring notes.
- Final cleanup checklist after the capstone presentation.

Current temporary guidance:

- Stop AKS when the team is not actively testing.
- Do not delete shared resources unless the team agrees.
- Do not delete databases or ACR images before the final demo.
- Check with the team before stopping resources during active testing periods.

---

## 14. Stop AKS After Testing

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

---

## 15. Final Rehearsal Sign-Off

This section should be completed after P10 is finished and the full rehearsal has been run.

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
| Cost-control/cleanup confirmed | Pending P10 |  |
| Known issues documented | Pending |  |
| Team handover completed | Pending |  |

---

## 16. Known Issues / Pending Items

| Item | Owner | Status |
|---|---|---|
| P10 cost-control and cleanup checklist | Faith | Pending |
| Final release rehearsal | Khairul Rizal | Pending |
| Final runbook update after P10 | Khairul Rizal | Pending |
| Final team sign-off | Team | Pending |

---

## 17. Final Notes

This runbook is designed to help the team avoid confusion during the final presentation.

The team should use it as a checklist before the final demo, during the rehearsal, and after testing is completed.

This draft can be committed before P10 is complete, but the final PR should not be closed until the P10 cost-control and cleanup section has been updated.

Prepared by: Khairul Rizal  
Status: Draft pending P10
