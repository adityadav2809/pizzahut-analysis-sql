-- ========================================
-- 🍕 Pizza Sales Analysis - Full SQL Script
-- Author: adityadav2809@gmail.com
-- ========================================

USE pizzahut;

-- ===============================
-- ✅ BASIC QUERIES
-- ===============================

-- 1. Total number of orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- 2. Total revenue generated from pizza sales
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- 3. Highest-priced pizza
SELECT 
    p.pizza_id,
    pt.name AS pizza_name,
    p.price
FROM 
    pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY 
    p.price DESC
LIMIT 1;

-- 4. Most common pizza size ordered
SELECT 
    p.size,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    p.size
ORDER BY 
    total_quantity DESC
LIMIT 1;

-- 5. Top 5 most ordered pizza types
SELECT 
    pt.name AS pizza_type,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    total_quantity DESC
LIMIT 5;

-- ===============================
-- 🔁 INTERMEDIATE QUERIES
-- ===============================

-- 1. Total quantity of each pizza category ordered
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category;

-- 2. Distribution of orders by hour of the day
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    order_hour
ORDER BY 
    order_hour;

-- 3. Category-wise distribution of pizzas
SELECT 
    pt.category,
    COUNT(DISTINCT p.pizza_id) AS pizza_count
FROM 
    pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category;

-- 4. Group orders by date and calculate avg pizzas per day
SELECT 
    order_date,
    ROUND(AVG(total_pizzas), 2) AS avg_pizzas
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity) AS total_pizzas
    FROM 
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 
        o.order_id, o.order_date
) daily_orders
GROUP BY 
    order_date
ORDER BY 
    order_date;

-- 5. Top 3 most ordered pizza types by revenue
SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    total_revenue DESC
LIMIT 3;

-- ===============================
-- 🔥 ADVANCED QUERIES
-- ===============================

-- 1. Percentage contribution of each pizza type to total revenue
SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price) * 100.0 / 
         (SELECT SUM(od2.quantity * p2.price)
          FROM order_details od2
          JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id), 2) AS revenue_percentage
FROM 
    order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    revenue_percentage DESC;

-- 2. Cumulative revenue over time
SELECT 
    order_date,
    ROUND(SUM(daily_revenue) OVER (ORDER BY order_date), 2) AS cumulative_revenue
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM 
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY 
        o.order_date
) AS daily_sales;

-- 3. Top 3 most ordered pizza types by revenue for each category
SELECT 
    ranked.category,
    ranked.pizza_type,
    ranked.total_revenue
FROM (
    SELECT 
        pt.category,
        pt.name AS pizza_type,
        ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY pt.category 
            ORDER BY SUM(od.quantity * p.price) DESC
        ) AS rank_in_category
    FROM 
        order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY 
        pt.category, pt.name
) AS ranked
WHERE 
    ranked.rank_in_category <= 3
ORDER BY 
    ranked.category, ranked.total_revenue DESC;


-- ========================================
-- END OF SCRIPT 🎉
-- ========================================
