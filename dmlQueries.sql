create database ecommerce;

use ecommerce;

select * from product


--Select all products with brand “Cacti Plus”

select * from product
where brand='Cacti Plus'


--Count of total products with product category=”Skin Care”

select COUNT (*) from product
where category ='Skin Care'

--Count of total products with MRP more than 100

select COUNT (*) from product
where mrp >100

--Count of total products with product category=”Skin Care” and MRP more than 100

select COUNT (*) from product
where category= 'Skin Care' and mrp > 100

--Brandwise product count

select product.brand, count (product.product_id) from product	
group by brand

--Brandwise as well as Active/Inactive Status wise product count

select product.brand,
	sum(case when active = 'Y' then 1 else 0 end) as active,
	sum(case when active = 'N' then 1 else 0 end) as inactive,
	COUNT(*) AS totals
from product
group by brand


--Display all columns with Product category in Skin Care or Hair Care

select * from product
where category = 'Skin Care' or category = 'Hair Care'

--Display   all   columns   with   Product   category=”Skin   Care”   and Brand=”Pondy”, and MRP more than 100

select * from product
where mrp>100 and (category='Skin Care' and brand='Pondy');

--Display   all   columns   with   Product   category   ="Skin   Care"   or Brand=”Pondy”, and MRP more than 100

select * from product
where mrp>100 and (category='Skin Care' or brand='Pondy');

--Display all product names only with names starting from letter P

select * from product
where product_name like 'P%'

--Display  all product  names only with names Having letters “Bar”  in Between

select * from product
where product_name like '%Bar%'


select * from sales


--Sales of those products which have been sold in more than two quantity in a bill
select * from sales
where qty > 2

--Sales of those products which have been sold in more than two quantity throughout the bill
select product_id, SUM(qty) quantity from sales 
group by product_id having SUM(qty) > 2



/*
Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
After populating the data, find no of people sharing
Birth date
Birth month
Weekday
Find the current age of all people
*/

drop table if exists person;

create table person(
    name varchar(50),
    birthdate date
);

bulk insert dbo.person
from 'D:\01. Desktop\LeapFrog\sql_learn\dates.csv'
with (
  firstrow = 2,
  fieldterminator = ',',
  rowterminator = '\n'
  )

select * from person

--no of people sharing Birth date

select COUNT(name) 
from person 
where birthdate 
    IN (
     select birthdate
     from person
     group by birthdate
     having COUNT(birthdate) > 1
    )

--

select birthdate,
	MONTH(birthdate) birthmonth
from person
--

select COUNT(name) ,
    DATENAME(weekday, GETDATE()) as WEEKDAY
from person

--

select   *, 
	DATEDIFF(year, birthdate, GETDATE()) Age
from     person
