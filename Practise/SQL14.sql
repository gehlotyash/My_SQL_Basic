# Datasets used: employee.csv and membership.csv

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Schema EmpMemb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS SQL2Takehome3;
USE SQL2Takehome3;


-- 1. Create a table Employee by refering the data file given. 

-- -- Follow the instructions given below: 
-- -- Q1. Values in the columns Emp_id and Members_Exclusive_Offers should not be null.
-- -- Q2. Column Age should contain values greater than or equal to 18.
-- -- Q3. When inserting values in Employee table, if the value of salary column is left null, then a value 20000 should be assigned at that position. 
-- -- Q4. Assign primary key to Emp_ID
-- -- Q5. All the email ids should not be same.
create table employees
(	
	Emp_id varchar(3) not null primary key,
	Name varchar(50),
    Age int check(age>=18),
    `E-mail` varchar(100) unique,
    salary int default 20000,
    `Members Exclusive Offers` varchar(5) not null
);

describe employees;

-- 2. Create a table Membership by refering the data file given. 

-- -- Follow the instructions given below: 
-- -- Q6. Values in the columns Prime_Membership_Active_Status and Employee_Emp_ID should not be null.
-- -- Q7. Assign a foreign key constraint on Employee_Emp_ID.
-- -- Q8. If any row from employee table is deleted, then the corresponding row from the Membership table should also get deleted.

create table memberships
(	
	Employee_Emp_id varchar(3) not null,
	Prime_Membership_Active_Status varchar(5) not null,
    Enrollment_Date varchar(15),
    End_Date varchar(15),
	Foreign Key (Employee_Emp_id)
    references employees(Emp_id)
    on update restrict on delete cascade
);

describe memberships;