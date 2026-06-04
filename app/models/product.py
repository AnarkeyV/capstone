# Temporary local testing version of product.py
# This allows the website to run without Azure SQL first.

SAMPLE_PRODUCTS = [
    {
        "product_id": "TSHIRT-001",
        "category_id": 1,
        "category_name": "Dress Shirts",
        "category_label": "Formal Shirts",
        "category": "formal",
        "name": "Classic Oxford White Shirt",
        "description": "Premium Egyptian cotton Oxford shirt with mother-of-pearl buttons. Features a tailored fit with French placket and split yoke for comfort. Ideal for Singapore's business casual environment.",
        "price": 89.00,
        "fabric_type": "100% Egyptian Cotton Oxford",
        "care_instructions": "Machine wash cold. Hang dry recommended. Low iron if needed.",
        "size_options": '["S","M","L","XL"]',
        "color_options": '["White","Light Blue"]',
        "image_url": "/static/images/products/classic-oxford-white-shirt.png",
        "stock_quantity": 25,
        "is_active": 1,
        "is_new": True,
        "is_bestseller": True,
        "sizes": ["S", "M", "L", "XL"],
        "colours": [
            {"name": "White", "hex": "#ffffff"},
            {"name": "Light Blue", "hex": "#a8c5da"}
        ],
    },
    {
        "product_id": "TSHIRT-002",
        "category_id": 1,
        "category_name": "Dress Shirts",
        "category_label": "Formal Shirts",
        "category": "formal",
        "name": "Premium Twill Blue Shirt",
        "description": "A refined blue twill shirt designed for all-day comfort. Breathable fabric and a crisp collar make it suitable for office wear and business meetings.",
        "price": 109.00,
        "fabric_type": "Cotton Twill",
        "care_instructions": "Machine wash cold. Hang dry recommended.",
        "size_options": '["S","M","L","XL"]',
        "color_options": '["Light Blue","Navy"]',
        "image_url": "/static/images/products/premium-twill-blue-shirt.png",
        "stock_quantity": 20,
        "is_active": 1,
        "is_new": False,
        "is_bestseller": True,
        "sizes": ["S", "M", "L", "XL"],
        "colours": [
            {"name": "Light Blue", "hex": "#a8c5da"},
            {"name": "Navy", "hex": "#1a2e4a"}
        ],
    },
    {
        "product_id": "TSHIRT-003",
        "category_id": 1,
        "category_name": "Dress Shirts",
        "category_label": "Formal Shirts",
        "category": "formal",
        "name": "Mandarin Collar Linen Shirt",
        "description": "A modern Asian-inspired shirt made with a breathable linen blend. Designed for Singapore's warm climate and smart casual occasions.",
        "price": 99.00,
        "fabric_type": "Linen Cotton Blend",
        "care_instructions": "Machine wash gentle. Hang dry.",
        "size_options": '["S","M","L","XL"]',
        "color_options": '["White","Sage"]',
        "image_url": "/static/images/products/mandarin-collar-linen-shirt.png",
        "stock_quantity": 18,
        "is_active": 1,
        "is_new": True,
        "is_bestseller": False,
        "sizes": ["S", "M", "L", "XL"],
        "colours": [
            {"name": "White", "hex": "#ffffff"},
            {"name": "Sage", "hex": "#8fad91"}
        ],
    },
]


class Product:
    @staticmethod
    def get_all(active_only=True):
        """Return local sample products for testing without Azure SQL."""
        if active_only:
            return [p for p in SAMPLE_PRODUCTS if p.get("is_active") == 1]
        return SAMPLE_PRODUCTS

    @staticmethod
    def get_by_id(product_id):
        """Return one local sample product by product_id."""
        for product in SAMPLE_PRODUCTS:
            if product["product_id"] == product_id:
                return product
        return None