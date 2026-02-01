-- Sales Performance Analysis
-- Author: Avani Garg

-- =========================
-- Table structure
-- =========================
CREATE TABLE sales (
  order_id INT PRIMARY KEY,
  order_date DATE,
  customer_id VARCHAR(20),
  product_name VARCHAR(100),
  category VARCHAR(50),
  sales DECIMAL(10,2),
  region VARCHAR(50)
);

-- =========================
-- Sample data
-- =========================
INSERT INTO sales VALUES
(1, '2023-01-05', 'C001', 'Laptop', 'Electronics', 1200.00, 'North'),
(2, '2023-01-08', 'C002', 'Phone', 'Electronics', 800.00, 'South'),
(3, '2023-02-10', 'C003', 'Desk Chair', 'Furniture', 150.00, 'West'),
(4, '2023-02-15', 'C001', 'Monitor', 'Electronics', 300.00, 'North'),
(5, '2023-03-01', 'C004', 'Tablet', 'Electronics', 600.00, 'East'),
(6, '2023-03-12', 'C005', 'Office Desk', 'Furniture', 450.00, 'West'),
(7, '2023-03-18', 'C006', 'Headphones', 'Accessories', 120.00, 'South'),
(8, '2023-04-05', 'C002', 'Phone Case', 'Accessories', 40.00, 'South'),
(9, '2023-04-20', 'C007', 'Printer', 'Electronics', 500.00, 'East'),
(10,'2023-05-10', 'C008', 'Router', 'Electronics', 200.00, 'North');

-- =========================
-- Total revenue
-- =========================
SELECT SUM(sales) AS total_revenue
FROM sales;

-- =========================
-- Monthly revenue trend
-- =========================
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  SUM(sales) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;

-- =========================
-- Top 5 products
-- =========================
SELECT 
  product_name,
  SUM(sales) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- =========================
-- Revenue by category
-- =========================
SELECT 
  category,
  SUM(sales) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- =========================
-- Revenue by region
-- =========================
SELECT 
  region,
  SUM(sales) AS revenue
FROM sales
GROUP BY region
ORDER BY revenue DESC;

-- =========================
-- Month-over-month growth
-- =========================
WITH monthly_sales AS (
  SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS revenue
  FROM sales
  GROUP BY month
)
SELECT 
  month,
  revenue,
  revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
  ROUND(
    (revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 /
    LAG(revenue) OVER (ORDER BY month),
    2
  ) AS growth_percentage
FROM monthly_sales;
