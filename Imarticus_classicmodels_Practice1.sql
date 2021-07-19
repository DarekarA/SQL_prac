# Check whichall Databases are present
show databases; 

# Select Databases ----------------------------------------------------------------------------------------------
use classicmodels;



# Select Statements -----------------------------------------------------------------------------------------------------

# 1. Select all columns from Table
select * from orders;

# 2. Select multiple  columns from Table
select status,orderNumber from orders;



### SORT Data  ------------------------------------------------------------------------------------------------------------------------
select * from customers;

# 1. Sort customer by values in contactLastName column in Ascending order
select * from customers order by contactLastName ASC;

# 2. Sort customer by values in contactLastName column in Descending order
select * from customers order by contactLastName DESC;

# 3. Sort customer by lastname descending and first name in Ascending
   #(Read carefully to understand) First sort on lastname,then sort its groups based in firstname
select * from customers order by contactLastName DESC,contactFirstName ASC; 



# 4. select the orderline items from orderdetails table.
     # Calculates the subtotal for eachline item and sorts the result set based on subtotal.
select * from orderdetails;

select orderNumber,orderlinenumber, quantityordered * priceeach from orderdetails order by quantityordered * priceeach DESC;    
    
    ## OR   (Same thing but using an alais (To make it look better and short code))
    
SELECT 
    orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach AS subtotal
FROM
    orderdetails
ORDER BY subtotal DESC;    


# DAY 2 -----------------------------------------------------------------------------------------------------------

# Operator Description
/*
= Equal to. You can use it with almost any data types.
<> or != Not equal to ==
< Less than. You typically use it with numeric and date/time data types.
> Greater than.
<= Less than or equal to
>= Greater than or equal to

# filtering clause

1. AND
2. OR
3. LIKE
4. IN
5. BETWEEN
6. LIMIT
7. IS NULL

# Wildcard
1. % => Any number of random characters allowed
2. _ => Specific number of random characters allowed

*/


## WHERE (FILTER) CLAUSE -----------------------------------------------------------------------------------------------

#1. Find all employess whose job title = Sales Rep
select * from employees;

select lastName,firstname,jobtitle from employees where jobtitle="sales rep"; # USE SINGLE = TO COMPARE.

#2. Find all employess whose job title = Sales Rep and office code = 1 
select lastName,firstname,jobtitle,officeCode from employees where jobtitle="sales rep" and officeCode="1";

#3. job title = Sales Rep OR office code = 1 
select lastName,firstname,jobtitle,officeCode from employees where jobtitle="sales rep" or officeCode="1";

#4. finds employees whose last names end with the string 'son':

# % => Any number of random characters allowed
# _ => Specific number of random characters allowed

select lastName,firstname from employees where lastName LIKE '%son';

# 5 To find employees whose first names start with T, end with m, 
    #and contain any single character between e.g., Tom , Tim T%m
select lastName,firstname from employees where firstname LIKE 't%m';

# 6. find all employees whose last names contain on
select lastName,firstname from employees where lastName LIKE '%on%';

# 7. finds customers who locate in
     # California, USA, and have the credit limit greater than 100K.
select * from customers;
select customerName,country, state , city , creditLimit  from customers where country="USA" and state="CA" and creditLimit>=100000;

# 8. finds customers who locate in  California or USA, and have the credit limit greater than 10K.
select customerName,country, state , city , creditLimit  from customers where country="USA" or state="CA" and creditLimit>=100000;

# 9. select orders from givin order number (10165,10287,10310) ;
select * from orders;

select * from orders where orderNumber in (10165,10287,10310);


# 10. find products whose buy prices us between 90 and 100
select * from products;

select productName,buyPrice from products where buyPrice between 90 and 100;
select productName,buyPrice from products where buyPrice >= 90 and buyPrice <=100;
# OR
select productName,buyPrice from products where buyPrice >= 90 and buyPrice <=100;

# 11. find top five customers who have the highest credit:
SELECT customerName,creditLimit FROM customers ORDER BY creditLimit DESC LIMIT 5;

# 12. find customers who dont have salesRepEmployeeNumber
SELECT customerName , salesRepEmployeeNumber FROM customers where salesRepEmployeeNumber is  null;

# 13. find customers who have salesRepEmployeeNumber
SELECT customerName , salesRepEmployeeNumber FROM customers where salesRepEmployeeNumber is not null;




## DISTINCT CLAUSE

# 1. Select unique lastnames from employees
select * from employees;

select distinct lastName from employees;

# 2. get unique comnbination of city and state from customer tables
select * from customers;

select distinct state,city from customers where state is not null;


# Manage Databases -----------------------------------------------------------------------------------------------

# Select Database
use classicmodels;

# Get Name of Current DB
select database();

# Create Database "mydb"
CREATE DATABASE IF NOT EXISTS mydb;



# MYSQL CREAT TABLE ----------------------------------------------------------------------------------------------
create table IF NOT EXISTS test(col1 int , col2 varchar(255));

# 1. Create a table names Tasks
CREATE TABLE IF NOT EXISTS tasks(
task_id INT auto_increment primary key, # like an index, will increment for each record
title varchar(255) NOT NULL , # Cant be blank
start_date date,
due_date date,
status tinyint not null,
priority tinyint not null,
description text,
created_at timestamp default current_timestamp
);

# check the structure of the tabel;
DESCRIBE task;
select * from task;

# 2. CREATE TABLE with a foreign key primary key

CREATE TABLE IF NOT EXISTS checklists (
todo_id INT AUTO_INCREMENT PRIMARY KEY,
task_id INT,
todo VARCHAR(255) NOT NULL,
is_completed BOOLEAN NOT NULL DEFAULT FALSE,
FOREIGN KEY (task_id)
REFERENCES task (task_id)
ON UPDATE RESTRICT ON DELETE CASCADE
);




