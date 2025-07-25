CREATE DATABASE pizza_runner;


-- Table: runners
CREATE TABLE runners (
  runner_id INTEGER PRIMARY KEY,
  registration_date DATE
);

-- Table: customer_orders
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_date TIMESTAMP,
  PRIMARY KEY (order_id, pizza_id),
  FOREIGN KEY (pizza_id) REFERENCES pizza_names(pizza_id)
);

-- Table: runner_orders
CREATE TABLE runner_orders (
  order_id INTEGER PRIMARY KEY,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23),
  FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
  FOREIGN KEY (runner_id) REFERENCES runners(runner_id)
);

-- Table: pizza_names
CREATE TABLE pizza_names (
  pizza_id INTEGER PRIMARY KEY,
  pizza_name TEXT
);

-- Table: pizza_recipes
CREATE TABLE pizza_recipes (
  pizza_id INTEGER PRIMARY KEY,
  toppings TEXT,
  FOREIGN KEY (pizza_id) REFERENCES pizza_names(pizza_id)
);

-- Table: pizza_toppings
CREATE TABLE pizza_toppings (
  topping_id INTEGER PRIMARY KEY,
  topping_name TEXT
);

-- Insert runners
INSERT INTO runners VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');

-- Insert pizza names
INSERT INTO pizza_names VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');

-- Insert pizza recipes
INSERT INTO pizza_recipes VALUES
  (1, '1,2,3,4,5,6,8,10'),
  (2, '4,6,7,9,11,12');

-- Insert pizza toppings
INSERT INTO pizza_toppings VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

-- Insert customer orders
INSERT INTO customer_orders VALUES
  (1, 101, 1, '', '', '2020-01-01 18:05:02'),
  (2, 101, 1, '', '', '2020-01-01 19:00:52'),
  (3, 102, 1, '', '', '2020-01-02 23:51:23'),
  (3, 102, 2, '', NULL, '2020-01-02 23:51:23'),
  (4, 103, 1, '4', '', '2020-01-04 13:23:46'),
  (5, 104, 1, NULL, '1', '2020-01-08 21:00:29'),
  (6, 101, 2, NULL, NULL, '2020-01-08 21:03:13'),
  (7, 105, 2, NULL, '1', '2020-01-08 21:20:29'),
  (8, 102, 1, NULL, NULL, '2020-01-09 23:54:33'),
  (9, 103, 1, '4', '1,5', '2020-01-10 11:22:59'),
  (10, 104, 1, '2,6', '1,4', '2020-01-11 18:34:49');

-- Insert runner orders
INSERT INTO runner_orders VALUES
  (1, 1, '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  (2, 1, '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  (3, 1, '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  (4, 2, '2020-01-04 13:53:03', '23.4', '40', NULL),
  (5, 3, '2020-01-08 21:10:57', '10', '15', NULL),
  (6, 3, NULL, NULL, NULL, 'Restaurant Cancellation'),
  (7, 2, '2020-01-08 21:30:45', '25km', '25mins', NULL),
  (8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minute', NULL),
  (9, 2, NULL, NULL, NULL, 'Customer Cancellation'),
  (10, 1, '2020-01-11 18:50:20', '10km', '10minutes', NULL);
