Create Table EmployeeDemographics
(EmployeeID int,
Firstname varchar(50),
Lastname varchar(50),
Age int,
Gender varchar(50)
)

create table Employeesalary
(EmployeeID int,
jobtitle varchar(50),
salary int
)


Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)


--select statement 
--Top, Distinct, Count, As Max, Min, Avg

select * from EmployeeDemographics
select top 5 * from EmployeeDemographics;
select distinct(Age) from EmployeeDemographics
select count(distinct(gender)) from EmployeeDemographics
select min(Age) from EmployeeDemographics
select max(Age) from EmployeeDemographics
select Avg(salary) from Employeesalary


--Where Statement
--=,<>,<,>,And, Or, Like,Null, Not Null, In

select * from EmployeeDemographics where Firstname <> 'jim'
select * from EmployeeDemographics where Firstname = 'jim'
select * from EmployeeDemographics where Age <30
select * from EmployeeDemographics where Age <= 30 and gender ='male'
select * from EmployeeDemographics where Firstname like 'S%'
select * from EmployeeDemographics where lastname like '%S%'
select * from EmployeeDemographics where lastname is Null
select * from EmployeeDemographics where lastname is Not Null
select * from EmployeeDemographics where Firstname IN ('JIM','Pam')

--Group By, Order By
select gender from EmployeeDemographics group by Gender;
select Gender, Count(gender) As CountGender
from EmployeeDemographics where Age >31 Group By Gender

select Gender, Count(gender) As CountGender
from EmployeeDemographics where Age >31 Group By Gender 

select * from EmployeeDemographics order by Age Desc

select * from EmployeeDemographics order by 4 Desc

--Intermidiate:
--Joins
--Unions
--Case Statement
--Updating/deleting Data
--Partition By
--Data Types
--Alising
--Creating Views
--Having vs Group By Statement
--GetDate()
--Primary Key vs Foreign Key

--Inner Joins, Full/Left/right/ Outer Joins
select * from EmployeeDemographics;
select * from Employeesalary;

select * from [Sql Tutorial].dbo.EmployeeDemographics
Inner Join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

select * from [Sql Tutorial].dbo.EmployeeDemographics
Full Outer Join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

select * from [Sql Tutorial].dbo.EmployeeDemographics
left Outer Join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

select * from [Sql Tutorial].dbo.EmployeeDemographics
right Outer Join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

select EmployeeDemographics.EmployeeID,Firstname,jobtitle from [Sql Tutorial].dbo.EmployeeDemographics
left outer Join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

Select EmployeeDemographics.EmployeeID,Firstname, salary from [Sql Tutorial].dbo.EmployeeDemographics
inner join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID = Employeesalary.EmployeeID
where Firstname <> 'micheal'
Order by 'Salary'DESC

Select jobtitle, AVG(salary) from [Sql Tutorial].dbo.EmployeeDemographics
inner join
[Sql Tutorial].dbo.Employeesalary
ON EmployeeDemographics.EmployeeID = Employeesalary.EmployeeID
where jobtitle ='Salesman'
Group By jobtitle

--Union Statement
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)


Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

select * from EmployeeDemographics
Union All
select * from WareHouseEmployeeDemographics
order by EmployeeID

--Becare when doing this
select EmployeeID, firstname, Age from EmployeeDemographics
Union All
select EmployeeID, jobtitle, salary from Employeesalary
order by EmployeeID


--Case Statement
select firstname, lastname, age,
CASE
	WHEN Age =38 THEN 'Stanley'
	WHEN Age > 30 THEN 'Old'
	When Age between 27 AND 30 then 'Young'
	ELSE 'baby'
END As type
from [Sql Tutorial].dbo.EmployeeDemographics
where Age is Not Null
order by Age

select EmployeeDemographics.EmployeeID, firstname, jobtitle,salary, 
case
	when jobtitle = 'Salesman' then salary + (salary*0.50)
	when jobtitle = 'HR' then salary + (salary*0.30)
	when jobtitle = 'Accountant' then salary + (salary*0.20)
	Else salary + (salary*0.10)
End As 'New Salary'

from EmployeeDemographics
join Employeesalary
On EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID


--Having Clause

select jobtitle, count(jobtitle)
from EmployeeDemographics
join Employeesalary
On EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID
Group By jobtitle
having Count(jobtitle)>2

select jobtitle, Avg(salary)
from EmployeeDemographics
join Employeesalary
On EmployeeDemographics.EmployeeID=Employeesalary.EmployeeID

Group By jobtitle
having Avg(salary) >36000
order by Avg(salary)

--updating/Deleting of Database

select * from EmployeeDemographics
update EmployeeDemographics
set EmployeeID = 1012 where Age = 39

update EmployeeDemographics
set Firstname = 'Ola', Lastname='Akin' 
where Age = 39 And EmployeeID=1012

select * from Employeesalary
select * from EmployeeDemographics

where EmployeeID = 1020

Delete from EmployeeDemographics
where EmployeeID = 1020

--Alias
select firstname Fname
from EmployeeDemographics

select firstname As Fname
from EmployeeDemographics

select firstname + ' '+ Lastname As Fullname
from EmployeeDemographics

select AVG(Age) As AverageAge
from EmployeeDemographics

select Demo.Firstname Fname
from EmployeeDemographics As Demo


--Partition By

Select firstname, lastname, Gender, Salary,
COUNT(Gender) over (Partition By Gender) As TotalGender
from [Sql Tutorial]..EmployeeDemographics Demo
Join [Sql Tutorial]..Employeesalary sal
on demo.EmployeeID = sal.EmployeeID
Select firstname, lastname, jobtitle, Salary,
COUNT(jobtitle) over (Partition By jobtitle) As Totaljob
from [Sql Tutorial]..EmployeeDemographics Demo
Join [Sql Tutorial]..Employeesalary sal
on demo.EmployeeID = sal.EmployeeID


--CTEs

with CTE_Employee as
(Select firstname, lastname, Gender, Salary,
COUNT(Gender) over (Partition By Gender) As TotalGender
from [Sql Tutorial]..EmployeeDemographics Demo
Join [Sql Tutorial]..Employeesalary sal
on demo.EmployeeID = sal.EmployeeID
where Salary >'45000'
)
select Firstname, salary
from CTE_Employee


--tmp Tables
Create Table #tmp_Employees(
EmployeeID int,
JobTitle varchar(100),
salary int
) 
select * from #tmp_Employees
Insert into #tmp_Employees values (
'1001', 'HR', '45000'
)

Insert into #tmp_Employees 
SELECT * From [Sql Tutorial]..Employeesalary

Select * From #tmp_Employees
Drop Table if exists #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)
Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM [Sql Tutorial]..EmployeeDemographics emp
JOIN [Sql Tutorial]..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

select * from #temp_employee3

--String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

--Using Replace
select LastName, Replace(Lastname, '- Fired', '') As NewLastname from EmployeeErrors


--Substring
select SUBSTRING(Firstname, 5,3) from EmployeeErrors

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), 
Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN [Sql Tutorial]..EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

--Upper and Lower
select Firstname, UPPER(FirstName), LOWER(FirstName) from EmployeeErrors

--Store Procedure

Create PROCEDURE 
TEXT1
AS 
Select * from EmployeeDemographics

EXEC TEXT1
use [Sql Tutorial]
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

EXEC Temp_Employee









