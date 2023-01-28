select * from CovidDeaths
where continent is not null and new_cases >0 and new_deaths>0
and location = 'kenya'

--Temp Table. You can query it several time unlike a one time CTE

DROP TABLE IF EXISTS #Temp_Employees
Create table #Temp_Employees
(employeeID int,
Jobtitle varchar (255),
Salary int
)
--DROP TABLE IF EXISTS dbo.Product
select * from #Temp_Employees

insert into #Temp_Employees values ('1001', 'HR', '45000')
insert into #Temp_Employees values (1002, 'HR', 50000)

--how to insert via select statement
insert into #Temp_Employees
select * from employees

drop table if exists #Accountants
create table  #Accountants
(employeeID int,
Jobtitle varchar (255),
Salary int
)

insert into #Accountants
select * from #Temp_Employees
where Jobtitle='Accountant'

select * from  #Accountants

--CTE TABLES: TEMP TABLES
--aka names subquesries or inner queries or nested queries
with popvac as(
select continent, location, date, population, new_deaths,
sum(cast(new_cases as int)) OVER( Partition by location Order by location, date ROWS BETWEEN  UNBOUNDED PRECEDING AND CURRENT ROW ) AS Run_Totals
--OVER(order by location)--OVER(Partition by location)
from CovidDeaths
where continent is not null and new_cases>0 and new_deaths>0
)

select * from popvac

--Temp Table. You can query it several time unlike a one time CTE
--ussed mostly in stored procedures
DROP TABLE IF EXISTS #Temp_Employees
Create table #Temp_Employees
(employeeID int,
Jobtitle varchar (255),
Salary int
)
--DROP TABLE IF EXISTS dbo.Product
select * from #Temp_Employees

insert into #Temp_Employees values ('1001', 'HR', '45000')
insert into #Temp_Employees values (1002, 'HR', 50000)

--how to insert via select statement
insert into #Temp_Employees
select * from employees

Create View KenyaData as
select * from CovidDeaths
where continent is not null and new_cases >0 and new_deaths>0
and location = 'kenya'
--order by new_deaths desc


select * from KenyaData
order by new_deaths desc