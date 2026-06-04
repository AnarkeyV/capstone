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
If healthy, increase canary replicas or update production image
        │
        ▼
If unhealthy, remove canary deployment
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

Test the health endpoint through the service public IP:

```bash
curl -i http://<external-ip>/health
```

Expected result:

```text
HTTP/1.1 200 OK
```

---

## 8. Rollback

If the canary version has problems, remove the canary deployment:

```bash
kubectl delete deployment capstone-app-canary -n staging
```

The stable deployment can continue running.

---

## 9. Production-Ready Future Improvement

For real production canary deployment, the team should add:

| Improvement | Purpose |
|---|---|
| Ingress Controller | Allows traffic routing rules |
| Weighted traffic split | Sends specific percentages to canary |
| Monitoring dashboard | Tracks errors and latency |
| Automated rollback | Rolls back if canary fails |
| Argo Rollouts | Manages progressive delivery |

---

## 10. Presentation Explanation

Use this explanation:

```text
We added a canary deployment structure to show how a future production release could safely test a new app version alongside the stable version. The basic Kubernetes service can route traffic to both versions, while exact percentage-based canary routing would require a future ingress controller or rollout tool such as Argo Rollouts.
```

---

## 11. Final Recommendation

For The Shirt Bar, canary deployment should be implemented after staging and monitoring are stable.

Recommended order:

```text
Staging environment
        ▼
Monitoring dashboard
        ▼
Canary deployment structure
        ▼
Ingress-based traffic splitting
        ▼
Automated rollback
```
