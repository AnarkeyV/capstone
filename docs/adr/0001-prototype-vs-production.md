# ADR 0001 - Capstone Prototype vs Production Launch

## Status

Accepted for final submission.

## Context

The project demonstrates a working e-commerce prototype and cloud deployment workflow for The Shirt Bar. It includes Flask, Docker, GitHub Actions, ACR, AKS, Terraform, testing, canary/blue-green release examples and GCP Cloud Run portability evidence.

A mentor sanity check confirmed that the project is strong as a capstone and academic deliverable, but should not be considered production-ready for real payments or customer personal data without further hardening.

## Decision

We will present the project as a working prototype and pilot-ready cloud architecture. We will clearly separate completed capstone evidence from production hardening work.

## Consequences

- The team can safely demonstrate the working website, payment outcome pages and DevOps workflow.
- The README and presentation will avoid overclaiming production readiness.
- Future production work will focus on Stripe webhook verification, Azure SQL persistence, HTTPS/WAF, Key Vault, OIDC CI/CD, monitoring and autoscaling.
