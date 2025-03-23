
create DATABASE sql_p1
use sql_p1


select * from [dbo].[SQL - Retail Sales Analysis_utf ]


select count(*) from [dbo].[SQL - Retail Sales Analysis_utf ]

--Data Cleaning
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


-- Data Exploration

-- How many sales we have?
select count(*) as Total_sales 
from [dbo].[SQL - Retail Sales Analysis_utf ]

-- How many uniuque customers we have ?
select count(DISTINCT[customer_id]) as Total_Customers
from [dbo].[SQL - Retail Sales Analysis_utf ]

select DISTINCT [category] from 
[dbo].[SQL - Retail Sales Analysis_utf ]





-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 
select * 
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [sale_date] = '2022-11-05'



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM [dbo].[SQL - Retail Sales Analysis_utf ]
WHERE 
    [category] = 'Clothing'
    AND 
    [sale_date] BETWEEN '2022-11-01' AND '2022-11-30'
    AND
    [quantiy] >= 4



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select [category],sum([total_sale]) as Net_Sales, COUNT(*) as Total_Orders
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by [category]



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select Round(AVG([age]),2) as Avg_age
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [category]='Clothing'



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from [dbo].[SQL - Retail Sales Analysis_utf ]
where [total_sale] > 1000




-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select Count(*) as Total_transaction,[category],[gender]
from [dbo].[SQL - Retail Sales Analysis_utf ]
group by [category],[gender]
order by [category]



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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





-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select top(5) [customer_id],SUM([total_sale]) as Total_Sales
from [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [customer_id]



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select Count(DISTINCT([customer_id])) as Count_Unique_Coustomer,[category]
from [dbo].[SQL - Retail Sales Analysis_utf ]
GROUP BY [category]



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

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
