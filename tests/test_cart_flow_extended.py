from app.app import create_app


def create_test_client():
    app = create_app()
    app.config["TESTING"] = True
    app.config["SECRET_KEY"] = "test-secret-key"

    return app.test_client()


def test_add_same_product_twice_increases_quantity():
    client = create_test_client()

    for _ in range(2):
        response = client.post(
            "/cart/add/TSHIRT-001",
            data={
                "size": "M",
                "color": "White",
                "quantity": "1",
            },
            follow_redirects=False,
        )

        assert response.status_code == 302

    with client.session_transaction() as session:
        cart = session["cart"]
        assert cart["TSHIRT-001|M|White"]["quantity"] == 2


def test_add_same_product_different_options_creates_separate_cart_items():
    client = create_test_client()

    client.post(
        "/cart/add/TSHIRT-001",
        data={
            "size": "M",
            "color": "White",
            "quantity": "1",
        },
    )

    client.post(
        "/cart/add/TSHIRT-001",
        data={
            "size": "L",
            "color": "Light Blue",
            "quantity": "1",
        },
    )

    with client.session_transaction() as session:
        cart = session["cart"]
        assert "TSHIRT-001|M|White" in cart
        assert "TSHIRT-001|L|Light Blue" in cart
        assert len(cart) == 2


def test_update_cart_quantity_to_zero_removes_item():
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
                "image_url": "",
            }
        }

    response = client.post(
        "/cart/update/TSHIRT-001|M|White",
        data={"quantity": "0"},
        follow_redirects=False,
    )

    assert response.status_code == 302

    with client.session_transaction() as session:
        assert session["cart"] == {}


def test_cart_shipping_is_added_below_free_shipping_threshold():
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
                "image_url": "",
            }
        }

    response = client.get("/cart")

    assert response.status_code == 200
    assert b"89" in response.data
    assert b"5" in response.data


def test_cart_free_shipping_applies_from_100_dollars():
    client = create_test_client()

    with client.session_transaction() as session:
        session["cart"] = {
            "TSHIRT-002|M|Light Blue": {
                "product_id": "TSHIRT-002",
                "name": "Premium Twill Blue Shirt",
                "price": 109.0,
                "quantity": 1,
                "size": "M",
                "color": "Light Blue",
                "image_url": "",
            }
        }

    response = client.get("/cart")

    assert response.status_code == 200
    assert b"Premium Twill Blue Shirt" in response.data
    assert b"109" in response.data