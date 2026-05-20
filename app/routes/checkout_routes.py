from flask import Blueprint, render_template, redirect, url_for, session, request, current_app
import stripe
import uuid
from datetime import datetime

checkout_bp = Blueprint("checkout", __name__)


def generate_order_id():
    """Generate unique order ID: TSB-YYYYMMDD-XXXXXX"""
    date_part = datetime.now().strftime("%Y%m%d")
    random_part = uuid.uuid4().hex[:6].upper()
    return f"TSB-{date_part}-{random_part}"


@checkout_bp.route("/checkout", methods=["GET"])
def checkout():
    cart = session.get("cart", {})

    if not cart:
        return redirect(url_for("product.home"))

    subtotal = sum(item["price"] * item["quantity"] for item in cart.values())
    shipping = 0 if subtotal >= 100 else 5
    total = subtotal + shipping

    return render_template(
        "checkout.html",
        cart=cart,
        cart_items=list(cart.values()),
        subtotal=subtotal,
        shipping=shipping,
        discount=0,
        total=total
    )


@checkout_bp.route("/checkout/create-session", methods=["POST"])
def create_checkout_session():
    stripe.api_key = current_app.config["STRIPE_SECRET_KEY"]

    cart = session.get("cart", {})

    if not cart:
        return redirect(url_for("product.home"))

    # Customer details from checkout form
    first_name = request.form.get("first_name", "")
    last_name = request.form.get("last_name", "")
    customer_name = f"{first_name} {last_name}".strip()
    customer_email = request.form.get("email")
    address = request.form.get("address")
    city = request.form.get("city")
    postal_code = request.form.get("postal_code")
    country = request.form.get("country", "SG")

    order_id = generate_order_id()

    line_items = []

    for item in cart.values():
        line_items.append({
            "price_data": {
                "currency": "sgd",
                "product_data": {
                    "name": item["name"],
                    "description": f"Size: {item['size']} | Colour: {item['color']}",
                },
                "unit_amount": int(item["price"] * 100),
            },
            "quantity": item["quantity"],
        })

    try:
        checkout_session = stripe.checkout.Session.create(
            payment_method_types=["card"],
            line_items=line_items,
            mode="payment",
            customer_email=customer_email,
            success_url=url_for(
                "checkout.success",
                order_id=order_id,
                _external=True
            ),
            cancel_url=url_for(
                "checkout.failed",
                order_id=order_id,
                _external=True
            ),
            metadata={
                "order_id": order_id,
                "customer_name": customer_name,
                "customer_email": customer_email or "",
                "address": address or "",
                "city": city or "",
                "postal_code": postal_code or "",
                "country": country or "",
            }
        )

        session["latest_order"] = {
            "order_id": order_id,
            "customer_email": customer_email,
            "customer_name": customer_name,
            "order_items": list(cart.values()),
            "order_total": sum(item["price"] * item["quantity"] for item in cart.values()),
        }

        return redirect(checkout_session.url, code=303)

    except Exception as e:
        return render_template(
            "failed.html",
            order_id=order_id,
            error_message=str(e)
        )


@checkout_bp.route("/success")
def success():
    order_id = request.args.get("order_id")
    latest_order = session.get("latest_order", {})

    order_items = latest_order.get("order_items", [])
    order_total = latest_order.get("order_total", 0)
    customer_email = latest_order.get("customer_email")

    # Clear cart only after successful payment redirect
    session["cart"] = {}
    session.modified = True

    return render_template(
        "success.html",
        order_id=order_id,
        order_items=order_items,
        order_total=order_total,
        customer_email=customer_email
    )


@checkout_bp.route("/failed")
def failed():
    order_id = request.args.get("order_id")

    return render_template(
        "failed.html",
        order_id=order_id,
        error_message="Payment was cancelled or unsuccessful."
    )