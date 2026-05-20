from flask import Blueprint, render_template, request, redirect, url_for, session, flash
from app.models.product import Product

cart_bp = Blueprint("cart", __name__)

@cart_bp.route("/cart", methods=["GET"])
def cart():
    cart_items = session.get("cart", {})

    subtotal = sum(item["price"] * item["quantity"] for item in cart_items.values())
    shipping = 0 if subtotal >= 100 or subtotal == 0 else 5
    total = subtotal + shipping

    return render_template(
        "cart.html",
        cart=cart_items,
        subtotal=subtotal,
        shipping=shipping,
        total=total
    )

@cart_bp.route("/cart/add/<product_id>", methods=["POST"])
def add_to_cart(product_id):
    product = Product.get_by_id(product_id)

    if not product:
        flash("Product not found.", "error")
        return redirect(url_for("product.home"))

    size = request.form.get("size")
    color = request.form.get("color")
    quantity = int(request.form.get("quantity", 1))

    if not size or not color:
        flash("Please select a size and color.", "error")
        return redirect(url_for("product.product_detail", product_id=product_id))

    cart = session.get("cart", {})
    cart_key = f"{product_id}|{size}|{color}"

    if cart_key in cart:
        cart[cart_key]["quantity"] += quantity
    else:
        cart[cart_key] = {
            "product_id": product_id,
            "name": product["name"],
            "price": float(product["price"]),
            "quantity": quantity,
            "size": size,
            "color": color,
            "image_url": product.get("image_url", "")
        }

    session["cart"] = cart
    session.modified = True

    flash("Item added to cart.", "success")
    return redirect(url_for("cart.cart"))

@cart_bp.route("/cart/update/<cart_key>", methods=["POST"])
def update_cart(cart_key):
    cart = session.get("cart", {})

    if cart_key not in cart:
        flash("Item not found in cart.", "error")
        return redirect(url_for("cart.cart"))

    quantity = int(request.form.get("quantity", 1))

    if quantity <= 0:
        cart.pop(cart_key)
    else:
        cart[cart_key]["quantity"] = quantity

    session["cart"] = cart
    session.modified = True

    flash("Cart updated.", "success")
    return redirect(url_for("cart.cart"))

@cart_bp.route("/cart/remove/<cart_key>", methods=["POST"])
def remove_from_cart(cart_key):
    cart = session.get("cart", {})

    if cart_key in cart:
        cart.pop(cart_key)

    session["cart"] = cart
    session.modified = True

    flash("Item removed from cart.", "success")
    return redirect(url_for("cart.cart"))
