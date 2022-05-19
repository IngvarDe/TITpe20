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

select * from Person
-- otsib kõik New Yorki elanikud ülesse
select * from Person where City = 'New York'
-- ei soovi New Yorki elanikke näha
select * from Person where City <> 'New York'
select * from Person where City != 'New York'

--- konkreetse vanusega inimesed
select * from Person where Age = 20 or Age = 24 or Age = 40
--- nagu eelmine päring, aga lühemalt
select * from Person where Age in (20, 24, 40)
--- mingis vanusevahemikus olevad inimesed
select * from Person where Age between 20 and 25
--- kõik linnad, mis algavad G-tähega
select * from Person where City like 'G%'
---kui kasutame kaks korda %-märki, siis otsib igalt pool @-märki (selle märgi asemele 
--- võib panna igasuguseid märke)
select * from Person where Email like '%@%' 
-- kõik emailid, kus ei asu @-märki
select * from Person where Email not like '%@%'
-- alakriipsudega määratleme ära @-märgi asetuse soovitud otsingus
select * from Person where Email like '_@_.com'
--- otsib nimesid, kus esimene märk algab S, C ja I-ga.
select * from Person where Name like '[SCI]%'
-- soovime otsida, kus esimene täht ei ole nimes S, C, I
select * from Person where Name like '[^SCI]%'  
-- linn peab olema New York või Gotham ja vanust alla 30 aasta
select * from Person where (City = 'New York' or City = 'Gotham') and Age < 30
--- nime järgi selekteerime
select * from Person order by Name


---- JOIN-d
select * from Department
select * from Employee

-- inner join, näitab ainult neid ridasid, mille on olemas kattuvus osakonna lõikes
select Name, Gender, Salary, DepartmentName
from Employee
inner join Department
on Employee.DepartmentId = Department.Id

--left join, kui soovime kõiki andmeid näha
select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id

-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department
-- right outer join
select Name, Gender, Salary, DepartmentName
from Employee
right outer join Department
on Employee.DepartmentId = Department.Id

select * from Department
select * from Employee

--- outer join
--- kuidas saada kõikide tabelite andmed ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employee
full outer join Department
on Employee.DepartmentId = Department.Id

--- cross join võtab kaks allpool olevat tabelit kokku ja korrutab need omavahel läbi
--- igas osakonnas oleva töötajaga
select Name, Gender, Salary, DepartmentName
from Employee
cross join Department

--- keerulisemad JOIN-d
-- kaks isikut, kelle ei ole väärtust osakondades
select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null

select Name, Gender, Salary, DepartmentName
from Employee
left join Department
on Employee.DepartmentId = Department.Id
where Department.Id is null

--- right join
select Name, Gender, Salary, DepartmentName
from Employee
right join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null

--- full join
-- otsib ülesse mõlemas tabelis NULL väärtustega olevad read
select Name, Gender, Salary, DepartmentName
from Employee
full join Department
on Employee.DepartmentId = Department.Id
where Employee.DepartmentId is null
or Department.Id is null

--- self join
select * from Employee

--- tabeli nime muutmine
-- esimene string on vana tabeli nimi ja järgmine string uus nimetus
sp_rename 'Department1', 'Department'

--
alter table Employee
add ManagerId int 

-- self join on tabeli sees oleva info kokku panemine
select E.Name as Employee, M.Name as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--inner join
select E.Name as Employee, M.Name as Manager
from Employee E
inner join Employee M
on E.ManagerId = M.Id

--- cross join
select E.Name as Employee, M.Name as Manager
from Employee E
cross join Employee M

--
select ISNULL('Asd', 'No Manager') as Manager

--- saab ka teistmoodi teha
select coalesce(NULL, 'No Manager') as Manager


--- neile kellele ei ole ülemust määratud, siis paneb neile No Manager teksti
select E.Name as Employee, ISNULL(M.Name, 'No Manager') as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--- 4 tund SQL

--- teeme päringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employee E
left join Employee M
on E.ManagerId = M.Id

--- lisame kaks veergu juurde
alter table Employee
add MiddleName nvarchar(30)
alter table Employee
add LastName nvarchar(30)

update Employee set MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employee set MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employee set MiddleName = NULL, LastName = NULL
where Id = 3
update Employee set MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employee set MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employee set MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employee set MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employee set MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employee set MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employee set MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employee
-- igast reast võtab esimese täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName,  MiddleName, LastName) as Name
from Employee


--- loome kaks tabelit
create table IndianCustomers
(
Id int identity(1, 1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1, 1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers values('Raj', 'R@R.com')
insert into IndianCustomers values('Sam', 'S@S.com')

insert into UKCustomers values('Ben', 'B@B.com')
insert into UKCustomers values('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--- kasutame union all, mis näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employee
end

-- kolm erinevat viisi sp esile kutsuda
spGetEmployees
exec spGetEmployees
execute spGetEmployees

-- tegime sp, kus on kaks parameetrit
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employee
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--- kui allpool olevat käsklust käima panna, siis nõuab Gender parameetrit
spGetEmployeesByGenderAndDepartment
-- õige variant
spGetEmployeesByGenderAndDepartment 'Male', 1
-- sp parameetrite järjekorrast saab mööda minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'
-- kuidas vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja võti peale panna, et keegi teine ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employee
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- ei näe enam sp sisu, kui encryption on peale pandud
sp_helptext spGetEmployeesByGenderAndDepartment

select * from Employee

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = COUNT(Id) from Employee where Gender = @Gender
end

--- if ja else loogika, kus näitab ära, töötajate arvu ja vastava teksti,
--- mis asub stringi sees
declare @TotalCount int
exec spGetEmployeeCountByGender 'Male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

-- näitab ära, et mitu rida vastab nõutele
declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out,
@Gender = 'Male'
print @TotalCount

--- 5 tund SQL