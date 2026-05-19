-- Drop tables in reverse order of dependencies
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;

-- orders
CREATE TABLE orders (
    order_id NVARCHAR(30) PRIMARY KEY, -- Format: TSB-20260513-ABC123
    customer_name NVARCHAR(200) NOT NULL,
    customer_email NVARCHAR(200) NOT NULL,
    shipping_address NVARCHAR(500) NOT NULL,
    city NVARCHAR(100),
    postal_code NVARCHAR(20),
    country NVARCHAR(100) DEFAULT 'Singapore',
    total_amount DECIMAL(10,2) NOT NULL,
    payment_status NVARCHAR(20) DEFAULT 'pending', -- pending, succeeded, failed, refunded
    stripe_payment_id NVARCHAR(100),
    stripe_session_id NVARCHAR(200),
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE()
);

-- order_items
CREATE TABLE order_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(30) NOT NULL,
    product_id NVARCHAR(20) NOT NULL,
    product_name NVARCHAR(200) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    selected_size NVARCHAR(10),
    selected_color NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Indexes for order queries
CREATE INDEX idx_orders_email ON orders(customer_email);
CREATE INDEX idx_orders_status ON orders(payment_status);
CREATE INDEX idx_orders_date ON orders(created_at DESC);
