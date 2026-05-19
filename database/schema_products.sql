-- Drop tables in reverse order of dependencies to prevent constraint locks
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;

-- Categories
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    is_active BIT DEFAULT 1,
    created_at DATETIME2 DEFAULT GETDATE()
);

-- Products
CREATE TABLE products (
    product_id NVARCHAR(20) PRIMARY KEY, -- Format: TSHIRT-001
    category_id INT,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(1000),
    price DECIMAL(10,2) NOT NULL,
    fabric_type NVARCHAR(100),
    care_instructions NVARCHAR(500),
    size_options NVARCHAR(100), -- JSON array string: '["S","M","L","XL"]'
    color_options NVARCHAR(200), -- JSON array string: '["White","Blue"]'
    image_url NVARCHAR(500),
    stock_quantity INT DEFAULT 10,
    is_active BIT DEFAULT 1,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Indexes for faster product searches
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_active ON products(is_active);
