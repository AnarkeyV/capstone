# The Shirt Bar — Capstone Project

Cloud-native e-commerce platform for The Shirt Bar, a premium sustainable menswear brand based in Singapore.

## Tech Stack

- **Backend:** Python / Flask
- **Database:** Azure SQL Database
- **Payments:** Stripe (Test Mode)
- **Cloud:** Microsoft Azure
- **CI/CD:** GitHub Actions (planned)
- **IaC:** Terraform (planned)

## Local Setup

1. Clone the repository
2. Create virtual environment: `python3 -m venv venv`
3. Activate: `source venv/bin/activate`
4. Install dependencies: `pip install -r app/requirements.txt`
5. Copy `.env.example` to `.env` and fill in credentials
6. Run: `python app/app.py`

## Project Structure
capstone/
├── app/ # Flask application
│ ├── routes/ # Route blueprints
│ ├── models/ # Database models
│ ├── templates/ # Jinja2 HTML templates
│ └── static/ # CSS, JS, images
├── database/ # SQL schemas and seed data
├── tests/ # Unit tests
└── terraform/ # Infrastructure as Code
