--TEMP TABLES- multiuse but temp
--DROP TABLE IF EXISTS #temp_Employee
--CREATE TABLE #temp_Employee(
--EmployeeID int,
--JobTitle varchar(100),
--Salary int)

--INSERT INTO #temp_Employee VALUES(
--'1001', 'HR', '45000'
--)
--INSERT INTO #temp_Employee
--Select * 
--FROM [SQL Tutorial]..EmployeeSalary

--DROP TABLE IF EXISTS #Temp_Employee2
--CREATE TABLE #Temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int, 
--AvgSalary int)

--INSERT INTO #Temp_Employee2 
--SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(salary)
--From EmployeeDemographics emp
--Join EmployeeSalary sal
--	On emp.EmployeeID = sal.EmployeeID
--Group By JobTitle