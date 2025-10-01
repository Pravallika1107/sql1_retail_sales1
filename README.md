# sql1_retail_sales1
**Project Overview**
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Project Title: Retail Sales Analysis
Level: Beginner
Database: sqlproject1

Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

--- **CREATE DATABASE SQLPROJECT1**
drop database if exists sqlproject1;
create database sqlproject1;

--- **CREATE TABLE retail_sales1** 
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
2.**DATA EXPLORATION AND CLEANING**
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.

select * 
from retail_sales1;

--- **count of records**
select count (*) from retail_sales1;

----**DATA WITH NULL VALUES**---
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
-----------OR---------------
--- **DATA WITH NULL VALUES**
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
   
--- **DATA CLEANING**
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
   
--- **DATA EXPLORATION**

--- NUMBER OF UNIQUE TRANSACTIONS
SELECT COUNT(DISTINCT TRANSACTIONS_ID) FROM RETAIL_SALES1;

--- **Number of UNIQUE CUSTOMERS WE HAVE**
SELECT COUNT(DISTINCT CUSTOMER_ID) FROM RETAIL_SALES1;

--- **NUMBER OF UNIQUE CATEGORIES**
SELECT COUNT(DISTINCT CATEGORY) FROM RETAIL_SALES1;

**3. DATA ANALYSIS AND FINDINGS**
**The following SQL queries were developed to answer specific business questions:**

-- Q.1**Write a SQL query to retrieve all columns for sales made on '2022-11-05'**
           select * from retail_sales1 where sale_date = '2022-11-05';

-- Q.2 **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**
           select transactions_id, sale_date, category, quantiy
           from retail_sales1
           where category = 'Clothing'
           and quantiy >= 4
           and sale_date between '2022-11-01' and '2022-11-30';


-- Q.3**Write a SQL query to calculate the total sales (total_sale) for each category.**
          select category,count(total_sale) from retail_sales1 
          group by category;

-- Q.4 **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
         select round(avg(age)) from retail_sales1 
         where category = 'Beauty';

-- Q.5 **Write a SQL query to find all transactions where the total_sale is greater than 1000.**
         select transactions_id,total_sale from retail_sales1 where total_sale > 1000;

-- Q.6 **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
         select  category, gender,  count(*) from retail_sales1
         group by gender, category;

-- Q.7 **Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year**
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


-- Q.8 **Write a SQL query to find the top 5 customers based on the highest total sales**
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales1
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
-- Q.9 **Write a SQL query to find the number of unique customers who purchased items from each category.**
select count( distinct customer_id),category from retail_sales1 group by category;

-- Q.10 **Write a SQL query to create each shift and the number of orders (Example: Morning <=12, Afternoon Between 12 & 17, Evening >17)***
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

**FINDINGS**
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

**REPORTS**
Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: Insights into sales trends across different months and shifts.
Customer Insights: Reports on top customers and unique customer counts per category.
Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
