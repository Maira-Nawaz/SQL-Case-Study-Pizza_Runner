--  ****************Pizza Metrics****************


select * from `customer_orders`
select * from `pizza_names`
select * from `pizza_recipes`
select * from `pizza_toppings`
select * from `runner_orders`
select * from `runners`

--  1. How many pizzas were ordered?

SELECT 
    COUNT(*) AS Total_Orders
FROM
    customer_orders


--  2. How many unique customer orders were made?

SELECT 
    COUNT(DISTINCT order_id), COUNT(DISTINCT customer_id) 
FROM
    customer_orders


--  3. How many successful orders were delivered by each runner?

SELECT 
    COUNT(*) AS Successfull_Orders,
    runner_orders.runner_id
FROM
    runners
        JOIN
    runner_orders ON runners.runner_id = runner_orders.runner_id
WHERE
    runner_orders.cancellation IS NULL
GROUP BY runner_orders.runner_id


--  4. How many of each type of pizza was delivered?

SELECT 
    COUNT(*), pizza_name as Type_of_pizza_delivered
FROM
    customer_orders
        JOIN
    pizza_names ON customer_orders.pizza_id = pizza_names.pizza_id
    join runner_orders on runner_orders.order_id = customer_orders.order_id
WHERE cancellation IS NULL
GROUP BY pizza_name


--  5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
    COUNT(*), pizza_name, customer_id
FROM
    customer_orders
        JOIN
    pizza_names ON customer_orders.pizza_id = pizza_names.pizza_id
WHERE
    pizza_name IN ('Meatlovers' , 'Vegetarian')
GROUP BY pizza_name , customer_id


--  6. What was the maximum number of pizzas delivered in a single order?

SELECT 
    COUNT(*) AS Pizza_count, customer_orders.order_id
FROM
    customer_orders
        JOIN
    runner_orders ON customer_orders.order_id = runner_orders.order_id
WHERE
    runner_orders.cancellation IS NULL
GROUP BY customer_orders.order_id
ORDER BY Pizza_count DESC
LIMIT 1;


--  7. How many pizzas were delivered that had both exclusions and extras?

SELECT 
    COUNT(*) as Pizzas_With_Both_Exclusions_Extras
FROM
    customer_orders
        JOIN
    runner_orders ON customer_orders.order_id = runner_orders.order_id
WHERE
    customer_orders.exclusions IS NOT NULL AND
    customer_orders.extras IS NOT NULL;



--  8. What was the total volume of pizzas ordered for each hour of the day?

SELECT 
    HOUR(order_date) AS Hour_of_the_day,
    COUNT(*) AS Total_Orders
FROM
    customer_orders
GROUP BY Hour_of_the_day


--  9. What was the volume of orders for each day of the week?

SELECT 
    DAYNAME(order_date) AS Day_of_the_week,
    COUNT(*) AS Total_Orders
FROM
    customer_orders
GROUP BY Day_of_the_week


-- 10. What is the successful delivery percentage for each runner?

SELECT 
    runner_id,
    count(CASE WHEN cancellation IS NULL THEN 1 END) * 100.0 / COUNT(*) AS successful_delivery_percentage
FROM
    runner_orders
GROUP BY  runner_id

