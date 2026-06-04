# Final Project Verification Checklist

This checklist is used to verify that The Shirt Bar capstone project is ready for team review, demonstration, and final presentation.

---

## 1. GitHub Repository Check

Confirm that the latest work is committed and pushed to `main`.

```bash
git status
```

Expected result:

```text
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```

Check recent commits:

```bash
git log --oneline -5
```

Confirm the latest commits include the README update, automated tests, and release rehearsal work.

---

## 2. README Check

Open the GitHub repository homepage and confirm the README displays correctly.

Check that the README includes:

- Project overview
- Screenshots
- AKS deployment evidence
- Automated testing section
- GitHub Actions CI/CD section
- AKS cost-control note
- Team handover notes

Screenshot files should be visible from:

```text
documentation/screenshots/
```

Expected screenshot files:

```text
aks-homepage-v23.png
aks-product-detail-v23.png
aks-cart-v23.png
```

---

## 3. Automated Test Check

Run local tests:

```bash
python -m pytest
```

Expected result:

```text
4 passed
```

Current route tests verify:

| Route | Purpose |
|---|---|
| `/health` | Kubernetes health check |
| `/` | Homepage |
| `/product/TSHIRT-001` | Product detail page |
| `/cart` | Cart page |

---

## 4. Docker Local Build Check

Build the Docker image locally:

```bash
docker build -t shirtbar-shop-test:latest -f app/Dockerfile .
```

Run the container:

```bash
docker run --rm -p 5002:8000 shirtbar-shop-test:latest
```

In another terminal, test:

```bash
curl -i http://localhost:5002/
curl -i http://localhost:5002/health
curl -i http://localhost:5002/product/TSHIRT-001
curl -i http://localhost:5002/cart
```

Expected result:

```text
HTTP/1.1 200 OK
```

Stop the container with:

```text
Ctrl + C
```

---

## 5. GitHub Actions Check

Open:

```text
GitHub → Actions → CI/CD Release Pipeline
```

A fully green pipeline requires AKS to be running.

If AKS is stopped for cost control, this result is acceptable:

| Stage | Expected Result When AKS Is Stopped |
|---|---|
| Install Dependencies & Run Tests | Pass |
| Build and Push Docker Image | Pass |
| Set AKS Context | May pass |
| Deploy to Kubernetes Cluster | May fail |

Reason:

```text
AKS is stopped, so GitHub Actions cannot reach the Kubernetes API server.
```

This does not mean the code, tests, Docker build, or ACR push is broken.

---

## 6. AKS State Check

Check whether AKS is running or stopped:

```bash
az aks show --resource-group rg-capstone --name capstone-aks --query "powerState.code" -o tsv
```

Expected value when not testing:

```text
Stopped
```

Start AKS before demo or deployment:

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

Stop AKS after demo or testing:

```bash
az aks stop --resource-group rg-capstone --name capstone-aks
```

---

## 7. AKS Deployment Check

When AKS is running, connect to the cluster:

```bash
az aks get-credentials --resource-group rg-capstone --name capstone-aks --overwrite-existing
```

Check deployment:

```bash
kubectl get deployments
```

Expected:

```text
capstone-app   1/1
```

Check pods:

```bash
kubectl get pods
```

Expected:

```text
READY   STATUS
1/1     Running
```

Check service:

```bash
kubectl get svc
```

Expected public IP:

```text
20.184.58.23
```

Check deployed image:

```bash
kubectl describe deployment capstone-app | grep Image
```

Expected image should be the latest deployed version from the pipeline or the known working image:

```text
capstonereg047af007.azurecr.io/ecommerce-app:v23
```

---

## 8. Public Website Check

When AKS is running, test:

```bash
curl -i http://20.184.58.23/
curl -i http://20.184.58.23/health
curl -i http://20.184.58.23/product/TSHIRT-001
curl -i http://20.184.58.23/cart
```

Expected result:

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

## 9. Azure Container Registry Check

List image tags:

```bash
az acr repository show-tags \
  --name capstonereg047af007 \
  --repository ecommerce-app \
  --output table
```

Confirm that recent image versions exist.

Known successful image:

```text
v23
```

---

## 10. Demo Readiness Checklist

Before final presentation:

- [ ] README displays properly on GitHub
- [ ] Screenshots display properly in README
- [ ] `python -m pytest` passes
- [ ] AKS is started before live demo
- [ ] Pod is `1/1 Running`
- [ ] Public homepage returns `200 OK`
- [ ] `/health` returns `{"status":"ok"}`
- [ ] Product detail page returns `200 OK`
- [ ] Cart page returns `200 OK`
- [ ] AKS is stopped after demo

---

## 11. Team Explanation

Use this explanation if the GitHub Actions deployment stage fails while AKS is stopped:

```text
The CI stages are working correctly. Tests passed and the Docker image was built and pushed successfully. The deployment stage failed only because AKS was intentionally stopped for Azure cost control. To complete a full deployment run, start AKS first and re-run the workflow.
```

---

## 12. Final Status Summary

The project is considered ready when:

- Code is merged into `main`
- README is updated and displays screenshots
- Automated tests pass
- Docker image builds successfully
- AKS deployment has been tested successfully
- Release rehearsal has been documented
- AKS is stopped when not in use
