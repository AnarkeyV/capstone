# Kubernetes Canary Deployment Strategy

This folder contains a safe canary deployment example for The Shirt Bar capstone project.

The goal is to show how a future production release can test a new application version with limited traffic before replacing the stable version.

---

## 1. What Is Canary Deployment?

A canary deployment runs two versions of an application at the same time:

| Version | Purpose |
|---|---|
| Stable | Current known-good version |
| Canary | New version being tested |

The idea is to send a small amount of traffic to the canary version first. If it works well, the team can gradually increase traffic to it.

---

## 2. Important Capstone Note

The basic Kubernetes `Service` in this folder can route traffic to both stable and canary pods, but it does **not** guarantee an exact percentage split such as 90/10.

For accurate traffic splitting, a production setup normally needs one of these:

- NGINX Ingress Controller
- Azure Application Gateway Ingress Controller
- Service mesh such as Istio or Linkerd
- Argo Rollouts

This folder is therefore a safe first step that demonstrates the canary deployment structure without changing the current working deployment.

---

## 3. Files

```text
kubernetes/canary/
├── README.md
├── stable-deployment.yaml
├── canary-deployment.yaml
└── service.yaml
```

| File | Purpose |
|---|---|
| `stable-deployment.yaml` | Runs the known working app version |
| `canary-deployment.yaml` | Runs the new test app version |
| `service.yaml` | Routes traffic to pods with `app: capstone-canary-demo` |

---

## 4. How This Canary Example Works

Both deployments use the same shared service label:

```yaml
app: capstone-canary-demo
```

They are separated using a version label:

```yaml
version: stable
version: canary
```

The service selects:

```yaml
app: capstone-canary-demo
```

This means the service can send traffic to both stable and canary pods.

---

## 5. Example Flow

```text
Deploy stable version
        │
        ▼
Deploy canary version with fewer replicas
        │
        ▼
Test /health, homepage, product, and cart routes
        │
        ▼
If healthy, promote canary image to stable deployment
        │
        ▼
If unhealthy, remove canary deployment and keep stable running
```

---

## 6. Apply Commands

Only run these commands when AKS is running and the team agrees to test the canary example.

Create or use a namespace first, for example staging:

```bash
kubectl apply -f kubernetes/environments/staging/namespace.yaml
```

Apply stable version:

```bash
kubectl apply -f kubernetes/canary/stable-deployment.yaml
```

Apply canary version:

```bash
kubectl apply -f kubernetes/canary/canary-deployment.yaml
```

Apply service:

```bash
kubectl apply -f kubernetes/canary/service.yaml
```

Check resources:

```bash
kubectl get deployments -n staging
kubectl get pods -n staging
kubectl get svc -n staging
```

---

## 7. Health Checks

Because the staging service is currently using `ClusterIP`, the safest testing method is port-forwarding.

Start port-forwarding from the project root or any terminal connected to AKS:

```bash
kubectl port-forward -n staging service/capstone-canary-service 8080:80
```

Then test the routes locally:

```bash
curl -i http://localhost:8080/health
curl -i http://localhost:8080/
curl -i http://localhost:8080/product/TSHIRT-001
curl -i http://localhost:8080/cart
```

Expected result:

```text
HTTP/1.1 200 OK
```

> Note: `ClusterIP` is being used because the Azure subscription has reached the public IP limit in Southeast Asia. Port-forwarding allows the team to test the AKS service without needing a new public LoadBalancer IP.

---

## 8. Rollback

If the canary version has problems, remove the canary deployment:

```bash
kubectl delete deployment capstone-app-canary -n staging
```

The stable deployment can continue running.

---

## 9. Automated Canary Promotion and Rollback Scripts

This project now includes helper scripts for testing, promoting, and rolling back the canary deployment.

The scripts are located in:

```text
scripts/
├── canary_promote_or_rollback.sh
└── canary_rollback.sh
```

### 9.1 Canary promotion script

Run this from the project root:

```bash
./scripts/canary_promote_or_rollback.sh
```

This script performs the following steps:

1. Checks that the `staging` namespace exists.
2. Applies the stable deployment.
3. Applies the canary deployment.
4. Applies the canary service.
5. Waits for both stable and canary rollouts to complete.
6. Starts a local port-forward to the `ClusterIP` service.
7. Tests the following routes:
   - `/health`
   - `/`
   - `/product/TSHIRT-001`
   - `/cart`
8. If all checks pass, the canary image is promoted to the stable deployment.
9. The canary deployment is removed after successful promotion.

### 9.2 Manual rollback script

If the canary deployment has problems, run:

```bash
./scripts/canary_rollback.sh
```

This removes the canary deployment while leaving the stable deployment active.

### 9.3 Tested result

The automation was tested successfully against the staging AKS environment.

The script confirmed:

- Stable deployment rolled out successfully.
- Canary deployment rolled out successfully.
- `ClusterIP` service was tested through port-forwarding.
- `/health`, homepage, product detail, and cart routes passed.
- Canary image `capstonetfacr047af007.azurecr.io/ecommerce-app:v24` was promoted to the stable deployment.
- Canary deployment was removed after promotion.
- Stable deployment remained healthy with `2/2` replicas.

### 9.4 Important note

This is script-based automation for the capstone staging environment.

It does not provide advanced percentage-based production traffic splitting. For that, the project would need a tool such as an ingress controller, service mesh, or Argo Rollouts.

---

## 10. Production-Ready Future Improvement

For real production canary deployment, the team should add:

| Improvement | Purpose |
|---|---|
| Ingress Controller | Allows traffic routing rules |
| Weighted traffic split | Sends specific percentages to canary |
| Monitoring dashboard | Tracks errors and latency |
| Automated alerting | Notifies the team if errors increase |
| Argo Rollouts | Manages progressive delivery and automated promotion/rollback |

> The capstone project now includes a working script-based promotion and rollback approach. A future production version can improve this further by using weighted traffic routing and automated metric-based decisions.

---

## 11. Presentation Explanation

Use this explanation:

```text
We added a canary deployment structure to show how a future production release could safely test a new app version alongside the stable version. The basic Kubernetes service can route traffic to both versions, while exact percentage-based canary routing would require a future ingress controller or rollout tool such as Argo Rollouts.

For this capstone, we also added a script-based automation step. The script deploys stable and canary versions, checks the rollout status, tests the main app routes through port-forwarding, promotes the canary image to stable if the checks pass, and removes the canary deployment after successful promotion.
```

---

## 12. Final Recommendation

For The Shirt Bar, canary deployment should be implemented after staging and monitoring are stable.

Recommended order:

```text
Staging environment
        ▼
Monitoring dashboard
        ▼
Canary deployment structure
        ▼
Script-based promotion and rollback
        ▼
Ingress-based traffic splitting
        ▼
Metric-based automated rollback
```

The current project has completed the safe staging-level canary structure and script-based promotion workflow. The next production-level improvement would be more advanced traffic splitting using ingress, service mesh, or Argo Rollouts.
