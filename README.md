[![CI/CD Pipeline](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml/badge.svg)](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml)
[![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/flask-ecommerce-green.svg)](https://flask.palletsprojects.com/)
[![Docker](https://img.shields.io/badge/docker-supported-blue.svg)](https://www.docker.com/)
[![Azure](https://img.shields.io/badge/Azure-AKS%20%7C%20ACR%20%7C%20SQL-0078D4.svg)](https://azure.microsoft.com/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-deployed-326CE5.svg)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/terraform-IaC-7B42BC.svg)](https://www.terraform.io/)
[![GCP](https://img.shields.io/badge/GCP-Cloud%20Run%20POC-4285F4.svg)](https://cloud.google.com/run)
[![Status](https://img.shields.io/badge/project-final%20proposal%20ready-success.svg)](#final-project-status)

# 🛍️ The Shirt Bar — Cloud-Native E-Commerce Capstone Project

A cloud-native e-commerce platform for **The Shirt Bar**, a premium sustainable menswear brand based in Singapore.

This project demonstrates how a Flask-based online shop can be containerised with Docker, pushed to Azure Container Registry, deployed to Azure Kubernetes Service, prepared for Azure SQL Database integration, automated through GitHub Actions, extended with Terraform-managed staging infrastructure, supported with safer release strategies such as canary and blue-green deployments, documented with monitoring and handover runbooks, and enhanced with a **Tidio AI chatbot widget** for first-level customer support.

---

## 📋 Table of Contents

- [Final Project Status](#final-project-status)
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Live Deployment Evidence](#live-deployment-evidence)
- [Screenshots](#screenshots)
- [Tidio AI Chatbot Evidence](#tidio-ai-chatbot-evidence)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Azure Resources](#azure-resources)
- [Application Routes](#application-routes)
- [Local Development](#local-development)
- [Automated Testing](#automated-testing)
- [Docker Build and Local Test](#docker-build-and-local-test)
- [Kubernetes Deployment](#kubernetes-deployment)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Terraform Staging Infrastructure](#terraform-staging-infrastructure)
- [Terraform Remote Backend](#terraform-remote-backend)
- [Canary Deployment](#canary-deployment)
- [Blue-Green Deployment](#blue-green-deployment)
- [Azure SQL Databases](#azure-sql-databases)
- [Monitoring and Operational Evidence](#monitoring-and-operational-evidence)
- [GCP Cloud Run Backup-Cloud Proof of Concept](#gcp-cloud-run-backup-cloud-proof-of-concept)
- [Release Rehearsal Result](#release-rehearsal-result)
- [Cost Control](#cost-control)
- [Project Structure](#project-structure)
- [DevOps and Cloud Skills Demonstrated](#devops-and-cloud-skills-demonstrated)
- [Troubleshooting Notes](#troubleshooting-notes)
- [Future Improvements](#future-improvements)
- [Team Handover Notes](#team-handover-notes)

---

## ✅ Final Project Status

| Item | Status |
|---|---|
| Flask e-commerce application | Completed |
| Product listing and product detail pages | Completed |
| Cart and checkout routes | Completed |
| Tidio AI chatbot widget | Completed and locally verified |
| Docker container build | Completed |
| Azure Container Registry image push | Completed |
| Azure Kubernetes Service deployment | Completed and verified |
| GitHub Actions CI/CD | Completed |
| Automated pytest suite | 26 tests passed |
| Terraform staging infrastructure | Completed |
| Terraform remote backend | Completed |
| Canary deployment example | Completed and tested |
| Blue-green deployment example | Completed |
| Monitoring and health-check documentation | Completed |
| Azure SQL preparation | Completed / planned production integration |
| GCP Cloud Run proof of concept | Completed |
| Final proposal documentation | Completed |

| Production readiness sanity check | Completed - reviewed as excellent capstone prototype with production hardening items documented |
| Terraform structure cleanup | Updated - split into clearer Terraform files |
| Demo readiness | Updated - failed payment, successful payment and live background-change workflow documented |

> **Current branch:** `main`  
> **Documentation status:** Updated after chatbot verification and final proposal alignment.


---

## 🧪 Production Readiness Sanity Check

A technical sanity check was completed before final submission to separate what the capstone currently proves from what a real production e-commerce launch would still require.

### Current Capstone Scope

This repository demonstrates a working cloud prototype:

- Flask e-commerce storefront with product, cart, checkout, success and failed-payment routes
- Dockerised application image
- Azure Container Registry image storage
- Azure Kubernetes Service deployment
- GitHub Actions CI/CD workflow
- pytest test coverage for critical routes and flows
- Terraform-managed staging infrastructure
- Canary and blue-green release examples
- Tidio chatbot widget integration
- GCP Cloud Run backup-cloud proof of concept

### Important Production Clarification

This project should be presented as a **working capstone prototype and cloud architecture proof of concept**, not as a fully production-ready public store handling real money and customer personal data.

Before a real go-live, the following items should be completed:

| Area | Production Hardening Needed | Why It Matters |
|---|---|---|
| Payments | Add Stripe webhook verification before confirming payment | Prevents users from directly opening the success page without a verified payment event |
| Data persistence | Store cart/order records in Azure SQL or another server-side database | Prevents order data from being lost or only stored in browser session cookies |
| Secrets | Use Azure Key Vault and avoid development fallback secrets in production | Protects passwords, API keys and application signing keys |
| CI/CD security | Move from long-lived ACR/kubeconfig secrets to GitHub OIDC with Azure login | Reduces credential exposure risk |
| Availability | Use 2+ replicas, HPA and a PodDisruptionBudget | Reduces downtime during updates or node maintenance |
| HTTPS/WAF | Add Ingress, TLS and Azure Front Door/Web Application Firewall | Protects public traffic and supports safer customer access |
| Observability | Add Application Insights, alerts and structured logs | Helps the business detect and explain issues quickly |
| App security | Add CSRF protection, rate limiting and generic error messages | Reduces common web application risk |

A detailed review is included in:

```text
sanity_check.md
```

### How This Will Be Explained During Presentation

> "Our prototype proves the shopping journey, cloud deployment, CI/CD workflow and release process. The sanity check shows that we understand what is already working, and what must be hardened before a real public production launch. This keeps the recommendation realistic for a business such as The Shirt Bar."


## 📖 Project Overview

The Shirt Bar e-commerce application was built as a practical DevOps and Cloud Support capstone project.

The project focuses on:

- Building a Flask e-commerce web application
- Structuring the app with routes, templates, static assets and product models
- Adding product listing, product detail, cart, checkout, success and failed-payment pages
- Adding a `/health` endpoint for Kubernetes liveness and readiness checks
- Adding a **Tidio AI chatbot widget** for basic customer assistance and product enquiries
- Containerising the application using Docker
- Storing application images in Azure Container Registry
- Deploying the containerised application to Azure Kubernetes Service
- Automating test, build, push and deployment steps through GitHub Actions
- Preparing Azure SQL Database support for future product and order data persistence
- Creating Terraform-managed staging infrastructure
- Using Terraform remote backend storage for shared state management
- Demonstrating safer release strategies through canary and blue-green deployment examples
- Documenting monitoring, release rehearsal, cost control and handover procedures
- Demonstrating multi-cloud container portability through a separate GCP Cloud Run proof of concept

---

## ✨ Key Features

| Feature | Description |
|---|---|
| **Product Listing** | Homepage displays The Shirt Bar product collection |
| **Product Detail Page** | Individual product pages using SKU routes |
| **Shopping Cart** | Cart page and add-to-cart route structure |
| **Checkout Flow** | Checkout, success and failed-payment pages prepared for e-commerce flow |
| **Flask Blueprints** | Routes split into product, cart and checkout modules |
| **Health Endpoint** | `/health` route supports Kubernetes probes and deployment validation |
| **AI Chatbot Widget** | Tidio chatbot embedded into the shared Flask base template for first-level customer assistance, product enquiries and basic support guidance |
| **Dockerised App** | Flask app packaged into a production container |
| **ACR Integration** | Docker images pushed to Azure Container Registry |
| **AKS Deployment** | App deployed through Kubernetes Deployment and Service YAML |
| **CI/CD Workflow** | GitHub Actions builds, tests, pushes and deploys the app |
| **Terraform Staging** | Infrastructure-as-code staging environment created with Terraform |
| **Remote Terraform Backend** | Azure Storage backend prepared for shared Terraform state |
| **Canary Deployment** | Canary promotion and rollback scripts created and tested |
| **Blue-Green Deployment** | Blue-green Kubernetes manifests prepared for safer production releases |
| **Monitoring Assets** | Health checks, monitoring guide and operational runbooks documented |
| **GCP Cloud Run POC** | Same Dockerised app deployed to Google Cloud Run as a backup-cloud proof of concept |

---

## 🌐 Live Deployment Evidence

The full shop application was successfully deployed and tested on **Azure Kubernetes Service (AKS)**.

| Item | Value |
|---|---|
| **Previous AKS Image** | `capstonereg047af007.azurecr.io/ecommerce-app:v23` |
| **Latest Staging Image** | `capstonetfacr047af007.azurecr.io/ecommerce-app:v24` |
| **AKS Service** | `capstone-service` |
| **Deployment** | `capstone-app` |
| **Original Resource Group** | `rg-capstone` |
| **Original AKS Cluster** | `capstone-aks` |
| **Original ACR** | `capstonereg047af007` |
| **Final Result** | Full shop deployment verified successfully |

> **Cost note:** AKS may be stopped outside testing/demo periods to reduce Azure cost, so the public endpoint may not always be reachable.

### ✅ Verified Routes

| Route | Result | Purpose |
|---|---:|---|
| `/` | `200 OK` | Shop homepage and product listing |
| `/health` | `200 OK` | Kubernetes health check |
| `/product/TSHIRT-001` | `200 OK` | Product detail page |
| `/cart` | `200 OK` | Shopping cart page |
| `/checkout` | `200 OK` | Checkout page |
| `/success` | `200 OK` | Successful payment page |
| `/failed` | `200 OK` | Failed or cancelled payment page |

---

## 📸 Screenshots

Screenshots were captured during the successful AKS deployment and local verification checks.

### Homepage

![The Shirt Bar AKS Homepage](documentation/screenshots/aks-homepage-v23.png)

### Product Detail Page

![The Shirt Bar Product Detail Page](documentation/screenshots/aks-product-detail-v23.png)

### Cart Page

![The Shirt Bar Cart Page](documentation/screenshots/aks-cart-v23.png)

> These screenshots show that the deployed application was reachable through AKS and that the main shop pages loaded successfully.

---

## 🤖 Tidio AI Chatbot Evidence

The latest prototype includes a **Tidio AI chatbot widget** embedded into the shared Flask base template.

The chatbot provides first-level customer assistance for:

- Product enquiries
- Styling questions
- Store or support guidance
- Basic customer-service questions before escalation to staff

### Implementation Location

The chatbot is implemented in:

```text
app/templates/base.html
```

The Tidio widget is loaded through a frontend script tag, which means it appears across pages that extend the shared base template.

> Important clarification: the chatbot is **not** a custom Flask backend service and it is **not** a separate AKS microservice. It is a third-party frontend widget embedded into the website.

### Pages Tested

| Page | Result |
|---|---|
| Homepage | Chatbot bubble visible |
| Product detail page | Chatbot available |
| Cart page | Chatbot available |
| Checkout page | Chatbot available |

### Local Desktop Verification

The chatbot was tested locally on desktop and verified to:

- Appear on the storefront
- Open successfully
- Accept a customer enquiry
- Provide a response
- Not block the main shop layout
- Not break existing Flask routes
- Pass the existing automated test suite after verification

### Screenshot Evidence

| Evidence | Screenshot Path |
|---|---|
| Homepage chatbot bubble | `documentation/screenshots/chatbot/chatbot-homepage-bubble.png` |
| Chatbot window opened | `documentation/screenshots/chatbot/chatbot-window-opened.png` |
| Sample chatbot reply | `documentation/screenshots/chatbot/chatbot-sample-reply.png` |

Full evidence notes are documented in:

```text
documentation/chatbot_tidio_evidence.md
```

---

## 🏗️ Architecture

The project uses an Azure-first architecture with a separate GCP Cloud Run proof of concept for container portability.

```text
┌──────────────────┐
│ Local Developer  │
│ VS Code + Git    │
└────────┬─────────┘
         │ git push
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
         │ docker build + test + push
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
         │ service routing
         ▼
┌────────────────────────────┐
│ The Shirt Bar Web App      │
│ Flask + Jinja2 + CSS       │
│ Tidio frontend chatbot     │
└────────────────────────────┘
```

### Architecture Notes

| Zone | Components | Explanation |
|---|---|---|
| User & Internet Entry | Users, Internet, HTTPS | Customers access the store through a browser over HTTPS. |
| Entry Layer | Azure Front Door/WAF, Application Gateway/Ingress | Recommended production layer for SSL offload, routing, WAF rules and rate limiting. |
| AKS Cluster | Node pool, `capstone-app`, `capstone-service` | Runs the single Dockerised Flask application. |
| App Modules | Product routes, cart routes, checkout routes, health endpoint | Core app functions tested through pytest and browser checks. |
| Chatbot Widget | Tidio script in `base.html` | Frontend customer-support widget loaded by the website. |
| Data / Storage | Azure SQL, Blob Storage, Redis | SQL and Blob are planned production integrations; Redis is a future caching recommendation. |
| Supporting Services | ACR, Key Vault, Monitor, Log Analytics, Service Bus | ACR stores images, Key Vault protects secrets, Monitor provides visibility, Service Bus supports future decoupled events. |
| DevOps / CI-CD | GitHub, GitHub Actions, Docker, Terraform, ACR, AKS, Jenkins validation | Code becomes a tested Docker image deployed to AKS. |
| Backup-Cloud POC | GCP Cloud Run, Artifact Registry | Same container deployed to GCP to demonstrate portability. |

---

## 🛠️ Tech Stack

| Area | Technology |
|---|---|
| Backend | Python, Flask |
| Frontend | HTML, CSS, Jinja2 Templates |
| AI Chatbot / Customer Support | Tidio chatbot widget |
| Testing | pytest |
| Database | Azure SQL Database preparation |
| Containerisation | Docker |
| Container Registry | Azure Container Registry |
| Orchestration | Azure Kubernetes Service |
| CI/CD | GitHub Actions |
| Alternative CI/CD Validation | Jenkins |
| Infrastructure as Code | Terraform |
| Deployment | Kubernetes YAML |
| Monitoring | Azure Monitor, Log Analytics, health checks |
| Cloud Platform | Microsoft Azure |
| Backup-Cloud POC | Google Cloud Run, Google Artifact Registry |
| Payment Integration | Stripe Test Mode |
| Documentation | Markdown, Runbooks, Final Proposal |

---

## ☁️ Azure Resources

| Resource Type | Name |
|---|---|
| Original Resource Group | `rg-capstone` |
| Original AKS Cluster | `capstone-aks` |
| Original Azure Container Registry | `capstonereg047af007` |
| Original ACR Login Server | `capstonereg047af007.azurecr.io` |
| Kubernetes Deployment | `capstone-app` |
| Kubernetes Service | `capstone-service` |
| Product Database | `tsb-products-db` |
| Orders Database | `tsb-orders-db` |
| Terraform Staging Resource Group | `rg-capstone-tf-staging` |
| Terraform Staging AKS | `capstone-aks-tf-staging` |
| Terraform Staging ACR | `capstonetfacr047af007` |
| Terraform State Resource Group | `rg-capstone-tfstate` |
| Terraform State Storage Account | `capstonetfstate047af007` |
| Terraform State Container | `tfstate` |
| Terraform State Key | `staging.terraform.tfstate` |

---

## 📡 Application Routes

| Route | Method | Description |
|---|---|---|
| `/` | `GET` | Main shop homepage and product listing |
| `/product/<sku>` | `GET` | Product detail page |
| `/cart` | `GET` | Shopping cart page |
| `/cart/add/<sku>` | `POST` | Add selected product to cart |
| `/cart/update/<cart_key>` | `POST` | Update cart quantity |
| `/cart/remove/<cart_key>` | `POST` | Remove item from cart |
| `/checkout` | `GET` | Checkout page |
| `/checkout/create-session` | `POST` | Creates checkout session / simulated order flow |
| `/success` | `GET` | Successful payment page |
| `/failed` | `GET` | Failed or cancelled payment page |
| `/health` | `GET` | Health endpoint for Kubernetes probes |

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

Run the app from the repository root using module mode:

```bash
python -m app.app
```

Local Flask URL:

```text
http://localhost:5001
```

> Note: avoid running `python app/app.py` from the repository root because Python may confuse `app/app.py` with the `app` package and produce an import error such as `'app' is not a package`.

---

## ✅ Automated Testing

Automated tests were added using `pytest`.

The test files are located in:

```text
tests/
├── conftest.py
├── test_app_routes.py
├── test_cart_checkout_routes.py
├── test_product_routes_extended.py
└── test_e2e_shop_flow.py
```

The current tests validate:

| Test Area | Example Scope |
|---|---|
| Health check | `/health` returns `200 OK` and `{"status":"ok"}` |
| Homepage | Homepage loads The Shirt Bar content |
| Product detail | Valid product page loads correctly |
| Cart | Cart page and cart flows load correctly |
| Checkout | Checkout, success and failed pages load correctly |
| End-to-end shop flow | Main customer journey can be exercised through the Flask test client |
| Chatbot UI check | Tidio widget was manually verified on desktop without breaking existing routes |

Run tests locally:

```bash
python -m pytest -v
```

Expected result:

```text
26 passed
```

The automated test suite was re-run after chatbot verification, and all tests passed.

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
  -t capstonereg047af007.azurecr.io/ecommerce-app:v23 \
  -f app/Dockerfile . \
  --push
```

For Terraform staging / latest staging image:

```bash
docker buildx build --platform linux/amd64 \
  -t capstonetfacr047af007.azurecr.io/ecommerce-app:v24 \
  -f app/Dockerfile . \
  --push
```

This avoids the `ImagePullBackOff` issue caused by a platform mismatch.

---

## ☸️ Kubernetes Deployment

Kubernetes files are located in:

```text
kubernetes/
├── deployment.yaml
├── service.yaml
├── canary/
└── blue-green/
```

Useful commands:

```bash
kubectl get deployments
kubectl get pods
kubectl get svc
kubectl describe deployment capstone-app
```

Check the deployed image:

```bash
kubectl describe deployment capstone-app | grep Image
```

Check the service:

```bash
kubectl get svc
```

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
4. Run pytest tests
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

## 🧩 Terraform Staging Infrastructure

> Final submission update: Terraform has been reorganized into separate files for clearer professional review: `versions.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf` and `terraform.tfvars.example`.


Terraform was added to demonstrate Infrastructure as Code for a staging environment.

Terraform files are located in:

```text
terraform/
├── main.tf
├── variables.tf
└── outputs.tf
```

The staging environment includes:

| Resource | Purpose |
|---|---|
| Resource Group | Holds staging resources |
| AKS Cluster | Runs staging Kubernetes workloads |
| Azure Container Registry | Stores staging Docker images |
| Network resources | Provides network foundation |
| Storage preparation | Supports Terraform/backend or future assets depending configuration |

Example workflow:

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## 🗃️ Terraform Remote Backend

Terraform remote backend storage was prepared to avoid relying only on local state files.

Backend details:

| Item | Value |
|---|---|
| Resource Group | `rg-capstone-tfstate` |
| Storage Account | `capstonetfstate047af007` |
| Container | `tfstate` |
| State Key | `staging.terraform.tfstate` |

Remote backend configuration is stored under:

```text
terraform-backend/
```

After backend creation, the main Terraform state can be migrated from the `terraform/` folder.

---

## 🟢 Canary Deployment

Canary deployment was added to reduce release risk.

A canary release allows a new version of the app to run beside the stable version first. The team can test the new version before promoting it fully.

Canary-related files include:

```text
kubernetes/canary/
scripts/canary_promote_or_rollback.sh
scripts/canary_rollback.sh
```

Canary validation included:

- Stable deployment rollout
- Canary deployment rollout
- Service verification through port-forward
- `/health`, homepage, product detail and cart route checks
- Promotion of v24 to stable
- Deletion of canary deployment after successful promotion
- Stable deployment remaining healthy with `2/2` replicas

---

## 🔵🟢 Blue-Green Deployment

Blue-green deployment manifests were added as another safer release strategy.

Files are located in:

```text
kubernetes/blue-green/
├── deployment-blue.yaml
├── deployment-green.yaml
└── service.yaml
```

Concept:

| Environment | Meaning |
|---|---|
| Blue | Current stable version |
| Green | New candidate version |

The service selector can be switched from blue to green after verification. This keeps the old version available for rollback.

---

## 🗄️ Azure SQL Databases

The project includes Azure SQL setup planning for product and order data.

| Database | Purpose |
|---|---|
| `tsb-products-db` | Product and category data |
| `tsb-orders-db` | Orders and order item data |

Database scripts and setup helpers are stored in:

```text
database/
```

For the current capstone, some product data remains in the application model for simplicity. Azure SQL is documented as a production-ready integration path.

---

## 📊 Monitoring and Operational Evidence

Monitoring and health-check documentation is stored under:

```text
documentation/monitoring_health_check_guide.md
```

Monitoring coverage includes:

- `/health` route
- Kubernetes liveness/readiness probe explanation
- AKS pod and deployment checks
- Service checks
- GitHub Actions deployment status interpretation
- Troubleshooting guidance when AKS is stopped for cost control
- Screenshot evidence checklist

Recommended production monitoring services:

| Service | Purpose |
|---|---|
| Azure Monitor | Metrics and resource monitoring |
| Log Analytics | Centralized logs and KQL queries |
| Application Insights | Application performance and request tracing |
| Alerts | Notification when uptime, deployment or performance thresholds fail |

---

## ☁️ GCP Cloud Run Backup-Cloud Proof of Concept

In addition to the main Azure AKS deployment, this project includes a separate Google Cloud Platform proof of concept.

The same Dockerised Flask e-commerce application was pushed to Google Artifact Registry and deployed to Google Cloud Run. This demonstrates that the application is portable across cloud providers because it is packaged as a container.

This GCP deployment is **not** a full disaster recovery setup. It is a backup-cloud proof of concept used to show that the application can run outside Azure with minimal changes.

| Item | Value |
|---|---|
| GCP Project ID | `shirtbar-gcp-showcase-khairul` |
| Region | `asia-southeast1` |
| Service | Google Cloud Run |
| Container Registry | Google Artifact Registry |
| Image | `ecommerce-app:gcp-demo-v1` |

GCP documentation is stored in:

```text
docs/gcp-cloud-run-showcase.md
```

GCP evidence screenshots are stored in:

```text
docs/images/
```

---

## ✅ Release Rehearsal Result

A release rehearsal was completed as part of the handover process.

Final successful result:

- Docker image fixed to serve the full Flask shop app
- `/health` endpoint added for Kubernetes probes
- AKS successfully pulled and ran image `v23`
- Service returned `200 OK`
- Homepage loaded successfully
- Product detail page loaded successfully
- Cart page loaded successfully
- Terraform staging was created and validated
- Canary deployment promotion flow was tested
- Blue-green deployment manifests were prepared
- GCP Cloud Run proof of concept was completed
- Tidio chatbot was verified locally on desktop
- Automated tests passed after chatbot verification
- AKS was stopped after testing for cost control
- Documentation and proposal were updated

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

For Terraform staging:

```bash
az aks stop --resource-group rg-capstone-tf-staging --name capstone-aks-tf-staging
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

> Do not delete resource groups, public IPs, ACRs or Terraform backend storage unless the team has confirmed that no further grading, demo or evidence collection is required.

---

## ⚠️ Important CI/CD Note: AKS Must Be Running for Deployment

The GitHub Actions workflow has two major parts:

1. **CI checks** — install dependencies, run tests, build the Docker image and push the image to ACR.
2. **CD deployment** — connect to AKS and apply the Kubernetes deployment.

If AKS is intentionally stopped for cost control, the CI stages can still pass, but the Kubernetes deployment stage may fail because GitHub Actions cannot reach the AKS API server.

This does **not** necessarily mean the code, tests, Docker image or pipeline build is broken.

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

Then re-run the GitHub Actions workflow.

After verification or demo testing, stop AKS again.

---

## 📁 Project Structure

```text
capstone/
├── app/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── models/
│   ├── routes/
│   ├── static/
│   └── templates/
├── ansible/
├── database/
├── docs/
│   ├── gcp-cloud-run-showcase.md
│   └── images/
├── documentation/
│   ├── chatbot_tidio_evidence.md
│   ├── monitoring_health_check_guide.md
│   ├── phase2_release_rehearsal_handover_runbook.md
│   └── screenshots/
│       └── chatbot/
│           ├── chatbot-homepage-bubble.png
│           ├── chatbot-window-opened.png
│           └── chatbot-sample-reply.png
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── canary/
│   └── blue-green/
├── monitoring/
├── scripts/
│   ├── canary_promote_or_rollback.sh
│   └── canary_rollback.sh
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── terraform-backend/
├── tests/
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
| Version Control | Git, GitHub, branches, commits and pull requests |
| Python Web Development | Flask, Jinja2 templates, route handling |
| Frontend Integration | Tidio chatbot widget embedded in shared template |
| Automated Testing | pytest route and workflow tests |
| Containerisation | Docker, Dockerfile, image tagging, Linux AMD64 build |
| Cloud Registry | Azure Container Registry |
| Kubernetes | AKS, Deployment, Service, probes, rollout status |
| CI/CD | GitHub Actions pipeline |
| Alternative CI/CD | Jenkins validation pipeline |
| Infrastructure as Code | Terraform staging infrastructure |
| Remote State | Azure Storage Terraform backend |
| Cloud Database | Azure SQL Database preparation |
| Release Management | Canary and blue-green deployment strategies |
| Monitoring | Health checks, Azure Monitor/Log Analytics planning, runbooks |
| Multi-Cloud Awareness | GCP Cloud Run and Artifact Registry proof of concept |
| Troubleshooting | Import issues, ImagePullBackOff, platform mismatch, stopped AKS deployment failures |
| Cost Awareness | AKS stop/start, Azure student plan cost control and budget guardrails |
| Documentation | README, runbooks, evidence docs, final proposal and team handover guide |

---

## 🛠️ Troubleshooting Notes

### `ModuleNotFoundError: No module named 'app.routes'; 'app' is not a package`

Cause:

```bash
python app/app.py
```

This can make Python treat `app/app.py` as a standalone script instead of the `app` package.

Fix:

```bash
python -m app.app
```

Run this from the repository root.

---

### Chatbot does not appear locally

Check that the Tidio script exists in:

```text
app/templates/base.html
```

Then confirm the page is loading from a template that extends `base.html`.

Also check browser privacy/ad-blocking extensions, because some extensions may block third-party chatbot widgets.

---

### Docker image works locally but fails on AKS

Possible cause: ARM image built from Mac instead of Linux AMD64.

Fix:

```bash
docker buildx build --platform linux/amd64 \
  -t <acr-login-server>/ecommerce-app:<tag> \
  -f app/Dockerfile . \
  --push
```

---

### GitHub Actions deployment fails but tests pass

Possible cause: AKS is stopped for cost control.

Fix:

```bash
az aks start --resource-group rg-capstone --name capstone-aks
```

Then re-run the workflow.

---

## 🔮 Future Improvements

- Fully integrate Azure SQL into the live Flask application
- Move product images to Azure Blob Storage
- Add HTTPS ingress with a custom domain
- Add Azure Front Door and Web Application Firewall
- Add Application Insights for application performance monitoring
- Add production-ready alerts for AKS, application health and deployment failures
- Add Redis caching for campaign traffic spikes
- Add Service Bus for decoupled order and notification workflows
- Add formal load testing with k6 or Azure Load Testing
- Add mobile chatbot screenshots and chatbot FAQ tuning notes
- Expand Tidio chatbot configuration with approved brand FAQs and escalation rules
- Expand the GCP proof of concept into a fuller disaster recovery design with database replication, DNS failover, monitoring and recovery testing
- Add payment, shipping and marketplace integrations for Southeast Asia expansion

---

## 👥 Team Handover Notes

Before running a deployment demo:

1. Pull the latest `main` branch.
2. Activate the virtual environment.
3. Run `python -m pytest -v` and confirm tests pass.
4. Start AKS if a live Azure demo is required.
5. Confirm the cluster is running.
6. Re-run the GitHub Actions workflow or push a new commit to `main`.
7. Confirm the pod is healthy.
8. Test `/`, `/health`, `/product/TSHIRT-001`, `/cart` and `/checkout`.
9. Check that the Tidio chatbot appears and opens on the website.
10. Capture screenshots as evidence if anything changed.
11. Stop AKS after testing to reduce cost.

---

## 📄 License

This project was created for a DevOps / Cloud Support capstone project.

---

Built as part of DevOps and Cloud Support Engineering training.

Last updated: June 2026
