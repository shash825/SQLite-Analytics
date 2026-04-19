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

-- =============================================================
-- TASK 3 - Employees Earning Above Their Department Average
-- Logic: compute per-department average salary in a subquery,
-- join it back to each employee, keep rows where the employee's
-- salary is strictly greater than their own department's average.
-- =============================================================
SELECT
    e.first_name,
    e.last_name,
    d.name                          AS department,
    e.salary                        AS employee_salary,
    ROUND(dept_avg.avg_salary, 2)   AS department_average
FROM employees   AS e
JOIN departments AS d ON d.id = e.department_id
JOIN (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg ON dept_avg.department_id = e.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.name ASC, e.salary DESC;