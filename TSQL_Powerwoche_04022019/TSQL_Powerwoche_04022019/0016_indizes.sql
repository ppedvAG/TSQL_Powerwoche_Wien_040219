--IX

create table bestellungen
	(
	  BID int identity primary key,
	  KID int,
	  Bdatum date,
	  Lieferkosten money
	)
GO

--Warum jetzt ein CL IX ... SCAN

--da der PK immer automatisch als CL IX angelegt wird!
-- ==> nie wieder gute Bereichsabfragen!!


select * from bestellungen

set statistics io, time on
select  * from watlos3

 --	   Table Scan
select id from watlos3 where id = 1000	 --31170,  62/67ms


--vor allen Indizes: wer soll der gr IX sein
----> auf CustomerID.. kommt häufig vor
--besser mit:

--NIX_id
select id from watlos3 where id = 1000
--0 ms 3 Seiten

--
select id, freight from watlos3 where id = 1000
 --4 Seiten 0 ms-- aber Lookup 50% Kosten

 --besser: 
 --NIX_ID_Fr
 select id, freight from watlos3 where id = 1000
 --zusammengesetzter IX
 --max 16 Spalten (max 900byte)

 --aber noch besser mit IX mit eingeschl. Spalten
 --die eingeschlossenen Spalten 
 --sind Werte, die nur in eder untersten Ebene 
 --mit eingetragen werden. Der Baum bleibt klein
 --ca 1000 Spalten einschliessen


  select id, freight, city from watlos3
  where id = 1000	--3 Seiten 0 ms

  --und hier?
  select id, freight from watlos3
  where id = 1000	


 --Alle DS mit Fracht < 1
 --Ausgabe freight, city, country, productname


 --NIX_

 select freight, city, country, productname
 from
	watlos3
where freight < 1

--SQL schlägt vor:
CREATE NONCLUSTERED INDEX NIX_FR_CICYPN
ON [dbo].[watlos3] ([freight])
INCLUDE ([country],[city],[productname])



--Thema zusammengesetzt
--kaum mehr als 4 Spalten braucht
--

select country, city, possumme
from watlos3
where freight < 1  and city = 'Oulu'

--NIX_FRCI_i_CYCIpos--1,1 MIO indizieren

select count(*) from watlos3 where city = 'Oulu'
--warum nicht einen IX mit nur City= Oulu
--da nur 18944

--NIX_FR_i_CYPOS_filter_OULU



--Indizierte Sicht

select country, count(*) from watlos3
group by country


create view vind
as
select country, count(*) as Anzahl from watlos3
group by country

 select * from vind


 alter view vind  with schemabinding
as
select country, count_big(*) as Anzahl from dbo.watlos3
group by country


--Annahme: ihr seid Mr Bezos
--20 Jahre weltweiter versand
--Postabelle: 1 Trd Datensätze

--pro Land Umsatz?
--wieviele Seiten würde man über eine ind Sicht brauchen?

--2 

--wiviele Länder? 200 
--Sicht besteht nur aus 200 Zeilen und deren umsatz

--eigtl genial, aber viele Einschränkungen
--ohne group by sinnlos
--es muss ein count_big() enthalten sein
--es dürfen keine Null werte rauskommen

select isnull(NULL,0)



--Columnstore IX
 --2 Kopien als Spielwiese
select * into w1 from watlos2
select * into w2 from watlos2


 --typische Abfrage an w1
 --ideal: AGG, where , kein * 

 --wieviel Stück von welchem Produkt wurde verkauft
 --nur in Österreich


 --Productname, Anzahl aus Österreich
						  
--58 Zeilen
  --optimieren: NIX_CY_i_pnqy
 select productname, sum(quantity) as Anzahl
 from w1
 where country = 'Austria'
 group by productname
 --nach IX: 30ms  mit 556 Seiten


 --mit Columnstore IX schneller..
 --obwohl der nach nichts gefragt hat
 select productname, sum(quantity) as Anzahl
 from w2
 where country = 'Austria'
 group by productname


 --da braucht man einen neuen IX!!!
 select companyname, avg(freight) as Anzahl
 from w1
 where city  = 'Graz'
 group by companyname

  select companyname, avg(freight) as Anzahl
 from w2
 where city  = 'Graz'
 group by companyname


 --statt 240MB Daten nun 700kb
 --KOmpression
 --die w1 kommt aber nur 80MB

 select * from sys.dm_db_column_store_row_group_physical_stats


 insert into w2
 select top 100000 * from w1



















