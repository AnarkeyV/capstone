from flask import Flask
from dotenv import load_dotenv
import os

load_dotenv()


def create_app():
    app = Flask(__name__)

    app.secret_key = os.getenv("SECRET_KEY", "dev-secret-key")
    app.config["STRIPE_PUBLISHABLE_KEY"] = os.getenv("STRIPE_PUBLISHABLE_KEY")
    app.config["STRIPE_SECRET_KEY"] = os.getenv("STRIPE_SECRET_KEY")

    from app.routes.product_routes import product_bp
    from app.routes.cart_routes import cart_bp
    from app.routes.checkout_routes import checkout_bp

    app.register_blueprint(product_bp)
    app.register_blueprint(cart_bp)
    app.register_blueprint(checkout_bp)

    @app.route("/health")
    def health():
        return {"status": "ok"}, 200

    @app.context_processor
    def inject_cart_count():
        from flask import session

        cart = session.get("cart", {})
        count = sum(item["quantity"] for item in cart.values()) if cart else 0

        return {"cart_count": count}

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=5001)