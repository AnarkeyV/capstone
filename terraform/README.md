[![CI/CD Pipeline](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml/badge.svg)](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml)
[![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/flask-ecommerce-green.svg)](https://flask.palletsprojects.com/)
[![Docker](https://img.shields.io/badge/docker-supported-blue.svg)](https://www.docker.com/)
[![Azure](https://img.shields.io/badge/Azure-AKS%20%7C%20ACR%20%7C%20SQL-0078D4.svg)](https://azure.microsoft.com/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-deployed-326CE5.svg)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/terraform-IaC-7B42BC.svg)](https://www.terraform.io/)
[![GCP](https://img.shields.io/badge/GCP-Cloud%20Run%20POC-4285F4.svg)](https://cloud.google.com/run)
[![Status](https://img.shields.io/badge/project-final%20hardening%20updated-success.svg)](#final-project-status)

# 🛍️ The Shirt Bar — Cloud-Native E-Commerce Capstone Project

A cloud-native e-commerce prototype for **The Shirt Bar**, a premium sustainable menswear brand based in Singapore.

This project demonstrates how a Flask-based online shop can be containerised with Docker, tested with pytest, pushed to Azure Container Registry, deployed to Azure Kubernetes Service, automated through GitHub Actions, supported with Terraform staging infrastructure, documented with production hardening notes, and enhanced with a Tidio AI chatbot widget for first-level customer support.

The final update also includes client-facing website improvements, a mentor-led production-readiness sanity check, a clearer Terraform structure, Kubernetes hardening references, and a live demo flow for the capstone presentation.

---

## 📋 Table of Contents

- [Final Project Status](#final-project-status)
- [Executive Summary](#executive-summary)
- [Project Overview](#project-overview)
- [Prototype Scope vs Production Scope](#prototype-scope-vs-production-scope)
- [Key Features](#key-features)
- [Live Deployment Evidence](#live-deployment-evidence)
- [Screenshots and Evidence](#screenshots-and-evidence)
- [Architecture](#architecture)
- [High-Level Design Summary](#high-level-design-summary)
- [Tech Stack](#tech-stack)
- [Azure Resources](#azure-resources)
- [Application Routes](#application-routes)
- [Local Development](#local-development)
- [Automated Testing](#automated-testing)
- [Docker Build and Local Test](#docker-build-and-local-test)
- [Kubernetes Deployment](#kubernetes-deployment)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Terraform Infrastructure as Code](#terraform-infrastructure-as-code)
- [Terraform Remote Backend](#terraform-remote-backend)
- [Canary Deployment](#canary-deployment)
- [Blue-Green Deployment](#blue-green-deployment)
- [Azure SQL Preparation](#azure-sql-preparation)
- [Tidio AI Chatbot Evidence](#tidio-ai-chatbot-evidence)
- [Monitoring and Operational Evidence](#monitoring-and-operational-evidence)
- [GCP Cloud Run Backup-Cloud Proof of Concept](#gcp-cloud-run-backup-cloud-proof-of-concept)
- [Final Hardening Updates](#final-hardening-updates)
- [Known Production Gaps](#known-production-gaps)
- [Live Demo Guide](#live-demo-guide)
- [Cost Control](#cost-control)
- [Project Structure](#project-structure)
- [DevOps and Cloud Skills Demonstrated](#devops-and-cloud-skills-demonstrated)
- [Troubleshooting Notes](#troubleshooting-notes)
- [Future Improvements](#future-improvements)
- [Team Handover Notes](#team-handover-notes)
- [License](#license)

---

## ✅ Final Project Status

| Item | Status |
|---|---|
| Flask e-commerce application | Completed |
| Product listing and product detail pages | Completed |
| Customer-facing Collections page | Completed |
| Customer-facing About page | Completed |
| Cart and checkout routes | Completed |
| Success and failed payment outcome pages | Completed |
| Tidio AI chatbot widget | Completed and locally verified |
| Docker container build | Completed |
| Azure Container Registry image push | Completed |
| Azure Kubernetes Service deployment | Completed and verified |
| GitHub Actions CI/CD | Completed and passed after final hardening fix |
| Automated pytest suite | 26 tests passed |
| Kubernetes deployment | Verified with 2/2 pods running |
| Terraform staging infrastructure | Completed |
| Terraform remote backend | Completed |
| Terraform file structure cleanup | Completed |
| Canary deployment example | Completed and tested |
| Blue-green deployment example | Completed |
| Monitoring and health-check documentation | Completed |
| Azure SQL preparation | Completed / planned production integration |
| GCP Cloud Run proof of concept | Completed |
| Sanity check production-readiness review | Added |
| Final proposal documentation | Completed |

> **Current working branch for final updates:** `final-hardening-update`  
> **Main repository:** `https://github.com/AnarkeyV/capstone`  
> **Documentation status:** Updated after mentor sanity check, navigation improvements, Kubernetes rollout fix and successful GitHub Actions run.

---

## 🧾 Executive Summary

The Shirt Bar capstone project is a working cloud-native e-commerce prototype that demonstrates the full journey from application development to cloud deployment.

The project proves that a small retail e-commerce application can be:

- Built using Python Flask
- Organised into product, cart and checkout routes
- Tested using pytest
- Containerised with Docker
- Stored in Azure Container Registry
- Deployed to Azure Kubernetes Service
- Updated through GitHub Actions CI/CD
- Supported by Terraform infrastructure planning
- Demonstrated with safer release strategies such as canary and blue-green deployments
- Extended with a GCP Cloud Run portability proof of concept
- Documented with a realistic production hardening roadmap

This is a strong **capstone / proof-of-concept implementation**. It is not presented as a complete production payment system. Real production launch would require additional hardening such as Stripe webhook verification, Azure SQL order persistence, HTTPS/WAF, stronger secret management, OIDC-based deployment authentication and monitoring alerts.

---

## 📖 Project Overview

The Shirt Bar e-commerce application was built as a practical DevOps and Cloud Support capstone project.

The project focuses on:

- Building a Flask e-commerce web application
- Structuring the app with routes, templates, static assets and product models
- Adding product listing, product detail, collections, about, cart, checkout, success and failed-payment pages
- Adding a `/health` endpoint for Kubernetes probes and deployment validation
- Adding a Tidio AI chatbot widget for basic customer assistance and product enquiries
- Containerising the application using Docker
- Storing application images in Azure Container Registry
- Deploying the containerised application to Azure Kubernetes Service
- Automating test, build, push and deployment steps through GitHub Actions
- Preparing Azure SQL Database support for future product and order data persistence
- Creating Terraform-managed staging infrastructure
- Using Terraform remote backend storage for shared state management
- Demonstrating safer release strategies through canary and blue-green deployment examples
- Documenting monitoring, release rehearsal, production hardening and handover procedures
- Demonstrating multi-cloud container portability through a separate GCP Cloud Run proof of concept

---

## ⚖️ Prototype Scope vs Production Scope

This project is intentionally presented as a **working cloud prototype**, not a fully production-ready e-commerce system.

### What the prototype proves

| Area | Prototype Evidence |
|---|---|
| Website functionality | Product browsing, product details, cart, checkout, success and failed payment pages |
| Customer experience | Shop, Collections, About, Cart, Checkout and Tidio chatbot pages |
| Testing | 26 passing pytest tests |
| Containerisation | Docker image builds successfully |
| CI/CD | GitHub Actions runs tests, builds image, pushes to ACR and deploys to AKS |
| Kubernetes | AKS deployment confirmed with 2/2 pods running |
| Cloud readiness | Azure-first architecture with Terraform staging and Kubernetes manifests |
| Release safety | Canary and blue-green examples included |
| Portability | Same container demonstrated on GCP Cloud Run |
| Documentation | README, runbooks, hardening roadmap, sanity check and proposal materials |

### What production would still need

| Area | Production Requirement |
|---|---|
| Real payment confirmation | Stripe webhook signature verification before confirming orders |
| Order persistence | Azure SQL integration for cart, order and payment records |
| Secrets management | Azure Key Vault and workload identity instead of raw Kubernetes secrets |
| Secure public access | HTTPS, custom domain, Azure Front Door and WAF |
| Session integrity | Redis-backed server-side sessions instead of client-side cookies |
| Monitoring | Application Insights, Log Analytics alerts and operational dashboards |
| CI/CD security | GitHub Actions OIDC instead of long-lived credentials |
| Image security | Trivy, CodeQL, Dependabot, pip-audit and SBOM generation |
| Compliance | PDPA-ready privacy policy, retention rules and audit controls |

---

## ✨ Key Features

| Feature | Description |
|---|---|
| **Product Listing** | Homepage displays The Shirt Bar product collection |
| **Collections Page** | Client-facing page showing product categories with actual product images |
| **About Page** | Brand-focused page written for customers, not technical users |
| **Product Detail Page** | Individual product pages using product ID routes |
| **Shopping Cart** | Add-to-cart, update quantity, remove item and cart total flow |
| **Checkout Flow** | Checkout page and payment outcome screens for success and failure |
| **Flask Blueprints** | Routes split into product, cart and checkout modules |
| **Health Endpoint** | `/health` route supports Kubernetes probes and deployment validation |
| **AI Chatbot Widget** | Tidio chatbot embedded into the shared Flask base template |
| **Dockerised App** | Flask app packaged into a production-style container |
| **ACR Integration** | Docker images pushed to Azure Container Registry |
| **AKS Deployment** | App deployed through Kubernetes Deployment and Service YAML |
| **CI/CD Workflow** | GitHub Actions builds, tests, pushes and deploys the app |
| **Terraform Staging** | Infrastructure-as-code staging environment created with Terraform |
| **Remote Terraform Backend** | Azure Storage backend prepared for shared Terraform state |
| **Canary Deployment** | Canary promotion and rollback scripts created and tested |
| **Blue-Green Deployment** | Blue-green Kubernetes manifests prepared for safer releases |
| **Monitoring Assets** | Health checks, monitoring guide and operational runbooks documented |
| **GCP Cloud Run POC** | Same Dockerised app deployed to Google Cloud Run as a portability proof |
| **Production Hardening Review** | Mentor sanity check and roadmap added to the repository |

---

## 🌐 Live Deployment Evidence

The full shop application was successfully deployed and tested on **Azure Kubernetes Service (AKS)**.

| Item | Value |
|---|---|
| **Current AKS Image Source** | `capstonereg047af007.azurecr.io/ecommerce-app` |
| **Latest GitHub Actions Image Tag Example** | `v45` |
| **AKS Service** | `capstone-service` |
| **Deployment** | `capstone-app` |
| **Original Resource Group** | `rg-capstone` |
| **Original AKS Cluster** | `capstone-aks` |
| **Original ACR** | `capstonereg047af007` |
| **External IP** | `20.184.58.23` |
| **Final Deployment State** | `2/2` pods running |
| **Final Result** | GitHub Actions passed and AKS rollout verified |

> **Cost note:** AKS may be stopped outside testing/demo periods to reduce Azure cost, so the public endpoint may not always be reachable.

### Verified Routes

| Route | Result | Purpose |
|---|---:|---|
| `/` | `200 OK` | Shop homepage and product listing |
| `/health` | `200 OK` | Kubernetes health check |
| `/collections` | `200 OK` | Product collections page |
| `/about` | `200 OK` | Brand information page |
| `/product/TSHIRT-001` | `200 OK` | Product detail page |
| `/cart` | `200 OK` | Shopping cart page |
| `/checkout` | `200 OK` when cart has item | Checkout page |
| `/success` | `200 OK` | Successful payment outcome page |
| `/failed` | `200 OK` | Failed or cancelled payment outcome page |

---

## 📸 Screenshots and Evidence

Recommended evidence screenshots for final presentation:

| Evidence | Suggested Screenshot |
|---|---|
| GitHub Actions passed | Actions page showing successful workflow |
| AKS pods healthy | `kubectl get pods` showing 2 pods running |
| AKS deployment healthy | `kubectl get deployment capstone-app` showing `2/2` |
| LoadBalancer service | `kubectl get svc capstone-service` showing external IP |
| Homepage | Live homepage through AKS IP |
| Collections page | Product cards with images |
| About page | Brand-focused About page |
| Cart page | Product in cart |
| Checkout page | Checkout flow after adding item |
| Failed payment page | `/failed` outcome screen |
| Success payment page | `/success` outcome screen |

Existing screenshot folders:

```text
app/static/images/products/
documentation/screenshots/
documentation/screenshots/chatbot/
docs/images/
```

---

## 🏗️ Architecture

The project uses an Azure-first architecture with supporting DevOps automation and a GCP Cloud Run backup-cloud proof of concept.

### Azure Architecture Diagram

![The Shirt Bar Azure Architecture Diagram](docs/images/TheShirtBar_Azure_Architecture_Diagram.png)

### Simplified Deployment Flow

```text
Developer
   │
   │ git push
   ▼
GitHub Repository
   │
   │ triggers
   ▼
GitHub Actions CI/CD
   │
   ├── Run pytest tests
   ├── Build Docker image
   ├── Push image to Azure Container Registry
   └── Deploy Kubernetes manifests to AKS
          │
          ▼
Azure Kubernetes Service
   │
   ├── Deployment: capstone-app
   ├── Service: capstone-service
   └── Pods running Flask app
          │
          ▼
Customer browser
```

---

## 🧭 High-Level Design Summary

The high-level design shows how the major components connect without going too deeply into implementation details.

### Current deployed architecture

| Layer | Component | Purpose |
|---|---|---|
| Developer | VS Code, Git | Local development and source control |
| Repository | GitHub | Stores source code and triggers workflow |
| CI/CD | GitHub Actions | Runs tests, builds image, pushes to ACR and deploys to AKS |
| Testing | pytest | Validates application routes and customer flow |
| Container Registry | Azure Container Registry | Stores Docker images |
| Runtime | Azure Kubernetes Service | Runs the containerised Flask app |
| Application | Flask, Jinja, CSS | E-commerce website and customer pages |
| Service Exposure | Kubernetes LoadBalancer | Exposes website through public IP |
| Chatbot | Tidio widget | First-level customer assistance |
| IaC | Terraform | Creates and manages staging infrastructure |
| Backup-cloud POC | GCP Cloud Run | Demonstrates container portability |

### Recommended production direction

| Production Area | Recommended Enhancement |
|---|---|
| Entry protection | Azure Front Door + WAF + HTTPS |
| Traffic routing | Ingress controller with TLS |
| Scaling | HPA, cluster autoscaler and multi-node AKS |
| Availability | PodDisruptionBudget and multiple replicas |
| Secrets | Azure Key Vault + workload identity |
| Data | Azure SQL for products/orders, Redis for sessions/cart |
| Storage | Blob Storage for product images |
| Monitoring | Application Insights, Log Analytics, alerts |
| Security scanning | Trivy, CodeQL, Dependabot and pip-audit |
| Deployment security | GitHub Actions OIDC instead of long-lived secrets |

---

## 🛠️ Tech Stack

| Area | Technology |
|---|---|
| Backend | Python, Flask |
| Frontend | HTML, CSS, Jinja2 templates |
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
| Payment Integration | Stripe Test Mode / simulated outcome pages |
| Documentation | Markdown, runbooks, sanity check, final proposal |

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
| Public LoadBalancer IP | `20.184.58.23` |
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
| `/collections` | `GET` | Customer-facing collections page |
| `/about` | `GET` | Customer-facing brand page |
| `/product/<product_id>` | `GET` | Product detail page |
| `/cart` | `GET` | Shopping cart page |
| `/cart/add/<product_id>` | `POST` | Add selected product to cart |
| `/cart/update/<cart_key>` | `POST` | Update cart quantity |
| `/cart/remove/<cart_key>` | `POST` | Remove item from cart |
| `/checkout` | `GET` | Checkout page; redirects home if cart is empty |
| `/checkout/create-session` | `POST` | Creates checkout session / simulated order flow |
| `/success` | `GET` | Successful payment outcome page |
| `/failed` | `GET` | Failed or cancelled payment outcome page |
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

macOS / Linux:

```bash
source .venv/bin/activate
```

Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
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

> Avoid running `python app/app.py` from the repository root because Python may confuse `app/app.py` with the `app` package and produce an import error such as `'app' is not a package`.

---

## ✅ Automated Testing

Automated tests were added using `pytest`.

Test files are located in:

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

The tests validate:

| Test Area | Example Scope |
|---|---|
| Health check | `/health` returns `200 OK` and `{"status":"ok"}` |
| Homepage | Homepage loads The Shirt Bar content |
| Product detail | Valid product page loads correctly |
| Cart | Cart page and cart flows load correctly |
| Checkout | Checkout loads when cart has items and redirects when empty |
| Success and failed pages | Payment outcome pages load correctly |
| End-to-end shop flow | Customer can browse, add to cart and reach checkout |
| Product model | Product retrieval and fields are validated |

Run tests locally:

```bash
python -m pytest -v
```

Expected result:

```text
26 passed
```

Latest verified local result:

```text
26 passed in 0.45s
```

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
curl -i http://localhost:5002/collections
curl -i http://localhost:5002/about
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

Working command example:

```bash
docker buildx build --platform linux/amd64 \
  -t capstonereg047af007.azurecr.io/ecommerce-app:v45 \
  -f app/Dockerfile . \
  --push
```

This avoids `ImagePullBackOff` issues caused by platform mismatch.

---

## ☸️ Kubernetes Deployment

Kubernetes files are located in:

```text
kubernetes/
├── deployment.yaml
├── service.yaml
├── hpa.yaml
├── pdb.yaml
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

Check rollout:

```bash
kubectl rollout status deployment/capstone-app
```

Check deployed image:

```bash
kubectl describe deployment capstone-app | grep Image
```

Check service:

```bash
kubectl get svc capstone-service
```

Expected healthy state:

```text
NAME           READY   UP-TO-DATE   AVAILABLE
capstone-app   2/2     2            2
```

Expected pod state:

```text
NAME                            READY   STATUS
capstone-app-xxxxxxxxx-xxxxx    1/1     Running
capstone-app-xxxxxxxxx-xxxxx    1/1     Running
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

Important Docker build command pattern:

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

> The AKS cluster must be running before GitHub Actions can deploy to Kubernetes.

### Final CI/CD Verification

Final GitHub Actions passed after resolving:

1. A Kubernetes `runAsNonRoot` issue caused by a named image user.
2. An Azure Container Registry mismatch between original ACR and Terraform staging ACR.

Final verified AKS state:

```text
capstone-app   2/2   2   2
```

---

## 🧩 Terraform Infrastructure as Code

Terraform was added to demonstrate Infrastructure as Code for a staging environment.

Terraform files are located in:

```text
terraform/
├── versions.tf
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars.example
```

### Terraform File Purpose

| File | Purpose |
|---|---|
| `versions.tf` | Defines Terraform and provider version constraints |
| `providers.tf` | Defines Azure provider configuration |
| `main.tf` | Defines main Azure resources |
| `variables.tf` | Defines reusable input variables |
| `outputs.tf` | Prints useful resource outputs |
| `terraform.tfvars.example` | Example values for local/team use |

### Terraform Workflow

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
- Promotion of new image to stable
- Deletion of canary deployment after successful promotion
- Stable deployment remaining healthy

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

## 🗄️ Azure SQL Preparation

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

## 🤖 Tidio AI Chatbot Evidence

The prototype includes a **Tidio AI chatbot widget** embedded into the shared Flask base template.

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

> Important clarification: the chatbot is not a custom Flask backend service and it is not a separate AKS microservice. It is a third-party frontend widget embedded into the website.

### Pages Tested

| Page | Result |
|---|---|
| Homepage | Chatbot bubble visible |
| Collections page | Chatbot available |
| About page | Chatbot available |
| Product detail page | Chatbot available |
| Cart page | Chatbot available |
| Checkout page | Chatbot available |

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
| Log Analytics | Centralised logs and KQL queries |
| Application Insights | Application performance and request tracing |
| Alerts | Notification when uptime, deployment or performance thresholds fail |

---

## ☁️ GCP Cloud Run Backup-Cloud Proof of Concept

In addition to the main Azure AKS deployment, this project includes a separate Google Cloud Platform proof of concept.

The same Dockerised Flask e-commerce application was pushed to Google Artifact Registry and deployed to Google Cloud Run. This demonstrates that the application is portable across cloud providers because it is packaged as a container.

This GCP deployment is not a full disaster recovery setup. It is a backup-cloud proof of concept used to show that the application can run outside Azure with minimal changes.

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

## 🧪 Final Hardening Updates

A final mentor-led sanity check was added to the repository:

```text
sanity_check.md
```

This review identifies what is already strong and what must be improved before real production use.

### What was improved after the sanity check

| Improvement | Status |
|---|---|
| Added `sanity_check.md` to repository | Completed |
| Updated README to clarify prototype vs production scope | Completed |
| Added production hardening roadmap | Completed |
| Added live demo checklist | Completed |
| Split Terraform into clearer files | Completed |
| Added `terraform.tfvars.example` | Completed |
| Added Kubernetes HPA and PDB references | Completed |
| Improved Kubernetes container security context | Completed |
| Fixed deployment image registry mismatch | Completed |
| Added client-facing Collections page | Completed |
| Added client-facing About page | Completed |
| Fixed navbar links for Collections and About | Completed |
| Verified GitHub Actions and AKS rollout | Completed |

---

## ⚠️ Known Production Gaps

The following items are intentionally documented as future production work.

| Area | Gap | Production Direction |
|---|---|---|
| Payments | `/success` can be visited directly in prototype | Add Stripe webhook signature verification |
| Orders | Cart and order data not fully persisted to Azure SQL | Store orders in Azure SQL |
| Secrets | Kubernetes secrets used for demo | Move to Azure Key Vault + workload identity |
| Public endpoint | LoadBalancer HTTP used for demo | Add HTTPS, custom domain, Front Door and WAF |
| Sessions | Flask client-side sessions used | Move to Redis-backed sessions |
| CI/CD authentication | ACR credentials and kubeconfig used | Move to GitHub Actions OIDC |
| Monitoring | Health checks and docs exist | Add Application Insights alerts and dashboards |
| Security scanning | Not fully enforced in pipeline | Add CodeQL, Trivy, pip-audit and Dependabot |
| Compliance | Documentation stage only | Add PDPA data retention and privacy controls |

---

## 🎤 Live Demo Guide

Recommended final demo sequence:

### Demo 1 — Customer website flow

1. Open live website.
2. Show homepage.
3. Open Collections.
4. Open About.
5. Open a product page.
6. Add product to cart.
7. Go to cart.
8. Go to checkout.

### Demo 2 — Payment outcome flow

Show the two payment outcome pages:

```text
/failed
/success
```

Suggested explanation:

> This prototype demonstrates the customer-facing payment outcome flow. In production, successful payment confirmation would only happen after Stripe confirms the transaction through a verified webhook.

### Demo 3 — DevOps evidence

Show:

1. GitHub Actions passed.
2. `kubectl get pods` showing 2 running pods.
3. `kubectl get deployment capstone-app` showing `2/2`.
4. `kubectl get svc capstone-service` showing the public IP.

### Demo 4 — Optional live change

A small CSS background or style change can be shown locally, then explained as a change that would normally go through:

```text
Git commit → GitHub Actions → Docker build → ACR push → AKS deployment
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

Refresh kubeconfig:

```bash
az aks get-credentials --resource-group rg-capstone --name capstone-aks --overwrite-existing
```

Check deployment:

```bash
kubectl get pods
kubectl get deployment capstone-app
kubectl get svc capstone-service
```

Expected healthy state:

```text
capstone-app   2/2
```

> Do not delete resource groups, public IPs, ACRs or Terraform backend storage unless the team has confirmed that no further grading, demo or evidence collection is required.

---

## ⚠️ Important CI/CD Note: AKS Must Be Running for Deployment

The GitHub Actions workflow has two major parts:

1. **CI checks** — install dependencies, run tests, build the Docker image and push the image to ACR.
2. **CD deployment** — connect to AKS and apply the Kubernetes deployment.

If AKS is intentionally stopped for cost control, the CI stages can still pass, but the Kubernetes deployment stage may fail because GitHub Actions cannot reach the AKS API server.

This does not necessarily mean the code, tests, Docker image or pipeline build is broken.

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
│   ├── config.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── models/
│   ├── routes/
│   ├── static/
│   │   ├── css/
│   │   ├── js/
│   │   └── images/
│   │       └── products/
│   └── templates/
│       ├── base.html
│       ├── collections.html
│       ├── about.html
│       └── ...
├── ansible/
├── database/
├── docs/
│   ├── adr/
│   ├── images/
│   │   ├── TheShirtBar_Azure_Architecture_Diagram.png
│   │   ├── gcp-artifact-registry-image.png
│   │   ├── gcp-budget-alert.png
│   │   ├── gcp-cloud-run-health-route.png
│   │   ├── gcp-cloud-run-homepage.png
│   │   ├── gcp-cloud-run-service-page.png
│   │   └── gcp-cloud-run-url.png
│   ├── gcp-cloud-run-showcase.md
│   ├── live-demo-checklist.md
│   └── production-hardening-roadmap.md
├── documentation/
│   ├── chatbot_tidio_evidence.md
│   ├── monitoring_health_check_guide.md
│   ├── phase2_release_rehearsal_handover_runbook.md
│   └── screenshots/
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── hpa.yaml
│   ├── pdb.yaml
│   ├── canary/
│   └── blue-green/
├── monitoring/
├── scripts/
│   ├── canary_promote_or_rollback.sh
│   └── canary_rollback.sh
├── terraform/
│   ├── versions.tf
│   ├── providers.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── terraform-backend/
├── tests/
├── .github/
│   └── workflows/
│       ├── deploy.yml
│       └── deploy-oidc-template.yml
├── Jenkinsfile
├── azure-pipelines.yml
├── sanity_check.md
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
| Kubernetes | AKS, Deployment, Service, probes, rollout status, HPA/PDB references |
| CI/CD | GitHub Actions pipeline |
| Alternative CI/CD | Jenkins validation pipeline |
| Infrastructure as Code | Terraform staging infrastructure |
| Remote State | Azure Storage Terraform backend |
| Cloud Database | Azure SQL Database preparation |
| Release Management | Canary and blue-green deployment strategies |
| Monitoring | Health checks, Azure Monitor/Log Analytics planning, runbooks |
| Multi-Cloud Awareness | GCP Cloud Run and Artifact Registry proof of concept |
| Security Hardening | Non-root container context, PDB/HPA references, hardening roadmap |
| Troubleshooting | Import issues, ImagePullBackOff, runAsNonRoot, ACR mismatch, stopped AKS deployment failures |
| Cost Awareness | AKS stop/start, Azure student plan cost control and budget guardrails |
| Documentation | README, runbooks, evidence docs, final proposal, sanity check and team handover guide |

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

### `/checkout` redirects to homepage

This is expected when the cart is empty.

Correct flow:

```text
Homepage → Product → Add to Cart → Cart → Checkout
```

The checkout page only loads when the cart has at least one item.

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

### `runAsNonRoot` deployment error

Error example:

```text
container has runAsNonRoot and image has non-numeric user (appuser), cannot verify user is non-root
```

Cause:

Kubernetes could not verify that a named image user was non-root.

Fix:

Use numeric non-root IDs in `kubernetes/deployment.yaml`:

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  runAsGroup: 1000
  fsGroup: 1000
```

---

### `ImagePullBackOff` or `401 Unauthorized` from ACR

Error example:

```text
failed to authorize: 401 Unauthorized
```

Cause:

AKS is trying to pull from an ACR it does not have permission to access.

Fix:

Confirm the image registry in `kubernetes/deployment.yaml` matches the ACR attached to the active AKS cluster.

Original AKS should use:

```text
capstonereg047af007.azurecr.io
```

Terraform staging ACR is separate:

```text
capstonetfacr047af007.azurecr.io
```

---

### Wrong Kubernetes context

If `kubectl get pods` does not show capstone resources, check the current context:

```bash
kubectl config current-context
```

If it shows another project, such as a local `kind` cluster, switch back to AKS:

```bash
az aks get-credentials --resource-group rg-capstone --name capstone-aks --overwrite-existing
```

---

## 🔮 Future Improvements

- Fully integrate Azure SQL into the live Flask application
- Persist orders only after verified Stripe webhook confirmation
- Move product images to Azure Blob Storage and optionally serve through CDN
- Add HTTPS ingress with a custom domain
- Add Azure Front Door and Web Application Firewall
- Add Application Insights for application performance monitoring
- Add production-ready alerts for AKS, application health and deployment failures
- Add Redis caching for session/cart handling and campaign traffic spikes
- Add Service Bus for decoupled order and notification workflows
- Add formal load testing with k6 or Azure Load Testing
- Add CodeQL, Trivy, pip-audit and Dependabot into CI/CD
- Add image signing and SBOM generation
- Add privacy policy, cookie banner and PDPA data retention controls
- Expand Tidio chatbot configuration with approved brand FAQs and escalation rules
- Expand the GCP proof of concept into a fuller disaster recovery design with database replication, DNS failover, monitoring and recovery testing
- Add payment, shipping and marketplace integrations for Southeast Asia expansion

---

## 👥 Team Handover Notes

Before running a deployment demo:

1. Pull the latest branch.
2. Activate the virtual environment.
3. Run `python -m pytest -v` and confirm tests pass.
4. Start AKS if a live Azure demo is required.
5. Refresh kubeconfig with `az aks get-credentials`.
6. Confirm the cluster is running.
7. Re-run the GitHub Actions workflow or push a new commit.
8. Confirm the pods are healthy.
9. Test `/`, `/health`, `/collections`, `/about`, `/product/TSHIRT-001`, `/cart` and `/checkout`.
10. Check that the Tidio chatbot appears and opens on the website.
11. Capture screenshots as evidence if anything changed.
12. Stop AKS after testing to reduce cost.

### Final Presentation Checklist

```text
[ ] Start AKS
[ ] Confirm kubectl context is capstone-aks
[ ] Confirm pods are running
[ ] Confirm deployment is 2/2
[ ] Confirm LoadBalancer IP is available
[ ] Open live website
[ ] Test Collections and About
[ ] Add product to cart
[ ] Open checkout
[ ] Show failed payment outcome
[ ] Show success payment outcome
[ ] Show GitHub Actions passed
[ ] Stop AKS after presentation
```

---

## 📄 License

This project was created for a DevOps / Cloud Support capstone project.

---

Built as part of DevOps and Cloud Support Engineering training.

Last updated: June 2026
