from app.app import create_app


def create_test_client():
    app = create_app()
    app.config["TESTING"] = True
    app.config["SECRET_KEY"] = "test-secret-key"

    return app.test_client()


def test_add_to_cart_requires_size_and_color():
    client = create_test_client()

    response = client.post(
        "/cart/add/TSHIRT-001",
        data={"quantity": "1"},
        follow_redirects=False
    )

    assert response.status_code == 302
    assert "/product/TSHIRT-001" in response.headers["Location"]


def test_add_to_cart_with_valid_options_redirects_to_cart():
    client = create_test_client()

    response = client.post(
        "/cart/add/TSHIRT-001",
        data={
            "size": "M",
            "color": "White",
            "quantity": "1"
        },
        follow_redirects=False
    )

    assert response.status_code == 302
    assert "/cart" in response.headers["Location"]


def test_update_cart_quantity():
    client = create_test_client()

    with client.session_transaction() as session:
        session["cart"] = {
            "TSHIRT-001|M|White": {
                "product_id": "TSHIRT-001",
                "name": "Classic Oxford White Shirt",
                "price": 89.0,
                "quantity": 1,
                "size": "M",
                "color": "White",
                "image_url": ""
            }
        }

    response = client.post(
        "/cart/update/TSHIRT-001|M|White",
        data={"quantity": "2"},
        follow_redirects=False
    )

    assert response.status_code == 302
    assert "/cart" in response.headers["Location"]

    with client.session_transaction() as session:
        assert session["cart"]["TSHIRT-001|M|White"]["quantity"] == 2


def test_remove_from_cart():
    client = create_test_client()

    with client.session_transaction() as session:
        session["cart"] = {
            "TSHIRT-001|M|White": {
                "product_id": "TSHIRT-001",
                "name": "Classic Oxford White Shirt",
                "price": 89.0,
                "quantity": 1,
                "size": "M",
                "color": "White",
                "image_url": ""
            }
        }

    response = client.post(
        "/cart/remove/TSHIRT-001|M|White",
        follow_redirects=False
    )

    assert response.status_code == 302
    assert "/cart" in response.headers["Location"]

    with client.session_transaction() as session:
        assert session["cart"] == {}


def test_checkout_redirects_home_when_cart_empty():
    client = create_test_client()

    response = client.get("/checkout", follow_redirects=False)

    assert response.status_code == 302
    assert response.headers["Location"].endswith("/")


def test_checkout_loads_when_cart_has_items():
    client = create_test_client()

    with client.session_transaction() as session:
        session["cart"] = {
            "TSHIRT-001|M|White": {
                "product_id": "TSHIRT-001",
                "name": "Classic Oxford White Shirt",
                "price": 89.0,
                "quantity": 1,
                "size": "M",
                "color": "White",
                "image_url": ""
            }
        }

    response = client.get("/checkout")

    assert response.status_code == 200
    assert b"Checkout" in response.data


def test_success_page_clears_cart():
    client = create_test_client()

    with client.session_transaction() as session:
        session["cart"] = {
            "TSHIRT-001|M|White": {
                "product_id": "TSHIRT-001",
                "name": "Classic Oxford White Shirt",
                "price": 89.0,
                "quantity": 1,
                "size": "M",
                "color": "White",
                "image_url": ""
            }
        }
        session["latest_order"] = {
            "order_id": "TSB-TEST-001",
            "customer_email": "test@example.com",
            "order_items": list(session["cart"].values()),
            "order_total": 89.0
        }

    response = client.get("/success?order_id=TSB-TEST-001")

    assert response.status_code == 200

    with client.session_transaction() as session:
        assert session["cart"] == {}


def test_failed_page_loads():
    client = create_test_client()

    response = client.get("/failed?order_id=TSB-TEST-001")

    assert response.status_code == 200
    assert b"TSB-TEST-001" in response.data
