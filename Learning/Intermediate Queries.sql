--SELECT *
--FROM [SQL Tutorial].dbo.EmployeeDemographics
--Inner JOIN [SQL Tutorial].dbo.WareHouseEmployeeDemographics
--	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

--SELECT FirstName, LastName, Age,
--CASE
--	WHEN AGE > 30 THEN 'OLD'
--	WHEN AGE BETWEEN 28 AND 30 THEN 'YOUNG'
--	ELSE 'Baby'
--END
--FROM [SQL Tutorial].dbo.EmployeeDemographics
--WHERE AGE is NOT NULL
--ORDER BY AGE

--SELECT FirstName, LastName, JobTitle, Salary,
--CASE
--	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary * .10)
--	When JobTitle = 'Accountant' Then Salary + (Salary * .05)
--	When JobTitle = 'HR' then Salary + (Salary * .000001)
--	ELSE Salary + (Salary * .03)
--END AS SalaryAfterRaise
--FROM [SQL Tutorial].dbo.EmployeeDemographics
--JOIN [SQL Tutorial].dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE AGE is NOT NULL
--ORDER BY AGE


--SELECT JobTitle, COUNT(JobTitle)
--FROM EmployeeDemographics
--Join EmployeeSalary
--	ON	EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 1
--ORDER BY AVG(Salary)

--UPDATE EmployeeDemographics
--SET Age = 31, Gender = 'Female'
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--DELETE FROM EmployeeDemographics
--WHERE EmployeeID = 1005

--SELECT DEMO.EmployeeID
--FROM EmployeeDemographics AS DEMO
--Join EmployeeSalary AS Sal
--	On DEMO.EmployeeID = Sal.EmployeeID

--PARTITION VS GROUP BY
--SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
--FROM EmployeeDemographics AS DEMO
--Join EmployeeSalary AS Sal
--	On DEMO.EmployeeID = Sal.EmployeeID
----------------------------------------------
--SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) 
--FROM EmployeeDemographics AS DEMO
--Join EmployeeSalary AS Sal
--	On DEMO.EmployeeID = Sal.EmployeeID
--GROUP BY FirstName, LastName, Gender, Salary

--CTE -single use
--WITH CTE_Employee as 
--(SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
--AVG(SALARY) OVER (PARTITION BY Gender) as AvgSalary
--FROM EmployeeDemographics AS DEMO
--Join EmployeeSalary AS Sal
--	On DEMO.EmployeeID = Sal.EmployeeID
--WHERE Salary > '45000')
--Select *
--FROM CTE_Employee


--String Functions
/*

Today's Topic: String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/

--Drop Table EmployeeErrors;


--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50)
--,FirstName varchar(50)
--,LastName varchar(50)
--)

--Insert into EmployeeErrors Values 
--('1001  ', 'Jimbo', 'Halbert')
--,('  1002', 'Pamela', 'Beasely')
--,('1005', 'TOby', 'Flenderson - Fired')

--Select *
--From EmployeeErrors

---- Using Trim, LTRIM, RTRIM

--Select EmployeeID, TRIM(employeeID) AS IDTRIM
--FROM EmployeeErrors 

--Select EmployeeID, RTRIM(employeeID) as IDRTRIM
--FROM EmployeeErrors 

--Select EmployeeID, LTRIM(employeeID) as IDLTRIM
--FROM EmployeeErrors 

-- Using Replace

--Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
--FROM EmployeeErrors


---- Using Substring

--Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
--FROM EmployeeErrors err
--JOIN EmployeeDemographics dem
--	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
--	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)



---- Using UPPER and lower

--Select firstname, LOWER(firstname)
--from EmployeeErrors

--Select Firstname, UPPER(FirstName)
--from EmployeeErrors

