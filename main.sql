-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS inventory_db;

-- Use the inventory_db database
USE inventory_db;

-- Create the categories table
CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL
);

-- Create the products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create the orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample categories
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books');

-- Insert sample products
INSERT INTO products (name, description, price, quantity, category_id) VALUES
('Laptop', 'High-performance laptop', 1200.00, 10, 1),
('T-shirt', 'Cotton t-shirt', 20.00, 50, 2),
('Python Programming Book', 'Introduction to Python programming', 35.00, 30, 3);

-- Create the users table for user authentication
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'manager', 'staff') NOT NULL
);

-- Insert a sample admin user
INSERT INTO users (username, password, role) VALUES
('admin', 'admin123', 'admin');

-- Create stored procedure for user login
DELIMITER //
CREATE PROCEDURE AuthenticateUser(IN p_username VARCHAR(50), IN p_password VARCHAR(255))
BEGIN
    SELECT user_id, role FROM users WHERE username = p_username AND password = p_password;
END //
DELIMITER ;

-- Example usage of the AuthenticateUser procedure
CALL AuthenticateUser('admin', 'admin123');

-- Create stored procedures for CRUD operations on products
DELIMITER //
CREATE PROCEDURE AddProduct(
    IN p_name VARCHAR(255),
    IN p_description TEXT,
    IN p_price DECIMAL(10, 2),
    IN p_quantity INT,
    IN p_category_id INT
)
BEGIN
    INSERT INTO products (name, description, price, quantity, category_id) VALUES (p_name, p_description, p_price, p_quantity, p_category_id);
END //

CREATE PROCEDURE UpdateProduct(
    IN p_product_id INT,
    IN p_name VARCHAR(255),
    IN p_description TEXT,
    IN p_price DECIMAL(10, 2),
    IN p_quantity INT,
    IN p_category_id INT
)
BEGIN
    UPDATE products SET name = p_name, description = p_description, price = p_price, quantity = p_quantity, category_id = p_category_id WHERE product_id = p_product_id;
END //

CREATE PROCEDURE DeleteProduct(IN p_product_id INT)
BEGIN
    DELETE FROM products WHERE product_id = p_product_id;
END //

-- Example usage of CRUD procedures
CALL AddProduct('Smartphone', 'High-end smartphone', 800.00, 15, 1);
CALL UpdateProduct(1, 'Smartphone Updated', 'High-end smartphone with new features', 850.00, 20, 1);
CALL DeleteProduct(1);

-- Create stored procedures for managing orders
DELIMITER //
CREATE PROCEDURE AddOrder(
    IN p_customer_name VARCHAR(255),
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE product_quantity INT;
    DECLARE order_total DECIMAL(10, 2);

    -- Get current product quantity
    SELECT quantity INTO product_quantity FROM products WHERE product_id = p_product_id;

    -- Check if product is in stock
    IF product_quantity >= p_quantity THEN
        -- Calculate order total
        SELECT price * p_quantity INTO order_total FROM products WHERE product_id = p_product_id;

        -- Insert order into orders table
        INSERT INTO orders (customer_name, product_id, quantity, total_amount) VALUES (p_customer_name, p_product_id, p_quantity, order_total);

        -- Update product quantity
        UPDATE products SET quantity = product_quantity - p_quantity WHERE product_id = p_product_id;
        
        SELECT 'Order placed successfully' AS message;
    ELSE
        SELECT 'Product out of stock' AS message;
    END IF;
END //

-- Example usage of AddOrder procedure
CALL AddOrder('John Doe', 2, 2);

-- Create the roles table for user roles
CREATE TABLE IF NOT EXISTS roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Insert sample roles
INSERT INTO roles (role_name) VALUES
('admin'),
('manager'),
('staff');

-- Add role_id column to users table
ALTER TABLE users ADD COLUMN role_id INT,
    ADD FOREIGN KEY (role_id) REFERENCES roles(role_id);

-- Create stored procedure for user registration
DELIMITER //
CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_role_id INT
)
BEGIN
    INSERT INTO users (username, password, role_id) VALUES (p_username, p_password, p_role_id);
END //

-- Create stored procedure for password hashing
DELIMITER //
CREATE PROCEDURE HashPassword(
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT SHA256(p_password) AS hashed_password;
END //

-- Example usage of HashPassword procedure
CALL HashPassword('your_password_here');

-- Create stored procedure for password reset
DELIMITER //
CREATE PROCEDURE ResetPassword(
    IN p_username VARCHAR(50),
    IN p_new_password VARCHAR(255)
)
BEGIN
    UPDATE users SET password = SHA256(p_new_password) WHERE username = p_username;
END //

-- Example usage of ResetPassword procedure
CALL ResetPassword('admin', 'new_password_here');

-- Create stored procedure for product search
DELIMITER //
CREATE PROCEDURE SearchProducts(
    IN p_search_term VARCHAR(255)
)
BEGIN
    SELECT * FROM products WHERE name LIKE CONCAT('%', p_search_term, '%') OR description LIKE CONCAT('%', p_search_term, '%');
END //

-- Example usage of SearchProducts procedure
CALL SearchProducts('laptop');