# Deployment Strategy Future Plan

This document explains future deployment strategies that can make The Shirt Bar e-commerce platform safer and more production-ready.

The current capstone project already uses GitHub Actions, Docker, Azure Container Registry, and Azure Kubernetes Service. This future plan explains how the project can later support staged environments, blue-green deployments, and canary releases.

---

## 1. Purpose of This Future Improvement

The current deployment process pushes changes directly to the main AKS application after the CI/CD pipeline runs.

This is suitable for a capstone demonstration, but a production e-commerce business should reduce deployment risk by testing changes in safer stages before customers see them.

Future deployment strategy improvements can help the team:

- Test changes before production
- Reduce customer-facing downtime
- Roll back faster if something goes wrong
- Release new versions gradually
- Improve confidence in each deployment

---

## 2. Current Deployment Approach

Current simplified flow:

```text
Developer
   │
   ▼
GitHub main branch
   │
   ▼
GitHub Actions
   │
   ▼
Build Docker image
   │
   ▼
Push to Azure Container Registry
   │
   ▼
Deploy to AKS
   │
   ▼
Customer-facing application
```

This flow works, but it has one main limitation:

```text
Every successful deployment can affect the live application immediately.
```

---

## 3. Why a Safer Deployment Strategy Matters

For an e-commerce business like The Shirt Bar, the website may support product browsing, carts, checkout, and customer orders.

A bad deployment can cause:

- Product pages not loading
- Cart issues
- Checkout failures
- Lost sales
- Poor customer experience
- Extra troubleshooting pressure on the team

A safer deployment strategy reduces the chance that customers are affected by a faulty release.

---

## 4. Staged Environments

A staged environment approach separates the application into different deployment areas.

Recommended future environments:

| Environment | Purpose |
|---|---|
| Development | Used by developers for active changes |
| Staging | Used for final testing before production |
| Production | Used by real customers |

Future flow:

```text
Feature Branch
   │
   ▼
Pull Request
   │
   ▼
Automated Tests
   │
   ▼
Staging Deployment
   │
   ▼
Manual Review
   │
   ▼
Production Deployment
```

---

## 5. Development Environment

The development environment is used for testing new changes early.

Possible setup:

| Item | Example |
|---|---|
| Branch | `develop` |
| AKS namespace | `dev` |
| App URL | Internal or temporary URL |
| Database | Test database |

This environment does not need to be highly available because it is not customer-facing.

---

## 6. Staging Environment

The staging environment should look similar to production but should not serve real customers.

Possible setup:

| Item | Example |
|---|---|
| Branch | `staging` |
| AKS namespace | `staging` |
| App URL | `staging.theshirtbar.example.com` |
| Database | Staging database |
| Purpose | Final validation before production |

Staging can be used to verify:

- Homepage
- Product pages
- Cart flow
- Checkout test flow
- Health checks
- Kubernetes pod status
- GitHub Actions deployment result

---

## 7. Production Environment

Production is the customer-facing environment.

Possible setup:

| Item | Example |
|---|---|
| Branch | `main` |
| AKS namespace | `production` |
| App URL | `www.theshirtbar.example.com` |
| Database | Production database |
| Purpose | Real customer traffic |

Production deployments should happen only after testing has passed.

---

## 8. Namespace-Based AKS Strategy

One cost-conscious way to create staged environments is to use AKS namespaces.

Example namespaces:

```text
dev
staging
production
```

Check namespaces:

```bash
kubectl get namespaces
```

Create a namespace:

```bash
kubectl create namespace staging
```

Deploy into a namespace:

```bash
kubectl apply -f kubernetes/deployment.yaml -n staging
kubectl apply -f kubernetes/service.yaml -n staging
```

This approach allows multiple environments to exist in one AKS cluster.

---

## 9. Blue-Green Deployment Strategy

Blue-green deployment uses two production-like environments.

| Environment | Role |
|---|---|
| Blue | Current live version |
| Green | New version being tested |

Flow:

```text
Customers use Blue
        │
Deploy new version to Green
        │
Test Green
        │
Switch traffic from Blue to Green
        │
Green becomes live
```

If Green has issues, traffic can stay on Blue or switch back to Blue.

---

## 10. Blue-Green Benefits

| Benefit | Explanation |
|---|---|
| Lower downtime | New version is prepared before traffic switches |
| Safer rollback | Old version remains available |
| Cleaner testing | New version can be tested separately |
| Better demo control | Team can show old and new versions clearly |

Blue-green deployment is useful for important releases where downtime should be minimized.

---

## 11. Blue-Green AKS Example

A future AKS setup could use two deployments:

```text
capstone-app-blue
capstone-app-green
```

A Kubernetes Service can route traffic to one version by using labels.

Example idea:

```yaml
selector:
  app: capstone-app
  version: blue
```

To switch traffic, the service selector can be changed from:

```text
version: blue
```

to:

```text
version: green
```

This should be tested carefully in a staging environment before production use.

---

## 12. Canary Deployment Strategy

A canary deployment releases a new version to a small portion of users first.

Example:

```text
95% traffic → current version
5% traffic  → new version
```

If the new version works correctly, the traffic percentage can be increased gradually.

Example rollout:

```text
5% → 25% → 50% → 100%
```

---

## 13. Canary Benefits

| Benefit | Explanation |
|---|---|
| Lower risk | Only a small number of users see the new version first |
| Easier detection | Problems can be detected before full rollout |
| Gradual confidence | Traffic increases only if the new version is healthy |
| Better production testing | Real traffic validates the release |

Canary deployment is more advanced than the current capstone needs, but it is a strong future improvement for production.

---

## 14. Canary Requirements

A proper canary strategy may require:

- Ingress controller
- Traffic splitting rules
- Monitoring dashboards
- Error-rate tracking
- Rollback process
- Application version labels
- Strong automated tests

Examples of tools that can support this in the future:

| Tool | Purpose |
|---|---|
| NGINX Ingress Controller | Route traffic inside Kubernetes |
| Azure Application Gateway Ingress Controller | Azure-native ingress option |
| Azure Monitor | Monitor metrics and logs |
| Prometheus / Grafana | Advanced monitoring dashboards |
| Argo Rollouts | Advanced progressive delivery |

---

## 15. GitHub Actions Future Workflow

A future GitHub Actions workflow can be improved to support environments.

Example idea:

```text
Pull Request
   │
   ▼
Run tests only
   │
   ▼
Merge to staging
   │
   ▼
Deploy to staging
   │
   ▼
Manual approval
   │
   ▼
Deploy to production
```

This protects the production environment because every change must pass tests and staging checks first.

---

## 16. Manual Approval Gate

For production releases, GitHub Actions can use a manual approval step.

Purpose:

```text
Do not deploy to production until a team member approves the release.
```

This is useful for The Shirt Bar because the team can verify:

- Tests passed
- Docker image built successfully
- Staging deployment works
- Demo screenshots are captured
- AKS is running
- The timing is suitable for production release

---

## 17. Rollback Plan

Every deployment strategy should include rollback planning.

Simple rollback methods:

| Method | Example |
|---|---|
| Kubernetes rollout undo | `kubectl rollout undo deployment/capstone-app` |
| Redeploy known working image | Use image `v23` |
| Re-run older GitHub Actions workflow | Redeploy previous successful version |
| Blue-green switchback | Route traffic back to Blue |

Example rollback command:

```bash
kubectl rollout undo deployment/capstone-app
```

Check rollout status:

```bash
kubectl rollout status deployment/capstone-app
```

---

## 18. Recommended Future Roadmap

The safest order for future deployment improvements:

1. Add pull request testing without deployment.
2. Add staging namespace in AKS.
3. Deploy pull requests or staging branch to staging only.
4. Add manual approval before production deployment.
5. Add blue-green deployment for safer production releases.
6. Add canary deployment only after monitoring is strong.

---

## 19. What Should Not Be Done Too Early

The team should avoid adding too many advanced release strategies before the basics are stable.

Avoid implementing canary or blue-green immediately if:

- Tests are not stable
- Monitoring is not ready
- Team members are not comfortable with Kubernetes
- Rollback has not been practised
- AKS cost needs to stay low
- Final presentation is close

For the current capstone, documenting these future strategies is safer than making risky live infrastructure changes.

---

## 20. Demo Explanation

Use this explanation during presentation:

```text
Our current CI/CD pipeline builds, tests, pushes, and deploys the application to AKS. For a production version, we would improve the release process with staging, manual approvals, and safer rollout methods such as blue-green or canary deployments. This would reduce the risk of downtime and allow the team to test changes before customers are affected.
```

---

## 21. Final Recommendation

For The Shirt Bar, the recommended future deployment path is:

```text
Current CI/CD pipeline
        ▼
Pull request testing
        ▼
Staging deployment
        ▼
Manual approval
        ▼
Production deployment
        ▼
Blue-green deployment
        ▼
Canary deployment
```

This path is practical because it improves safety step by step without making the system too complex too early.
