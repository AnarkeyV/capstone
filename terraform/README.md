# Terraform Infrastructure

This folder contains Terraform configuration for The Shirt Bar capstone infrastructure.

This version moves beyond reference-only Terraform by defining actual Azure resources for a future staging-style environment.

---

## 1. Safety Note

Do not run `terraform apply` until the team has reviewed the Terraform plan.

Start with:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Only proceed to `terraform apply` after checking the plan carefully.

---

## 2. What This Terraform Creates

This Terraform configuration defines:

| Resource | Purpose |
|---|---|
| Azure Resource Group | Container for the future Terraform-managed environment |
| Azure Container Registry | Stores Docker images |
| Azure Kubernetes Service | Runs the Flask e-commerce application |
| Log Analytics Workspace | Stores AKS monitoring logs and metrics |
| AKS OMS Agent | Connects AKS to Log Analytics |
| Storage Account | Future product image storage |
| Blob Container | Future `product-images` container |
| AcrPull Role Assignment | Allows AKS to pull images from ACR |

---

## 3. Why This Uses New Resource Names

The existing working Azure resources should not be modified suddenly before final review.

This Terraform version uses separate default names such as:

```text
rg-capstone-tf-staging
capstone-aks-tf-staging
capstonetfacr047af007
law-capstone-tf-staging
tsbproductimg047af007
```

This avoids accidentally changing the existing working AKS deployment.

---

## 4. Commands

Go into the Terraform folder:

```bash
cd terraform
```

Initialise Terraform:

```bash
terraform init
```

Format files:

```bash
terraform fmt
```

Validate files:

```bash
terraform validate
```

Preview the plan:

```bash
terraform plan
```

Return to repo root:

```bash
cd ..
```

---

## 5. Important Cost Warning

Creating AKS and Log Analytics resources may create Azure cost.

Only run `terraform apply` after the team agrees and understands the cost impact.

---

## 6. Future Improvements

After this Terraform structure is reviewed, the team can later add:

- Azure SQL Database
- Azure Key Vault
- Azure Monitor dashboard resources
- Kubernetes namespaces
- Ingress controller
- Staging and production variable files
- Remote Terraform state in Azure Storage
