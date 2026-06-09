# Production Hardening Roadmap - The Shirt Bar Capstone

This document translates the final sanity check into a practical improvement roadmap.

## Current position

The capstone is a strong working prototype. It proves the storefront, route testing, Docker image build, ACR image storage, AKS deployment, GitHub Actions workflow, Terraform staging resources, release strategies and GCP portability proof of concept.

It should not be described as a finished production store for real payment and customer personal data until the items below are completed.

## Phase 0 - Safe final-submission improvements

- Keep `sanity_check.md` in the repository as review evidence.
- Split Terraform into `versions.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf` and `terraform.tfvars.example`.
- Remove `external-ip.txt` and ignore it in `.gitignore`.
- Add `/healthz` and `/readyz` routes.
- Add `pdb.yaml` and `hpa.yaml` as production-readiness manifests.
- Update README to explain prototype scope vs production roadmap.

## Phase 1 - Before real public go-live

- Add Stripe webhook signature verification.
- Persist orders and order status in Azure SQL.
- Replace client-side session cart with Redis or server-side storage.
- Add HTTPS, Ingress and Azure Front Door/WAF.
- Move secrets to Azure Key Vault with Workload Identity/CSI driver.
- Migrate CI/CD from long-lived secrets to GitHub OIDC.
- Add CSRF protection and rate limiting.
- Add Application Insights and Azure Monitor alerts.

## Phase 2 - Operational maturity

- Add CodeQL, Trivy, Bandit, pip-audit and Dependabot.
- Add load testing with k6 or Azure Load Testing.
- Add structured JSON logs.
- Add NetworkPolicy, namespace separation, ResourceQuota and LimitRange.
- Add backup and disaster-recovery procedures.
- Decide on one canonical CI/CD pipeline.

## Suggested client wording

> The project is ready as a capstone prototype and pilot validation platform. For a real public launch, we recommend a hardening phase covering verified payments, database persistence, HTTPS/WAF, secret management, monitoring and release resilience.
