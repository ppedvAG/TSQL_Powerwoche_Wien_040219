--JOIN

Select * from 
		TAB1 JOIN TAB2 ON TAB1.SP = TAB2.SP

select * from 
		customers inner join orders
			ON customers.customerid = orders.customerid


 select * from 
		customers c inner join orders o
			ON c.customerid = o.customerid

 select * from 
		customers c left join orders o
			ON c.customerid = o.customerid

 --das gleiche wie oben mit Left
 select * from 
		orders o right join customers c
			ON c.customerid = o.customerid


 --inner join

 --Alle Kunden (Companyname, City) aus Berlin 
 --und deren Frachtkosten	 (freight)

 select 
			companyname 
			, city 
			, freight
from 
		customers c inner join orders o 
		ON 
		c.customerid = o.customerid
where 
		city = 'berlin'


--welche Kunden habe nicht bestellt?

select 
		companyname
		, c.customerid
		--, o.customerid, o.orderid
from 
		customers c left join orders o 
		ON
		c.customerid = o.customerid
where
		o.orderid is null

--das ganze per right join

 select 
		companyname
		, c.customerid
		--, o.customerid, o.orderid
from 
		orders o  right join customers c
		ON
		c.customerid = o.customerid
where
		o.orderid is null

--CROSS JOIN

select * from customers, orders


select * from customers cross join orders

--rate mal: C 91   O 830 OD 2155
--DB hat knapp 3 MB Daten
--wie groﬂ ist ca das Ergebnis?

select 91*830*2155

--JOIN


--mehr Tabellen 

select * from 
		TAB A inner join TAB B
		ON A.SP = B.SP
			  inner join TAB C
		ON c.cp = b.sp
			 inner join  TAB D
		ON d.sp = c.sp

		    
--Ausgabe: Firma, BestNr, freight, 
--          productname, menge und preis


  select companyname, o.orderid, p.productname
		,o.freight, od.unitprice, od.quantity
from
	customers c
	inner join orders o on o.customerid = c.customerid
	inner join [order details] od on od.orderid = o.orderid
	inner join products p on p.productid = od.productid


--select * from employees
-- Ang, Stv (weil gleiche Stadt)

 select e1.Lastname, e2.lastname, e1.city, e2.city 
 from 
		employees e1 inner join employees e2
		on	
			e1.city = e2.city
			and e1.lastname <> e2.lastname
order by 1,2
















