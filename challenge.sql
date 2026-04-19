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

