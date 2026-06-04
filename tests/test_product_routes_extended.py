from app.app import create_app


def create_test_client():
    app = create_app()
    app.config["TESTING"] = True
    app.config["SECRET_KEY"] = "test-secret-key"

    return app.test_client()


def test_homepage_displays_multiple_products():
    client = create_test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert b"Classic Oxford White Shirt" in response.data
    assert b"Premium Twill Blue Shirt" in response.data
    assert b"Mandarin Collar Linen Shirt" in response.data


def test_product_detail_page_displays_product_options():
    client = create_test_client()

    response = client.get("/product/TSHIRT-001")

    assert response.status_code == 200
    assert b"Classic Oxford White Shirt" in response.data
    assert b"White" in response.data
    assert b"Light Blue" in response.data
    assert b"S" in response.data
    assert b"M" in response.data
    assert b"L" in response.data
    assert b"XL" in response.data


def test_invalid_product_returns_404():
    client = create_test_client()

    response = client.get("/product/INVALID-SKU")

    assert response.status_code == 404