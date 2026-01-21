create database raw_store;
use raw_store;
## creating a table to load data
create table raw_superstore (
row_id int,
order_id varchar(20),
order_date varchar(20),
ship_date varchar(20),
ship_mode varchar(20),
customer_id varchar(20),
customer_name varchar(100),
segment varchar(50),
country varchar(50),
city varchar(50),
state varchar(50),
postal_code varchar(20),
region varchar(50),
product_id varchar(30),
category varchar(50),
sub_category varchar(50),
product_name varchar(200),
sales decimal(12,2),
quantity int,
discount decimal(5,2),
profit decimal(12,2)
);

## verify Load 
select count(*) from raw_superstore;
select * from raw_superstore limit 5;

## creating clean analytics table 
## table sales_transaction-fact table
create table sales_transaction as
select
order_id,
str_to_date(order_date, '%m/%d/%Y') as order_date,
product_id,
customer_id,
region,
sales as revenue,
discount,
quantity,
(sales - profit) as cost
from raw_superstore;

## table products - dimension table
use raw_store;
create table product as 
select distinct
product_id,
product_name,
category,
sub_category
from raw_superstore;

## table customers - dimension table
create table customers as 
select distinct
customer_id,
segment
from raw_superstore;

## table regions - dimension table
create table regions as 
select distinct
region,
country
from raw_superstore;

## table calender - dimension table
create table calender as 
select distinct
str_to_date(order_date, '%m/%d/%Y') as date,
year(str_to_date(order_date, '%m/%d/%Y')) as year,
month(str_to_date(order_date, '%m/%d/%Y')) as month,
quarter(str_to_date(order_date, '%m/%d/%Y')) as quarter
from raw_superstore;

## Data Validation
select count(*) from raw_superstore;
select count(*) from sales_transaction;

## Revenue and profit check
select 
round(sum(revenue),2) as total_revenue,
round(sum(cost),2) as total_cost,
round(sum(revenue - cost),2) as total_profit
from sales_transaction;

select 
round(sum(sales),2) as raw_revenue,
round(sum(profit),2) as raw_profit
from raw_superstore;

## SQL KPI Query set
## monthly revenue and profit(foundation KPI)
select
date_format(order_date, '%Y-%m') as month,
round(sum(revenue),2) as total_revenue,
round(sum(revenue - cost),2) as total_profit,
round(sum(revenue - cost)/sum(revenue) * 100,2) as gross_margin_pct
from sales_transaction 
group by date_format(order_date, '%Y-%m')
order by month;

## Month-over-Month (MoM) Revenue Growth %

with monthly_revenue as (
select
date_format(order_date, '%Y-%m') as month,
sum(revenue) as revenue
from sales_transaction
group by date_format(order_date, '%Y-%m')
)
select
month,
round(revenue,2) as revenue,
round(
(revenue - lag(revenue) over (order by month)) /
lag(revenue) over (order by month) * 100, 2) as mom_growth_pct
from monthly_revenue
order by month;

## Revenue Contribution by Product Category
select p.category,
round(sum(s.revenue),2) as category_revenue,
round(
sum(s.revenue) /
(select sum(revenue) from sales_transaction) * 100, 2) as contribution_pct
from sales_transaction s
join product p on s.product_id = p.product_id
group by p.category
order by category_revenue desc;

## Region-wise Revenue & Profitability
select
region,
round(sum(revenue), 2) as total_revenue,
round(sum(revenue - cost), 2) as total_profit,
round(sum(revenue - cost) / sum(revenue) * 100, 2) as margin_pct
from sales_transaction
group by region
order by total_revenue desc;

## Discount vs Margin Impact 
select
case
when discount = 0 then 'No discount'
when discount <= 0.2 then 'Low discount'
when discount <= 0.5 then 'Medium discount'
else 'High discount'
end as discount_band,
round(sum(revenue),2) as total_revenue,
round(sum(revenue - cost) / sum(revenue) * 100, 2) as margin_pct
from sales_transaction
group by discount_band
order by margin_pct desc;
use raw_store;
DROP TABLE IF EXISTS product;
CREATE TABLE product AS
SELECT
  product_id,
  MAX(product_name) AS product_name,
  MAX(category) AS category,
  MAX(sub_category) AS sub_category
FROM raw_superstore
GROUP BY product_id;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
SELECT
  customer_id,
  MAX(segment) AS segment
FROM raw_superstore
GROUP BY customer_id;

select round(sum(revenue),2) from sales_transaction ;

select date_format(order_date, '%Y-%m-01') as month,
sum(revenue) as monthly_revenue
from sales_transaction
group by month
order by month;