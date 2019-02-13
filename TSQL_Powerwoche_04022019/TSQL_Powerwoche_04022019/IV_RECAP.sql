--Proc-- was ist der Vor und Nachteil von Proz?

--schneller, weil der Plan ("kompiliert") immer vorliegt
-- auch nach Neustart
--Pläne wiederverwenden gibts auch bei adhoc
----> Autoparametrisierung, aber die wird sofort eingestellt,
--wenn der Plan etwas komplexer sein sollte (1 Join)
--Proc verliert ihren Vorteil, wenn sehr varibal Ergebnisse
--geliefert werden
--Der erste Aufruf mit dem erste Parameter legt den Plan+
--für die gesamt Prozedur fest
--Kann man so eine doofe Proc finden






exec _kdidsuche





/****** Object:  StoredProcedure [dbo].[gp_idsuche]    Script Date: 08.02.2019 09:12:36 ******/
DROP PROCEDURE [dbo].[gp_idsuche]
GO


create proc [dbo].[gp_idsuche] @id int
as
select * from watlos3 where id <= @id
GO

exec gp_idsuche 2
exec gp_idsuche 1000000

select * from watlos3 where id <=2
select * from watlos3 where id <=1000000

--Plancache leeren
dbcc freeproccache	--nicht im Produktivsystem..


exec gp_idsuche 1000000

  exec gp_idsuche 2

 select * from watlos3 where id <=1000000
select * from watlos3 where id <=2

--Im QueryStore beobachten.. Verschiedene Pläne?
--große Diff bei Dauern zb (oder auch Lesen/Schreiben)

--PLan erwzingen: kann man machen 
--das Problem wird dadruch kaum behoben
--besser im Code...

						  
select freight from orders
		where customerid like 'A%'


--Funktionen sind Seites performance eigtl immer
--schlecht ..ausser man kann das Gegenteil beweisen
 --statt mit like 'A%' --IX SEEK
 --nun mit F()
select freight from orders
		where left(customerid,1) ='A'


--tu nie in where eine f() um eine Spalte



--Vergleich: CL IX SEEK, SCAN usw

/* wer ist besser:

Table scan vs CL IX SCAN 
--> gleich schnell + Anzahl der Ebenen - 1

--> CL IX SCAN vs CL IX SEEK
--> SEEK

--> CL IX SCAN  vs IX SCAN
--IX SCAN besser als CL IX SCAN und TAB SCAN

 --NCLIX auf HEAP vs NCLIX auf CLIX
 --> NCLIX auf HEAP, weil der CLIX immer beim Wurzelkntoen beginnt

 --IX Fragmentieren: 
 --ab 10% reorg
 --ab 30 rebuild


--Was wenn IX aber passen.. was kann es denn dann sein?
*/
select * from sys.dm_os_wait_stats	order by 3 desc



*/










 set statistics io , time on
SELECT       



Customers.CustomerID, Employees.LastName, Employees.Title, Customers.ContactTitle, Products.ProductName, Products.CategoryID, Orders.EmployeeID, Shippers.CompanyName, 
                         [Order Details].UnitPrice AS Expr1, [Order Details].Quantity
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                         Shippers ON Orders.ShipVia = Shippers.ShipperID
where customers.customerid = 'ALFKI'		   
		  order by expr1
