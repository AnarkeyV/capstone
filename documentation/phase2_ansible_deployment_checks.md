# Phase 2 Ansible Deployment Checks Documentation

Project: The Shirt Bar E-Commerce Capstone  
Resource Group: rg-capstone  
Phase: Phase 2 — Azure Deployment and Cloud Readiness  
Task: CSD-20 — P2-8 Add Ansible Scripts for Deployment Checks  
Owner: Khairul Rizal  
Last Updated: 02-06-2026

---

## 1. Purpose of This Document

This document records the Ansible deployment check setup for The Shirt Bar e-commerce capstone project.

The purpose of this task is to add a simple, repeatable Ansible check that can confirm whether the deployed website is reachable after deployment.

For this capstone project, Ansible is being used for **post-deployment validation**, not for full server configuration or full application deployment.

---

## 2. Scope

This document covers:

- Creating an Ansible folder
- Creating a local Ansible inventory
- Creating a deployment health check playbook
- Running the playbook against the deployed AKS website
- Verifying that the website returns a successful HTTP response
- Documenting how teammates can run the same check safely

This document does **not** include passwords, Azure secrets, database credentials, ACR passwords, or Kubernetes secret values.

---

## 3. Why Ansible Is Used Here

Ansible helps automate repeated operational checks.

Instead of manually opening the website every time and guessing whether deployment is working, the team can run one command to check whether the website responds correctly.

For this project, Ansible gives the team a simple way to demonstrate:

- Automation
- Repeatable operational checks
- Post-deployment validation
- Basic DevOps workflow understanding

---

## 4. Current AKS Service Information

The deployed application is exposed through an AKS LoadBalancer service.

| Item | Value |
|---|---|
| AKS Cluster | `capstone-aks` |
| Resource Group | `rg-capstone` |
| Kubernetes Service | `capstone-service` |
| Service Type | `LoadBalancer` |
| External IP | `20.184.58.23` |
| Application URL | `http://20.184.58.23` |
| Service Port | `80` |

The Ansible playbook checks the deployed website through:

    http://20.184.58.23

---

## 5. Ansible Installation

Ansible was installed inside the local Python virtual environment.

The installation was verified using:

    ansible --version

Initial result before installation:

    command not found: ansible

Ansible was then installed using:

    python -m pip install ansible

After installation, Ansible was available from the terminal.

---

## 6. Files Created

| File | Purpose |
|---|---|
| `ansible/inventory.ini` | Defines where Ansible should run the checks |
| `ansible/deployment_check.yml` | Runs the website health check |
| `documentation/phase2_ansible_deployment_checks.md` | Documents the Ansible setup and result |

---

## 7. Inventory File

File created:

    ansible/inventory.ini

Content:

    [local]
    localhost ansible_connection=local

### Explanation

This inventory tells Ansible to run the playbook from the local laptop.

The project does not require SSH access to a remote server for this check.

This is suitable for the capstone because the playbook is only checking whether the deployed website is reachable.

---

## 8. Inventory Test

The inventory was tested using:

    ansible all -i ansible/inventory.ini -m ping

Expected result:

    localhost | SUCCESS

Actual result:

    localhost | SUCCESS

This confirms that Ansible can run commands locally using the inventory file.

---

## 9. Deployment Check Playbook

File created:

    ansible/deployment_check.yml

Content:

    ---
    - name: The Shirt Bar deployment health check
      hosts: local
      gather_facts: false

      vars:
        app_url: "http://20.184.58.23"

      tasks:
        - name: Show target website URL
          ansible.builtin.debug:
            msg: "Checking website at {{ app_url }}"

        - name: Check if website is reachable
          ansible.builtin.uri:
            url: "{{ app_url }}"
            method: GET
            return_content: false
            status_code:
              - 200
              - 301
              - 302
            timeout: 15
          register: website_check

        - name: Show website check result
          ansible.builtin.debug:
            msg: "Website responded with HTTP status {{ website_check.status }}"

---

## 10. What the Playbook Does

| Step | Description |
|---|---|
| Show target website URL | Prints the website URL being checked |
| Check if website is reachable | Sends an HTTP GET request to the deployed website |
| Show website check result | Prints the returned HTTP status code |

The accepted HTTP status codes are:

| Status Code | Meaning |
|---|---|
| `200` | Website responded successfully |
| `301` | Website redirected permanently |
| `302` | Website redirected temporarily |

For this test, the deployed website returned:

    HTTP status 200

This means the website was reachable successfully.

---

## 11. How to Run the Playbook

From the project root folder, activate the Python virtual environment if needed:

    source .venv/bin/activate

Then run:

    ansible-playbook -i ansible/inventory.ini ansible/deployment_check.yml

Expected result:

    failed=0

Actual result:

    failed=0

The playbook also showed:

    Website responded with HTTP status 200

---

## 12. Result Summary

The Ansible deployment check succeeded.

| Check | Result |
|---|---|
| Ansible installed | Completed |
| Local inventory created | Completed |
| Inventory test succeeded | Completed |
| Deployment check playbook created | Completed |
| AKS external IP confirmed | Completed |
| Website health check completed | Completed |
| Website returned HTTP 200 | Completed |
| Secrets stored in Ansible files | No secrets stored |

---

## 13. Notes About the Python Interpreter Warning

During the playbook run, Ansible displayed a Python interpreter warning.

This warning is not a task failure.

The playbook result still showed:

    failed=0

This means the Ansible deployment check completed successfully.

For this capstone task, no further action is required for that warning.

---

## 14. Security Notes

No secrets are stored in the Ansible files.

The Ansible files do not include:

- SQL admin password
- ACR password
- Stripe secret key
- Azure service principal secret
- Kubernetes secret values
- Full database connection string

The playbook only checks the public website URL.

---

## 15. Completion Criteria for CSD-20

CSD-20 is considered complete when:

- An Ansible folder exists.
- A local inventory file exists.
- A deployment check playbook exists.
- The playbook can be run by a team member.
- The playbook checks the deployed website.
- The website returns a successful HTTP response.
- The purpose of Ansible is documented.
- No secrets are stored in Ansible files.

Current progress:

| Requirement | Status |
|---|---|
| Ansible installed | Completed |
| `ansible/inventory.ini` created | Completed |
| `ansible/deployment_check.yml` created | Completed |
| Inventory test completed | Completed |
| Website health check completed | Completed |
| Website returned HTTP 200 | Completed |
| Documentation created | Completed |
| Documentation committed to GitHub | Pending |

Status: In Progress — Ansible files and documentation completed; GitHub commit and pull request pending  
Prepared by: Khairul Rizal  
Target Completion Date: 02-06-2026

---

## 16. Suggested Commit Message

Suggested Git commit message:

    Add Ansible deployment health check

---

## 17. Handover Notes

Team members can run the Ansible check after deployment to confirm that the website is reachable.

Command:

    ansible-playbook -i ansible/inventory.ini ansible/deployment_check.yml

If the result shows:

    failed=0

and:

    Website responded with HTTP status 200

then the website is reachable from the local machine running the check.
