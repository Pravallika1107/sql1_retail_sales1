--- CREATE RETAIL SALES ANALYSIS P1
drop database if exists sqlproject1;
create database sqlproject1;
--- CREATE TABLE 
drop table if exists retail_sales1;
create table retail_sales1(
transactions_id	int primary key,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(10),
age	int,
category varchar(50),	
quantiy	int,
price_per_unit	float,
cogs float, 	
total_sale float
);
select * 
from retail_sales1;

--- count of records
select count (*) from retail_sales1;

--- see null data in the retail_sales
select * from retail_sales1
where transactions_id is null;

select * from retail_sales1
where sale_date is null;

select * from retail_sales1
where sale_time is null;

select * from retail_sales1
where customer_id is null;

select * from retail_sales1
where gender is null;

select * from retail_sales1
where age is null;

select * from retail_sales1
where category is null;

select * from retail_sales1
where quantiy is null;

select * from retail_sales1
where price_per_unit is null;

select * from retail_sales1
where cogs is null;

select * from retail_sales1
where total_sale is null;
--- data with null values
select * from retail_sales1
where 
     transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
     or
	 category is null
	 or
	 quantiy is null
	 or 
	 cogs is null
	 or
	 total_sale is null;
--- DATA CLEANING
delete  from retail_sales1
where
      transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
     or
	 category is null
	 or
	 quantiy is null
	 or 
	 cogs is null
	 or
	 total_sale is null;
--- DATA EXPLORATION
--- NUMBER OF UNIQUE TRANSACTIONS
SELECT COUNT(DISTINCT TRANSACTIONS_ID) FROM RETAIL_SALES1;
--- Number of UNIQUE CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT CUSTOMER_ID) FROM RETAIL_SALES1;
--- NUMBER OF UNIQUE CATEGORIES
SELECT COUNT(DISTINCT CATEGORY) FROM RETAIL_SALES1;

--- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS ---26:00 YT
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales1 where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select transactions_id, sale_date, category, quantiy
from retail_sales1
where category = 'Clothing'
  and quantiy >= 4
  and sale_date between '2022-11-01' and '2022-11-30';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,count(total_sale) from retail_sales1 
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age)) from retail_sales1 
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transactions_id,total_sale from retail_sales1 where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select  category, gender,  count(*) from retail_sales1
group by gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales1
GROUP BY 1, 2
) as t1
WHERE rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales1
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count( distinct customer_id),category from retail_sales1 group by category;

-- Q.10 Write a SQL query to create each shift and the number of orders (Example: Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales1
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

---END OF PROJECT