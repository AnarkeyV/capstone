# Production Kubernetes Environment

This folder contains Kubernetes manifests for the **production** environment of The Shirt Bar capstone project.

---

## Purpose

The purpose of this environment is to separate deployment stages so the team can test changes safely before affecting production.

---

## Files

```text
namespace.yaml
deployment.yaml
service.yaml
```

| File | Purpose |
|---|---|
| `namespace.yaml` | Creates the `production` namespace |
| `deployment.yaml` | Deploys the Flask e-commerce app into `production` |
| `service.yaml` | Exposes the app inside or outside the cluster |

---

## Environment Settings

| Setting | Value |
|---|---|
| Namespace | `production` |
| Replicas | `2` |
| Service Type | `LoadBalancer` |
| Health Check | `/health` |
| Container Port | `8000` |

---

## Apply Commands

Apply namespace first:

```bash
kubectl apply -f kubernetes/environments/production/namespace.yaml
```

Then apply deployment and service:

```bash
kubectl apply -f kubernetes/environments/production/deployment.yaml
kubectl apply -f kubernetes/environments/production/service.yaml
```

Check resources:

```bash
kubectl get all -n production
```

---

## Important Note

Before using this environment, the namespace must have the required Kubernetes secrets:

```text
acr-secret
app-secrets
```

These are needed because the deployment uses:

```yaml
imagePullSecrets:
- name: acr-secret

envFrom:
- secretRef:
    name: app-secrets
```

Do not apply this environment to production without confirming the secrets are available.
