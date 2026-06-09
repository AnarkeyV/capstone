from flask import Flask
from dotenv import load_dotenv
import os

load_dotenv()


def _get_secret_key() -> str:
    """Return a safe Flask secret key for the current environment.

    For local capstone development, a fallback keeps tests and demos easy to run.
    For staging/production, missing SECRET_KEY should stop the app immediately
    because Flask uses this key to sign session cookies.
    """
    secret_key = os.getenv("SECRET_KEY")
    app_env = os.getenv("APP_ENV", "development").lower()

    if secret_key:
        return secret_key

    if app_env in {"production", "prod", "staging"}:
        raise RuntimeError("SECRET_KEY must be set for staging or production environments.")

    return "dev-secret-key"


def create_app():
    app = Flask(__name__)
    app.secret_key = _get_secret_key()

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

    @app.route("/healthz")
    def healthz():
        return {"status": "ok", "check": "liveness"}, 200

    @app.route("/readyz")
    def readyz():
        # Current capstone readiness is intentionally lightweight because Azure SQL
        # and Stripe webhook persistence are documented as production roadmap items.
        return {"status": "ok", "check": "readiness"}, 200

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
