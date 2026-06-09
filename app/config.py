import os
from dotenv import load_dotenv

load_dotenv()


def _safe_secret_key():
    secret_key = os.getenv("SECRET_KEY")
    app_env = os.getenv("APP_ENV", "development").lower()

    if secret_key:
        return secret_key

    if app_env in {"production", "prod", "staging"}:
        raise RuntimeError("SECRET_KEY must be set for staging or production environments.")

    return "dev-secret-key"


class Config:
    SECRET_KEY = _safe_secret_key()
    STRIPE_PUBLISHABLE_KEY = os.getenv("STRIPE_PUBLISHABLE_KEY")
    STRIPE_SECRET_KEY = os.getenv("STRIPE_SECRET_KEY")
    DB_SERVER = os.getenv("DB_SERVER")
    DB_NAME = os.getenv("DB_NAME")
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv("DB_PASSWORD")
