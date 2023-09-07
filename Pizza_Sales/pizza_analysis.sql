create database pizza_sales;

use pizza_sales;

SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    order_details;
SELECT 
    *
FROM
    pizzas;
SELECT 
    *
FROM
    pizza_types;

CREATE VIEW pizza_details AS
    SELECT 
        p.pizza_id,
        p.pizza_type_id,
        pt.name,
        pt.category,
        p.size,
        p.price,
        pt.ingredients
    FROM
        pizzas p
            JOIN
        pizza_types pt ON pt.pizza_type_id = p.pizza_type_id;

SELECT 
    *
FROM
    pizza_details;

alter table orders
modify date DATE;

alter table orders
modify time TIME;

-- total revenue

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- Total pizza sold
SELECT 
    SUM(od.quantity) AS pizza_sold
FROM
    order_details AS od;

-- Total orders
SELECT 
    COUNT(DISTINCT (order_id)) AS total_orders
FROM
    order_details;

-- avg order value
SELECT 
    ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT (od.order_id)),
            2) AS avg_order_value
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- avg pizza per order
SELECT 
    ROUND(SUM(od.quantity) / COUNT(DISTINCT (od.order_id)),
            0) AS avg_pizza_per_order
FROM
    order_details od;

-- total revenue and no of orders per category
SELECT 
    p.category,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
    COUNT(DISTINCT (od.order_id)) AS total_orders
FROM
    order_details od
        JOIN
    pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.category;

-- Total revenue and no of orders per size
SELECT 
    p.size,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
    COUNT(DISTINCT (od.order_id)) AS total_orders
FROM
    order_details od
        JOIN
    pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.size;

-- hourly, daily, and monthly trends in orders and revenue of pizza
SELECT 
    CASE
        WHEN HOUR(o.time) BETWEEN 9 AND 12 THEN 'Late Morning'
        WHEN HOUR(o.time) BETWEEN 12 AND 15 THEN 'Lunch'
        WHEN HOUR(o.time) BETWEEN 15 AND 18 THEN 'Mid Afternoon'
        WHEN HOUR(o.time) BETWEEN 18 AND 21 THEN 'Dinner'
        WHEN HOUR(o.time) BETWEEN 21 AND 23 THEN 'Late Night'
        ELSE 'Others'
    END AS meal_time,
    COUNT(DISTINCT (od.order_id)) AS total_orders
FROM
    order_details od
        JOIN
    orders o ON o.order_id = od.order_id
GROUP BY meal_time
ORDER BY total_orders DESC;

-- hourly, daily, and monthly trends in orders and revenue of pizza
SELECT 
    CASE
        WHEN HOUR(o.time) BETWEEN 9 AND 12 THEN 'Late Morning'
        WHEN HOUR(o.time) BETWEEN 12 AND 15 THEN 'Lunch'
        WHEN HOUR(o.time) BETWEEN 15 AND 18 THEN 'Mid Afternoon'
        WHEN HOUR(o.time) BETWEEN 18 AND 21 THEN 'Dinner'
        WHEN HOUR(o.time) BETWEEN 21 AND 23 THEN 'Late Night'
        ELSE 'Others'
    END AS meal_time,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    orders o ON o.order_id = od.order_id
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
GROUP BY meal_time
ORDER BY total_revenue DESC;

-- weekdays trend
SELECT 
    DAYNAME(o.date) AS day_name,
    COUNT(DISTINCT (od.order_id)) AS total_orders
FROM
    order_details od
        JOIN
    orders o
GROUP BY DAYNAME(o.date)
ORDER BY total_orders DESC;

-- month trend
SELECT 
    MONTHNAME(o.date) AS month_name,
    COUNT(DISTINCT (od.order_id)) AS total_orders
FROM
    order_details od
        JOIN
    orders o
GROUP BY MONTHNAME(o.date)
ORDER BY total_orders DESC;

-- most ordered pizza with size
SELECT 
    p.name, p.size, COUNT(od.order_id) AS count_pizzas
FROM
    order_details od
        JOIN
    pizza_sales.pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.name , p.size
ORDER BY count_pizzas DESC;

-- most ordered pizza
SELECT 
    p.name, COUNT(od.order_id) AS count_pizzas
FROM
    order_details od
        JOIN
    pizza_sales.pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.name
ORDER BY count_pizzas DESC;

-- top 5 pizza by revenue
SELECT 
    p.name, SUM(od.quantity * p.price) AS total_revenue
FROM
    order_details od
        JOIN
    pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 5;

-- top pizza by sale
SELECT 
    p.name, SUM(od.quantity) AS max_pizza_sold
FROM
    order_details od
        JOIN
    pizza_details p ON od.pizza_id = p.pizza_id
GROUP BY p.name
ORDER BY max_pizza_sold DESC
LIMIT 5;

-- pizza analysis
SELECT 
    name, price
FROM
    pizza_details
ORDER BY price DESC;

-- Most used ingredients
SELECT 
    ingredients, count(ingredients)
FROM
    pizza_details
    group by ingredients;
    
create temporary table numbers as (
	select 1 as n union all
    select 2 union all select 3 union all select 4 union all
    select 5 union all select 6 union all select 7 union all
    select 8 union all select 9 union all select 10
);

select ingredients, count(ingredients) as ingredients_count
from (
	select substring_index(substring_index(ingredients, ',', n), ',',-1) as ingredients
    from order_details
    join pizza_details on pizza_details.pizza_id = order_details.pizza_id
    join numbers on char_length(ingredients) - char_length(replace(ingredients, ',', '')) >= n-1
) as subquery
group by ingredients
order by ingredients_count desc