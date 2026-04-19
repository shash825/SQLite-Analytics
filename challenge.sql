-- =============================================================
-- SQLite Coding Challenge: challenge.sql
-- Database: bais_sqlite_lab.db
-- Tool used: VS Code + SQLTools (SQLite driver)
-- Validation: Ran each query in the SQLTools results panel and
-- spot-checked totals against manual aggregates on small subsets.
-- =============================================================

-- =============================================================
-- TASK 1 - Top 5 Customers by Total Spend
-- Logic: line total = quantity * unit_price at the order_items
-- level, rolled up to the customer. No status filter applied so
-- that the result reflects lifetime spend across every order.
-- =============================================================
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spend
FROM customers AS c
JOIN orders       AS o  ON o.customer_id = c.id
JOIN order_items  AS oi ON oi.order_id   = o.id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 5;

-- =============================================================
-- TASK 2 - Total Revenue by Product Category (all orders)
-- Logic: sum line totals grouped by the product's category.
-- =============================================================
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products    AS p
JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.category
ORDER BY revenue DESC;


-- =============================================================
-- TASK 2 (variant) - Revenue by Category, Delivered orders only
-- For comparison against the all-orders version above. Only
-- realized revenue from orders that actually shipped.
-- =============================================================
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue_delivered
FROM products    AS p
JOIN order_items AS oi ON oi.product_id = p.id
JOIN orders      AS o  ON o.id          = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY revenue_delivered DESC;
