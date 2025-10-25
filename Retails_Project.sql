--creating table
create table retail(
					transactions_id	int primary key,
					sale_date	date,
					sale_time	time,
					customer_id	int,
					gender	varchar(10),
					age	int,
					category varchar(15),	
					quantity	int,
					price_per_unit	int,
					cogs	float,
					total_sale int
					);

--displaying the tab;e
select * from retail;

--counting the number of rows
select count(*) from retail

--Data Cleaning

--checking for null values in transactions_id column
select * from retail
where transactions_id is null

--checking for null values in table
select * from retail
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
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null


-- removing null values
delete from retail
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
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

--DATA ANALYSIS

--how many sales in data?
select count(*) as sales_in_db from retail

--number of unique customers
select count(distinct customer_id) as no_of_customers from retail

--number of categories
select count(distinct category) as no_of_categories from retail

--business problems

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail
where sale_date='2022-11-05'


--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select *
	from retail
where category='Clothing'
	and to_char(sale_date,'YYYY-MM')='2022-11'
	and quantity>=4


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,
		sum(total_sale) as net_sale
		from retail
		group by category



--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age
from retail
where category='Beauty'



--Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
select * from retail
where total_sale>1000



--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,sum(transactions_id)
from retail
group by category,gender
order by 1



--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select extract(Year from sale_date)as year,
		extract(month from sale_date)as month,
		avg(total_sale) as avg_sale
		from retail
		group by year,month
		order by year,avg_sale desc



--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) from retail
		group by customer_id
		order by sum(total_sale) desc
		limit 5



--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
		count(distinct customer_id)
		from retail
		group by category



--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
		case
		when extract(hour from sale_time)<12 then 'Morning'
		when extract(hour from sale_time)between 12 and 16 then 'Afternoon'
		else 'Evening'
		end as shift,
		count(transactions_id)
from retail
group by shift

