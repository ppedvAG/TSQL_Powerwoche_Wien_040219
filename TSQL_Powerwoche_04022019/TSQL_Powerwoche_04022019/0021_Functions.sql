--Functions

/*
Skalarwertfunktionen -- > wert rein--> Wert zurück
Tabellenwertfunktionen --> Wert rein--> Tabelle zurück

extrem flexibel einsetzbar


*/



select f(wert), f(spalte) from f(wert) 
where f(spalte) > f(wert)

--Billivariante

create function f_demo(@par1 int, @par2 int)
returns int
as
BEGIN
   return (select @par1+@par2)
END

--funktkioniert scheinbar nicht..
select 	f_demo(100,200)	 --unbekannt

--der Aufruf einer F() muss immer mit Angabe des Schemas
--gemacht werden

--Schema??


/*
Schema entspricht gedanklich einem Ordner

C
	O1	   (ordner und Dateien)
	O2
	O3

c:\O1\Datei

DB
	Schema1	  (Tabellen, Sichten, Proc, F())
	Schema2

DB-schema-tabelle
*/

select * from northwind.dbo.orders

select * from master.dbo.sysobjects

select * from dbo.orders

select * from orders

select * from northwind..orders

select dbo.f_demo(100,200)


select dbo.f_demo(unitprice, quantity) 
from [order details]


--f_brutto .. EIngabe für netto Wert und die Mwst

 create function f_brutto (@netto money, @Proz decimal(4,2))
 returns money
 as
 begin
	 return (select @netto * (@proz +100)/100)
 end


  select dbo.f_brutto(100,20)


  --jo nett
  select freight as netto, dbo.f_brutto(freight, 20) from orders

  --alle Bestellungen deren Frachtkosten größer als 500 Brutto sind
  select * from orders where dbo.f_brutto(freight,20) > 500 

  --häufiger: RngSumme

  --F_RngSumme(BestNr) --> Rsumme raus


  create function f_RngSumme (@bestid int) returns money
  as
	  Begin 

	  return (select sum(unitprice*quantity) from [order details]
			where orderid = @BestId)
	  end


select orderid, dbo.f_RngSumme(orderid), customerid from orders
 order by 1


 --alle Best die über 5000 kosteten
--Cool? 
 select  * from orders
 where 
	dbo.f_rngsumme(orderid) > 5000

--oder auch nicht: mal ohne Funktione

select distinct o.* from orders o 
	inner join [order details] od on od.orderid = o.orderid
	where  o.orderid in		
				(select orderid from 
					(
					select orderid, sum(unitprice * quantity)as Summe from [order details]
					group by orderid having sum(unitprice*quantity) > 5000
					) t)


select o.* from orders o inner join [order details] od
	on od.orderid = o.orderid
	


 select orderid, sum(unitprice * quantity) 	 as Rngsumme
  into #t1
  from [order details]
	group by orderid having sum(unitprice*quantity) > 5000

select * from orders where orderid in 
	(select orderid from #t1)
 drop table #t1








select * from orders where orderid in
(
select orderid from [order details]
				group by orderid having sum(unitprice*quantity) > 5000
) 




 select distinct o.* from orders o 
	inner join [order details] od on od.orderid = o.orderid
	where  o.orderid in		
				(select orderid from 
					(
					select orderid, sum(unitprice * quantity)as Summe from [order details]
					group by orderid having sum(unitprice*quantity) > 5000
					) t)




--Alle Angestellten im Rentenalter

--Employees.. Birthdate .. 65 Jahre


select * from employees
	where year(getdate()) - 	year(birthdate) > =65  

select * from employees
	where datediff(yy, birthdate,getdate()) > 65

declare @Solldatum datetime
set @solldatum = dateadd(yy,-65, Getdate())
select @solldatum
select * from employees where birthdate <= @Solldatum
 select * from employees where birthdate<='1954-02-07 15:02:44.613'

select * from employees
	where birthdate <= dateadd(yy,-65,Getdate())




--Funktionen erfüllen fast immer das Vorurteil: Miese Performance
--Tu niemals in ein where eine F() um eine Spalte
--versuche die Spalte alleine hinzustellen und die Berechnung 
--auf die andere Seite

select * from sys.dm_db_index_physical_Stats(db_id(), object_id('employees'),NULL,NULL, 'detailed')


select 4134*0.24


 set statistics io, time on
select 

* from employees	 with (index=NIX)
	where birthdate <= dateadd(yy,-65,Getdate())

--Tabellenwertfunktion

create function f_tab(@wert varchar(50)) returns table
as
begin 
return
select * from orders where shipcountry= @wert  
end


select dbo.f_rngsumme(10248)

alter table o add RngSumme as dbo.f_Rngsumme(orderid)

select * from o
 --die Spalte RngSumme wird immer erechnet... ist nicht fix
select * from o where rngsumme > 5000

 ----in dieses Fall kein Begin end
 create function ftest2 (@par1 int)
 returns table
 as
 return (select * from orders where orderid = @par1)









