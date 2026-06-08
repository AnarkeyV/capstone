# Tidio AI Chatbot Evidence

## Overview

The Shirt Bar prototype includes a **Tidio AI chatbot widget** embedded into the shared Flask base template.

The chatbot provides first-level customer assistance for product enquiries, styling questions, and general support guidance. It is intended to improve the customer experience by giving shoppers a quick support channel while they browse the online store.

This chatbot is implemented as a **third-party frontend widget**, not as a custom Flask backend chatbot service.

---

## Implementation Location

The chatbot script is located in:

```text
app/templates/base.html
```

The widget is loaded using a Tidio script tag:

```html
<script src="//code.tidio.co/jrfuhf8cartl4aukihog4mz5cm6gobib.js" async></script>
```

Because the script is placed inside `base.html`, the chatbot can appear across pages that extend the shared base template.

---

## Chatbot Type

| Item | Details |
|---|---|
| Chatbot platform | Tidio |
| Implementation type | Third-party frontend widget |
| Backend route required | No |
| Flask API changes required | No |
| Main template file | `app/templates/base.html` |
| Purpose | Customer assistance, product enquiry support, basic FAQ guidance |

---

## Pages Tested

The chatbot was tested locally on desktop across the main customer journey pages.

| Page | URL | Result |
|---|---|---|
| Homepage | `/` | Chatbot bubble visible |
| Product detail page | `/product/TSHIRT-001` | Chatbot available while viewing product information |
| Cart page | `/cart` | Chatbot available and does not block cart layout |
| Checkout page | `/checkout` | Chatbot available and does not block checkout layout |

---

## Manual Test Steps

The following manual checks were completed:

1. Started the Flask application locally.
2. Opened the website in a desktop browser.
3. Confirmed that the chatbot bubble appeared on the page.
4. Opened the chatbot window.
5. Sent a sample product enquiry.
6. Confirmed that the chatbot accepted the message and returned a response.
7. Checked that the chatbot did not break the homepage, product page, cart page, or checkout page.
8. Ran the automated test suite after chatbot verification.

---

## Sample Chatbot Test Question

```text
Do you have white shirts suitable for Singapore office wear?
```

This question was used to check whether the chatbot could respond to a realistic customer enquiry related to The Shirt Bar’s products and target market.

---

## Automated Test Result

After verifying the chatbot manually, the main application test suite was executed.

Result:

```text
All tests passed
```

This confirms that the chatbot addition did not break the existing Flask routes, product pages, cart flow, checkout pages, or health-check behaviour.

---

## Screenshot Evidence

The following screenshots should be stored in the project repository:

```text
documentation/screenshots/chatbot/chatbot-homepage-bubble.png
documentation/screenshots/chatbot/chatbot-window-opened.png
documentation/screenshots/chatbot/chatbot-sample-reply.png
```

Recommended screenshot descriptions:

| Screenshot | Purpose |
|---|---|
| `chatbot-homepage-bubble.png` | Shows the chatbot bubble visible on the homepage |
| `chatbot-window-opened.png` | Shows the chatbot window opened by the user |
| `chatbot-sample-reply.png` | Shows a sample chatbot response to a customer enquiry |

---

## Architecture Note

The Tidio chatbot should be shown in the architecture as a **third-party customer support widget connected to the Flask frontend**.

It should **not** be shown as a separate backend microservice inside AKS because the current implementation does not create a custom chatbot API or a dedicated chatbot container.

Recommended architecture label:

```text
Tidio AI Chatbot Widget
Third-party customer support assistant
Embedded in app/templates/base.html
```

Recommended connection:

```text
Flask E-Commerce Web App Frontend → Tidio AI Chatbot Widget
```

---

## Final Proposal Update Wording

### Project Overview

The latest prototype also includes a Tidio AI chatbot widget embedded into the shared website template. This provides a first-level customer assistance channel for product enquiries, styling questions, and basic support guidance.

### Software Employed

| Layer | Software / Service | Role | Reason |
|---|---|---|---|
| AI Customer Support | Tidio Chatbot | Frontend chatbot widget embedded in the Flask base template | Provides first-level customer assistance without building a custom chatbot backend |

### Testing

| Testing Type | Scope | Evidence / Outcome |
|---|---|---|
| Chatbot UI Testing | Confirm Tidio bubble appears on homepage, product page, cart, and checkout; test basic message/reply flow | Verifies chatbot does not break the main e-commerce journey |

### Support

Chatbot support includes periodic review of common customer questions, FAQ tuning, and escalation guidance so the widget remains useful during campaigns and product launches.

### Cost Structure

| Item | Description | Estimated Cost |
|---|---|---|
| AI Chatbot Setup & Configuration | Tidio widget configuration, FAQ setup, and testing | SGD 1,000–3,000 one-time setup; subscription depends on selected Tidio plan |

---

## Git Commands to Add Evidence

After placing the screenshots and this Markdown file into the project, run:

```bash
git status
git add documentation/screenshots/chatbot documentation/chatbot_tidio_evidence.md
git commit -m "docs: add Tidio chatbot evidence"
git push origin main
```

---

## Summary

The chatbot feature has been verified as a Tidio frontend widget embedded in the shared Flask template. It improves customer support by giving shoppers a quick first-level assistance channel while preserving the existing application structure.

The feature should be documented as an implemented customer support enhancement, while the architecture diagram should show it as an external third-party widget connected to the Flask frontend rather than as an internal AKS microservice.
