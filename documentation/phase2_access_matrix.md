# Phase 2 Access Matrix

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Owner: Khairul Rizal  
Last Updated: 22-05-2026

---

## 1. Purpose of This Document

This document tracks which team members have access to the required tools for Phase 2 of the capstone project.

Phase 2 involves deploying the website to Azure, setting up CI/CD, using Azure SQL, Docker, Kubernetes, Terraform, Jenkins, Ansible, monitoring, and cost management.

This access matrix helps the team confirm that the correct people can access the correct platforms before deployment work begins.

---

## 2. Access Summary

| Team Member | Azure Resource Group Role | Azure DevOps Role | GitHub Access | Confirmed Access? | Notes |
|---|---|---|---|---|---|
| Khairul Rizal | Owner | Project Administrator | Admin/Maintainer | Yes | Project lead access verified |
| Terence | Contributor | Contributor | Contributor | Yes | Access confirmed for GitHub, Azure, and Azure DevOps |
| Peng Chou | Contributor | Contributor | Contributor | Yes | Access confirmed for GitHub, Azure, and Azure DevOps |
| Faith | Reader / Contributor | Reader / Contributor | Contributor | Yes | Access confirmed for GitHub, Azure, and Azure DevOps |

---

## 3. Azure Access Checklist

Each team member should confirm that they can:

- Open Azure Portal
- View the `rg-capstone` resource group
- See the AKS resource
- See the Azure Container Registry resource
- See any Azure SQL resources, if available
- View Cost Management or resource cost information, if permission allows

---

## 4. Azure DevOps Access Checklist

Each team member should confirm that they can:

- Open the Azure DevOps project
- View Pipelines
- View the service connection if required
- View project settings if they are an administrator
- View or run pipelines if assigned to deployment work

---

## 5. GitHub Access Checklist

Each team member should confirm that they can:

- Open the GitHub repository
- Pull the latest `main` branch
- Create a new branch
- Push their branch
- Create a Pull Request
- Review Pull Requests, if assigned

---

## 6. Role Explanation for Non-Technical Members

### Owner

Can manage Azure resources and assign access to other people. This role should be limited to the project lead or people responsible for managing access.

### Contributor

Can create, update, and delete resources inside the assigned scope. This is suitable for active technical team members who need to deploy or troubleshoot resources.

### Reader

Can view resources but cannot make changes. This is suitable for team members who only need to check resources or understand the setup.

### Project Administrator

Can manage Azure DevOps project settings, permissions, repositories, pipelines, and service connections.

### Contributor in Azure DevOps

Can work with code, pipelines, and project items, but does not have full admin control.

### GitHub Admin / Maintainer

Can manage the repository, branches, pull requests, collaborators, and repository settings.

### GitHub Contributor

Can work on code through branches and pull requests, depending on repository permissions.

---

## 7. Security Notes

- Do not share passwords or secret keys in GitHub.
- Do not commit `.env` files.
- Do not upload database passwords, Stripe secret keys, or service credentials into the repository.
- Do not give everyone Owner access unless necessary.
- Use Contributor for active deployment work.
- Use Reader for view-only access.
- Keep Stripe keys, database passwords, and service connection credentials private.
- Use pull requests for code changes instead of pushing directly to `main`.
- Review access again before final deployment.

---

## 8. Confirmation Log

| Date | Team Member | Platform Checked | Result | Notes |
|---|---|---|---|---|
| 22-05-2026 | Khairul Rizal | Azure / Azure DevOps / GitHub | Confirmed | Project lead access verified |
| 22-05-2026 | Terence | Azure / Azure DevOps / GitHub | Confirmed | Access verified |
| 22-05-2026 | Peng Chou | Azure / Azure DevOps / GitHub | Confirmed | Access verified |
| 22-05-2026 | Faith | Azure / Azure DevOps / GitHub | Confirmed | Access verified |

---

## 9. Access Review Notes

The team has confirmed that all members have the required access for Phase 2 project work.

Current confirmed platforms:

- GitHub repository access
- Azure Portal access
- Azure DevOps project access

This means the team can proceed with the next Phase 2 tasks:

- CSD-14 — Set Azure naming, tagging, and budget guardrails
- CSD-15 — Prepare Terraform baseline for Azure infrastructure
- CSD-16 — Configure Azure SQL connection, firewall, and secrets plan
- CSD-17 — Build Docker image and push to Azure Container Registry
- CSD-18 — Deploy Flask website to AKS
- CSD-19 — Set up GitHub and Azure DevOps release workflow
- CSD-24 — Add Jenkins pipeline for CI/CD demonstration

---

## 10. Completion Status

CSD-13 is considered complete when:

- All team members have confirmed Azure access.
- All team members have confirmed Azure DevOps access.
- All team members have confirmed GitHub access.
- This access matrix has been committed to the repository.
- No passwords, `.env` files, or secret keys have been committed.

Status: Completed  
Completed by: Khairul Rizal  
Completion Date: 22-05-2026