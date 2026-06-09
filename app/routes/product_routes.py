from flask import Blueprint, render_template, abort
from app.models.product import Product

product_bp = Blueprint("product", __name__)


@product_bp.route("/")
def home():
    products = Product.get_all()
    return render_template("home.html", products=products)


@product_bp.route("/product/<product_id>")
def product_detail(product_id):
    product = Product.get_by_id(product_id)

    if not product:
        abort(404)

    return render_template("product.html", product=product)

@product_bp.route("/collections")
def collections():
    return render_template("collections.html")


@product_bp.route("/about")
def about():
    return render_template("about.html")