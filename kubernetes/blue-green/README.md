# Kubernetes Blue-Green Deployment Strategy

This folder contains a blue-green deployment example for The Shirt Bar capstone project.

The goal is to compare blue-green deployment with the canary deployment strategy already included in the project.

---

## 1. What Is Blue-Green Deployment?

Blue-green deployment runs two complete versions of the application environment at the same time:

| Environment | Purpose |
|---|---|
| Blue | Current active version receiving traffic |
| Green | New version prepared and tested before switching traffic |

Instead of slowly sharing traffic between the old and new versions, blue-green deployment switches traffic from one full environment to another.

This makes rollback simple because the previous environment can remain available while the new environment is being tested.

---

## 2. How This Example Works

This example uses two Kubernetes deployments:

```text
capstone-app-blue
capstone-app-green
```

Both deployments use the same application label:

```yaml
app: capstone-blue-green-demo
```

They are separated by version labels:

```yaml
version: blue
version: green
```

The Kubernetes service controls which version receives traffic.

Current service selector:

```yaml
selector:
  app: capstone-blue-green-demo
  version: blue
```

This means traffic is currently routed to the blue deployment.

To switch traffic to green, update the service selector to:

```yaml
selector:
  app: capstone-blue-green-demo
  version: green
```

---

## 3. Files

```text
kubernetes/blue-green/
├── README.md
├── deployment-blue.yaml
├── deployment-green.yaml
└── service.yaml
```

| File | Purpose |
|---|---|
| `deployment-blue.yaml` | Runs the current active version |
| `deployment-green.yaml` | Runs the new version being prepared |
| `service.yaml` | Routes traffic to either blue or green |

---

## 4. Blue-Green Flow

```text
Deploy blue environment
        │
        ▼
Route service traffic to blue
        │
        ▼
Deploy green environment
        │
        ▼
Test green before switching traffic
        │
        ▼
If green is healthy, switch service selector to green
        │
        ▼
If green has problems, switch service selector back to blue
```

---

## 5. Apply Commands

Only run these commands when AKS is running and the team agrees to test the blue-green example.

Apply the blue deployment:

```bash
kubectl apply -f kubernetes/blue-green/deployment-blue.yaml
```

Apply the green deployment:

```bash
kubectl apply -f kubernetes/blue-green/deployment-green.yaml
```

Apply the service:

```bash
kubectl apply -f kubernetes/blue-green/service.yaml
```

Check resources:

```bash
kubectl get deployments -n staging
kubectl get pods -n staging
kubectl get svc -n staging
```

Check rollout status:

```bash
kubectl rollout status deployment/capstone-app-blue -n staging
kubectl rollout status deployment/capstone-app-green -n staging
```

---

## 6. Test the Active Environment

Because the service is using `ClusterIP`, use port-forwarding:

```bash
kubectl port-forward -n staging service/capstone-blue-green-service 8081:80
```

Then open another terminal and test the routes:

```bash
curl -i http://localhost:8081/health
curl -i http://localhost:8081/
curl -i http://localhost:8081/product/TSHIRT-001
curl -i http://localhost:8081/cart
```

Expected result:

```text
HTTP/1.1 200 OK
```

> Note: `ClusterIP` is being used because the Azure subscription has reached the public IP limit in Southeast Asia. Port-forwarding allows the team to test the AKS service without needing a new public LoadBalancer IP.

---

## 7. Switch Traffic from Blue to Green

Open the blue-green service file:

```bash
nano kubernetes/blue-green/service.yaml
```

Change the selector from:

```yaml
selector:
  app: capstone-blue-green-demo
  version: blue
```

to:

```yaml
selector:
  app: capstone-blue-green-demo
  version: green
```

Apply the service again:

```bash
kubectl apply -f kubernetes/blue-green/service.yaml
```

The service now routes traffic to the green deployment.

Confirm the service:

```bash
kubectl describe service capstone-blue-green-service -n staging
```

Test again through port-forwarding:

```bash
kubectl port-forward -n staging service/capstone-blue-green-service 8081:80
```

In another terminal:

```bash
curl -i http://localhost:8081/health
curl -i http://localhost:8081/
curl -i http://localhost:8081/product/TSHIRT-001
curl -i http://localhost:8081/cart
```

---

## 8. Rollback from Green to Blue

If the green deployment has problems, rollback is simple.

Open the service file:

```bash
nano kubernetes/blue-green/service.yaml
```

Change the selector from:

```yaml
selector:
  app: capstone-blue-green-demo
  version: green
```

back to:

```yaml
selector:
  app: capstone-blue-green-demo
  version: blue
```

Apply the service:

```bash
kubectl apply -f kubernetes/blue-green/service.yaml
```

Traffic returns to the blue deployment.

---

## 9. Validate YAML Before Applying

Before applying the files to AKS, validate them locally with a client-side dry run:

```bash
kubectl apply --dry-run=client -f kubernetes/blue-green/deployment-blue.yaml
kubectl apply --dry-run=client -f kubernetes/blue-green/deployment-green.yaml
kubectl apply --dry-run=client -f kubernetes/blue-green/service.yaml
```

If the files are valid, Kubernetes should return output similar to:

```text
deployment.apps/capstone-app-blue configured (dry run)
deployment.apps/capstone-app-green configured (dry run)
service/capstone-blue-green-service configured (dry run)
```

---

## 10. Cleanup

After testing, remove the blue-green resources if the team does not need them running:

```bash
kubectl delete -f kubernetes/blue-green/service.yaml
kubectl delete -f kubernetes/blue-green/deployment-green.yaml
kubectl delete -f kubernetes/blue-green/deployment-blue.yaml
```

Confirm cleanup:

```bash
kubectl get deployments -n staging
kubectl get svc -n staging
```

---

## 11. Canary vs Blue-Green

| Strategy | How It Works | Best For |
|---|---|---|
| Canary | Releases a new version gradually beside the stable version | Lower-risk gradual testing |
| Blue-Green | Runs two full environments and switches traffic between them | Fast rollback and clear environment separation |

### Canary deployment

Canary is useful when the team wants to test a new version slowly.

In this project, the canary example runs a stable version and a canary version at the same time. The script-based canary workflow checks the app routes and promotes the canary image to stable if the checks pass.

### Blue-green deployment

Blue-green is useful when the team wants a clearer switch between two complete versions.

In this project, the service selector decides whether traffic goes to blue or green. If green works, the service is switched to green. If green fails, the service is switched back to blue.

---

## 12. Capstone Note

This is a safe staging-level example.

It demonstrates the blue-green deployment concept using Kubernetes deployments and a `ClusterIP` service.

For production, blue-green deployment would normally be combined with:

- Ingress controller
- Custom domain
- HTTPS
- Monitoring alerts
- Automated smoke tests
- Database migration strategy
- Clear rollback approval process

---

## 13. Presentation Explanation

Use this explanation:

```text
We added blue-green deployment as a comparison to canary deployment. In canary deployment, a small test version runs beside the stable version before promotion. In blue-green deployment, two complete versions run separately. The Kubernetes service decides whether users go to blue or green. If green works, we switch traffic to green. If it fails, we switch back to blue quickly.
```

---

## 14. Final Recommendation

For The Shirt Bar, blue-green deployment is useful when the team wants a fast and clear rollback path.

Recommended order:

```text
Staging environment
        ▼
Monitoring dashboard
        ▼
Canary deployment structure
        ▼
Script-based canary promotion and rollback
        ▼
Blue-green deployment comparison
        ▼
Production ingress and automated traffic control
```

The current project uses blue-green deployment as a comparison strategy. Canary remains the better fit for gradual production releases, while blue-green is useful for demonstrating full-environment switching and fast rollback.
