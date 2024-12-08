USE sales_retail;

-- DATA CLEANING

ALTER TABLE retail
CHANGE ï»¿transactions_id transactions_id INT PRIMARY KEY;

SELECT *
FROM retail;

ALTER TABLE retail
MODIFY COLUMN sale_date DATE;

ALTER TABLE retail
MODIFY COLUMN sale_time TIME;

ALTER TABLE retail
MODIFY COLUMN gender VARCHAR(15);

ALTER TABLE retail
MODIFY COLUMN category VARCHAR(15);

ALTER TABLE retail
MODIFY COLUMN price_per_unit FLOAT;

ALTER TABLE retail
MODIFY COLUMN cogs FLOAT;

ALTER TABLE retail
MODIFY COLUMN total_sale FLOAT;

SELECT *
FROM retail
LIMIT 10;

SELECT * 
FROM retail
WHERE
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE
FROM retail
WHERE
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- DATA EXPLORATION

-- How many sales we have?
SELECT COUNT(*) AS Total_sales
FROM retail;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail;

-- How many unique categories we have?
SELECT COUNT(DISTINCT category) AS cat_total
FROM retail;

-- What all categories we have?
SELECT DISTINCT category AS category
FROM retail;

-- DATA ANALYSIS

-- Q1 WRITE A QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"
SELECT *
FROM retail
WHERE sale_date = '2022-11-05';

-- Q2 WRITE A QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE 
-- MONTH OF NOV-2022
SELECT *
FROM retail
WHERE category = 'Clothing' AND
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' AND
quantiy >= 4;

-- Q3 WRITE A QUERY TO CALCULATE THE TOTAL SALES AND TOTAL ORDERS FOR EACH CATEGORY
SELECT category, SUM(total_sale) as net_sale, COUNT(*) AS total_orders
FROM retail
GROUP BY category;

-- Q4 WRITE A QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY
SELECT ROUND(AVG(age), 2) AS average_age_of_customer, category
FROM retail
WHERE category = 'Beauty';

-- Q5 WRITE A QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALES IS GREATER THAN 1000
SELECT *
FROM retail
WHERE total_sale > 1000;

-- Q6 WRITE A QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail
GROUP BY category, gender;

-- Q7 WRITE A QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR
SELECT year1, month1, avg_sale FROM
(
SELECT YEAR(sale_date) AS year1, MONTH(sale_date) AS month1, ROUND(AVG(total_sale), 2) AS avg_sale, RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS rankk
FROM retail
GROUP BY year1, month1
) AS T1
WHERE rankk = 1;

-- Q8 WRITE A QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q9 WRITE A QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
SELECT category, COUNT(DISTINCT customer_id) AS uniq_customers
FROM retail
GROUP BY category;

-- Q10 WRITE A QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS( EXAMPLE MORNING < 12, AFTERNOON BETWEEN 12 AND 17, EVENING > 17)
WITH HOURLY_SALE AS 
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift
FROM retail
)
SELECT shift, COUNT(*) AS total_orders
FROM HOURLY_SALE
GROUP BY shift;

-- END --