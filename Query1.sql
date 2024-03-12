--kuvab k�ige nooremad
select min(cast(Age as int)) from Person

--kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

--konkreetsetes linnades olevate isikute koondvanus
select City, sum(cast(Age as int)) as TotalAge from Person group by City

--kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Age int

--kuvab esimeses reas v�lja toodud j�rjestuses ja muudab Age-i TotalAge-ks
--j�rjest ab Citys olevate nimede j�rgi ja siis GenderID j�rgi
select City, GenderId, sum(Age) as TotalAge from Person 
group by City, GenderId
order by City

insert into Person values
(11, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust, et mitu inimest on GenderId v��rtusega 2 konkreetses linnas
--arvutab vanused kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--n�itab �ra inimeste koondvanuse, mis on �le 41 aasta ja kui palju neid igas linnas elab
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja department
create table Department
(
Id int not null primary key,
Name nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int not null primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId ) values
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Feamail', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

select * from Employees

insert into Department (Id, Name, Location, DepartmentHead) values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department

update Employees
set DepartmentId = NULL
where Id = 10

--left join
select Employees.Name, Gender, Salary, Department.Name
from Employees left join Department
on Employees.DepartmentId=Department.Id

--arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees 

--min palga saaja
select min(cast(Salary as int)) from Employees 

--�he kuu palga saaja linnade l�ikes
select Location, sum(cast(Salary as int)) as TotalSalary 
from Employees 
left join Department 
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

select * from Employees
update Employees
set City = 'New York'
where Id = 10

--n�itab erinevust palgafondi osas nii linnade kui soo osas
select City, Gender, sum(cast(Salary as int)) as Toatlsalary from Employees
group by City, Gender
--sama, mis eelmine, aga linnad on t�hestiku j�rjekorras
select City, Gender, sum(cast(Salary as int)) as Totalsalary from Employees
group by City, Gender
order by City

--loeb �ra ridade arvu Employees tabelis
select count(*) from Employees

--mitu t��tajat on soo ja linna kaupa
select City, Gender, count(Id) as [Toatl Employees(s)] 
from Employees
group by City, Gender

--kuvab ainult k�ik naised linnade kaupa
select City, Gender, count(Id) as [Toatl Employees(s)] 
from Employees
where Gender='Female'
group by City, Gender

--kasutame having
select City, Gender, count(Id) as [Toatl Employees(s)] 
from Employees
group by City, Gender
having Gender = 'Male'

select Gender, City, sum(cast(Salary as int)) as Totalsalary, count (Id)
as [Total Employees(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1

alter table Employees
drop column City

--inner join
--kuvsb neid, kellel on DepartmentName all olemas v��rtus
select Employees.Name, Gender, Salary, Department.Name
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join
--kuidas saada k�ik andmed Employeest k�tte
select Employees.Name, Gender, Salary, Department.Name
from Employees
left join Department --v�i left outer join
on Employees.DepartmentId = Department.Id

--right join
--kuidas saada DepartmentName alla uus nimetus 
select Employees.Name, Gender, Salary, Department.Name
from Employees
right join Department --v�i right outer join
on Employees.DepartmentId = Department.Id

--kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Employees.Name, Gender, Salary, Department.Name
from Employees
full outer join Department 
on Employees.DepartmentId = Department.Id

--cross join v�tab kaks allpool olevat tabelit kokku ja korrutab need omavahel l�bi
select Employees.Name, Gender, Salary, Department.Name
from Employees
cross join Department 

--p�ringu sisu:
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--kuidas kuvada ainult need isiskud, kellel on DepartmentName NULL
select Employees.Name, Gender, Salary, Department.Name
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--teine variant
select Employees.Name, Gender, Salary, Department.Name
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where DepartmentId is null

--full join
--m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Employees.Name, Gender, Salary, Department.Name
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--kuidas saame Department tabelis oleva rea, kus on NULL
select Employees.Name, Gender, Salary, Department.Name
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--kuidas muuta tabeli nime, alguses vana tabeli nimi ja siis uue nimi
sp_rename 'Department', 'Department1'
sp_rename 'Department1', 'Department'

--kasutame Employees tabeli asemel l�hendit E ja Departmenti puhul D
select E.Name as EmpName, D.Name as DeptName
from Employees E
left join Department D
on E.DepartmentId = D.Id

--inner join
--kuvab ainult DeptId all olevate isikute v��rtused
select E.Name as EmpName, D.Name as DeptName
from Employees E
inner join Department D
on E.DepartmentId = D.Id

--cross join
select E.Name as EmpName, D.Name as DeptName
from Employees E
cross join Department D

select isnull('Aigi', 'No Manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--kui Expression on �ige, siis paneb v��rtuse, mida soovid v�i m�ne teise v��rtuse
case when Expression Then '' else '' end

--
alter table Employees
add ManagerId int

--neil, kellel ei ole �lemust, siis paneb neile No manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p�ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30),
LastName nvarchar(30)

--muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'


update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees
set FirstName = NULL, MiddleName = 'Tod', LastName = 'Someone'
where Id = 5
update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees
set FirstName = 'Valerie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10 


--igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees

--loome
create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union 
select Id, Name, Email from UKCustomers

--kuidas sorteerida nime j�rgi
select Id, Name, Email from IndianCustomers
union 
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
create procedure spGetEmployees
as begin
	select Firstname, Gender from Employees
end

--n��d saab kasutada sellenimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGet Employees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kui n��d allolevat k�sklust k�ima panna, siis n�uab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--�ige variant
spGetEmployeesByGenderAndDepartment 'male', 1

--niimoodi saab parameetrite j�rjestusest m��da minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja v�ti peale panna, et keegi teine ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
--with encryption
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab �ra n�uetele vastavad read, prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount
go --tee �levalpool �ra, siis mine edasi
select * from Employees

