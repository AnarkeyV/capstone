[![CI/CD Pipeline](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml/badge.svg)](https://github.com/AnarkeyV/capstone/actions/workflows/deploy.yml)
[![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/flask-ecommerce-green.svg)](https://flask.palletsprojects.com/)
[![Docker](https://img.shields.io/badge/docker-supported-blue.svg)](https://www.docker.com/)
[![Azure](https://img.shields.io/badge/Azure-AKS%20%7C%20ACR%20%7C%20SQL-0078D4.svg)](https://azure.microsoft.com/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-deployed-326CE5.svg)](https://kubernetes.io/)
[![Status](https://img.shields.io/badge/project-release%20rehearsal%20passed-success.svg)](#release-rehearsal-result)

# 🛍️ The Shirt Bar — Cloud-Native E-Commerce Capstone Project

A cloud-native e-commerce platform for **The Shirt Bar**, a premium sustainable menswear brand based in Singapore.

This project demonstrates how a Flask-based online shop can be containerised, pushed to Azure Container Registry, deployed to Azure Kubernetes Service, connected to Azure SQL Database, and released through a GitHub Actions CI/CD workflow.

---

## 📋 Table of Contents

- [Live Deployment Evidence](#live-deployment-evidence)
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Azure Resources](#azure-resources)
- [Application Routes](#application-routes)
- [Local Development](#local-development)
- [Docker Build and Local Test](#docker-build-and-local-test)
- [Kubernetes Deployment](#kubernetes-deployment)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Azure SQL Databases](#azure-sql-databases)
- [Release Rehearsal Result](#release-rehearsal-result)
- [Cost Control](#cost-control)
- [Project Structure](#project-structure)
- [DevOps and Cloud Skills Demonstrated](#devops-and-cloud-skills-demonstrated)
- [Future Improvements](#future-improvements)

---

## 🌐 Live Deployment Evidence

The full shop application was successfully deployed and tested on **Azure Kubernetes Service (AKS)**.

| Item | Value |
|---|---|
| **AKS Image** | `capstonereg047af007.azurecr.io/ecommerce-app:v23` |
| **AKS Service** | `capstone-service` |
| **Deployment** | `capstone-app` |
| **Public Test IP** | `http://20.184.58.23` |
| **Final Result** | Full shop deployment verified successfully |

> **Cost note:** AKS may be stopped outside testing/demo periods to reduce Azure cost, so the public IP may not always be reachable.

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

Recommended screenshot files:

```text
documentation/screenshots/aks-homepage-v23.png
documentation/screenshots/aks-product-detail-v23.png
documentation/screenshots/aks-cart-v23.png
```

| Page | Screenshot |
|---|---|
| **Homepage** | `aks-homepage-v23.png` |
| **Product Detail** | `aks-product-detail-v23.png` |
| **Cart Page** | `aks-cart-v23.png` |

> These screenshots provide visual evidence that the deployed application was reachable through the AKS public IP and that the main shop pages loaded successfully.

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
| **AKS Deployment** | App deployed through Kubernetes Deployment and Service YAML |
| **ACR Integration** | Docker images pushed to Azure Container Registry |
| **CI/CD Workflow** | GitHub Actions builds, pushes, and deploys the app |
| **Release Runbook** | Handover and release rehearsal documented for team use |

---

## 🏗️ Architecture

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
         │ docker build + push
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
         │ public LoadBalancer
         ▼
┌────────────────────────────┐
│ The Shirt Bar Web App      │
│ Flask + Jinja2 + CSS       │
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
| CI/CD | GitHub Actions |
| Deployment | Kubernetes YAML |
| Cloud Platform | Microsoft Azure |
| Payment Integration | Stripe Test Mode |
| Documentation | Markdown, Runbooks |

---

## ☁️ Azure Resources

| Resource Type | Name |
|---|---|
| Resource Group | `rg-capstone` |
| AKS Cluster | `capstone-aks` |
| Azure Container Registry | `capstonereg047af007` |
| ACR Login Server | `capstonereg047af007.azurecr.io` |
| Kubernetes Deployment | `capstone-app` |
| Kubernetes Service | `capstone-service` |
| Public Service IP | `20.184.58.23` |
| Product Database | `tsb-products-db` |
| Orders Database | `tsb-orders-db` |

---

## 📡 Application Routes

| Route | Method | Description |
|---|---|---|
| `/` | `GET` | Main shop homepage and product listing |
| `/product/<sku>` | `GET` | Product detail page |
| `/cart` | `GET` | Shopping cart page |
| `/cart/add/<sku>` | `POST` | Add selected product to cart |
| `/health` | `GET` | Health endpoint for Kubernetes probes |

The `/health` route was added so Kubernetes liveness and readiness probes can confirm that the Flask application is running correctly.

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

This avoids the `ImagePullBackOff` issue caused by a platform mismatch.

---

## ☸️ Kubernetes Deployment

Kubernetes files are located in:

```text
kubernetes/
├── deployment.yaml
└── service.yaml
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

Check the public service:

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
4. Login to Azure Container Registry
5. Build Docker image for Linux AMD64
6. Push Docker image to ACR
7. Set AKS context
8. Apply Kubernetes deployment and service files
9. Wait for rollout status

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

## 🗄️ Azure SQL Databases

The project includes Azure SQL setup for product and order data.

| Database | Purpose |
|---|---|
| `tsb-products-db` | Product and category data |
| `tsb-orders-db` | Orders and order item data |

Database scripts and setup helpers are stored in:

```text
database/
```

---

## ✅ Release Rehearsal Result

A release rehearsal was completed as part of the handover process.

Final successful result:

- Docker image fixed to serve the full Flask shop app
- `/health` endpoint added for Kubernetes probes
- AKS successfully pulled and ran image `v23`
- Public LoadBalancer service returned `200 OK`
- Homepage loaded successfully
- Product detail page loaded successfully
- Cart page loaded successfully
- AKS was stopped after testing for cost control
- Release runbook was updated and merged

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

## 📁 Project Structure

```text
capstone/
├── app/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── routes/
│   ├── models/
│   ├── templates/
│   └── static/
├── database/
│   ├── generate_aeo.py
│   └── init_db.py
├── documentation/
│   └── phase2_release_rehearsal_handover_runbook.md
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md
```

---

## 📈 DevOps and Cloud Skills Demonstrated

| Skill Area | Tools / Practices |
|---|---|
| Version Control | Git, GitHub, pull requests, branch cleanup |
| CI/CD | GitHub Actions pipeline |
| Containerisation | Docker, Dockerfile, image tagging |
| Cloud Registry | Azure Container Registry |
| Kubernetes | AKS, Deployment, Service, probes, rollout status |
| Cloud Database | Azure SQL Database |
| Troubleshooting | ImagePullBackOff, Docker build context, platform mismatch |
| Release Management | Release rehearsal, runbook, handover notes |
| Cost Awareness | AKS stop/start and Azure cost control |

---

## 🔮 Future Improvements

- Add automated unit and integration tests
- Add product image uploads and storage using Azure Blob Storage
- Add HTTPS ingress with a custom domain
- Add monitoring dashboards for AKS and application metrics
- Add Terraform infrastructure as code
- Add staged environments for development, staging, and production
- Add canary or blue-green deployment strategy

---

## 👥 Team Handover Notes

Before running a deployment demo:

1. Start AKS.
2. Confirm the cluster is running.
3. Re-run the GitHub Actions workflow or push a new commit to `main`.
4. Confirm the pod is `1/1 Running`.
5. Test `/`, `/health`, `/product/TSHIRT-001`, and `/cart`.
6. Capture screenshots as evidence.
7. Stop AKS after testing to reduce cost.

---

## 📄 License

This project was created for a DevOps / Cloud Support capstone project.

---

Built as part of DevOps and Cloud Support Engineering training.

Last updated: June 2026
