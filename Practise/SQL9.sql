# Dataset used: titanic_ds.csv
# Use subqueries for every question
Create database SQL2Inclass1;
use SQL2Inclass1;
#Q1. Display the first_name, last_name, passenger_no , 
#fare of the passenger who paid less than the  maximum fare. (20 Row)
select First_name, Last_name, fare 
from titanic_ds
where fare<(select max(fare) from titanic_ds);


#Q2. Display the first_name ,sex, age, fare and deck_number of the passenger 
#equals to passenger number 7 but exclude passenger number 7.(4 Rows)
select first_name, sex, age, fare, deck_number 
from titanic_ds
where deck_number = (select deck_number from titanic_ds where passenger_no = 7) and passenger_no!=7;


#Q3. Display first_name,embark_town where deck is equals to the deck of embark
# town ends with word 'town' (7 Rows)
select first_name, embark_town 
from titanic_ds
where deck = any(select deck from titanic_ds where embark_town like '%town');

# Dataset used: youtube_11.csv

#Q4. Write a query to print video_id and channel_title where trending_date is equals to 
#the trending_date of  category_id 1(5 Rows)
select video_id, channel_title 
from youtube_11
where trending_date = all(select trending_date from youtube_11 where category_id=1);


#Q5. Write a query to display the publish date, trending date ,views and description 
#where views are more than views of Channel 'vox'.(7 Rows))
select Publish_date, trending_date, views, Description 
from youtube_11
where views > (select views from youtube_11 where channel_title like 'vox');


#Q6. Write a query to display the channel_title, publish_date and the trending_date 
#having category id in between 9 to Maximum category id .
# Do not use Max function and Use Subquery (3 Rows)
select Category_id, Channel_title, Publish_date, trending_date 
from youtube_11
where category_id >= 9;

# Database used: db1 (db1.sql file provided)

#Q7. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))
select * from orders 
where status = 'cancelled'
and customernumber in (select customernumber from payments where amount>100000);


#Q8. Get employee details who shipped an order within a time span of two days 
#from order date (15 Rows)
select * 
from employees e join customers c
on e.employeenumber= c.salesrepemployeenumber
join orders o
on o.customernumber=c.customernumber
where datediff(o.orderdate,o.shippeddate)<3
group by employeenumber;


select * from employees 
where employeenumber = any (select salesrepemployeenumber from customers 
where customernumber=any(select customernumber from orders 
where datediff(orderdate,shippeddate)<3));


#Q9. Get product name , product line , product vendor of products that got cancelled(53 Rows)
 select ProductName, ProductLine, ProductVendor 
 from products p join orderdetails od
 using(productcode)
 join orders o
 using(ordernumber)
 where o.status = 'cancelled'
 group by productName;
 
 
#Q10. Display those customers who ordered product of price greater than average price(buyPrice)
#of all products(98 Rows)
select  * from customers 
where customernumber = any (select customernumber from orders
where ordernumber = any (select ordernumber from orderdetails
where productcode = any (select productcode from products 
where buyprice>
(select avg(buyprice) from products)
)));





