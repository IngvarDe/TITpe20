--- loome uue andmebaasi
create database TITpe20

--- DB kustutamine
drop database TITpe20

--- db valimine
use TITpe20

-- loome tabeli
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwomen', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)

select * from Person

--- võõrvõtme loomine kahe tabeli vahel
alter table Person add constraint Person_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- ei luba panna Genderit väärtusega, mida ei ole Gender tabelis olemas.
insert into Person values (7, 'Ironman', 'i@iron.com', NULL)

--- kui andmete sisestamisel ei ole sisestatud väärtust Gender-i alla, siis 
--- automaatselt sisestab seal väärtuse 3
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Gender values (3, 'Unknown')

select * from Person

insert into Person (Id, Name, Email)
values (8, 'Ironman', 'i@iron.com')

--- piirangu maga võtmine
alter table Person
drop constraint DF_Persons_GenderId

--- lisame uue veeru juurde
alter table Person
add Age nvarchar(10)

--- vanuseline piirnagu, et ei saa suuremat nr sisestada
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 171)

--- kuidas saame olemasolevaid andmeid uuendada
update Person
set Age = 170
where Id = 8

-- lisame uue veeru
alter table Person
add City nvarchar(50)

--- 2 tund SQL 

select * from Person
select * from Gender

-- otsin konkreetset linna veerust city
select * from Person where City = 'Gotham'
-- välsitab kõik, kes elavad Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- kõik, kes on 20, 24 ja 35 aastased
select * from Person where Age = 20 or Age = 24 or Age = 35
select * from Person where Age in (20, 24, 35)
-- kõik, kes on 20 kuni 25 a vanad
select * from Person where Age between 20 and 25
-- kõik linnad, mis algavad G-tähega ja käskluseks on %-märk
select * from Person where City like 'G%'
-- ükstapuha, kus asub antud juhul märk @
select * from Person where Email like '%@%'
-- otsib, kus teine märk on @
select * from Person where Email like '_@_.com'
-- otsib kõike ridu, kus ei ole kuvatud @ märki
select * from Person where Email not like '%@%'
-- otsib nimesid, kus esimene märk algab S, B ja A-ga
select * from Person where Name like '[SBA]%'
-- otsib nimesid, kus esimene märk ei ole S, B ja A
select * from Person where Name like '[^SBA]%'
-- otsime linna järgi ja täpsustame vanuse
select * from Person 
where (City = 'Gotham' or City = 'Atlantis') and Age < 36
-- paneb tähestikulisse järjestusse
select * from Person order by Name
-- selekteerib vastupidises järjestuses
select * from Person order by Name desc
-- võtame kolm ülemist rida
select top 3 * from Person
-- võtab nime ja vanuse järgi kaks ülemist rida
select top 2 Age, Name from Person
--- võtame pooled nimekirjas olnutest
select top 50 percent * from Person
-- hakkab vanemast pihta ja langevas järjekorras
select * from Person order by Age desc
-- hakkab kõige vanemast ja näitab ainult esimest
select top 1 * from Person order by Age desc

--- saan välja toodud veergudes olevaid andmeid
select distinct Name, City from Person

create table Employee
(
Id int not null primary key,
Name nvarchar(50) not null,
Gender nvarchar(50) not null,
Salary int null,
City nvarchar(50)
)

-- andmete sisestamine tabelisse
insert into Employee (Id, Name, Gender, Salary, City)
values (1, 'Tom', 'Male', 4000, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (2, 'Pam', 'Female', 3000, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (3, 'John', 'Male', 3500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (4, 'Sam', 'Male', 4500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (5, 'Todd', 'Male', 2800, 'Sydney')
insert into Employee (Id, Name, Gender, Salary, City)
values (6, 'Ben', 'Male', 7000, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (7, 'Sara', 'Female', 4800, 'Sydney')
insert into Employee (Id, Name, Gender, Salary, City)
values (8, 'Valarie', 'Female', 5500, 'New York')
insert into Employee (Id, Name, Gender, Salary, City)
values (9, 'James', 'Male', 6500, 'London')
insert into Employee (Id, Name, Gender, Salary, City)
values (10, 'Russell', 'Male', 8800, 'London')


-- 2 tund 

create table Department
(
	Id int primary key,
	DepartmentName nvarchar(20),
	Location nvarchar(20),
	DepartmentHead nvarchar(20)
)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Department', 'Sydney', 'Cindrella')

select * from Employee
select * from Department

alter table Employee
add  DepartmentId nvarchar(20)

select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id


select SUM(Salary) from Employee  --- arvutab kõikide palgad kokku
--- kui Salary veerg on nvarchar, siis kasutab cast-i
select SUM(CAST(Salary as int)) from Employee
--- min palga saaja ja kui kasutan max, siis kõige suurema palga saaja
select MIN(Salary) from Employee
--- ühe kuu palgafond linnade lõikes
select City, SUM(Salary) as TotalSalary from Employee group by City

select City, Gender, SUM(Salary) as TotalSalary from Employee
group by City, Gender  --- toome soolise erisuse mängu

select City, Gender, SUM(Salary) as TotalSalary from Employee
group by City, Gender
order by City -- order by-ga paneme linnad tähestikulisse järjestusse

select Gender, City, SUM(Salary) as TotalSalary from Employee
group by City, Gender
order by City  --peale selecti toome välja järjestuse päringu tulemuses

select COUNT(*) from Employee --loeb ära, mitu inimest on nimekirjas, 
--- * asemele võib panna ak muid veergude nimesid
select * from Employee

--- mitu töötajat on soo ja linna kaupa
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
group by Gender, City

-- kuvab ainult kõik mehed linnade kaupa
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
where Gender = 'Male'
group by Gender, City

--- kasutame having tingimust otsimisel
select Gender, City, SUM(Salary) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employee
group by Gender, City
having Gender = 'Female'


select * from Employee where SUM(Salary) > 4000
-- annab veateate ja soovib having kasutamist

--- 
select Gender, City, SUM(Salary) as TotalSalary, COUNT(Id) as [Total Employee(s)]
from Employee group by Gender, City
having SUM(Salary) < 4000

--- loome tabeli, milles hakatakse automaatselt nummerdama Id-d
cReaTe table Test1
(
Id int identity(1, 1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1

--- kustutame veeru City Employee tabelist
alter table Employee
drop column City


-- inner join
-- kuvab neid, kellel oon DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employee
inner join Department
on Employee.DepartmentId = Department.Id

--- 3 tund SQL