import pytest

from app.app import create_app


@pytest.fixture
def client():
    app = create_app()
    app.config["TESTING"] = True

    with app.test_client() as client:
        yield client


def test_health_route_returns_ok(client):
    response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_homepage_loads(client):
    response = client.get("/")

    assert response.status_code == 200
    assert b"The Shirt Bar" in response.data


def test_product_detail_page_loads(client):
    response = client.get("/product/TSHIRT-001")

    assert response.status_code == 200
    assert b"Classic Oxford White Shirt" in response.data


def test_cart_page_loads(client):
    response = client.get("/cart")

    assert response.status_code == 200
    assert b"Shopping Cart" in response.data