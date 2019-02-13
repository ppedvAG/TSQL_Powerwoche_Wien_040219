 --Views.. Sichten


 --gemerkte Abfrage
 --enthalten eigtl nie Daten (<--> ind Sicht)
 --verhält sich wie Tabelle (SELECT, INS, UP, DEL)
 --aber unter Einschränkungen

 --Einsatzgebiet:
 --komplexe Abfragen immer wieder vereinfacht verwenden zu können

 --Sicht kann vertikal und horizontal gefilterte Daten ausgeben
 --Security! Sensible Daten ausblenden 
 --das geht! Tabellen Zugriff verweigern aber über die Sicht Daten holen


--im vergleich zu temp Tabellen
--Sicht bleibt... auch nach Neustart des Servers
--immer aktuelle Daten aus Sicht!



 create view vTest1
 as
 --hier immer ein! Select Statement 
 select companyname, customerid, city, country 
 from	kundenukusait
 where 
		city like 'A%';
GO	 --ohne GO ein Batch mit nachfolgenden TSQL..das nicht ginge
 select * from vTest1


 --INS UP DEL

 select * from vTest

 --klappt
 update vtest set customerid = 'PPEDV' where customerid = 'RATTC'

 --insert 	 klappt nur dann, wenn Pflichtfelder gefüllt werden
 --falls die Sicht ein oder mehrere Pflichtfelder nicht enthält
 --geht kein INS mehr
insert into vtest (companyname, city)
values
					('ppedv ag', 'Wien')


--klappt nun 
 insert into vtest (companyname, city, customerid)
values
					('ppedv ag', 'Wien', 'PPgmb')

--aber ;-)
select * from vtest


--delete
--nur das was die Sicht ausgibt wird auch gelöscht
delete from vtest
 --bester schlechtester Kunde mit Sicht

 create view v1
 as
  select top 1 companyname , freight
  from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight desc 
GO
 
 create view v2
 as
  select top 1 companyname , freight
  from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight asc 
GO


select * from v1
UNION ALL
select * from V2


--Sicht mit		 : vKundeUmsatz
--Firma, Customerid, country, city
--orderid, freight, shipcountry, shipcity
--productid, unitprice, quantity
--productname
--lastname, firstname


 create view vKundeUmsatz
 as
 select
		companyname, c.Customerid, c.country, c.city	 
	,	o.orderid, o.freight, o.shipcountry, o.shipcity	
	,	od.productid, od.unitprice, od.quantity
	,	productname	
	,	lastname, firstname
from 
			   customers c 
	inner join orders o				on c.CustomerID = o.customerid
	inner join [order details] od	on od.orderid = o.orderid
	inner join employees e			on e.employeeid = o.employeeid
	inner join products p			on p.productid = od.productid
 GO

 select * from vKundeumsatz


 --Sicht ändern
 
 ALTER view vKundeUmsatz
 as
 select
		companyname, c.Customerid, c.country, c.city	 
	,	o.orderid, o.freight, o.shipcountry, o.shipcity	
	,	od.productid, od.unitprice, od.quantity, od.unitprice*quantity as Possumme
	,	productname	
	,	lastname, firstname
from 
			   customers c 
	inner join orders o				on c.CustomerID = o.customerid
	inner join [order details] od	on od.orderid = o.orderid
	inner join employees e			on e.employeeid = o.employeeid
	inner join products p			on p.productid = od.productid
 GO






