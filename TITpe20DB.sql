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