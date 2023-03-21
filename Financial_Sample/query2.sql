select * from financial_sample;

-- There are 5 segments from which sales has happened.
select count(distinct segment) from financial_sample;
-- Most of the sales are done by Government. And rest are done by other segments with equal distribution
select segment, count(segment) from financial_sample
group by segment;

-- There are 5 countries that has done the sales.
select count(distinct country) from financial_sample;
select country, count(country) from financial_sample
group by country;

-- All countries have same count of distribution
select country, count(country) from financial_sample
group by country;

-- There are 6 products
select count(distinct product) from financial_sample;
-- Paseo is the most selling product. And the least selling products are Carretera and Montana
select product, count(product) from financial_sample
group by product;

-- Maximum units sold are 4492
select max(units_sold) from financial_sample;

-- Canada Government has made more sales for the Product Carretera
select segment, country, Product, count(Product) from financial_sample
group by segment;

select segment, Product, count(Product) as USA from financial_sample
where country = "Canada"
group by Product;

select segment, Product, count(Product) as USA from financial_sample
where country ="Canada"
group by Product;

select segment, Product,
count(case when country = "Canada" then Product end) as "Canada",
count(case when country = "France" then Product end) as "France",
count(case when country = "Germany" then Product end) as "Germany",
count(case when country = "Mexico" then Product end) as "Mexico",
count(case when country = "United States of America" then Product end) as "USA"
from financial_sample
group by Product;

select segment, Product,
count(case when country = "Canada" then Product end) as "Canada",
count(case when country = "France" then Product end) as "France",
count(case when country = "Germany" then Product end) as "Germany",
count(case when country = "Mexico" then Product end) as "Mexico",
count(case when country = "United States of America" then Product end) as "USA"
from financial_sample
group by Segment;

-- Total Sales 
select sum(Gross_Sales) from financial_sample;