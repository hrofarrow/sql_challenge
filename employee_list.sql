-- Create tables for CSV files
CREATE TABLE titles (
	title_id VARCHAR (255) PRIMARY KEY NOT NULL, 
	title VARCHAR(20)
);

CREATE TABLE departments (
	dept_no VARCHAR(20) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(20) 
);

CREATE TABLE employeeDepartments (
	emp_no int PRIMARY KEY, 
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE deptmanagers (
	dept_no VARCHAR (10) NOT NULL,
	emp_no int,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE salaries (
	emp_no int NOT NULL,
	salary int,
	FOREIGN KEY (emp_no) REFERENCES employeeDepartments(emp_no)
);

CREATE TABLE employees (
	emp_no int, 
	emp_title_id VARCHAR(255),
	birth_date VARCHAR(255),
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	sex VARCHAR(2),
	hire_date VARCHAR(255)
);

-- Query different tables and scenerios 
SELECT * FROM employees;

-- create list only employee number, last name, first name, sex, and salary
CREATE TABLE employee_info AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM salaries AS s
INNER JOIN employees AS e ON
e.emp_no = s.emp_no;

SELECT * FROM employee_info;
-- List first name, last name, and hire date for employees who were hired in 1986.
--- Extract Year  and employee number only 
CREATE TABLE hire_year_table AS
SELECT DATE_PART('year', hire_date::date), emp_no from employees;
SELECT * FROM hire_year_table; 

--- Join both tables 
CREATE TABLE eighties_employees AS
SELECT e.emp_no, e.first_name, e.last_name, h.date_part
FROM hire_year_table AS h
INNER JOIN employees AS e ON
e.emp_no = h.emp_no
WHERE date_part = '1986';

SELECT * FROM eighties_employees;

-- List the manager of each department with the following information: department number, 
-- department name, the manager's employee number, last name, first name.
CREATE VIEW managers_list AS
SELECT t.title_id, d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name  
FROM titles AS t
JOIN employees AS e
ON (t.title_id = e.emp_title_id)
  JOIN employeedepartments AS ed
  ON (ed.emp_no = e.emp_no)
    JOIN departments AS d
    ON (d.dept_no = ed.dept_no)
	WHERE t.title_id = 'm0001';

SELECT * FROM managers_list;

--List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

CREATE VIEW department_list AS
SELECT d.dept_no, d.dept_name, ed.emp_no, e.last_name, e.first_name
FROM departments AS d
JOIN employeedepartments AS ed
ON (ed.dept_no = d.dept_no)
  JOIN employees AS e
  ON (e.emp_no = ed.emp_no);
  
SELECT * FROM department_list;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
--- Pull out only first names that are "hercules"
CREATE TABLE hercules AS
SELECT e.first_name, e.last_name, e.sex, e.emp_no
FROM employees AS e 
WHERE e.first_name = 'Hercules';

--- Create column that only pulls out last name - first initial 
CREATE TABLE last_name_initial AS 
SELECT SUBSTRING (last_name, 1, 1 ) AS last_initial, h.emp_no
FROM hercules AS h;

--- Join the two new tables 
CREATE TABLE hercules_B AS
SELECT h.first_name, h.last_name, h.sex, l.last_initial
FROM hercules AS h
INNER JOIN last_name_initial AS l ON
h.emp_no = l.emp_no;

--- Pull out only B last names 
CREATE TABLE only_hercules_B AS 
SELECT h.first_name, h.last_name, h.sex
FROM hercules_B AS h 
WHERE h.last_initial = 'B';

SELECT * FROM only_hercules_B;

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
--- Pull out all necessary data columns into one table 
CREATE VIEW all_departments AS
SELECT d.dept_no, d.dept_name, ed.emp_no, e.last_name, e.first_name
FROM departments AS d
JOIN employeedepartments AS ed
ON (ed.dept_no = d.dept_no)
  JOIN employees AS e
  ON (e.emp_no = ed.emp_no);

--- pull out only sales department
CREATE TABLE sales_department AS 
SELECT a.emp_no, a.last_name, a.first_name, a.dept_name 
FROM all_departments AS a
WHERE a.dept_no = 'd007';

SELECT * FROM sales_department; 

-- List all employees in the Sales and Development departments, including their employee number,
-- last name, first name, and department name.
CREATE TABLE sales_and_dev AS 
SELECT a.emp_no, a.last_name, a.first_name, a.dept_name 
FROM all_departments AS a
WHERE a.dept_no = 'd007' OR a.dept_no = 'd005';

SELECT * FROM sales_and_dev;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE TABLE name_frequency AS
SELECT last_name, COUNT(last_name) AS "Frequency of last names"
FROM employees
GROUP BY last_name
ORDER BY "Frequency of last names" DESC;

SELECT * FROM name_frequency;





