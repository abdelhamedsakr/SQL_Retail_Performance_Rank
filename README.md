# Retail_Performance_Rank SQL Project

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1.Set up a retail sales database

```sql
CREATE DATABASE sql_p1;

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM [dbo].[SQL - Retail Sales Analysis_utf ]
SELECT COUNT(DISTINCT [customer_id]) FROM [dbo].[SQL - Retail Sales Analysis_utf ]
SELECT DISTINCT [category] FROM [dbo].[SQL - Retail Sales Analysis_utf ]

SELECT * FROM retail_sales
WHERE [transactions_id] IS NULL

SELECT * FROM retail_sales
WHERE [sale_date] IS NULL

SELECT * FROM [dbo].[SQL - Retail Sales Analysis_utf ]
WHERE [sale_time] IS NULL


select * from [dbo].[SQL - Retail Sales Analysis_utf ]
where 
    [transactions_id] is NULL
    OR
    [sale_date] is NULL
    OR
    [sale_time] is NULL
    OR
    [gender] is NULL
    OR
    [category] is NULL
    OR
    [quantiy] is NULL
    OR
    [cogs] is Null
    OR
    [total_sale] is NULL

Delete from [dbo].[SQL - Retail Sales Analysis_utf ]
where 
    [transactions_id] is NULL
    OR
    [sale_date] is NULL
    OR
    [sale_time] is NULL
    OR
    [gender] is NULL
    OR
    [category] is NULL
    OR
    [quantiy] is NULL
    OR
    [cogs] is Null
    OR
    [total_sale] is NULL
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * 
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [sale_date] = '2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
WHERE 
    [category] = 'Clothing'
    AND 
    [sale_date] BETWEEN '2022-11-01' AND '2022-11-30'
    AND
    [quantiy] >= 4

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select [category],sum([total_sale]) as Net_Sales, COUNT(*) as Total_Orders
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by [category]
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select Round(AVG([age]),2) as Avg_age
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [category]='Clothing'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select *
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [total_sale] > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select Count(*) as Total_transaction,[category],[gender]
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by [category],[gender]
order by [category]

```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
WITH ranked_sales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM [dbo].[SQL - Retail Sales Analysis_utf ]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM ranked_sales
WHERE rank = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select top(5) [customer_id],SUM([total_sale]) as Total_Sales
from [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [customer_id]
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select Count(DISTINCT([customer_id])) as Count_Unique_Coustomer,[category]
from [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM [dbo].[SQL - Retail Sales Analysis_utf]
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.


