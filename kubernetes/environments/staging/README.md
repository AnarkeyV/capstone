# Staging Kubernetes Environment

This folder contains Kubernetes manifests for the **staging** environment of The Shirt Bar capstone project.

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
| `namespace.yaml` | Creates the `staging` namespace |
| `deployment.yaml` | Deploys the Flask e-commerce app into `staging` |
| `service.yaml` | Exposes the app inside or outside the cluster |

---

## Environment Settings

| Setting | Value |
|---|---|
| Namespace | `staging` |
| Replicas | `1` |
| Service Type | `LoadBalancer` |
| Health Check | `/health` |
| Container Port | `8000` |

---

## Apply Commands

Apply namespace first:

```bash
kubectl apply -f kubernetes/environments/staging/namespace.yaml
```

Then apply deployment and service:

```bash
kubectl apply -f kubernetes/environments/staging/deployment.yaml
kubectl apply -f kubernetes/environments/staging/service.yaml
```

Check resources:

```bash
kubectl get all -n staging
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
