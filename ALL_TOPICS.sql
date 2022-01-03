
show databases;
use classicmodels;

show tables; #Tables in classicModels : customers,employees,offices,orderdetails,orders,payments,productlines,products

/*######################################
1.DDL commands are : CREATE,DROP,ALTER,TRUNCATE,RENAME 
2.DML Commands are : SELECT,INSERT,UPDATE,DELETE
3.DCL Commands are : GRANT, REVOKE
4.TCL Commands are : COMMIT,ROLLBACK,SAVEPOINT,SETTRANSACTION
########################################*/

select * from customers;
select customerName , phone,city from customers;

################ 1. DISTINCT CLAUSE : used to return only distinct (different) values from any columns.
select DISTINCT CITY from customers;
select DISTINCT CITY, contactFirstName from customers ORDER BY CITY; # Will return all unique pairs of (city,contactFirstName)

select count(DISTINCT CITY) from customers;
SELECT Count(*) AS DistinctCountries FROM (select DISTINCT CITY from customers) AS T1; ## The same o/p as above

################ 2. WHERE CLAUSE (with : BETWEEN , IN , LIKE):
select * from customers where creditLimit > 21000;
select * from customers where state ='NY';
 
 /* The following operators can be used in the WHERE clause:
=, >, <, >=, <=, <> / !=	Not equal.	
BETWEEN	Between a certain range	
LIKE	Search for a pattern	
IN	To specify multiple possible values for a column */

select * from customers where state IN ("NY","NV","CA","PA"); #Any state from :("NY","NV","CA","PA")
select * from customers where state NOT IN ("NY","NV","CA","PA"); #All state except :("NY","NV","CA","PA")

select * from customers where customerNumber between 100 AND 120; #Any CustomerNumber between 100 and 120. 
select * from customers where contactFirstName LIKE "A%"; #Name Starts with 'A'
select * from customers where contactFirstName LIKE "%s"; #Name ends with 's'
select * from customers where contactFirstName LIKE "%e%"; #Name has 'e' anywhere
select * from customers where contactFirstName LIKE "_r%"; #2nd letter is 'r'


################ 3. AND , OR , NOT (The WHERE clause can be combined with AND, OR, and NOT operators.)

select * from customers where state ='NY' and creditLimit>100000;
select * from customers where state ='NY' OR state ='CA' OR state='PA';
select * from customers where NOT state ='NY'; # All state except 'NY'

################ 4.ORDER BY CLAUSE
select customerNumber , contactFirstName , city , creditLimit from customers ORDER BY creditLimit;  #Ascending
select customerNumber , contactFirstName , city , creditLimit from customers ORDER BY creditLimit DESC; #Descending

select customerNumber , city , creditLimit from customers ORDER BY creditLimit,customerNumber;  #Multi level sort 1st by creditLimit then customerNumber
select customerNumber , city , creditLimit from customers ORDER BY creditLimit,customerNumber DESC;

################ 5. INSERT INTO.
  ##1. Specify both the column names and the values to be inserted:
INSERT INTO table_name (column1, column2, column3) VALUES (value1, value2, value3);
  ##2. INSERT INTO ALL COLUMNS.
 INSERT INTO table_name VALUES (value1, value2, value3); 
 
 ################ 6.  NULL VALUES : "IS NULL" and "IS NOT NULL" operators  : Note: A NULL value is different from a zero value or a field that contains spaces. 
     ##A field with a NULL value is one that has been left blank during record creation! 
 select * from customers where addressLine2 is NULL;
 select * from customers where addressLine2 is NOT NULL;
 
 ################ 7. UPDATE : Modify the existing records in a table.
 UPDATE customers SET contactFirstName = "SirAlex" where customerNumber=114;
 select * from customers;
 UPDATE customers SET contactFirstName = "SirAlexx" , country="UK" where customerNumber=114; ## Update Multiple Columns
 select * from customers;
 
################# 8. DELETE : Used to delete existing records in a table.
 DELETE FROM customers where customerNumber=103; ## Will delete All rows that satisfy the condition.
       # delete all rows in a table without deleting the table. This means that the table structure, attributes, and indexes will be intact:
 DELETE FROM table_name;
 
################# 9 . LIMIT
SELECT * FROM Customers LIMIT 5;
SELECT * FROM Customers WHERE Country='Germany' LIMIT 3;
 
################# 10. MIN() and MAX() Functions alter
SELECT min(customerNumber) , max(customerNumber) , min(creditLimit) , max(creditLimit) ,min(postalCode) from customers;
SELECT * FROM Customers ;
 
################## 11. COUNT(), AVG() and SUM() Functions
 SELECT COUNT(creditLimit) , AVG(creditLimit) , SUM(creditLimit) from customers;
 
################### 12. WILDCARDS : '%' , '_' , '[charlist]' , '[!charlist]'
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE "A%";
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE "%s"; 
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE "_s%"; #2nd character is 's'
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE "__s%";  #3rd character is 's'
 
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE '[SNV]%';
 select customerNumber , contactLastName , contactFirstName from customers where contactFirstName LIKE '[ABC]%';
  
################### 13. BETWEEN : Selects values within a given range. The values can be NUMBERS, TEXT, or DATES.

 SELECT * FROM Customers;
 SELECT * FROM Customers where state BETWEEN 'CA' and 'CT' ORDER BY state; # IMP TO ORDER BY STATE 
 SELECT * FROM Customers where city BETWEEN 'Cambridge' and 'Cork' ORDER BY city;  # All cities starting from 'C' to 'M' , NOT SHOWING CITIES WITH 'N'.
  
################### 14. Aliases  : used to give a table, or a column in a table, a temporary name.
           /* Every derived table (AKA sub-query) must indeed have an alias. I.e. each query in brackets must be given an alias ( AS whatever ),
		     which can the be used to refer to it in the rest of the outer query. */

 select customerNumber as C1 , state as S1 from customers;  
 select * from customers AS TABLE1; # Alias name for the Table
 
################### 15. UNION , UNION ALL : https://dataschool.com/learn-sql/what-is-the-difference-between-union-and-union-all/
		/* The UNION operator is used to combine the result-set of two or more SELECT statements.
			Every SELECT statement within UNION must have the same number of columns
			The columns must also have similar data types
			The columns in every SELECT statement must also be in the same order*/
 /* UNION: only keeps unique records
    UNION ALL: keeps all records, including duplicates
*/  ## DEMO DATASET TO SEE EXAMPLES
  CREATE TABLE TableA(ID INT);
  INSERT INTO TableA VALUES(1),(2),(3),(4);
  Select * from TableA;  
  
  CREATE TABLE TableB(ID INT);
  INSERT INTO TableB VALUES(3),(4),(5),(6);
  Select * from TableB;  
 
 ### UNION : only keeps unique records.
SELECT ID  FROM TableA UNION SELECT ID  FROM TableB; 
 ### UNION ALL : keeps all records, including duplicates.
SELECT ID  FROM TableA UNION ALL SELECT ID  FROM TableB; 
 
#################### 16. GROUP BY : aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG())
 select count(*) ,country from customers GROUP BY country;
 select sum(creditLimit) ,country from customers GROUP BY country;
 select AVG(creditLimit) ,country from customers GROUP BY country;
       ## ORDEY BY 2 Columns : https://stackoverflow.com/questions/2421388/using-group-by-on-multiple-columns 
 select country , city , AVG(creditLimit) from customers GROUP BY country,city ORDER BY country;
  
#################### 17. HAVING : HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions (ex : GROUP BY).
		## WRITTEN AFTER THE "GROUP BY" CLAUSE
 select AVG(creditLimit) ,country from customers  GROUP BY country HAVING AVG(creditLimit) >80000;
 select AVG(creditLimit) AS C1,country from customers  GROUP BY country HAVING C1 >80000;
 
#################### 18. EXISTS :Used to TEST EXISTENCE of any record in a SUBQUERY.EXISTS returns TRUE if the subquery RETURNS 1 OR MORE RECORDS.
 SELECT * from customers where EXISTS (select * from customers where country='UK'); # Subquery returns TRUE so we will get output of OUTER query.
 
 SELECT * from customers where EXISTS (select * from customers where country='UKE'); # Subquery returns FALSE so we will get output of OUTER query.
 
#################### 19. ANY, ALL


#################### 20. 'INSERT INTO SELECT' : Copies data from one table into a new table.
 create table IF NOT EXISTS new_table (ID INT , CITYYYY varchar(20));
 
 insert into new_table select customerNumber , city from customers;  
 select * from new_table;
 
#################### 21. CASE :
	/* The CASE statement goes through conditions and returns a value when the first condition is met (like an if-then-else statement). So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.
       If there is no ELSE part and no conditions are true, it returns NULL.*/
  
  select * from customers;
  select customerNumber , country,
	CASE
		WHEN country='USA' THEN "USA"
        WHEN country="UK" THEN "UK"
        ELSE "NOT USA" 
        END AS ISUSA
    from customers;    

#################### 22. NULL FUNCTIONS :    IFNULL(), ISNULL(), COALESCE(), and NVL() 
	/* 
    - IFNULL() :lets you return an alternative value if an expression is NULL. ex :IFNULL(UnitsOnOrder, 0) i.e will return 0 if UnitsOnOrder is Null.
    - ISNULL() : Returns 1 if expression is NULL, 0 if not NULL	*/
	
select customerNumber , contactLastName , creditLimit , state , ISNULL(State) AS STATE1 from customers ;
select customerNumber , contactLastName , creditLimit , state , IFNULL(State , "STATE IS NULL") AS STATE1 from customers ;

#################### 23. Stored Procedure :  Prepared SQL code that you can save, so the code can be reused over and over again.

DELIMITER $$
	CREATE PROCEDURE GetCustomers()
	BEGIN
		SELECT customerNumber , customerName , city from customers;
    END$$
Delimiter ;    

CALL GetCustomers();

#########################

