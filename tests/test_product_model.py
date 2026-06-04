from app.models.product import Product, SAMPLE_PRODUCTS


def test_get_all_returns_active_products_only_by_default():
    products = Product.get_all()

    assert len(products) > 0
    assert all(product["is_active"] == 1 for product in products)


def test_get_all_can_return_all_products():
    products = Product.get_all(active_only=False)

    assert products == SAMPLE_PRODUCTS
    assert len(products) == len(SAMPLE_PRODUCTS)


def test_get_by_id_returns_correct_product():
    product = Product.get_by_id("TSHIRT-001")

    assert product is not None
    assert product["product_id"] == "TSHIRT-001"
    assert product["name"] == "Classic Oxford White Shirt"
    assert product["price"] == 89.00


def test_get_by_id_returns_none_for_invalid_product():
    product = Product.get_by_id("INVALID-SKU")

    assert product is None


def test_products_have_required_ecommerce_fields():
    required_fields = {
        "product_id",
        "name",
        "description",
        "price",
        "image_url",
        "stock_quantity",
        "sizes",
        "colours",
        "is_active",
    }

    for product in Product.get_all():
        assert required_fields.issubset(product.keys())
        assert product["price"] > 0
        assert product["stock_quantity"] >= 0
        assert len(product["sizes"]) > 0
        assert len(product["colours"]) > 0