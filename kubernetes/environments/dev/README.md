# Dev Kubernetes Environment

This folder contains Kubernetes manifests for the **dev** environment of The Shirt Bar capstone project.

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
| `namespace.yaml` | Creates the `dev` namespace |
| `deployment.yaml` | Deploys the Flask e-commerce app into `dev` |
| `service.yaml` | Exposes the app inside or outside the cluster |

---

## Environment Settings

| Setting | Value |
|---|---|
| Namespace | `dev` |
| Replicas | `1` |
| Service Type | `ClusterIP` |
| Health Check | `/health` |
| Container Port | `8000` |

---

## Apply Commands

Apply namespace first:

```bash
kubectl apply -f kubernetes/environments/dev/namespace.yaml
```

Then apply deployment and service:

```bash
kubectl apply -f kubernetes/environments/dev/deployment.yaml
kubectl apply -f kubernetes/environments/dev/service.yaml
```

Check resources:

```bash
kubectl get all -n dev
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
