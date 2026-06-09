# Live Demo Checklist - Graduation Presentation

## Required demo proof points

1. Failed payment outcome
2. Successful payment outcome
3. Visible background change to prove the DevOps workflow

## Demo safety rule

Do not depend only on live cloud. Prepare both local and AKS paths. If AKS is stopped or slow, use the local app and explain that the same code is deployed through the CI/CD workflow.

## Terminal preparation

```bash
cd ~/Documents/capstone
source .venv/bin/activate
python -m pytest -v
python -m app.app
```

Open the app:

```text
http://localhost:5001
```

## Payment outcome demo

Open these pages directly if the Stripe session is not available during the presentation:

```text
http://localhost:5001/failed
http://localhost:5001/success
```

Suggested wording:

> This is a prototype payment outcome flow. The failed page shows what happens when payment is cancelled or unsuccessful. The success page shows the completed customer journey. In production, the success state would only be confirmed after Stripe webhook verification.

## Background-change demo

1. Open the homepage.
2. Open the CSS file used for the page background.
3. Make a small background colour or image change.
4. Save the file and refresh local browser.
5. Run tests.
6. Commit the change on a demo branch or show GitHub Actions evidence if not pushing live.

Example Git commands:

```bash
git checkout -b demo/background-change
git status
git add app/static/css/style.css
git commit -m "Demo visible background update"
git push origin demo/background-change
```

## Recovery plan

If the live update is slow, show:

- the local browser change,
- the Git commit,
- the GitHub Actions workflow page,
- the README evidence of AKS deployment.
