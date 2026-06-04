# Azure Blob Storage Future Plan

This document explains how The Shirt Bar e-commerce project can use **Azure Blob Storage** in a future production version.

The current capstone application already displays product images and product pages. For a real business deployment, product images should eventually be stored in cloud object storage instead of relying only on local static files inside the application container.

---

## 1. Purpose of This Future Improvement

The purpose of adding Azure Blob Storage is to make product image storage more scalable, reliable, and easier to manage.

In the current project, product images are handled as part of the application files. This is acceptable for a capstone demonstration, but it is not ideal for a production e-commerce business because images may change often and can increase the size of the application container.

Azure Blob Storage would allow product images to be stored separately from the application code.

---

## 2. Current Approach

Current simplified approach:

```text
Flask App Container
├── application code
├── templates
├── static files
└── product image references
```

This means the application and image assets are closely tied together.

If images need to be updated, the team may need to update the code repository, rebuild the Docker image, push the image to Azure Container Registry, and redeploy to AKS.

---

## 3. Future Azure Blob Storage Approach

Future recommended approach:

```text
Product Admin / Developer
        │
        ▼
Azure Blob Storage Container
        │
        ▼
Public or secured image URL
        │
        ▼
Flask Product Page
        │
        ▼
Customer Browser
```

Product images would be uploaded to Azure Blob Storage. The application would store or reference the image URL and display it on the product page.

---

## 4. Why Azure Blob Storage Is Useful

| Benefit | Explanation |
|---|---|
| **Scalability** | Blob Storage can store many product images without increasing the application container size. |
| **Separation of concerns** | Application code and product images are managed separately. |
| **Easier updates** | Product images can be changed without rebuilding the Flask Docker image. |
| **Cloud-native design** | Static assets are stored in a service designed for object storage. |
| **Future CDN support** | Images can later be delivered through Azure CDN or Front Door for faster loading. |
| **Cost control** | Blob Storage is usually cost-effective for static files such as images. |

---

## 5. Recommended Azure Resources

A future implementation may include:

| Azure Resource | Purpose |
|---|---|
| Azure Storage Account | Main storage resource |
| Blob Container | Stores product images |
| Azure CDN or Front Door | Optional future image delivery acceleration |
| Managed Identity or Access Key | Secure application access to Blob Storage |
| Azure Key Vault | Store secrets if access keys are used |

Recommended container name:

```text
product-images
```

Example image path:

```text
https://<storage-account-name>.blob.core.windows.net/product-images/classic-oxford-white-shirt.jpg
```

---

## 6. Image Access Options

There are two common access approaches.

### Option A — Public Read Access

Images are publicly readable by customers.

This is simple and works well for normal product images.

| Advantage | Disadvantage |
|---|---|
| Easy for product pages to load images | Anyone with the image URL can view the image |
| Simple for demo and public product assets | Not suitable for private documents or sensitive files |

### Option B — Private Container with Application Access

The container is private and the app uses secure access to retrieve or generate image URLs.

| Advantage | Disadvantage |
|---|---|
| More secure | More complex to configure |
| Better for restricted files | Requires credentials, managed identity, or SAS tokens |

For The Shirt Bar product images, **public read access or CDN-backed public image delivery** would usually be acceptable because product images are intended to be seen by customers.

---

## 7. Recommended Production Flow

A production-ready flow may look like this:

1. Product image is uploaded to Azure Blob Storage.
2. The image URL is saved in the product database.
3. Flask retrieves the product data from the database.
4. Flask renders the product page with the image URL.
5. Customer browser loads the image from Blob Storage or CDN.

```text
Azure SQL Product Table
        │ image_url
        ▼
Flask Product Route
        │
        ▼
Jinja2 Product Template
        │
        ▼
Customer Browser loads image from Blob Storage
```

---

## 8. Example Database Field

The product table can store an image URL field:

```sql
image_url NVARCHAR(500)
```

Example value:

```text
https://<storage-account-name>.blob.core.windows.net/product-images/classic-oxford-white-shirt.jpg
```

This matches the current application direction because the cart already stores and passes `image_url` values in the session.

---

## 9. Example Flask Usage

A product dictionary may include:

```python
product = {
    "id": "TSHIRT-001",
    "name": "Classic Oxford White Shirt",
    "price": 89.00,
    "image_url": "https://<storage-account-name>.blob.core.windows.net/product-images/classic-oxford-white-shirt.jpg"
}
```

A Jinja2 template can display it using:

```html
<img src="{{ product.image_url }}" alt="{{ product.name }}">
```

This keeps the application simple because the browser loads the image directly from Blob Storage.

---

## 10. Security Considerations

For production, the team should consider:

- Whether images should be public or private
- Whether upload access should be restricted
- Whether storage access keys should be stored in Azure Key Vault
- Whether Managed Identity can be used instead of secrets
- Whether uploaded files should be validated before storage
- Whether image file size limits should be enforced
- Whether only safe image file types should be accepted

Recommended safe image file types:

```text
.jpg
.jpeg
.png
.webp
```

---

## 11. Cost Considerations

Azure Blob Storage is usually cost-effective for storing static files, but cost still depends on:

- Number of images
- Total storage size
- Number of customer image requests
- Data transfer volume
- Whether CDN or Front Door is added later

For this capstone project, Blob Storage is documented as a future improvement instead of being added immediately to avoid unnecessary cloud cost and deployment risk.

---

## 12. Why This Was Not Implemented Immediately

This improvement was kept as a future plan because the current project priority is to maintain a stable working deployment.

Adding Blob Storage immediately would require:

- Creating a Storage Account
- Creating a Blob container
- Adding Azure SDK dependencies
- Managing access keys or identity
- Updating product image paths
- Testing image upload and retrieval
- Updating deployment secrets
- Retesting the AKS deployment

Since the application is already successfully deployed and tested, adding this now may introduce unnecessary risk before the final presentation.

---

## 13. Suggested Future Implementation Steps

A future team can implement this in phases.

### Phase 1 — Create Azure Storage Account

Create a storage account in the same Azure region as the project:

```text
Southeast Asia
```

### Phase 2 — Create Blob Container

Create a container named:

```text
product-images
```

### Phase 3 — Upload Sample Product Images

Upload product images such as:

```text
classic-oxford-white-shirt.jpg
linen-casual-shirt.jpg
business-blue-shirt.jpg
```

### Phase 4 — Update Product Data

Update the product records so `image_url` points to Blob Storage URLs.

### Phase 5 — Update Flask Templates

Ensure templates use:

```html
<img src="{{ product.image_url }}" alt="{{ product.name }}">
```

### Phase 6 — Test Locally

Run:

```bash
python -m pytest
```

Then manually check product pages.

### Phase 7 — Build and Deploy

Build and deploy using the existing GitHub Actions pipeline.

---

## 14. Future Architecture With Blob Storage

```text
Customer Browser
      │
      ├── loads web page from AKS
      │
      ▼
Azure Kubernetes Service
      │
      ├── Flask product route reads product data
      │
      ▼
Azure SQL Database
      │
      └── product record includes image_url
      │
      ▼
Customer Browser
      │
      └── loads product image from Azure Blob Storage
```

This architecture is more production-ready because application compute, database records, and static image storage are separated.

---

## 15. Demo Explanation

Use this explanation during presentation:

```text
For the current capstone, product images are kept simple so the application remains stable for deployment. In a production version, we would move product images to Azure Blob Storage. This separates images from the application container, reduces rebuilds when images change, and prepares the platform for CDN integration.
```

---

## 16. Final Recommendation

Azure Blob Storage is recommended as a future improvement for The Shirt Bar because it supports a more scalable and maintainable e-commerce architecture.

It should be implemented after the current deployment, testing, and handover process is stable.
