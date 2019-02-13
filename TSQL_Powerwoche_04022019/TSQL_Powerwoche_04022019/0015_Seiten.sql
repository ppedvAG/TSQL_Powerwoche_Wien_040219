--DB besteht aus Seiten	(Page)

-- 1 Seiten hat max 8192 byte davon 8060 Nutzlast für 700max Slots

--8 Seiten am Stück = Block (Extent)

--naja.. was osll ich sagen: im Normalfall 
--muss ein 1DS in eine Seite passen!


use northwind;
GO

create table txy (id int identity, sp1 char(4100), sp2 char(4100))
--Fehler beim Erstellen oder Ändern der txy-Tabelle, weil die Mindestzeilengröße 8211 betragen würde, 
--einschließlich 7 Bytes an internen Verwaltungsbytes. 
--Dies überschreitet die maximal zulässige Größe für 
--Tabellenzeilen von 8060 Bytes.


--DB Design: 
--CRM eine! Tabelle für Kunden
--Eigeschaften wie Hobby 1 bis 3, Fax 1 bis 4..
--Frau1, Frau2, Frau3 , Religion
--300 Spalten

--1 DS : 4100 bytes... 1 MIO DS

--> 8kb * 1 MIO (1 DS pro Seite nur)
--wobei knapp 4 kb eigtl Verschwendung

--==> 8 GB --> das was auf der HDD ist muss 1:1 in RAM

--kann man das messen.

set statistics io, time on
--Anzahl der Seiten, CPU Aufwand in ms und Dauer in ms

--wie bei jeder Messung: vorsicht: messen kostet
--> Heisenbergsche Unschärfe
select * from customers
--logische Lesevorgänge 5
-- CPU-Zeit = 0 ms, verstrichene Zeit = 47 ms.

 set statistics io, time off		 --mit Messung 28sek.. ohne 22 Sek
create table test2
	(id int identity, sp1 char(4100))


 --Daten reinpumpen
insert into test2
select 'XX'
GO 20000

set statistics io, time on
select * from test2 where id = 1000
--logische Lesevorgänge 20000
--alles durchsuchen müssen: SCAN

dbcc showcontig('test2')
 --- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

--wie können wir diese Tabelle optimieren?

/*
statt nvarchar varchar, wenn kein unicode gebraucht wird
statt char ein varchar
--würde die Software ändern!!

DB Redesign
	   --statt 4100byte in einer Tab mit einem DS jheweils

--2te Tabelle mit 100bytes
--ein paar Spalten rausnehmen in TabSonst
--1 MIO DS a 4000 = 4 GB (500000 Seiten
--1 MS DS a 100  => 12500 Seiten==> 110 MB
 Statt 8GB auf HDD und im RAM
 nun 4,1 GB auf HDD und im RAM


 --Messung: Set statistics.. Seiten und ms
 -- PLAN: SCAN oder SEEK

 --SEEK: optimal = herauspicken von Datensätzen
--ohne where immer ein SCAN
--mit where kann ein SEEK (optimum) kommen

--Sucheim TelBuch: nach Maier (Seek)
				  nach Thomas (Scan)

*/


select * from customers where customerid like 'A%'

select * from customers where left(customerid,1) ='A'

 -----------
 select top 1 companyname, sum(unitprice*quantity) as Umsatz
  from 
	customers c inner join orders o on c.customerid = o.customerid
				inner join [order details] od on od.orderid = o.orderid 
  group by companyname
  order by umsatz desc

 
 select top 1 companyname, sum(unitprice*quantity) as Umsatz
  from vKundeumsatz
  group by companyname
  order by umsatz desc




  select * into ku from vkundeumsatz

 ---was ist schneller: Sicht oder ad-hoc ABfrage
 create view vku
as
  select country, sum(freight) as Summe from ku
  where country = 'UK'
  group by country


 select country, sum(freight) as summe from ku
  where country = 'UK'
  group by country

  select * from vku

  --Fazit Sicht ist gleich schnell, sofern sie das selbe macht was auch die adhoc Abfrage tut



















