--Select 				 Ausgabe von Daten			 

--SELECT 'TXT', Zahl, Spalte, Mathe, f()

select * from tabelle --* f�r alle Spalten der Tabellen aus dem from
order by sp asc|desc
--Bist Sicher?  korrekte DB?

use northwind;

select * from orders

begin tran
delete from customers  where customerid = 'fissa'

rollback




select * from customers

select * from orders

--Liste: Welche Bestellungen sind wie: zu sp�t, noch nicht angekommen , usw..

--Ausgabe: BestNr, BestDatum, Lieferdatum, gew. Lieferdatum, 
---     verz�gerung
select datediff(dd, '1.1.2000', '3.1.2000')

   select   orderid
		,OrderDate
		,Shippeddate
	    ,Requireddate
		,datediff(dd, shippeddate, RequiredDate)   as delayed   					--Verz�gerung in Tagen
from orders
order by delayed desc

--F�r die Schreibfaulen!!
   select   orderid--, 100
		,OrderDate
		,Shippeddate
	    ,Requireddate
		,datediff(dd, shippeddate, RequiredDate)   as delayed   					--Verz�gerung in Tagen
from orders
order by 5


--aber sicher auch where


select * from orders




