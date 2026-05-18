-- database/seed_products.sql

-- 1. Insert the category first as required by Task 3
INSERT INTO categories (category_name, description)
VALUES ('Dress Shirts', 'Premium dress shirts for the modern Singapore professional');

-- 2. Insert 12 premium products for The Shirt Bar
INSERT INTO products (product_id, category_id, name, description, price, fabric_type, care_instructions, size_options, color_options, image_url, stock_quantity)
VALUES 
('TSHIRT-001', 1, 'Classic Oxford White Shirt', 'Premium Egyptian cotton Oxford shirt with mother-of-pearl buttons. Features a tailored fit suitable for office wear.', 89.00, 'Egyptian Cotton', 'Machine wash cold. Hang dry recommended.', '["S","M","L","XL"]', '["White"]', '/static/images/products/tshirt-001.jpg', 25),

('TSHIRT-002', 1, 'Tropical Breeze Linen Blend', 'A lightweight, highly breathable linen-cotton blend designed specifically for Singapore’'s humid climate.', 79.00, 'Linen Blend', 'Hand wash or delicate cycle. Do not tumble dry.', '["S","M","L","XL"]', '["Light Blue", "Pale Pink"]', '/static/images/products/tshirt-002.jpg', 18),

('TSHIRT-003', 1, 'Mandarin Collar Executive', 'Modern Asian fusion style featuring a sleek Mandarin collar in a high-thread-count poplin weave.', 99.00, 'Poplin', 'Dry clean recommended for best results.', '["S","M","L","XL"]', '["Charcoal", "Navy"]', '/static/images/products/tshirt-003.jpg', 22),

('TSHIRT-004', 1, 'Midnight Navy Twill', 'A sophisticated dark navy shirt with a subtle twill texture that resists wrinkles throughout the workday.', 109.00, 'Twill', 'Warm iron if needed. Machine wash cold.', '["S","M","L","XL"]', '["Navy"]', '/static/images/products/tshirt-004.jpg', 30),

('TSHIRT-005', 1, 'Business Casual Sky Blue', 'The perfect everyday office shirt in a versatile sky blue. Soft-touch finish for all-day comfort.', 69.00, 'Oxford', 'Machine wash cold. Tumble dry low.', '["S","M","L","XL"]', '["Sky Blue"]', '/static/images/products/tshirt-005.jpg', 28),

('TSHIRT-006', 1, 'Heritage Gingham Check', 'Classic gingham pattern in a breathable broadcloth. Perfect for transitioning from meetings to dinner.', 85.00, 'Broadcloth', 'Machine wash cold. Hang dry.', '["S","M","L","XL"]', '["Red/White", "Blue/White"]', '/static/images/products/tshirt-006.jpg', 15),

('TSHIRT-007', 1, 'Royal Dobby Textured Shirt', 'Features a delicate dobby weave that adds depth and a premium feel to your professional wardrobe.', 119.00, 'Dobby Cotton', 'Professional laundering recommended.', '["S","M","L","XL"]', '["White", "Silver"]', '/static/images/products/tshirt-007.jpg', 20),

('TSHIRT-008', 1, 'Signature Easy-Iron White', 'A tech-forward cotton treated for wrinkle resistance. Stays crisp even in Singapore heat.', 95.00, 'Non-Iron Cotton', 'Machine wash cold. No ironing required.', '["S","M","L","XL"]', '["White"]', '/static/images/products/tshirt-008.jpg', 25),

('TSHIRT-009', 1, 'Emerald Forest Linen', 'Premium 100% linen shirt in a bold forest green. Relaxed fit for a sophisticated weekend look.', 89.00, '100% Linen', 'Cold hand wash only.', '["S","M","L","XL"]', '["Forest Green"]', '/static/images/products/tshirt-009.jpg', 16),

('TSHIRT-010', 1, 'Slate Grey Minimalist', 'Hidden button-down collar and a clean front placket for the modern minimalist professional.', 129.00, 'Egyptian Cotton', 'Dry clean only.', '["S","M","L","XL"]', '["Slate Grey"]', '/static/images/products/tshirt-010.jpg', 21),

('TSHIRT-011', 1, 'Champagne Celebration Shirt', 'A luxurious satin-finish cotton shirt with a subtle sheen, perfect for weddings and formal events.', 149.00, 'Satin-Finish Cotton', 'Professional dry clean.', '["S","M","L","XL"]', '["Champagne"]', '/static/images/products/tshirt-011.jpg', 12),

('TSHIRT-012', 1, 'Daily Tech Stretch Shirt', 'Blended with 3% elastane for a comfortable stretch that moves with you during your commute.', 75.00, 'Cotton Stretch', 'Machine wash cold. Low iron.', '["S","M","L","XL"]', '["White", "Black"]', '/static/images/products/tshirt-012.jpg', 24);