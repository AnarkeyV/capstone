import json

def get_product_aeo_graph(product, variants):
    """
    Constructs a structured schema map optimized for LLM scrapers and search bots.
    Accepts data dicts retrieved from the Azure SQL Database.
    """
    # 1. Structured Product Context Block
    product_schema = {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": f"https://shirtbar.com{product['Handle']}#product",
        "name": product["Title"],
        "description": product["BodyHTML"],
        "vendor": product["Vendor"],
        "offers": []
    }

    # 2. Map all structural database variants as active offers
    for v in variants:
        offer = {
            "@type": "Offer",
            "@id": f"https://shirtbar.com{product['Handle']}#variant-{v['VariantID']}",
            "sku": v["SKU"],
            "price": float(v["Price"]),
            "priceCurrency": v.get("PriceCurrency", "USD"),
            "availability": "https://schema.org" if v["StockQuantity"] > 0 else "https://schema.org",
            "itemCondition": "https://schema.org"
        }
        product_schema["offers"].append(offer)

    # 3. Conversational FAQ Context Block (Highly favored by modern AI search models)
    faq_schema = {
        "@context": "https://schema.org",
        "@type": "FAQPage",
        "mainEntity": [
            {
                "@type": "Question",
                "name": f"Does the {product['Title']} have multiple options?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": f"Yes, we support multiple variations across this product type. Current tracked options are managed via SKU mappings."
                }
            },
            {
                "@type": "Question",
                "name": f"Is shipping available for {product['Title']}?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "Yes, global shipping handles are available across our entire retail framework."
                }
            }
        ]
    }

    # Wrap both logical entities into a single clean structural graph
    unified_graph = {
        "@graph": [product_schema, faq_schema]
    }

    return json.dumps(unified_graph, indent=2)

# Quick Local DevOps Smoke Test
if __name__ == "__main__":
    sample_prod = {"Title": "Classic Blue Oxford", "Handle": "blue-oxford", "BodyHTML": "Premium 100% Cotton", "Vendor": "ShirtBar"}
    sample_vars = [{"VariantID": 101, "SKU": "SBAR-BLU-MD", "Price": 29.99, "StockQuantity": 15}]
    
    print("[*] Simulating AEO Engine Output JSON-LD:")
    print(get_product_aeo_graph(sample_prod, sample_vars))
