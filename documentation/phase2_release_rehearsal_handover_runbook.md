# Phase 2 Release Rehearsal and Handover Runbook

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Task: CSD-23 — P2-11 Complete Azure Release Rehearsal and Handover Runbook  
Owner: Khairul Rizal  
Status: Updated after P10 and rehearsal check — issue found before final demo  
Last Updated: 04-06-2026

---

## 1. Purpose of This Runbook

This runbook explains how the team should prepare for the final Azure release rehearsal and final project handover.

The goal is to make sure the team can:

- Confirm the website or deployed service is reachable.
- Test the main customer journey where available.
- Check that monitoring and deployment checks are available.
- Understand what to do if the website does not work during the final demo.
- Know which resources should remain running and which resources should be stopped after testing.
- Follow the agreed Azure cost-control and cleanup rules.

This runbook also records the rehearsal finding that the current AKS deployment is reachable, but the deployed image is returning an API/health response instead of the full customer-facing e-commerce website.

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
| Flask Website Deployment to AKS | Partially verified — AKS service reachable, but customer-facing shop not exposed |
| CI/CD Release Workflow | Completed |
| Ansible Deployment Check | Completed and passed |
| Azure Monitoring | Completed |
| Cost Controls and Cleanup Checklist | Completed in P10 |
| Final Release Rehearsal | Infrastructure check completed; full shop flow blocked |
| Final Handover Runbook | Updated after P10 and rehearsal check |

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
| AKS Deployment | `capstone-app` |
| Current AKS Image | `capstonereg047af007.azurecr.io/ecommerce-app:v21` |
| AKS Service | `capstone-service` |
| AKS Service Type | `LoadBalancer` |
| Current External IP | `20.184.58.23` |
| Current Service URL | `http://20.184.58.23` |

Important note: the external IP may change if the service or deployment is recreated. Always confirm the latest IP using `kubectl get svc`.

---

## 4. Required Access Before Final Demo

Before the final demo, confirm that the team has access to:

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
| `capstone-aks` | Yes | Required to host the deployed service |
| `capstonereg047af007` | Yes | Required for container image storage |
| `sql-capstone-csd07grp2` | Yes | Required for Azure SQL databases |
| `tsb-products-db` | Yes | Product database |
| `tsb-orders-db` | Yes | Orders database |
| `capstone-service` | Yes | Public LoadBalancer service |
| Monitoring/log resources | Yes | Required for P9 monitoring explanation |
| `sql-capstone-CSD07-grp2` | No / cleanup candidate | Keep until final confirmation |

---

## 7. Rehearsal Check Completed on 04-06-2026

AKS was started temporarily for the P11 rehearsal check and stopped again afterwards for cost control.

### AKS Status Before Testing

| Item | Result |
|---|---|
| AKS cluster | `capstone-aks` |
| Power state before rehearsal | `Stopped` |
| Provisioning state | `Succeeded` |

### AKS Status During Testing

| Item | Result |
|---|---|
| AKS cluster | `capstone-aks` |
| Power state during rehearsal | `Running` |
| Provisioning state | `Succeeded` |

### Kubernetes Service Check

Command used:

    kubectl get svc

Result:

| Service | Type | Cluster IP | External IP | Port |
|---|---|---|---|---|
| `capstone-service` | `LoadBalancer` | `10.0.110.69` | `20.184.58.23` | `80:30500/TCP` |
| `kubernetes` | `ClusterIP` | `10.0.0.1` | `<none>` | `443/TCP` |

### Kubernetes Deployment Check

Command used:

    kubectl describe deployment

Key result:

| Item | Value |
|---|---|
| Deployment | `capstone-app` |
| Replicas | `1 desired`, `1 available` |
| Image | `capstonereg047af007.azurecr.io/ecommerce-app:v21` |
| Container port | `8000/TCP` |
| Liveness probe | `/health` |
| Readiness probe | `/health` |

### Browser / Curl Route Test

| Route | Result | Notes |
|---|---|---|
| `/` | `HTTP/1.1 200 OK` | Returns API JSON: `Capstone API is running` |
| `/health` | `HTTP/1.1 200 OK` | Returns `{"status":"ok"}` |
| `/products` | `HTTP/1.1 404 NOT FOUND` | Customer-facing product route not available |
| `/home` | `HTTP/1.1 404 NOT FOUND` | Customer-facing home route not available |

### Rehearsal Finding

The AKS deployment is reachable and healthy, but the currently deployed image appears to be an API/health-check version instead of the full customer-facing e-commerce website.

The following result should be reported honestly:

    Infrastructure health check: Passed
    AKS LoadBalancer: Reachable
    Ansible check: Passed
    Full e-commerce shop flow: Blocked because the current AKS image returns API/health JSON, not the customer-facing shop pages

---

## 8. Pre-Demo Checklist

Before starting the final demo, confirm the following:

| Check | Status |
|---|---|
| Team has pulled latest `main` branch | Pending final demo |
| AKS cluster is running | Pending final demo |
| Correct Azure subscription is selected | Pending final demo |
| `kubectl` is connected to `capstone-aks` | Completed during rehearsal |
| Website/service external IP is confirmed | Completed during rehearsal |
| Latest deployment workflow has completed | Pending final demo |
| API/health endpoint loads | Completed |
| Customer-facing homepage loads | Blocked — current image returns API JSON |
| Product pages load | Blocked — `/products` returns 404 |
| Cart works | Blocked until correct shop image/routes are deployed |
| Checkout test flow works | Blocked until correct shop image/routes are deployed |
| Success page works | Blocked until correct shop image/routes are deployed |
| Failed/cancelled flow works | Blocked until correct shop image/routes are deployed |
| Ansible health check passes | Completed |
| Azure monitoring/logs checked | Pending final demo |
| P10 cleanup/cost-control checklist confirmed | Completed |

---

## 9. Start AKS Cluster

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

## 10. Refresh AKS Credentials

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

## 11. Website / Service Smoke Test

Open the service URL in a browser:

    http://20.184.58.23

For the current deployment, this returns:

    {"message":"Capstone API is running","region":"southeastasia","status":"healthy"}

This confirms that the deployed service is reachable, but it does not confirm the full customer-facing shop flow.

For the final demo, the team should confirm whether the correct e-commerce frontend image and routes have been deployed.

---

## 12. Run Ansible Deployment Check

The Ansible playbook provides a repeatable health check for the deployed service.

Run:

    ansible-playbook -i ansible/inventory.ini ansible/deployment_check.yml

Actual rehearsal result:

    Website responded with HTTP status 200
    failed=0

If the playbook fails, check:

- AKS cluster is running.
- External IP is correct.
- Service is reachable in the browser.
- `app_url` in `ansible/deployment_check.yml` uses the latest external IP.
- Local internet connection is working.

---

## 13. Check Azure Monitoring

Check monitoring after the release rehearsal.

Areas to review:

| Area | What to Check | Result |
|---|---|---|
| AKS metrics | Cluster and pod health | Pending final demo |
| Logs | Any deployment or application errors | Pending final demo |
| Alerts | Whether alerts are configured or visible | Pending final demo |
| Resource usage | CPU/memory usage during testing | Pending final demo |

Monitoring should be checked after the website/service smoke test so that the team can confirm the deployed application generated visible activity.

---

## 14. Azure SQL Check

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

During final demo, confirm whether the deployed application is reading from Azure SQL or using local/static data, depending on the latest application configuration.

---

## 15. Issue Found During Rehearsal

### Issue

The currently deployed AKS image returns API/health JSON instead of the full customer-facing e-commerce website.

### Evidence

| Test | Result |
|---|---|
| `http://20.184.58.23/` | `200 OK`, API JSON response |
| `http://20.184.58.23/health` | `200 OK` |
| `http://20.184.58.23/products` | `404 NOT FOUND` |
| `http://20.184.58.23/home` | `404 NOT FOUND` |

### Impact

The infrastructure is working, but the final customer-facing shop flow cannot be fully demonstrated from the current AKS deployment.

### Suggested Follow-Up

The team should confirm whether the correct Flask e-commerce image has been built and deployed to AKS.

The current deployment image is:

    capstonereg047af007.azurecr.io/ecommerce-app:v21

If this image is not the final shop version, rebuild and redeploy the correct image before the final presentation.

---

## 16. Rollback / Recovery Notes

If the website fails during the final demo, follow this order:

1. Confirm AKS is running.
2. Confirm the external IP using `kubectl get svc`.
3. Try opening the service in a browser.
4. Run the Ansible health check.
5. Check Azure monitoring/logs.
6. Confirm the latest image exists in ACR.
7. Confirm whether AKS is using the correct image tag.
8. Redeploy using the release workflow if needed.
9. Fall back to explaining the documented architecture and screenshots if Azure is temporarily unavailable.

---

## 17. Cost-Control and Cleanup Rules

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

## 18. Stop AKS After Testing

If no team member needs the service running, stop AKS to reduce Azure cost:

    az aks stop \
      --resource-group rg-capstone \
      --name capstone-aks

Confirm it stopped:

    az aks show \
      --resource-group rg-capstone \
      --name capstone-aks \
      --query "{name:name, powerState:powerState.code, provisioningState:provisioningState}" \
      --output table

Actual result after rehearsal:

    PowerState    Stopped
    ProvisioningState    Succeeded

Important note: when AKS is stopped, the public service may not be reachable. This is expected.

---

## 19. Post-Presentation Cleanup Checklist

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

## 20. Final Rehearsal Sign-Off

| Item | Status | Notes |
|---|---|---|
| AKS started for rehearsal | Completed | Started temporarily for P11 check |
| AKS service reachable | Completed | LoadBalancer reachable at `20.184.58.23` |
| API/health endpoint loads | Completed | `/` and `/health` return `200 OK` |
| Homepage tested | Blocked | Current image returns API JSON, not shop homepage |
| Product flow tested | Blocked | `/products` returns `404 NOT FOUND` |
| Cart flow tested | Blocked | Shop routes not exposed in current deployment |
| Checkout flow tested | Blocked | Shop routes not exposed in current deployment |
| Success/failure pages tested | Blocked | Shop routes not exposed in current deployment |
| Ansible health check passed | Completed | `failed=0`, HTTP status `200` |
| Monitoring checked | Pending final demo |  |
| Cost-control/cleanup confirmed | Completed | Based on P10 |
| AKS stopped after testing | Completed | Stopped to control cost |
| Known issues documented | Completed | Current image/routing issue documented |
| Team handover completed | Pending |  |

---

## 21. Known Issues / Pending Items

| Item | Owner | Status |
|---|---|---|
| P10 cost-control and cleanup checklist | Faith | Completed |
| Final release rehearsal infrastructure check | Khairul Rizal | Completed |
| Full customer-facing shop flow from AKS | Team | Blocked / needs correct image or routes |
| Final monitoring check | Team | Pending final demo |
| Final team sign-off | Team | Pending |
| Confirm deletion of `sql-capstone-CSD07-grp2` after demo | Team | Pending |

---

## 22. Final Notes

This runbook is designed to help the team avoid confusion during the final presentation.

The P11 rehearsal successfully proved that the AKS LoadBalancer and health endpoint are reachable. It also identified an important issue before the final demo: the currently deployed AKS image does not expose the full customer-facing e-commerce website routes.

The team should resolve or explain this before final presentation day.

Prepared by: Khairul Rizal  
Status: Updated after P10 and rehearsal check — issue documented
