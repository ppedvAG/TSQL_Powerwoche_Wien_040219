--CREATE	   ALTER     DROP 		  --Table, Procedure, functions, views

create view vX
as
select getdate()   as Datum

ALTER VIEW Vx
as
select 100 as Zahl

drop view vx


--Tabellen

create table t1
	(
	 id int identity(1,1) primary key,
	 FamName varchar(50) NOT NULL,
	 VorName varchar(50) NULL,
	 GebDatum date NULL
	)

--Identity:
-- 1  2  3  4   5   8


drop table t1 


--Spalte dazu?
alter table t1 add Ort int null




select * from t1

--Spalte weg...
alter table t1 drop column ort

select * from t1

