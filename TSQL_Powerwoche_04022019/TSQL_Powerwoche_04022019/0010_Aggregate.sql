 use northwind

 -- SUM(), MIN(), MAX(), AVG(), COUNT(), 

--durchschnittliche Frachtkosten
 select avg(freight) from orders   --78,2442

 select avg(freight), sum(freight), min(freight), max(freight) 
 from orders

 select customerid, sum(freight) from orders
 group by customerid

 --Summe Frachtkosten pro Land (Shipcountry)

select	 shipcountry as Land, shipcity,sum(freight) from orders 
group by  shipcountry, shipcity
order by shipcountry, shipcity


--jetzt aber nur die, deren Summe Frachtkosten > 2000 ist
select	 shipcountry as Land, shipcity,sum(freight) from orders 
group by  shipcountry, shipcity	 having sum(freight) > 2000
order by shipcountry, shipcity

 --geht, aber sollte man tunlichst vermeiden
select	 shipcountry as Land, shipcity,sum(freight) from orders 
group by  shipcountry, shipcity	 having shipcountry= 'USA'
order by shipcountry, shipcity

--tu nie in having etwas filtern, was ein where leisten kann
--anders gesagt. im having sollten nur Agg stehen
--wg logischen Fluss


--Welcher Kunde hat den höchsten Umsatz?

  select top 1 companyname, sum(unitprice*quantity) as Umsatz
  from 
	customers c inner join orders o on c.customerid = o.customerid
				inner join [order details] od on od.orderid = o.orderid 
  group by companyname
  order by umsatz desc
  

  select top 1 companyname, sum(unitprice*quantity) 
  from vKundeumsatz
  group by companyname
  order by 2 desc


  --Anzahl pro Land pro Stadt
  select * from customers

select country, city, count(*) from customers
group by country, city
order by country, city

 --soweit so gut... aber ...
 --und in Österreich insgesamt?
 --Weltweit	 ?
 --und in Paris	   ..unabhängig von Land?


select country, city, count(*) from customers		  --92
group by country, city
	with rollup
order by country, city
				   
select country, city, count(*) as Anzahl
into #t1
from customers		   -- 162
group by country, city
	with cube
order by country, city



select * from #t1

--Welcher Kunde hatte die höchste RngSumme?


 select top 1 companyname, orderid, sum(possumme)
 from 
		vKundeumsatz
group by companyname, orderid
order by 3 desc



