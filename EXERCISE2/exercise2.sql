//Write a SQL query to remove the details of an employee whose first name ends in ‘even’
DELETE FROM EMPLOYEES WHERE FIRST_NAME LIKE '%even';

//Write a query in SQL to show the three minimum values of the salary from the table.
SELECT DISTINCT(SALARY) FROM  EMPLOYEES ORDER BY SALARY LIMIT 3;

//Write a SQL query to remove the employees table from the database
DROP TABLE EMPLOYEES;

//Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
CREATE TABLE EMPLOYEE AS SELECT * FROM EMPLOYEES;
TRUNCATE TABLE EMPLOYEES;

//Write a SQL query to remove the column Age from the table
ALTER TABLE EMPLOYEES ADD Age INT;
ALTER TABLE EMPLOYEES DROP COLUMN Age;

//Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME ,EMAIL,YEAR(HIRE_DATE) AS HIRE_YEAR FROM EMPLOYEES WHERE hire_year<2000;

//Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES WHERE YEAR(HIRE_DATE) BETWEEN 1990 AND 1999;

//Find the first occurrence of the letter 'A' in each employees Email ID .Return the employee_id, email id and the letter position
SELECT EMPLOYEE_ID,EMAIL,position('A' IN EMAIL) AS LETTER_POSITION FROM EMPLOYEES;

//Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12
SELECT EMPLOYEE_ID,CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME ,EMAIL FROM EMPLOYEES WHERE LEN(FULL_NAME)<12;

//Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID Return the employee_id, and their corresponding UNQ_ID;
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,'-',LAST_NAME,'-',EMAIL) AS UNQ_ID FROM EMPLOYEES;

//Write a SQL query to update the size of email column to 30
ALTER TABLE EMPLOYEES MODIFY EMAIL varchar(30);

//Fetch all employees with their first name , email , phone (without extension part) and extension (just the extension) Info : this mean you need to separate phone into 2 parts eg: 123.123.1234.12345 => 123.123.1234 and 12345 . first half in phone column and second half in extension column

SELECT FIRST_NAME, EMAIL,
CASE 
    WHEN(LENGTH(PHONE_NUMBER)=12) THEN(SUBSTR(PHONE_NUMBER,0,7))
    WHEN(LENGTH(PHONE_NUMBER)=14) THEN(SUBSTR(PHONE_NUMBER,0,9))
    WHEN(LENGTH(PHONE_NUMBER)=18) THEN(SUBSTR(PHONE_NUMBER,0,11))
END AS PHONE, 
SPLIT_PART(PHONE_NUMBER, '.', -1) as EXTENSION FROM EMPLOYEES;

//Write a SQL query to find the employee with second and third maximum salary.
SELECT * FROM EMPLOYEE WHERE SALARY IN (SELECT DISTINCT(SALARY) FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 2 OFFSET 1);
//OR SALARY = (SELECT DISTINCT(SALARY) FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 1 OFFSET 2) ORDER BY SALARY DESC; 

//Fetch all details of top 3 highly paid employees who are in department Shipping and IT
SELECT * FROM EMPLOYEES AS E, DEPARTMENTS AS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND DEPARTMENT_NAME = 'Shipping'
UNION
SELECT * FROM EMPLOYEES AS E, DEPARTMENTS AS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND DEPARTMENT_NAME = 'IT' ORDER BY SALARY DESC LIMIT 3;

//Display employee id and the positions(jobs) held by that employee (including the current position
SELECT E.EMPLOYEE_ID,J.JOB_TITLE FROM EMPLOYEES AS E , JOBS AS J WHERE E.JOB_ID = J.JOB_ID UNION SELECT H.EMPLOYEE_ID,J.JOB_TITLE FROM JOB_HISTORY AS H, JOBS AS J WHERE H.JOB_ID = J.JOB_ID ORDER BY EMPLOYEE_ID;

//Display Employee first name and date joined as WeekDay, Month Day, Year Eg :Emp ID Date Joinedm 1 Monday, June 21st, 1999
SELECT FIRST_NAME,CONCAT(DAYNAME(HIRE_DATE),',',' ',MONTHNAME(HIRE_DATE),' ',DAY(HIRE_DATE),'st',' ',YEAR(HIRE_DATE)) AS Date_Joined FROM EMPLOYEE;

//The company holds a new job opening for Data Engineer (DT_ENGG) with a minimum salary of 12,000 and maximum salary of 30,000 . The job position might be removed based on market trends (so, save the changes) . - Later, update the maximum salary to 40,000 . - Now, revert back the changes to the initial state, where the salary was 30,000
ALTER SESSION SET autocommit= false;
SELECT * FROM JOBS;
INSERT INTO JOBS VALUES('DT_ENGG','DATA_ENGINEER',12000,30000);
SELECT * FROM JOBS;
COMMIT;
UPDATE JOBS SET MAX_SALARY=40000 WHERE JOB_ID='DT_ENGG';
SELECT * FROM JOBS;
ROLLBACK;
SELECT * FROM JOBS;
ALTER SESSION SET autocommit =true;

//Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals
SELECT ROUND(AVG(SALARY),3) AS AVERAGE FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '1996-01-09' AND '1999-12-31';

//Display Australia, Asia, Antarctica, Europe along with the regions in the region table (Note: Do not insert data into the table)
//A. Display all the regions
SELECT REGION_NAME FROM REGIONS UNION ALL SELECT 'Asia' UNION ALL SELECT 'Australia' UNION ALL SELECT 'Antartica' UNION ALL SELECT 'Europe';
//B. Display all the unique regions
SELECT REGION_NAME FROM REGIONS UNION SELECT 'Asia' UNION SELECT 'Australia' UNION SELECT 'Antartica' UNION SELECT 'Europe';

