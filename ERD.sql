-- 1.  ERD 
CREATE DATABASE IF NOT EXISTS telco_erd_db;
USE telco_erd_db;

-- 2.  (Customer Information)
CREATE TABLE Customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen INT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INT
);

-- 3.  (Contracts & Billing)
CREATE TABLE Contracts (
    contract_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(50),
    contract_type VARCHAR(20),
    paperless_billing VARCHAR(5),
    payment_method VARCHAR(50),
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- 4. (Subscriptions & Services)
CREATE TABLE Customer_Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(50),
    phone_service VARCHAR(5),
    multiple_lines VARCHAR(20),
    internet_service VARCHAR(20),
    online_security VARCHAR(20),
    online_backup VARCHAR(20),
    device_protection VARCHAR(20),
    tech_support VARCHAR(20),
    streaming_tv VARCHAR(20),
    streaming_movies VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- 5. (Churn Status)
CREATE TABLE Churn_Status (
    churn_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(50),
    churn VARCHAR(5),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);