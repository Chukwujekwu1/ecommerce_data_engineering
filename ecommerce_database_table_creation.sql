-- First, let's drop the tables if they already exist
-- invoices, reviews, payments, order_items, orders, customers, products, suppliers, categories


DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;


-- now let's create the tables

-- categories
CREATE TABLE categories(
	category_id INT PRIMARY KEY,
	category_name VARCHAR(150) NOT NULL
);


-- suppliers
CREATE TABLE suppliers(
	supplier_id INT PRIMARY KEY,
	supplier_name VARCHAR(150) NOT NULL,
	contact_name VARCHAR(150),
	email VARCHAR(150),
	phone VARCHAR(50),
	country VARCHAR(50),
	city VARCHAR(50),
	lead_time_days INT,
	payment_terms VARCHAR(50),
	created_at TIMESTAMP
);


-- products
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	sku VARCHAR(50) NOT NULL UNIQUE,
	product_name VARCHAR(150) NOT NULL,
	category_id INT NOT NULL REFERENCES categories(category_id),
	brand VARCHAR(150),
	unit_price NUMERIC(10,2) NOT NULL,
	cost_price NUMERIC(10,2),
	stock_quantity INT DEFAULT 0,
	weight_kg NUMERIC(6,2),
	is_active INT DEFAULT 1,
	created_at TIMESTAMP
);


-- customers
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_type VARCHAR(50),
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	email VARCHAR(150) UNIQUE,
	phone VARCHAR(50),
	date_of_birth DATE,
	gender VARCHAR(50),
	registration_date TIMESTAMP,
	country VARCHAR(50),
	state VARCHAR(50),
	city VARCHAR(150),
	postal_code VARCHAR(50),
	address_line1 VARCHAR(225),
	loyalty_tier VARCHAR(50),
	total_lifetime_value NUMERIC(12,2) DEFAULT 0,
	is_active INT DEFAULT 1
);


-- orders
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT NOT NULL REFERENCES customers(customer_id),
	order_date TIMESTAMP NOT NULL,
	status VARCHAR(50) NOT NULL,
	payment_method VARCHAR(50),
	shipping_method VARCHAR(50),
	subtotal NUMERIC(10,2),
	discount_amount NUMERIC(10,2) DEFAULT 0,
	tax_amount NUMERIC(10,2) DEFAULT 0,
	shipping_cost NUMERIC(10,2) DEFAULT 0,
	total_amount NUMERIC(10,2),
	shipping_address VARCHAR(150),
	city VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	postal_code VARCHAR(50),
	notes TEXT
);


-- order_items
CREATE TABLE order_items(
	order_item_id INT PRIMARY KEY,
	order_id INT NOT NULL REFERENCES orders(order_id),
	product_id INT NOT NULL REFERENCES products(product_id),
	quantity INT NOT NULL,
	unit_price NUMERIC(10,2) NOT NULL,
	discount_pct INT DEFAULT 0,
	line_total NUMERIC(10,2) NOT NULL
);


-- payments
CREATE TABLE payments(
	payment_id INT PRIMARY KEY,
	order_id INT NOT NULL REFERENCES orders(order_id),
	payment_date TIMESTAMP,
	amount NUMERIC(10,2),
	payment_method VARCHAR(50),
	payment_status	VARCHAR(50),
	transaction_ref UUID,
	gateway VARCHAR(50),
	currency CHAR(3)
);


-- invoices
CREATE TABLE invoices(
	invoice_id INT PRIMARY KEY,
	order_id INT NOT NULL REFERENCES orders(order_id),
	invoice_date DATE,
	due_date DATE,
	total_amount NUMERIC(10,2),
	paid_amount NUMERIC(10,2) DEFAULT 0,
	balance_due NUMERIC(10,2) DEFAULT 0,
	invoice_status VARCHAR(50),
	notes TEXT
);


-- reviews
CREATE TABLE reviews(
	review_id INT PRIMARY KEY,
	product_id INT NOT NULL REFERENCES products(product_id),
	customer_id INT NOT NULL REFERENCES customers(customer_id),
	order_id INT NOT NULL REFERENCES orders(order_id),
	rating INT CHECK(rating BETWEEN 1 AND 5),
	review_title VARCHAR(225),
	review_body TEXT,
	review_date TIMESTAMP,
	verified_purchase INT DEFAULT 0,
	helpful_votes INT DEFAULT 0,
	is_approved INT DEFAULT 1
);