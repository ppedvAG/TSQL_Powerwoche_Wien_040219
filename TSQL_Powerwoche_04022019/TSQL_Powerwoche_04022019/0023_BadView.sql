--BadView

 --Sicht hat keine Daten (ausser ind Sicht)
 --Sicht macht immer das , was in ihr beschrieben wurde
--select über alle Tabelle

create table t100
	(
	 id int identity, 
	 Stadt int,
	 Land int
	 )

insert into t100
select 10,100
UNION
select 20,200
UNION
select 30,300

select * from t100


create view v100
as
select * from t100
GO

select * from v100
---soweit ok..

--Spalte dazu
alter table t100 add fluss int
--Fluss mit 1000er Werten
update t100 set fluss = id *1000

select * from t100

select * from v100	--ohne Fluss obwohl in Sicht select *

--es wird sich kein * gemerkt sondern das Schema der Tabelle

--hmmm

alter table t100 drop column land

select * from t100

select * from v100
--ohhhhh.. Werte von FLuss in nicht existente Spalte von Land


 alter table t100 add Land int

 update t100 set land = id *100

 --es bleibt die Spalte land (aber die falsche mit werte von FLuss)

 --es muss sicher sein, dass ich immer das korrekte sehe!

 alter view v100 with schemabinding
 as
 select * from t100

 --das schemabinding verlangt exakte Angaben
  --kein *
  --und genaue Angabe der Objekte inkl Schema

 alter view v100 with schemabinding
 as
 select id, stadt , land, fluss from dbo.t100


 --Sicht klappt wieder
--das Löschen von Spalten, die in der Sicht enthalten sind
--ist nicht möglich
 alter table t100 drop column fluss

--Spalten hinzufügen auf t100 klappt, da die sicht keine 
--Änderung hat
alter table t100 add spx int
