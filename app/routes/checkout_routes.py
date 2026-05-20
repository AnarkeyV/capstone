from flask import Blueprint, render_template, redirect, url_for, session

checkout_bp = Blueprint("checkout", __name__)


@checkout_bp.route("/checkout", methods=["GET"])
def checkout():
    cart = session.get("cart", {})

    if not cart:
        return redirect(url_for("product.home"))

    subtotal = sum(item["price"] * item["quantity"] for item in cart.values())
    shipping = 0 if subtotal >= 100 or subtotal == 0 else 5
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
    # Temporary placeholder.
    # We will replace this with Stripe logic in Task 6.
    return redirect(url_for("checkout.success"))


@checkout_bp.route("/success")
def success():
    return render_template("success.html")


@checkout_bp.route("/failed")
def failed():
    return render_template("failed.html")