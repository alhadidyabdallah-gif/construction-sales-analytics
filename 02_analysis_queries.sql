-- Construction Sales Analytics - Analytical Queries

-- 1. Top 10 Projects by Sales
SELECT 
    p.project_name,
    c.client_name,
    c.city,
    SUM(o.total_amount) AS total_sales
FROM orders o
JOIN projects p ON o.project_id = p.project_id
JOIN clients c ON p.client_id = c.client_id
GROUP BY p.project_name, c.client_name, c.city
ORDER BY total_sales DESC
LIMIT 10;

-- 2. Monthly Sales Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.total_amount) AS total_sales,
    COUNT(*) AS num_orders
FROM orders o
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- 3. Client Ranking (Window Function)
SELECT 
    c.client_name,
    c.city,
    SUM(o.total_amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS client_rank
FROM orders o
JOIN projects p ON o.project_id = p.project_id
JOIN clients c ON p.client_id = c.client_id
GROUP BY c.client_name, c.city
ORDER BY client_rank
LIMIT 20;

-- 4. ABC Analysis by Category
SELECT 
    p.category,
    SUM(o.total_amount) AS total_sales,
    ROUND(SUM(o.total_amount) / (SELECT SUM(total_amount) FROM orders) * 100, 2) AS percentage
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 5. Project Status Analysis
SELECT 
    p.status,
    COUNT(DISTINCT p.project_id) AS num_projects,
    SUM(o.total_amount) AS total_sales,
    AVG(p.budget) AS avg_budget
FROM projects p
LEFT JOIN orders o ON p.project_id = o.project_id
GROUP BY p.status
ORDER BY total_sales DESC;
