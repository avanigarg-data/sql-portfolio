-- Sales Performance Analysis
-- Author: Avani Garg

-- =========================
-- 1. Table structure
-- =========================
CREATE TABLE sales (
  order_id INT,
  order_date DATE,
  customer_id VARCHAR(20),
  product_name VARCHAR(100),
  category VARCHAR(50),
  sales DECIMAL(10,2),
  region VARCHAR(50)
);

-- =========================
-- 2. Total revenue
-- =========================
SELECT SUM(sales) AS total_revenue
FROM sales;

-- =========================
-- 3. Monthly revenue trend
-- =========================
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  SUM(sales) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;

-- =========================
-- 4. Top 5 products
-- =========================
SELECT 
  product_name,
  SUM(sales) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- =========================
-- 5. Revenue by category
-- =========================
SELECT 
  category,
  SUM(sales) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- =========================
-- 6. Revenue by region
-- =========================
SELECT 
  region,
  SUM(sales) AS revenue
FROM sales
GROUP BY region
ORDER BY revenue DESC;

-- =========================
-- 7. Month-over-month growth
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
