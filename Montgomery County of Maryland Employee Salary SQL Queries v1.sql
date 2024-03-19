-- number of rows into our dataset

SELECT COUNT(*) AS Number_Of_Rows
FROM Employee_Payroll$

-- number of employees

SELECT COUNT(DISTINCT Employee_Identifier) 
	AS Number_of_Employees
FROM Employee_Payroll$


-- number of job positions in 2016

SELECT COUNT(DISTINCT Position_id)
FROM Employee_Payroll$
WHERE Fiscal_Year = '2016'

-- number of job positions in 2017

SELECT COUNT(DISTINCT Position_id)
FROM Employee_Payroll$
WHERE Fiscal_Year = '2017'

/* How many employees were hired during 2016? */

SELECT COUNT(DISTINCT Employee_Identifier) AS Number_of_Employees_Hired_In_2016
FROM Employee_Payroll$
WHERE Original_Hire_Date LIKE '%2016%';

-- average base pay for each department office in 2016

SELECT Office_name, ROUND(AVG(Base_pay),0) AS Average_BasePay
FROM Employee_Payroll$
WHERE Fiscal_year = '2016' AND Office_name IS NOT NULL
GROUP BY Office_Name
ORDER BY Office_Name 

-- average base pay for each department office in 2017? 

SELECT Office_name, ROUND(AVG(Base_pay),0) AS Average_BasePay
FROM Employee_Payroll$
WHERE Fiscal_year = '2017' AND Office_name IS NOT NULL
GROUP BY Office_Name
ORDER BY Office_Name 

-- 2016 vs 2017 average base pay salaries 

SELECT *
FROM (SELECT Office_name, ROUND(AVG(Base_pay),0) AS Average_BasePay
FROM Employee_Payroll$
WHERE Fiscal_year = '2016' AND Office_name IS NOT NULL
GROUP BY Office_Name) 
AS fy16
LEFT JOIN
(SELECT Office_name, ROUND(AVG(Base_pay),0) AS Average_BasePay
FROM Employee_Payroll$
WHERE Fiscal_year = '2017' AND Office_name IS NOT NULL
GROUP BY Office_Name) 
AS fy17
ON fy16.Office_Name = fy17.Office_Name

-- top 10 total base pay job positions in 2016

SELECT Top 10 Job_title, ROUND(SUM(base_pay),0) AS Sum_base_pay
FROM Employee_Payroll$
WHERE fiscal_year = '2016'
GROUP BY Job_Title
ORDER BY Sum_base_pay DESC, Job_Title

-- top 10 earning employees in 2016

SELECT TOP 10 First_name, Last_name, Middle_initial, Job_title,
	ROUND(SUM(base_pay),0) AS base_pay
FROM Employee_Payroll$
WHERE fiscal_year = '2016'
GROUP BY first_name, last_name, Middle_Initial, Job_Title
ORDER BY base_pay DESC

-- employees hired on March 8th 2016

SELECT First_name, Last_name, Middle_initial,
	LEFT(DATETRUNC(day, Original_hire_date),11) AS Hiring_Date
FROM Employee_Payroll$
WHERE Original_Hire_Date LIKE '%Mar%8%2016%'
GROUP BY First_name, Last_name, Middle_initial, Original_hire_date;

-- total base pay paid to all employees during 2016 quarter 4

SELECT ROUND(SUM(base_pay),0) AS All_Employee_Base_Pay_for_2016Q4
FROM Employee_Payroll$
WHERE Fiscal_Period = '2016Q4'




