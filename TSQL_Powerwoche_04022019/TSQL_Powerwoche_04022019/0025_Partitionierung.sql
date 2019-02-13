--Partitionierung

/*

TAB A: 1000 Zeilen
TAB B: 100000 Zeilen

Beide Tabellen sind identisch

Abfrage, die leifert bei A und B 10 Zeilen

Welche Tabelle liefert vermutlkich schneller die Daten

3,5 Sekunden
21 Sek  B


Umsatztab, die wächst permanent.. also immer langsamer


--> Salamitaktik

*/



--partitionierte Sicht

--eine große Tabelle Umsatz
--statt der viele kleine Tabellen

create table u2019 (id int identity, jahr int, spx varchar(50))
create table u2018 (id int identity, jahr int, spx varchar(50))
create table u2017 (id int identity, jahr int, spx varchar(50))
create table u2016 (id int identity, jahr int, spx varchar(50))

-- wo ist für meine Abfrage nun "UMSATZ"


--View 
create view vUmsatz
as
select * from u2019
UNION ALL
select * from u2018
UNION ALL
select * from u2017
UNION ALL
select * from u2016


 --bis daher nur Aufwand und kein Nutzen
select * from vUmsatz where jahr = 2017

ALTER TABLE dbo.u2016 
	ADD CONSTRAINT 	CK_u2016 CHECK (jahr=2016)


ALTER TABLE dbo.u2018
	ADD CONSTRAINT 	CK_u2018 CHECK (jahr=2018)

ALTER TABLE dbo.u2017 
	ADD CONSTRAINT 	CK_u2017 CHECK (jahr=2017)

ALTER TABLE dbo.u2016 
	ADD CONSTRAINT 	CK_u2016 CHECK (jahr=2016)


--aber bei Abfragen auf ID, oder ander SPalten
--immer alle Tabelle durchsuchen


--wie siehst mit INS, UP, DEL aus?

insert into vumsatz (jahr, spx) values (2017,'AB')

--2019, weil erste Tabelle in UNION
--PK (eindeutigkeit über die Sicht weg)

--PK mit ID und Jahr in jeder Tabelle
--kein Identity Wert

insert into vumsatz (id,jahr, spx) values (1,2017,'AB')



--Partitionierung


--Dateigruppe
--per default immer inen DGr Primary
--jede Tabelle ist per default in Primary (=mdf)

create table t234 (id int)  --auf Primary

create table t234 (id int)  ON STAMM --=(DAteigruppenname)

create table testQQ (id int) on bis100

--4 DGruppen: bis100, bis200, bis5000, rest


--zuerst part f()

create partition function fZahl(int)
as
RANGE LEFT FOR VALUES (100,200)

----100------200-----
--1      2       3

 select $partition.fzahl(117)	   --> 2

 --dann Part Scheme

 create partition scheme SchZahl
 as
 partition fzahl to (bis100, bis200, rest)

 -----------------     1       2      3

create table ptab (id int identity, spx char(4100), nummer int)
		ON schZahl(nummer)


 declare @i as int = 0

 while @i < 20000
	begin
		insert into ptab values ('XY', @i)
		 set @i+=1
	end


 set statistics io, time on

 select * from ptab where id = 90

  select * from ptab where nummer = 90

  --Grenzen raus und rein

  --Tab, F(), schema
  --neue Grenze 5000

  --schema, f(), Tab nie

  alter partition scheme schZahl next used bis5000

  alter partition function fzahl() split range (5000)


  --grenze raus

  --Tab nie, f() ja , schema nö

  alter partition function fzahl() merge range (100)

  --Am Ende sagen wir: den einen Klotz brauchen wir gar nimmer
  --archivieren

  --kein Statement für Verschieben von Daten



  create table archiv(id int not null, spx char(4100), nummer int)
  on bis200


  alter table ptab switch partition 1 to archiv

  select * from archiv --alle hier im Org Tabeelle weg

  --100MB/ sek verschoben werden können
  --Archiveren ghätte soeben 1000MB verschieben
  --wie lange würde das dauern?
  --keine 10Sek, sondern egal wieviel Daten i.. immer nur ein paar ms

  --Archiv musste auf der DGruppe liegen, die Daten zum "Verschieben" enthalt


  --das wird auch dann schneller mit einer Dateigruppe

  --F() ist exakt

  --datetime

  31.12.2019 23:59:59.999


  --Kunden nach Name

  --A BIS M	N bis R   S bis Z

  ---N
  M..was ist größer: Maier 
































