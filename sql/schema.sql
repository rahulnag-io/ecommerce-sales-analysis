-- create database
CREATE DATABASE IF NOT EXISTS customers;

-- use the database
USE customers;

-- create table(s)
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- OPTIONAL: this imports the CSV file into the table
-- 
SET GLOBAL LOCAL_INFILE=ON;

LOAD DATA LOCAL INFILE 'C:/Users/Rahul Nag/Projects/self/E-Commerce Sales Analysis/data/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
--

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value DECIMAL(10,2),

    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,6),
    geolocation_lng DECIMAL(10,6),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

-- you may need to run this query multiple times to import all the data into respective tables 
--
LOAD DATA LOCAL INFILE 'C:/Users/Rahul Nag/Projects/self/E-Commerce Sales Analysis/data/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
--

-- add foreign keys
ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id),
ADD FOREIGN KEY (product_id) REFERENCES products(product_id),
ADD FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

ALTER TABLE payments
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE reviews
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- turn off safe mode (NOT RECOMMENDED)
SET SQL_SAFE_UPDATES = 0;

-- update datetime values
-- you may need to run this query multiple times to update datetime values into respective tables
-- 
UPDATE reviews
SET review_answer_timestamp = NULL
WHERE CAST(review_answer_timestamp AS CHAR) = '0000-00-00 00:00:00';
-- 

SELECT * FROM customers;