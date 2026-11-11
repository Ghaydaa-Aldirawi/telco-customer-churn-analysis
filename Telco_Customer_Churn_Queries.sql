-- 1. Create the database with a new name if it does not exist
CREATE DATABASE IF NOT EXISTS telco_customer_db;

-- 2. Use the new database
USE telco_customer_db;

-- 3. Create the customers table with the correct structure
CREATE TABLE IF NOT EXISTS customers (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10, 2),
    TotalCharges DECIMAL(10, 2),
    Churn VARCHAR(5)
);

USE telco_customer_db;

-- 1. What is the total number of customers? How many have left the company? And what is their overall percentage of the total?
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS total_churned,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers;

-- 2. What is the churn rate by contract type (monthly / annual / two-year)? And which contract type has the highest rate?
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY contract
ORDER BY churn_percentage DESC;

-- 3. Do those who leave pay a higher monthly bill than those who remain?
SELECT 
    churn,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY churn;

-- 4. What is the churn rate by internet service type, including only those types that have more than 500 customers?
SELECT 
    internetservice,
    COUNT(*) AS total_customers,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY internetservice
HAVING COUNT(*) > 500;

-- 5. How does the churn rate vary by subscription duration segment (less than one year / 1–3 years / more than 3 years)?
SELECT 
    CASE 
        WHEN tenure < 12 THEN 'Less than 1 Year'
        WHEN tenure BETWEEN 12 AND 36 THEN '1-3 Years'
        ELSE 'More than 3 Years'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY tenure_group
ORDER BY churn_percentage DESC;

-- 6. What is the churn rate based on gender, and is there a significant difference between males and females?
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY gender;

-- 7. Are senior citizens more likely to churn compared to non-senior citizens?
SELECT 
    CASE WHEN SeniorCitizen = 1 THEN 'Senior Citizen' ELSE 'Non-Senior Citizen' END AS customer_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY SeniorCitizen;

-- 8. How does the payment method affect customer churn (e.g., Electronic check vs. Automatic bank transfer)?
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_percentage DESC;

-- 9. Does having Tech Support or Online Security services reduce the churn rate?
SELECT 
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM customers
GROUP BY TechSupport, OnlineSecurity
ORDER BY churn_percentage DESC;

-- 10. What is the total financial revenue lost due to customer churn?
SELECT 
    ROUND(SUM(TotalCharges), 2) AS total_revenue_lost,
    ROUND(AVG(TotalCharges), 2) AS avg_lost_per_churned_customer
FROM customers
WHERE Churn = 'Yes';