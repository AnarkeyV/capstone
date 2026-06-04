# Terraform Infrastructure Reference

This folder contains a safe Terraform reference for The Shirt Bar capstone project.

The purpose is to show how the project can move toward **Infrastructure as Code (IaC)** without risking the existing working Azure deployment before final presentation.

---

## 1. Important Safety Note

This Terraform setup is intentionally written to read existing Azure resources using `data` sources.

It does **not** create, update, or delete Azure resources.

Do not run:

```bash
terraform apply
```

unless the team has reviewed the configuration and agreed to manage Azure infrastructure through Terraform.

---

## 2. Current Files

```text
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

| File | Purpose |
|---|---|
| `main.tf` | Configures the AzureRM provider and reads existing Azure resources |
| `variables.tf` | Stores project names and Azure resource names |
| `outputs.tf` | Displays useful information about the existing Azure resources |
| `README.md` | Explains how and why Terraform is included |

---

## 3. Existing Azure Resources Referenced

This Terraform reference reads the following existing resources:

| Resource | Name |
|---|---|
| Resource Group | `rg-capstone` |
| Azure Container Registry | `capstonereg047af007` |
| Azure Kubernetes Service | `capstone-aks` |

---

## 4. Setup Commands

From the repository root:

```bash
cd terraform
```

Initialise Terraform:

```bash
terraform init
```

Format the files:

```bash
terraform fmt
```

Validate syntax:

```bash
terraform validate
```

Preview what Terraform can read:

```bash
terraform plan
```

Because this folder uses only data sources, the plan should not show new Azure resources being created.

---

## 5. Why Terraform Is Useful

Terraform is useful because it allows cloud infrastructure to be written as code.

For this project, Terraform can eventually help the team manage:

- Resource Groups
- Azure Container Registry
- Azure Kubernetes Service
- Azure SQL Database
- Azure Storage Account
- Azure Key Vault
- Monitoring resources
- Staging and production environments

---

## 6. Why This Is Reference-Only for Now

The current Azure deployment is already working.

Changing live infrastructure before final presentation may create unnecessary risk, such as:

- Accidentally replacing resources
- Changing AKS settings
- Breaking GitHub Actions deployment
- Creating additional Azure cost
- Introducing state-management problems

For this reason, Terraform is included as a safe reference and future improvement.

---

## 7. Future Terraform Roadmap

Recommended future order:

1. Import existing Azure resources into Terraform state.
2. Store Terraform state remotely in Azure Storage.
3. Add Azure Storage Account for product images.
4. Add Key Vault for secrets.
5. Add Log Analytics and monitoring resources.
6. Add staging and production environments.
7. Add CI/CD workflow for Terraform plan review.

---

## 8. Presentation Explanation

Use this explanation during the final presentation:

```text
We added a Terraform folder to show how the project can move toward Infrastructure as Code. For safety, it currently reads existing Azure resources instead of changing them. This lets us demonstrate Terraform structure and future readiness without risking the working AKS deployment before presentation.
```

---

## 9. Final Recommendation

Terraform should be implemented gradually after the current application deployment and handover process are stable.

The next safe step would be to import existing Azure resources into Terraform state and store that state securely in Azure Storage.
