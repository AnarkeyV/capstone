# Monitoring and Health Check Guide

This guide explains how The Shirt Bar capstone project can be monitored and verified after deployment.

It focuses on simple checks that the team can perform using the application health route, Kubernetes commands, GitHub Actions results, and browser or curl tests.

---

## 1. Purpose of Monitoring

Monitoring helps the team confirm that the application is running correctly after a deployment.

For this project, monitoring is used to check:

- Whether the Flask application is responding
- Whether the Kubernetes pod is running
- Whether the public AKS service is reachable
- Whether the GitHub Actions pipeline completed the test and build stages
- Whether the deployment is healthy before a demo or presentation

---

## 2. Application Health Route

The project includes a health-check endpoint:

```text
/health
```

When the application is healthy, it returns:

```json
{
  "status": "ok"
}
```

Local test:

```bash
curl -i http://localhost:5002/health
```

AKS public test:

```bash
curl -i http://20.184.58.23/health
```

Expected result:

```text
HTTP/1.1 200 OK
```

This route is useful because it provides a simple way to check whether the Flask application is alive without needing to load the full shop page.

---

## 3. Kubernetes Health Probes

The Kubernetes deployment uses health checks to help AKS understand whether the application container is working.

The health route can be used by:

- **Liveness probe** — checks whether the container should stay running
- **Readiness probe** — checks whether the container is ready to receive traffic

In simple terms:

| Probe | Purpose |
|---|---|
| Liveness probe | Restarts the container if the app becomes unhealthy |
| Readiness probe | Prevents traffic from being sent to the app until it is ready |

The health endpoint supports both checks because it is lightweight and returns a clear `200 OK` response.

---

## 4. Check AKS Power State

Before checking the live website, confirm whether AKS is running.

```bash
az aks show --resource-group rg-capstone --name capstone-aks --query "powerState.code" -o tsv
```

Expected value during demo or testing:

```text
Running
```

Expected value during cost-control periods:

```text
Stopped
```

If AKS is stopped, the public site may not load and the GitHub Actions deployment stage may fail. This is expected.

Start AKS before deployment or demo:

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

Stop AKS after testing:

```bash
az aks stop --resource-group rg-capstone --name capstone-aks
```

---

## 5. Connect to AKS

When AKS is running, connect your local terminal to the cluster:

```bash
az aks get-credentials --resource-group rg-capstone --name capstone-aks --overwrite-existing
```

This allows `kubectl` commands to communicate with the AKS cluster.

---

## 6. Check Kubernetes Deployment

Check whether the deployment is available:

```bash
kubectl get deployments
```

Expected result:

```text
capstone-app   1/1
```

This means the deployment has one desired pod and one available pod.

---

## 7. Check Kubernetes Pods

Check running pods:

```bash
kubectl get pods
```

Expected healthy result:

```text
READY   STATUS
1/1     Running
```

Common unhealthy statuses:

| Status | Meaning |
|---|---|
| `ImagePullBackOff` | AKS cannot pull the Docker image |
| `CrashLoopBackOff` | The app starts but keeps crashing |
| `Pending` | Kubernetes cannot schedule the pod yet |
| `0/1 Running` | Pod is running but the container is not ready |

---

## 8. Check Kubernetes Service

Check the public LoadBalancer service:

```bash
kubectl get svc
```

Expected service:

```text
capstone-service
```

Expected public IP:

```text
20.184.58.23
```

If the external IP is missing or pending, the public website may not be reachable yet.

---

## 9. Check Deployed Image

Check which Docker image AKS is currently using:

```bash
kubectl describe deployment capstone-app | grep Image
```

Known successful image:

```text
capstonereg047af007.azurecr.io/ecommerce-app:v23
```

Pipeline deployments may use newer image tags such as `v24`, `v25`, or later depending on the GitHub Actions run number.

---

## 10. Public Website Checks

When AKS is running, test the main public routes:

```bash
curl -i http://20.184.58.23/
curl -i http://20.184.58.23/health
curl -i http://20.184.58.23/product/TSHIRT-001
curl -i http://20.184.58.23/cart
```

Expected result for each route:

```text
HTTP/1.1 200 OK
```

Browser checks:

| Page | URL |
|---|---|
| Homepage | `http://20.184.58.23/` |
| Health Check | `http://20.184.58.23/health` |
| Product Detail | `http://20.184.58.23/product/TSHIRT-001` |
| Cart | `http://20.184.58.23/cart` |

---

## 11. GitHub Actions Monitoring

Open the workflow page:

```text
GitHub → Actions → CI/CD Release Pipeline
```

Check these stages:

| Stage | What It Confirms |
|---|---|
| Install Dependencies & Run Tests | Python dependencies installed and pytest passed |
| Build and Push Docker Image | Docker image built and pushed to ACR |
| Set AKS Context | GitHub Actions could load the kubeconfig |
| Deploy to Kubernetes Cluster | Kubernetes deployment was applied successfully |

If AKS is stopped, the first two stages may pass while the deployment stage fails. This is expected during cost-control periods.

---

## 12. Test Monitoring Evidence

The project now includes automated pytest checks.

Run locally:

```bash
python -m pytest
```

Expected current result:

```text
12 passed
```

These tests verify:

- Health route
- Homepage
- Product detail page
- Cart page
- Cart add validation
- Cart add success redirect
- Cart update
- Cart remove
- Checkout empty-cart redirect
- Checkout page with items
- Success page cart clearing
- Failed payment page

This supports the monitoring story because tests confirm that critical routes work before the app is built and deployed.

---

## 13. Troubleshooting: Site Does Not Load

Use this checklist when the public site is not reachable.

### Step 1 — Check AKS state

```bash
az aks show --resource-group rg-capstone --name capstone-aks --query "powerState.code" -o tsv
```

If the result is:

```text
Stopped
```

Start AKS:

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

### Step 2 — Check pods

```bash
kubectl get pods
```

If pod status is not `Running`, describe the pod:

```bash
kubectl describe pod <pod-name>
```

### Step 3 — Check deployment image

```bash
kubectl describe deployment capstone-app | grep Image
```

Confirm the image points to Azure Container Registry.

### Step 4 — Check service

```bash
kubectl get svc
```

Confirm the external IP is available.

### Step 5 — Test health route

```bash
curl -i http://20.184.58.23/health
```

---

## 14. Troubleshooting: GitHub Actions Deploy Fails

If GitHub Actions deployment fails, check whether AKS was running.

If AKS was stopped, use this explanation:

```text
The CI stages are working correctly. Tests passed and the Docker image was built and pushed successfully. The deployment stage failed only because AKS was intentionally stopped for Azure cost control. To complete a full deployment run, start AKS first and re-run the workflow.
```

If AKS was running and deployment still failed, check:

- GitHub Secrets
- AKS kubeconfig
- Docker image tag
- Kubernetes deployment YAML
- Pod events using `kubectl describe pod`

---

## 15. Demo Monitoring Checklist

Before a final demo:

- [ ] Start AKS
- [ ] Confirm AKS state is `Running`
- [ ] Run `kubectl get pods`
- [ ] Confirm pod is `1/1 Running`
- [ ] Run `kubectl get svc`
- [ ] Confirm public IP is available
- [ ] Test `/health`
- [ ] Test homepage
- [ ] Test product detail page
- [ ] Test cart page
- [ ] Stop AKS after demo

---

## 16. Summary

This project uses a practical monitoring approach:

- Application-level monitoring through `/health`
- Kubernetes-level monitoring through `kubectl`
- Pipeline-level monitoring through GitHub Actions
- Manual verification through browser and curl tests
- Cost-control awareness through AKS stop/start checks

This gives the team enough visibility to explain whether the application is healthy, whether a deployment worked, and why a deployment may fail when AKS is intentionally stopped.
