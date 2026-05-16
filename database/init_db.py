import os
import pyodbc
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def get_connection():
    """Dynamically finds the installed SQL Server driver and connects to Azure."""
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")

    if not all([server, database, username, password]):
        raise ValueError("Missing database credentials in environment variables.")

    # Find what ODBC driver is installed on this machine
    available_drivers = [d for d in pyodbc.drivers() if "SQL Server" in d]
    if not available_drivers:
        raise RuntimeError("No Microsoft ODBC Driver found. Please install 'ODBC Driver for SQL Server'.")
    
    # Use the newest driver found on the host system
    chosen_driver = available_drivers[0]
    print(f"[*] Using detected system driver: {chosen_driver}")

    # Build the secure connection string
    conn_str = (
        f"DRIVER={{{chosen_driver}}};"
        f"SERVER={server};"
        f"DATABASE={database};"
        f"UID={username};"
        f"PWD={password};"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;"
        "Connection Timeout=30;"
    )
    return pyodbc.connect(conn_str)

def run_sql_file(cursor, file_path):
    """Reads a SQL file and executes it block by block."""
    print(f"[*] Executing script: {file_path.name}")
    
    with open(file_path, "r", encoding="utf-8") as f:
        sql_script = f.read()

    try:
        cursor.execute(sql_script)
        print(f"[+] Successfully executed {file_path.name}")
    except Exception as e:
        print(f"[-] Error executing {file_path.name}: {e}")
        raise e

def main():
    # Paths to your schema files
    base_dir = Path(__file__).parent
    products_schema = base_dir / "schema_products.sql"
    orders_schema = base_dir / "schema_orders.sql"

    print("[*] Starting Azure SQL Database initialization...")
    
    try:
        # Connect to Azure
        conn = get_connection()
        cursor = conn.cursor()
        
        # Turn off autocommit to manage transactions safely
        conn.autocommit = False

        # DevOps Master Reset: Drop order tables FIRST to release foreign keys on product tables
        print("[*] Clearing old constraints and tables...")
        drop_commands = """
        DROP TABLE IF EXISTS Payments;
        DROP TABLE IF EXISTS OrderDetails;
        DROP TABLE IF EXISTS Orders;
        DROP TABLE IF EXISTS Addresses;
        DROP TABLE IF EXISTS Users;
        DROP TABLE IF EXISTS Inventory;
        DROP TABLE IF EXISTS Variants;
        DROP TABLE IF EXISTS Products;
        DROP TABLE IF EXISTS Collections;
        """
        cursor.execute(drop_commands)

        # Execute schemas in strict dependency order
        run_sql_file(cursor, products_schema)
        run_sql_file(cursor, orders_schema)

        # Commit all changes to Azure if both scripts succeed without error
        conn.commit()
        print("[+] Database initialization completed successfully!")

    except Exception as e:
        print(f"[!] Critical initialization failure: {e}")
        if 'conn' in locals():
            print("[*] Rolling back changes...")
            conn.rollback()
    finally:
        if 'conn' in locals():
            cursor.close()
            conn.close()
            print("[*] Database connection closed.")

if __name__ == "__main__":
    main()
