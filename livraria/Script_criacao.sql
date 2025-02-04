CREATE DATABASE IF NOT EXISTS livraria;
USE livraria;

CREATE TABLE countries (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(45),   
    name VARCHAR(45)
);

CREATE TABLE regions (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(45),
    name VARCHAR(45)
)

CREATE TABLE cupons (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    code varchar(100),
    description varchar(50),
    percent FLOAT
)

CREATE TABLE attributes (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name JSON
)

CREATE TABLE rules (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    description VARCHAR(45),
    discount FLOAT
)

CREATE TABLE customers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    email_marketing CHAR(2)
)

CREATE TABLE address_detail (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    postal_code VARCHAR(45),
    street VARCHAR(100),
    neighborhood VARCHAR(50),
    city VARCHAR(100),
    countries_id INT,
    regions_id INT,
    CONSTRAINT fk_address_countries FOREIGN KEY (countries_id) REFERENCES countries(id) ON DELETE CASCADE,
    CONSTRAINT fk_address_regions FOREIGN KEY (regions_id) REFERENCES regions(id) ON DELETE CASCADE
)

CREATE TABLE categories (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    description VARCHAR(50),
    rule_id INT,
    constraint fk_categories_rule FOREIGN KEY (rule_id) REFERENCES rules(id) ON DELETE CASCADE
)

CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    price FLOAT,
    description VARCHAR(50),
    is_inStock INT,
    categories_id INT,
    CONSTRAINT fk_products_categories FOREIGN KEY (categories_id) REFERENCES categories(id) ON DELETE CASCADE 
)

CREATE TABLE products_attributes (
    product_id int,
    attribute_id int,
    CONSTRAINT fk_products_id FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_products_attributs FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
)

CREATE TABLE addresses (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(50),
    complement VARCHAR(50),
    address_detail_id INT,
    customer_id INT,
    CONSTRAINT fk_adress_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_adress_detail FOREIGN KEY (address_id) REFERENCES address_detail(id) ON DELETE CASCADE
)

CREATE TABLE reviews (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rating int,
    description VARCHAR(50),
    product_id INT,
    customer_id INT,
    CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
)

CREATE TABLE order_products (
    order_id INT,
    product_id INT,
    cupon_id INT,
    CONSTRAINT fk_order_products_order FOREIGN KEY (order_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_products_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_products_cupon FOREIGN KEY (cupon_id) REFERENCES cupons(id) ON DELETE CASCADE
)

CREATE TABLE order (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    total FLOAT,
    created_at VARCHAR(20),
    delivered_at VARCHAR(20),
    customer_id INT,
    address_id INT,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_product FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE CASCADE
)