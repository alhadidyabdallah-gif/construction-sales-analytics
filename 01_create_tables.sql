-- Construction Sales Analytics - Database Schema
-- Author: Abdullah Alahidy
-- Date: 2026

USE construction_db;

-- جدول العملاء
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    contact_person VARCHAR(100),
    phone VARCHAR(15),
    join_date DATE
) ENGINE=InnoDB;

-- جدول المشاريع
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    client_id INT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15,2),
    status VARCHAR(20),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
) ENGINE=InnoDB;

-- جدول المنتجات
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    stock_quantity INT
) ENGINE=InnoDB;

-- جدول الطلبات
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    total_amount DECIMAL(15,2),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;
