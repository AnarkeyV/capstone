# Kubernetes Staged Environments

This folder introduces a staged deployment structure for The Shirt Bar capstone project.

The goal is to separate development, staging, and production deployments so changes can be tested safely before they affect the customer-facing version.

---

## Folder Structure

```text
kubernetes/environments/
├── dev/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── README.md
├── staging/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── README.md
└── production/
    ├── namespace.yaml
    ├── deployment.yaml
    ├── service.yaml
    └── README.md
```

---

## Environment Purpose

| Environment | Purpose | Service Type | Replicas |
|---|---|---|---|
| `dev` | Internal testing and experiments | `ClusterIP` | 1 |
| `staging` | Pre-production validation | `LoadBalancer` | 1 |
| `production` | Customer-facing deployment | `LoadBalancer` | 2 |

---

## Why This Improves the Project

The current deployment uses one shared Kubernetes deployment.

This staged environment structure improves the project because it allows:

- Safer testing before production
- Clear separation between dev, staging, and production
- Better release control
- Easier troubleshooting
- Future GitHub Actions environment-based deployment
- A foundation for canary and blue-green releases

---

## Important Safety Note

These manifests are added as a staged environment structure. Do not apply them to AKS until the team confirms:

- AKS is running
- Required secrets exist in each namespace
- The selected image tag is correct
- The team understands possible Azure cost impact
- The current working deployment is backed up or documented

---

## Required Secrets Per Namespace

Each namespace requires:

```text
acr-secret
app-secrets
```

Example check:

```bash
kubectl get secrets -n staging
```

---

## Example Apply Flow

Apply dev:

```bash
kubectl apply -f kubernetes/environments/dev/namespace.yaml
kubectl apply -f kubernetes/environments/dev/deployment.yaml
kubectl apply -f kubernetes/environments/dev/service.yaml
```

Apply staging:

```bash
kubectl apply -f kubernetes/environments/staging/namespace.yaml
kubectl apply -f kubernetes/environments/staging/deployment.yaml
kubectl apply -f kubernetes/environments/staging/service.yaml
```

Apply production:

```bash
kubectl apply -f kubernetes/environments/production/namespace.yaml
kubectl apply -f kubernetes/environments/production/deployment.yaml
kubectl apply -f kubernetes/environments/production/service.yaml
```

---

## Check Environment Resources

```bash
kubectl get all -n dev
kubectl get all -n staging
kubectl get all -n production
```

---

## Recommended Future GitHub Actions Flow

A future workflow can use:

```text
Pull request → run tests only
develop branch → deploy to dev
staging branch → deploy to staging
main branch → deploy to production
```

This gives the team a professional release flow without immediately risking the production app.
