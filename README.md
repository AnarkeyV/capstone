[![CI/CD Pipeline](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml/badge.svg)](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml)
[![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/flask-ecommerce-green.svg)](https://flask.palletsprojects.com/)
[![Docker](https://img.shields.io/badge/docker-supported-blue.svg)](https://www.docker.com/)
[![Azure](https://img.shields.io/badge/Azure-AKS%20%7C%20ACR%20%7C%20SQL-0078D4.svg)](https://azure.microsoft.com/)
[![Terraform](https://img.shields.io/badge/terraform-remote%20state%20%7C%20staging-7B42BC.svg)](https://www.terraform.io/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-staging%20%7C%20canary%20%7C%20blue--green-326CE5.svg)](https://kubernetes.io/)
[![Status](https://img.shields.io/badge/project-final%20improvements%20validated-success.svg)](#current-project-status)

# 🛍️ The Shirt Bar — Cloud-Native E-Commerce Capstone Project

A cloud-native e-commerce platform for **The Shirt Bar**, a premium sustainable menswear brand based in Singapore.

This project demonstrates how a Flask-based online shop can be containerised with Docker, pushed to Azure Container Registry, deployed to Azure Kubernetes Service, prepared with Azure SQL Database support, automated through GitHub Actions, and extended with Terraform-managed staging infrastructure, monitoring assets, canary deployment automation, and blue-green deployment comparison.

---

## 📋 Table of Contents

- [Current Project Status](#current-project-status)
- [Live Deployment Evidence](#live-deployment-evidence)
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Azure Resources](#azure-resources)
- [Application Routes](#application-routes)
- [Local Development](#local-development)
- [Automated Testing](#automated-testing)
- [Docker Build and Local Test](#docker-build-and-local-test)
- [Docker Platform Note for AKS](#docker-platform-note-for-aks)
- [Terraform Staging Infrastructure](#terraform-staging-infrastructure)
- [Terraform Remote Backend](#terraform-remote-backend)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Canary Deployment Strategy](#canary-deployment-strategy)
- [Blue-Green Deployment Strategy](#blue-green-deployment-strategy)
- [Monitoring Dashboard Package](#monitoring-dashboard-package)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Azure SQL Databases](#azure-sql-databases)
- [Release Rehearsal Result](#release-rehearsal-result)
- [Cost Control](#cost-control)
- [Known Limitation: Azure Public IP Quota](#known-limitation-azure-public-ip-quota)
- [Project Structure](#project-structure)
- [DevOps and Cloud Skills Demonstrated](#devops-and-cloud-skills-demonstrated)
- [Future Improvements](#future-improvements)
- [Team Handover Notes](#team-handover-notes)

---

## ✅ Current Project Status

The project has completed the original release rehearsal and has now been extended with tested staging infrastructure, monitoring assets, expanded automated tests, Terraform remote backend storage, canary promotion automation, and blue-green deployment comparison.

| Area | Status |
|---|---|
| Flask e-commerce application | Completed |
| Docker container build | Completed |
| Azure Container Registry image push | Completed |
| AKS deployment | Completed |
| Release rehearsal | Passed |
| Terraform-managed staging infrastructure | Tested successfully |
| Terraform remote backend storage | Added and validated |
| Staging AKS deployment | Tested successfully |
| Product image loading in staging | Verified |
| Automated pytest coverage | Expanded to 26 passing tests |
| Canary deployment strategy | Tested successfully |
| Automated canary promotion and rollback scripts | Added and tested |
| Blue-green deployment strategy example | Added and tested |
| Monitoring dashboard package | Added |
| Current working branch | `infra-final-improvements` |
| Documentation status | Updated for final improvements |

---

## 🌐 Live Deployment Evidence

The full shop application was successfully deployed and tested on **Azure Kubernetes Service (AKS)**.

| Item | Value |
|---|---|
| **Previous AKS Image** | `capstonereg047af007.azurecr.io/ecommerce-app:v23` |
| **Latest Tested Staging Image** | `capstonetfacr047af007.azurecr.io/ecommerce-app:v24` |
| **AKS Service** | `capstone-service` |
| **Deployment** | `capstone-app` |
| **Previous Public Test IP** | `http://20.184.58.23` |
| **Current Staging Access Method** | `kubectl port-forward` |
| **Final Result** | Full shop and staging deployment verified successfully |

> **Cost and quota note:** AKS may be stopped outside testing/demo periods to reduce Azure cost. In the latest staging work, services were tested using `ClusterIP` and `kubectl port-forward` because the Azure subscription reached the public IP limit in Southeast Asia.

### ✅ Verified Routes

| Route | Result | Purpose |
|---|---:|---|
| `/` | `200 OK` | Shop homepage and product listing |
| `/health` | `200 OK` | Kubernetes health check |
| `/product/TSHIRT-001` | `200 OK` | Product detail page |
| `/cart` | `200 OK` | Shopping cart page |

---

## 📸 Screenshots

Screenshots were captured during the successful AKS deployment test.

### Homepage

![The Shirt Bar AKS Homepage](documentation/screenshots/aks-homepage-v23.png)

### Product Detail Page

![The Shirt Bar Product Detail Page](documentation/screenshots/aks-product-detail-v23.png)

### Cart Page

![The Shirt Bar Cart Page](documentation/screenshots/aks-cart-v23.png)

> These screenshots show that the deployed application was reachable through AKS and that the main shop pages loaded successfully.

---

## 📖 Project Overview

The Shirt Bar e-commerce application was built as a practical cloud deployment project.

The project focuses on:

- Building a Flask e-commerce web app
- Containerising the application using Docker
- Storing application images in Azure Container Registry
- Deploying to Azure Kubernetes Service
- Using Kubernetes health probes
- Preparing Azure SQL databases for product and order data
- Automating release deployment through GitHub Actions
- Creating Terraform-managed staging infrastructure
- Using Terraform remote backend storage for shared team state
- Testing Kubernetes staged environments
- Testing and automating a canary deployment strategy
- Adding a blue-green deployment strategy for comparison
- Adding monitoring dashboard documentation/assets
- Documenting release rehearsal and handover steps
- Applying cost-control practices by stopping AKS after testing

---

## ✨ Key Features

| Feature | Description |
|---|---|
| **Product Listing** | Homepage displays The Shirt Bar product collection |
| **Product Detail Page** | Individual product pages using SKU routes |
| **Shopping Cart** | Cart page and add-to-cart route structure |
| **Flask Blueprints** | Routes split into product, cart, and checkout modules |
| **Health Endpoint** | `/health` route supports Kubernetes probes |
| **Dockerised App** | Flask app packaged into a production container |
| **ACR Integration** | Docker images pushed to Azure Container Registry |
| **AKS Deployment** | App deployed through Kubernetes Deployment and Service YAML |
| **Terraform Staging** | Staging infrastructure managed through Terraform |
| **Terraform Remote Backend** | Shared Terraform state stored in Azure Storage |
| **Canary Deployment** | Safer deployment strategy tested using Kubernetes resources |
| **Canary Automation** | Script-based promotion and rollback workflow added |
| **Blue-Green Deployment** | Blue-green comparison strategy added and tested |
| **Monitoring Package** | Monitoring dashboard package added for operational visibility |
| **CI/CD Workflow** | GitHub Actions builds, tests, pushes, and deploys the app |
| **Release Runbook** | Handover and release rehearsal documented for team use |

---

## 🏗️ Architecture

```text
┌──────────────────┐
│ Local Developer  │
│ VS Code + Git    │
└────────┬─────────┘
         │ git push / pull request
         ▼
┌──────────────────┐
│ GitHub Repo      │
│ main branch      │
└────────┬─────────┘
         │ triggers
         ▼
┌──────────────────┐
│ GitHub Actions   │
│ CI/CD Pipeline   │
└────────┬─────────┘
         │ tests + docker build + push
         ▼
┌────────────────────────────┐
│ Azure Container Registry   │
│ ecommerce-app:vXX          │
└────────┬───────────────────┘
         │ image pull
         ▼
┌────────────────────────────┐
│ Azure Kubernetes Service   │
│ Deployment: capstone-app   │
│ Service: capstone-service  │
└────────┬───────────────────┘
         │ LoadBalancer or ClusterIP
         ▼
┌────────────────────────────┐
│ The Shirt Bar Web App      │
│ Flask + Jinja2 + CSS       │
└────────────────────────────┘
```

### Staging, canary, and blue-green extension

```text
┌────────────────────────────┐
│ Terraform                  │
│ Staging Infrastructure     │
└────────┬───────────────────┘
         │ uses remote backend
         ▼
┌────────────────────────────┐
│ Azure Storage              │
│ Terraform State Container  │
└────────────────────────────┘

┌────────────────────────────┐
│ AKS Staging Environment    │
│ Kubernetes Manifests       │
└────────┬───────────────────┘
         │ deploys
         ▼
┌────────────────────────────┐
│ Stable + Canary App        │
│ Blue + Green App Examples  │
└────────┬───────────────────┘
         │ ClusterIP + port-forward
         ▼
┌────────────────────────────┐
│ Local Browser / curl Tests │
│ http://localhost:8080      │
└────────────────────────────┘
```

---

## 🛠️ Tech Stack

| Area | Technology |
|---|---|
| Backend | Python, Flask |
| Frontend | HTML, CSS, Jinja2 Templates |
| Database | Azure SQL Database |
| Containerisation | Docker |
| Container Registry | Azure Container Registry |
| Orchestration | Azure Kubernetes Service |
| Infrastructure as Code | Terraform |
| Terraform State | Azure Storage remote backend |
| CI/CD | GitHub Actions |
| Deployment | Kubernetes YAML |
| Deployment Strategies | Canary, Blue-Green |
| Monitoring | Monitoring dashboard package, KQL query files |
| Cloud Platform | Microsoft Azure |
| Payment Integration | Stripe Test Mode |
| Documentation | Markdown, Runbooks, Playbooks |

---

## ☁️ Azure Resources

| Resource Type | Name |
|---|---|
| Original Resource Group | `rg-capstone` |
| Original AKS Cluster | `capstone-aks` |
| Original Azure Container Registry | `capstonereg047af007` |
| Original ACR Login Server | `capstonereg047af007.azurecr.io` |
| Terraform Staging Resource Group | `rg-capstone-tf-staging` |
| Terraform Staging AKS Cluster | `capstone-aks-tf-staging` |
| Terraform Staging ACR | `capstonetfacr047af007` |
| Terraform Staging ACR Login Server | `capstonetfacr047af007.azurecr.io` |
| Terraform State Resource Group | `rg-capstone-tfstate` |
| Terraform State Storage Account | `capstonetfstate047af007` |
| Terraform State Container | `tfstate` |
| Current Staging Service Type | `ClusterIP` |
| Product Database | `tsb-products-db` |
| Orders Database | `tsb-orders-db` |

> Resource names may differ if the team changes variable values in the Terraform files.

---

## 📡 Application Routes

| Route | Method | Description |
|---|---|---|
| `/` | `GET` | Main shop homepage and product listing |
| `/product/<sku>` | `GET` | Product detail page |
| `/cart` | `GET` | Shopping cart page |
| `/cart/add/<sku>` | `POST` | Add selected product to cart |
| `/cart/update/<cart_key>` | `POST` | Update item quantity |
| `/cart/remove/<cart_key>` | `POST` | Remove item from cart |
| `/checkout` | `GET` | Checkout page |
| `/checkout/create-session` | `POST` | Stripe checkout session route |
| `/success` | `GET` | Successful payment page |
| `/failed` | `GET` | Failed or cancelled payment page |
| `/health` | `GET` | Health endpoint for Kubernetes probes |

The `/health` route allows Kubernetes liveness and readiness probes to confirm that the Flask application is running correctly.

Example health response:

```json
{
  "status": "ok"
}
```

---

## 💻 Local Development

### Prerequisites

- Python 3.10+
- Git
- Docker Desktop
- Azure CLI
- kubectl
- Terraform

### 1. Clone the repository

```bash
git clone https://github.com/AnarkeyV/capstone.git
cd capstone
```

### 2. Create a virtual environment

```bash
python3 -m venv .venv
```

### 3. Activate the virtual environment

```bash
source .venv/bin/activate
```

### 4. Install dependencies

```bash
pip install -r app/requirements.txt
```

### 5. Run the Flask app locally

```bash
python app/app.py
```

Local Flask URL:

```text
http://localhost:5001
```

---

## ✅ Automated Testing

Automated tests were expanded using `pytest`.

The test files are located in:

```text
tests/
├── conftest.py
├── test_app_routes.py
├── test_cart_checkout_routes.py
├── test_cart_flow_extended.py
├── test_e2e_shop_flow.py
├── test_product_model.py
└── test_product_routes_extended.py
```

The current tests validate:

| Test Area | Coverage |
|---|---|
| Health route | `/health` returns `200 OK` and `{"status": "ok"}` |
| Homepage | Main shop page loads successfully |
| Product detail | Valid product page loads correctly |
| Invalid product | Invalid SKU returns `404` |
| Product model | Product lookup and required product fields |
| Cart | Add, update, remove, quantity and option behaviour |
| Shipping logic | Shipping below threshold and free shipping from $100 |
| Checkout | Checkout redirects when empty and loads with cart items |
| Success page | Cart clears after successful payment page |
| Failed page | Failed payment route loads correctly |
| End-to-end flow | Browse product, add to cart, view cart, and checkout |

Run tests locally:

```bash
python -m pytest -v
```

Expected output:

```text
26 passed
```

These tests are also executed inside the GitHub Actions pipeline before the Docker image is built and pushed.

---

## 🐳 Docker Build and Local Test

The Dockerfile is located at:

```text
app/Dockerfile
```

The Docker image must be built from the repository root because the Dockerfile copies files from the `app/` directory.

### Build the Docker image

```bash
docker build -t shirtbar-shop-test:latest -f app/Dockerfile .
```

### Run the container locally

```bash
docker run --rm -p 5002:8000 shirtbar-shop-test:latest
```

### Test the container

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

---

## 🧱 Docker Platform Note for AKS

When building from a Mac, the image may default to an ARM platform. AKS requires a Linux AMD64-compatible image.

The working command used for AKS was:

```bash
docker buildx build --platform linux/amd64 \
  -t capstonetfacr047af007.azurecr.io/ecommerce-app:v24 \
  -f app/Dockerfile . \
  --push
```

This avoids the `ImagePullBackOff` issue caused by a platform mismatch.

---

## 🏗️ Terraform Staging Infrastructure

Terraform was added to support managed staging infrastructure.

Terraform files are located in:

```text
terraform/
├── backend.tf
├── main.tf
├── outputs.tf
├── README.md
└── variables.tf
```

### What Terraform creates

| Resource | Purpose |
|---|---|
| Azure Resource Group | Holds the Terraform-managed staging resources |
| Azure Container Registry | Stores staging Docker images |
| Azure Kubernetes Service | Runs the staging app |
| Log Analytics Workspace | Stores AKS monitoring logs and metrics |
| AKS OMS Agent | Connects AKS to Log Analytics |
| Storage Account | Prepared for future product image storage |
| Blob Container | Prepared for product image assets |
| AcrPull Role Assignment | Allows AKS to pull images from ACR |

### Typical Terraform workflow

Go to the Terraform directory:

```bash
cd terraform
```

Then run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Only apply after reviewing the plan:

```bash
terraform apply
```

When prompted, type:

```text
yes
```

### Verified staging result

Terraform successfully created the staging infrastructure used for AKS testing.

A clean Terraform plan was later confirmed:

```text
No changes. Your infrastructure matches the configuration.
```

---

## 🔐 Terraform Remote Backend

Terraform remote backend storage was added for team-based state management.

This prevents each team member from using separate local `terraform.tfstate` files and allows Terraform state to be shared safely through Azure Storage.

Backend bootstrap files are located in:

```text
terraform-backend/
├── main.tf
└── .terraform.lock.hcl
```

Main Terraform backend configuration is located in:

```text
terraform/backend.tf
```

### Remote backend details

| Item | Value |
|---|---|
| Resource Group | `rg-capstone-tfstate` |
| Storage Account | `capstonetfstate047af007` |
| Container | `tfstate` |
| State Key | `staging.terraform.tfstate` |

### Backend workflow

The backend storage resources are created from:

```bash
cd terraform-backend
terraform init
terraform validate
terraform plan
terraform apply
```

The main Terraform state is then migrated from the `terraform/` folder:

```bash
cd ../terraform
terraform init -migrate-state
```

After migration, the main Terraform plan should be checked:

```bash
terraform validate
terraform plan
```

Expected result:

```text
No changes. Your infrastructure matches the configuration.
```

---

## ☸️ Kubernetes Deployment

Kubernetes files are located in:

```text
kubernetes/
├── deployment.yaml
├── service.yaml
├── canary/
├── blue-green/
└── environments/
```

Useful commands:

```bash
kubectl get deployments -n staging
kubectl get pods -n staging
kubectl get svc -n staging
kubectl describe deployment capstone-app -n staging
```

Check the deployed image:

```bash
kubectl describe deployment capstone-app -n staging | grep Image
```

Check services:

```bash
kubectl get svc -n staging
```

### Port-forward access for ClusterIP service

If the service type is `ClusterIP`, use port-forwarding:

```bash
kubectl port-forward -n staging service/capstone-service 8080:80
```

Then open:

```text
http://localhost:8080
```

---

## 🐤 Canary Deployment Strategy

A canary deployment is a safer way to test a new version of the application before fully replacing the stable version.

In this project, the canary deployment strategy was tested successfully in the staging environment.

Canary files are located in:

```text
kubernetes/canary/
├── README.md
├── stable-deployment.yaml
├── canary-deployment.yaml
└── service.yaml
```

### Why canary deployment is useful

Instead of immediately sending all users to a new version, a canary deployment allows the team to:

- Deploy a new version beside the stable version
- Test the new version in a controlled way
- Verify routes, product pages, cart pages, and images
- Reduce the risk of releasing broken changes
- Roll back more safely if something fails

### Automated canary scripts

The project now includes helper scripts:

```text
scripts/
├── canary_promote_or_rollback.sh
└── canary_rollback.sh
```

Run the canary promotion script from the project root:

```bash
./scripts/canary_promote_or_rollback.sh
```

The script performs:

1. Checks the `staging` namespace.
2. Applies stable deployment.
3. Applies canary deployment.
4. Applies canary service.
5. Waits for stable and canary rollout.
6. Starts local port-forwarding to the `ClusterIP` service.
7. Tests:
   - `/health`
   - `/`
   - `/product/TSHIRT-001`
   - `/cart`
8. Promotes the canary image to stable if checks pass.
9. Removes the canary deployment after successful promotion.

If canary has problems, run:

```bash
./scripts/canary_rollback.sh
```

### Tested canary result

The automation was tested successfully against staging AKS.

- Stable deployment rolled out successfully.
- Canary deployment rolled out successfully.
- `ClusterIP` service was tested through port-forwarding.
- `/health`, homepage, product detail, and cart routes passed.
- Canary image `capstonetfacr047af007.azurecr.io/ecommerce-app:v24` was promoted to the stable deployment.
- Canary deployment was removed after promotion.
- Stable deployment remained healthy with `2/2` replicas.

---

## 🔵🟢 Blue-Green Deployment Strategy

Blue-green deployment was added as a comparison to canary deployment.

Blue-green files are located in:

```text
kubernetes/blue-green/
├── README.md
├── deployment-blue.yaml
├── deployment-green.yaml
└── service.yaml
```

### What blue-green deployment means

Blue-green deployment runs two complete versions of the application environment:

| Environment | Purpose |
|---|---|
| Blue | Current active version receiving traffic |
| Green | New version prepared and tested before switching traffic |

The Kubernetes service controls whether traffic goes to blue or green.

Example selector for blue:

```yaml
selector:
  app: capstone-blue-green-demo
  version: blue
```

Example selector for green:

```yaml
selector:
  app: capstone-blue-green-demo
  version: green
```

### Blue-green test commands

Apply the deployments and service:

```bash
kubectl apply -f kubernetes/blue-green/deployment-blue.yaml
kubectl apply -f kubernetes/blue-green/deployment-green.yaml
kubectl apply -f kubernetes/blue-green/service.yaml
```

Check rollout:

```bash
kubectl rollout status deployment/capstone-app-blue -n staging
kubectl rollout status deployment/capstone-app-green -n staging
```

Test through port-forward:

```bash
kubectl port-forward -n staging service/capstone-blue-green-service 8081:80
```

Then test:

```bash
curl -i http://localhost:8081/health
curl -i http://localhost:8081/
curl -i http://localhost:8081/product/TSHIRT-001
curl -i http://localhost:8081/cart
```

### Canary vs blue-green

| Strategy | How It Works | Best For |
|---|---|---|
| Canary | Releases a new version gradually beside stable | Lower-risk gradual testing |
| Blue-Green | Runs two full environments and switches traffic between them | Fast rollback and clear environment separation |

---

## 📊 Monitoring Dashboard Package

A monitoring dashboard package was added to support operational visibility.

Monitoring files are located in:

```text
monitoring/
├── README.md
├── aks_monitoring_queries.kql
├── application_health_queries.kql
└── dashboard_plan.md
```

The monitoring package helps the team document and prepare monitoring for:

- Application health
- Deployment status
- AKS workload visibility
- Staging environment checks
- Evidence collection for demos and handover

Typical monitoring evidence should include:

- Pod status
- Deployment status
- Service status
- Application route checks
- Screenshots of successful app access
- Any dashboard screenshots or exported dashboard files

---

## 🔄 GitHub Actions CI/CD

The workflow file is located at:

```text
.github/workflows/deploy.yml
```

The CI/CD workflow performs:

1. Checkout code
2. Set up Python
3. Install dependencies
4. Run pytest route tests
5. Login to Azure Container Registry
6. Build Docker image for Linux AMD64
7. Push Docker image to ACR
8. Set AKS context
9. Apply Kubernetes deployment and service files
10. Wait for rollout status

Important Docker build command:

```bash
docker build --platform linux/amd64 \
  -t ${{ secrets.ACR_LOGIN_SERVER }}/ecommerce-app:v${{ github.run_number }} \
  -f app/Dockerfile .
```

The final `.` is important because the Docker build context must be the repository root.

### Required GitHub Secrets

| Secret | Purpose |
|---|---|
| `ACR_LOGIN_SERVER` | Azure Container Registry login server |
| `ACR_USERNAME` | ACR username |
| `ACR_PASSWORD` | ACR password |
| `KUBERNETES_KUBECONFIG` | AKS kubeconfig for deployment |

> The AKS cluster must be running before the GitHub Actions deployment step can reach the Kubernetes API server.

---

## ⚠️ Important CI/CD Note: AKS Must Be Running for Deployment

The GitHub Actions workflow has two major parts:

1. **CI checks** — install dependencies, run tests, build the Docker image, and push the image to ACR.
2. **CD deployment** — connect to AKS and apply the Kubernetes deployment.

If AKS is intentionally stopped for cost control, the CI stages can still pass, but the Kubernetes deployment stage may fail because GitHub Actions cannot reach the AKS API server.

This does **not** necessarily mean the code, tests, Docker image, or pipeline build is broken.

Expected situation when AKS is stopped:

| Pipeline Stage | Expected Result |
|---|---|
| Install Dependencies & Run Tests | Pass |
| Build and Push Docker Image | Pass |
| Set AKS Context | May pass |
| Deploy to Kubernetes Cluster | May fail because AKS is stopped |

To run a fully green deployment pipeline:

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

Confirm AKS is running:

```bash
az aks show --resource-group rg-capstone --name capstone-aks --query "powerState.code" -o tsv
```

Expected output:

```text
Running
```

Then re-run the GitHub Actions workflow.

After the team has finished verification or demo testing, stop AKS again:

```bash
az aks stop --resource-group rg-capstone --name capstone-aks
```

---

## 🗄️ Azure SQL Databases

The project includes Azure SQL setup for product and order data.

| Database | Purpose |
|---|---|
| `tsb-products-db` | Product and category data |
| `tsb-orders-db` | Orders and order item data |

Database scripts and setup helpers are stored in:

```text
database/
├── generate_aeo.py
├── init_db.py
├── schema_orders.sql
├── schema_products.sql
└── seed_products.sql
```

---

## ✅ Release Rehearsal Result

A release rehearsal was completed as part of the handover process.

Final successful result:

- Docker image fixed to serve the full Flask shop app.
- `/health` endpoint added for Kubernetes probes.
- AKS successfully pulled and ran image `v23`.
- Public LoadBalancer service returned `200 OK`.
- Homepage loaded successfully.
- Product detail page loaded successfully.
- Cart page loaded successfully.
- AKS was stopped after testing for cost control.
- Release runbook was updated and merged.

The release rehearsal runbook is documented in:

```text
documentation/phase2_release_rehearsal_handover_runbook.md
```

---

## 💰 Cost Control

To reduce Azure cost, AKS can be stopped when not actively testing or demonstrating.

### Stop AKS

```bash
az aks stop --resource-group rg-capstone --name capstone-aks
```

### Check AKS power state

```bash
az aks show --resource-group rg-capstone --name capstone-aks --query "powerState.code" -o tsv
```

Expected output when stopped:

```text
Stopped
```

### Start AKS before deployment or demo

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

Expected output when running:

```text
Running
```

---

## ⚠️ Known Limitation: Azure Public IP Quota

During staging testing, services were changed to `ClusterIP` instead of `LoadBalancer`.

### Reason

The Azure subscription reached the public IP limit in the Southeast Asia region.

### Impact

AKS cannot provision another external public IP address for a new LoadBalancer service until quota is increased or unused public IPs are removed.

### Current workaround

Use:

```bash
kubectl port-forward -n staging service/<service-name> 8080:80
```

Then open:

```text
http://localhost:8080
```

### Future options

- Request a public IP quota increase in Azure.
- Delete unused public IP addresses.
- Reuse an existing public IP where appropriate.
- Use an ingress controller when a suitable public IP is available.
- Continue using `ClusterIP` for internal staging validation.

---

## 📁 Project Structure

```text
capstone/
├── app/
│   ├── app.py
│   ├── config.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── models/
│   ├── routes/
│   ├── templates/
│   └── static/
├── ansible/
│   ├── deployment_check.yml
│   └── inventory.ini
├── database/
│   ├── generate_aeo.py
│   ├── init_db.py
│   ├── schema_orders.sql
│   ├── schema_products.sql
│   └── seed_products.sql
├── documentation/
│   ├── azure_blob_storage_future_plan.md
│   ├── database_setup.md
│   ├── deployment_strategy_future_plan.md
│   ├── final_project_verification_checklist.md
│   ├── monitoring_health_check_guide.md
│   ├── phase2_access_matrix.md
│   ├── phase2_ansible_deployment_checks.md
│   ├── phase2_azure_sql_setup.md
│   ├── phase2_cost_governance.md
│   ├── phase2_release_rehearsal_handover_runbook.md
│   └── screenshots/
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── canary/
│   ├── blue-green/
│   └── environments/
├── monitoring/
│   ├── README.md
│   ├── aks_monitoring_queries.kql
│   ├── application_health_queries.kql
│   └── dashboard_plan.md
├── scripts/
│   ├── canary_promote_or_rollback.sh
│   └── canary_rollback.sh
├── terraform/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── README.md
│   └── variables.tf
├── terraform-backend/
│   ├── main.tf
│   └── .terraform.lock.hcl
├── tests/
│   ├── conftest.py
│   ├── test_app_routes.py
│   ├── test_cart_checkout_routes.py
│   ├── test_cart_flow_extended.py
│   ├── test_e2e_shop_flow.py
│   ├── test_product_model.py
│   └── test_product_routes_extended.py
├── .github/
│   └── workflows/
│       └── deploy.yml
├── Jenkinsfile
├── azure-pipelines.yml
└── README.md
```

---

## 📈 DevOps and Cloud Skills Demonstrated

| Skill Area | Tools / Practices |
|---|---|
| Version Control | Git, GitHub, pull requests, branch cleanup |
| CI/CD | GitHub Actions pipeline |
| Automated Testing | pytest unit, route, integration, and e2e-style tests |
| Containerisation | Docker, Dockerfile, image tagging |
| Cloud Registry | Azure Container Registry |
| Kubernetes | AKS, Deployment, Service, probes, rollout status |
| Infrastructure as Code | Terraform staging infrastructure |
| Terraform State Management | Azure Storage remote backend |
| Deployment Strategy | Canary deployment, scripted canary promotion, blue-green comparison |
| Monitoring | Monitoring dashboard package and operational checks |
| Cloud Database | Azure SQL Database |
| Troubleshooting | ImagePullBackOff, Docker build context, platform mismatch, public IP quota, Terraform drift |
| Release Management | Release rehearsal, runbook, handover notes |
| Cost Awareness | AKS stop/start and Azure cost control |

---

## 🔮 Future Improvements

- Add product image uploads and storage using Azure Blob Storage
- Add HTTPS ingress with a custom domain
- Add Azure Key Vault for secrets management
- Add database migration workflow for Azure SQL
- Add production-ready alerting rules for AKS, application health, and deployment failures
- Add metric-based canary promotion and rollback using Azure Monitor or Argo Rollouts
- Add production-grade traffic splitting through ingress, service mesh, or Argo Rollouts
- Add more complete separation between development, staging, and production variable files
- Add security scanning for Docker images and dependencies
- Add automated cleanup workflow for temporary demo resources

---

## 👥 Team Handover Notes

Before running a deployment demo:

1. Start AKS.
2. Confirm the cluster is running.
3. Re-run the GitHub Actions workflow or push a new commit to `main`.
4. Confirm the pod is `1/1 Running`.
5. Test `/`, `/health`, `/product/TSHIRT-001`, and `/cart`.
6. If the service is `ClusterIP`, use `kubectl port-forward`.
7. Confirm product images load correctly.
8. Capture screenshots as evidence.
9. Stop AKS after testing to reduce cost.

### Before running Terraform

1. Confirm the correct Azure subscription:

```bash
az account show
```

2. Go to the Terraform folder:

```bash
cd terraform
```

3. Initialise Terraform:

```bash
terraform init
```

4. Validate and review the plan:

```bash
terraform validate
terraform plan
```

5. Only apply after the team agrees:

```bash
terraform apply
```

### Canary validation

Run from the project root:

```bash
./scripts/canary_promote_or_rollback.sh
```

If needed, rollback canary manually:

```bash
./scripts/canary_rollback.sh
```

### Blue-green validation

Apply blue-green files:

```bash
kubectl apply -f kubernetes/blue-green/deployment-blue.yaml
kubectl apply -f kubernetes/blue-green/deployment-green.yaml
kubectl apply -f kubernetes/blue-green/service.yaml
```

Test with port-forwarding:

```bash
kubectl port-forward -n staging service/capstone-blue-green-service 8081:80
```

Then test the routes:

```bash
curl -i http://localhost:8081/health
curl -i http://localhost:8081/
curl -i http://localhost:8081/product/TSHIRT-001
curl -i http://localhost:8081/cart
```

### After merging the final improvements branch into `main`

1. Switch back to `main` locally:

```bash
git checkout main
```

2. Pull the latest merged changes:

```bash
git pull origin main
```

3. Confirm the working tree is clean:

```bash
git status
```

4. Delete the merged local branch safely:

```bash
git branch -d infra-final-improvements
```

5. Prepare the final team playbook from the updated `main` branch.

---

## 📄 License

This project was created for a DevOps / Cloud Support capstone project.

---

Built as part of DevOps and Cloud Support Engineering training.

Last updated: June 2026
