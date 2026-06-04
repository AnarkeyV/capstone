from app.app import create_app


def create_test_client():
    app = create_app()
    app.config["TESTING"] = True
    app.config["SECRET_KEY"] = "test-secret-key"

    return app.test_client()


def test_customer_can_browse_product_add_to_cart_and_checkout():
    client = create_test_client()

    homepage_response = client.get("/")
    assert homepage_response.status_code == 200
    assert b"The Shirt Bar" in homepage_response.data

    product_response = client.get("/product/TSHIRT-001")
    assert product_response.status_code == 200
    assert b"Classic Oxford White Shirt" in product_response.data

    add_to_cart_response = client.post(
        "/cart/add/TSHIRT-001",
        data={
            "size": "M",
            "color": "White",
            "quantity": "1",
        },
        follow_redirects=False,
    )
    assert add_to_cart_response.status_code == 302
    assert "/cart" in add_to_cart_response.headers["Location"]

    cart_response = client.get("/cart")
    assert cart_response.status_code == 200
    assert b"Classic Oxford White Shirt" in cart_response.data

    checkout_response = client.get("/checkout")
    assert checkout_response.status_code == 200
    assert b"Checkout" in checkout_response.data