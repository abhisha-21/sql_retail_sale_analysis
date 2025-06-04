create database sql_project;
use sql_project;
create table sales(
           transactions_id	 INT,
           sale_date DATE,
           sale_time TIME,
           customer_id	INT,
           gender VARCHAR(15),	
           age	int,
           category	VARCHAR(15),
           quantity	int,
           price_per_unit	float,
           cogs	float,
           total_sales float);
------ question 1------
select * from sales;
------ question 2------
select count(*) from sales;

------ question 3------

select * from sales 
where transactions_id is null
      or sale_date is null
      or age is null
      or sale_time is null
      or category is null
      or quantity is null
      or price_per_unit is null
      or cogs is null
      or total_sales is null;
      
      ------ question 4------

select distinct category from sales;

------ question 5------

select * from sales where sale_date='2022-11-05';

------ question 6------

select category,sum(total_sales),count(*) as total_order from sales
group by category;

------ question 7-----

select category, sum(quantity), count(*) as total_order from sales group by category;

------ question 8------

select * from sales where category='Clothing' AND quantity>=4 and YEAR(sale_date) = 2022 AND MONTH(sale_date) = 11;

------ question 9------

select round(avg(age),2) from sales where category='Beauty';

------ question 10------

select * from sales where total_sales > 1000;

------ question 11------

select category,gender,count(transactions_id) from sales group by category,gender order by 1;

------ question 12------

SELECT *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sales), 2) AS sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sales) DESC
        ) AS rnk
    FROM sales
    GROUP BY year, month
) AS t1;

------ question 13------

select customer_id,sum(total_sales) as total_sale from sales
group by 1
order by 2 DESC
limit 5;

------ question 14------

 with hourly_sales as
 (select *,
 case
 when  EXTRACT(HOUR FROM sale_time)<12 then 'Morning'
 when  EXTRACT(HOUR FROM sale_time) between 12 and 17 then 'Afternoon'
 else 'Evening'
 end as shift from sales)

select shift, count(*) from hourly_sales group by shift order by 1 asc;

---- END OF PROJECT -----
