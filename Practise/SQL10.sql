# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS SQL2Takehome1;
USE SQL2Takehome1;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees 
#whose salary is greater than the average salary of all the employees.(11 Rows)
select employee_id, first_name, last_name, salary
from employee_details
where salary > (select avg(salary) from employee_details);


#Q2. Display first_name , last_name and department_id of those employee where the
# location_id of their department is 1700(3 Rows)
select employee_id, first_name, last_name, d.department_id
from employee_details e
join department_details d
using(department_id)
where location_id=1700;

select employee_id, first_name, last_name, department_id
from employee_details
where department_id in 
(select department_id 
from department_details
where location_id=1700);


#Q3. From the table employees_details, extract the employee_id, first_name, last_name,
# job_id and department_id who work in  any of the departments of Shipping,
# Executive and Finance.(9 Rows)
select employee_id, first_name, last_name, job_id, d.department_id
from employee_details e
join department_details d
using(department_id)
where d.department_name in 
(select department_name 
from department_details 
where department_name 
in ('Shipping','Executive','Finance'));

select employee_id, first_name, last_name, department_id
from employee_details
where department_id in 
(select department_id 
from department_details 
where department_name in ('Shipping','Executive','Finance'));


#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the 
#CLERKS who earn more than the salary of any IT_PROGRAMMER.(3 Rows)
select employee_id, first_name, last_name, job_id, phone_number, email
from employee_details 
where job_id like '%CLERK%'
and salary > any(select salary from employee_details where job_id like 'IT_PROG');


#Q5. Extract employee_id, first_name, last_name,salary, phone_number, 
#email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.(2 Rows)
select employee_id, first_name, last_name, job_id, phone_number, email
from employee_details
where job_id like 'AC_ACCOUNTANT'
and salary > all(select salary from employee_details where job_id like 'AD_VP');


#Q6. Write a Query to display the employee_id, first_name, last_name,
# department_id of the employees who have been recruited after the middle(avg) hire_date. (10 Rows)
select employee_id, first_name, last_name, d.department_id, hire_date
from employee_details e
join department_details d
using(department_id)
order by str_to_date(hire_date, '%d-%m-%y') desc
limit 10;


#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id 
#of the employees belonging to the 'Contracting' department (3 Rows)
select employee_id, first_name, last_name, phone_number, salary, job_id
from employee_details
where department_id = any(select department_id from department_details where department_name like 'contracting');



#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the
# employees who does not belong to 'Contracting' department(18 Rows)
select employee_id, first_name, last_name, phone_number, salary, job_id
from employee_details
where department_id <> all(select department_id from department_details where department_name like 'contracting');

#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the 
#employees who were recruited first in the department(7 Rows)
select employee_id, first_name, last_name, salary, hire_date, job_id, department_id
from employee_details
where str_to_date(hire_date, '%d-%m-%y') in 
(select min(str_to_date(hire_date, '%d-%m-%y'))
from employee_details group by department_id);


#Q10. Display the employee_id, first_name, last_name, salary and job_id of the 
#employees who earn maximum salary for every job.( 7Rows)
select employee_id, first_name, last_name, salary, job_id,department_id
from employee_details
where salary in(select max(salary) from employee_details group by department_id)
order by department_id;

