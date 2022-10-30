Create database Sql2Inclass3;
use Sql2Inclass3;

-- ------------------------------------------------------------------------------------------

-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null and Integer type.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should beaccepted
-- -- Q4. Assign primary key to Flight_ID
create table Airline_Details
(
	Flight_Id int primary key,
	Airline_Name varchar(100) not null unique,
	Country varchar(50) not null 
    check(country in ('United Kingdom', 'USA', 'India', 'Canada', 'Singapore'))
);

describe Airline_Details;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Name of the passenger should be not null
-- -- Q3. Only passengers having age greater than 18 are allowed.
-- -- Q4. Assign primary key to Traveller_ID
-- -- Q5. Flight_ID integer type and not null
-- -- Q6. Ticket_Price integer type and not null
create table Passengers
(
	Traveller_Id varchar(5) not null primary key,
    Name varchar(50) not null,
    PNR varchar(10) not null,
    Flight_Id int not null,
	Ticket_Price int not null,
	Age int check(age>18)
);

describe Passengers;

-- ----------------------------------------------------------------------------------
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique as well  .
alter table Passengers modify PNR varchar(10) unique;

-- ----------------------------------------------------------------------------------
-- -- Q4. Flight Id should not be null.
alter table Passengers modify Flight_Id int not null;

-- ---------------------------------------------------------------------------------- 
-- Q5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- Q2. Also deletion of any row from passenger table should not be allowed.
-- -- Q3. Create Discounted_Price column of varchar type 20 size with not null property.
create table Senior_Citizen_Details
(
	Traveller_Id varchar(5),
    Discounted_Price varchar(20),
    Foreign Key (Traveller_Id)
    references Passengers(Traveller_Id)
    on update cascade on delete restrict
);
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Q1. The cost should not be less than or equal to 0.
-- -- Q2. The cost column should not be null.
-- -- Q3. Assign a primary key to the column books_no.
create table books
(
	Book_No int primary key,
    Description varchar(100) null,
    Author_Name varchar(20) null,
    Cost int not null check(cost>0)
);


-- ---------------------------------------------------------------------------------------------------------------------------------------------------
# Q7. Update the table 'books' to add columns 'description' and 'author' and must be unique
# of varchar type.
alter table books modify Description varchar(50) unique, modify Author_Name varchar(20) unique;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q8. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
create table Bike_Sales
(
	Id int primary key auto_increment,
    Product varchar(15) not null,
    Quantity int not null check(Quantity>0),
    Release_Year int check(Release_Year between 2000 and 2010),
    Release_Month int check(Release_Month between 1 and 12)
);
