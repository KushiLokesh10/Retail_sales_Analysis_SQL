# Retail_sales_Analysis_SQL_Project

## **Problem Statement**
Retail businesses generate a large volume of data every day, making it challenging to gain insights from raw data. This project focuses on cleaning, exploring, and analyzing retail sales data to uncover patterns and answer key business questions.

---

## **Objective and Goals**
The primary objectives of this project are:
1. **Data Cleaning**: Ensure the dataset is complete and correctly formatted to facilitate accurate analysis.
2. **Data Exploration**: Understand the structure and key aspects of the dataset.
3. **Data Analysis**: Perform various analyses to answer specific business questions, such as identifying top customers, category sales, and seasonal trends.

---

## **Approach**
This project is broken into the following phases:
1. **Data Cleaning**: Fix structural issues in the dataset and handle missing or null values.
2. **Data Exploration**: Understand the dataset using descriptive queries.
3. **Data Analysis**: Solve key business problems using SQL queries.

---

## **Project Workflow**

### **Step 1: Setting Up the Database**
We use MySQL to host and query the retail dataset. The first step is selecting the database and modifying the schema.

```sql
USE sales_retail;
```

---

### **Step 2: Data Cleaning**
Cleaning involves addressing schema issues, changing column data types, and removing null or invalid entries.

1. **Fixing Column Names**:
   ```sql
   ALTER TABLE retail
   CHANGE ï»¿transactions_id transactions_id INT PRIMARY KEY;
   ```

2. **Modifying Column Types**:
   ```sql
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
   ```

3. **Removing Null Entries**:
   ```sql
   DELETE
   FROM retail
   WHERE
       transactions_id IS NULL OR
       sale_date IS NULL OR
       sale_time IS NULL OR
       customer_id IS NULL OR
       gender IS NULL OR
       age IS NULL OR
       category IS NULL OR
       quantiy IS NULL OR
       price_per_unit IS NULL OR
       cogs IS NULL OR
       total_sale IS NULL;
   ```

---

### **Step 3: Data Exploration**
Key exploratory queries to understand the dataset:

1. **How many sales we have?**:
   ```sql
   SELECT COUNT(*) AS Total_sales
   FROM retail;
   ```

2. **How many unique customers we have?**:
   ```sql
   SELECT COUNT(DISTINCT customer_id) AS total_customers
   FROM retail;
   ```

3. **How many unique categories we have?**:
   ```sql
   SELECT COUNT(DISTINCT category) AS cat_total
   FROM retail;
   ```

4. **What all categories we have?**:
   ```sql
   SELECT DISTINCT category AS category
   FROM retail;
   ```

---

### **Step 4: Data Analysis**

#### Q1 WRITE A QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"
```sql
SELECT *
FROM retail
WHERE sale_date = '2022-11-05';
```

#### Q2 WRITE A QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE 
#### MONTH OF NOV-2022
```sql
SELECT *
FROM retail
WHERE category = 'Clothing' AND
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' AND
quantiy > 10;
```

#### Q3 WRITE A QUERY TO CALCULATE THE TOTAL SALES AND TOTAL ORDERS FOR EACH CATEGORY
```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail
GROUP BY category;
```

#### Q4 WRITE A QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY
```sql
SELECT ROUND(AVG(age), 2) AS average_age_of_customer, category
FROM retail
WHERE category = 'Beauty';
```

#### Q5 WRITE A QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALES IS GREATER THAN 1000
```sql
SELECT *
FROM retail
WHERE total_sale > 1000;
```

#### Q6 WRITE A QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY
```sql
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail
GROUP BY category, gender;
```

#### Q7 WRITE A QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR
```sql
SELECT year1, month1, avg_sale 
FROM (
    SELECT YEAR(sale_date) AS year1, 
           MONTH(sale_date) AS month1, 
           ROUND(AVG(total_sale), 2) AS avg_sale, 
           RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS rankk
    FROM retail
    GROUP BY year1, month1
) AS T1
WHERE rankk = 1;
```

#### Q8 WRITE A QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
```sql
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;
```

#### Q9 WRITE A QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
```sql
SELECT category, COUNT(DISTINCT customer_id) AS uniq_customers
FROM retail
GROUP BY category;
```

#### Q10 WRITE A QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS( EXAMPLE MORNING < 12, AFTERNOON BETWEEN 12 AND 17, EVENING > 17)
```sql
WITH HOURLY_SALE AS (
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
```

---

### **Conclusion**
This project demonstrates the importance of systematic data cleaning, exploration, and analysis in answering business questions using SQL.

--- 
