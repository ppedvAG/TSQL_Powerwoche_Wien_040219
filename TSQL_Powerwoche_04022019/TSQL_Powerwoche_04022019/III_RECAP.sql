--IX
--NIX_OID_i_FrCu
select freight, customerid from orders
	where
		orderid = 10248


 --NIX_SC_i_FrCid
 --NIX_Eid_i_FRCid
select freight, customerid from orders
	where
		shipcity = 'Graz'
		OR
		employeeid = 3


--GIX_Odate
select * from orders where orderdate between '1.1.1998' and '1.3.1998'

--NIX_EID
--NIX_CID



set statistics io, time on
select country, city, freight
from 
	customers c
	inner loop join orders o on c.customerid = o.customerid
where 
	employeeid = 3 AND c.customerid like 'A%'


select country, city, freight
from 
	customers c
	inner merge join orders o on c.customerid = o.customerid
where 
	employeeid = 3 AND c.customerid like 'A%'
	

select country, city, freight
from 
	customers c
	 inner hash join orders o on c.customerid = o.customerid
where 
	employeeid = 3 AND c.customerid like 'A%'

--Was könnte daran schlecht sein?
--evtl Kompormisslösung



exec gp_Bestellsuche 'London' -- evt SCAN
--..ab jetzt imm ermit SCAN
exec gp_Bestellsuche 'Trimmelkamm'		--rel. wenig	Seek wäre besser


--die Pro hat immer einen festen Plan
--den bekommt man weg; indem man die Proc löscht und neu anlegt
-- create proc name... with recompile

dbcc freeproccache -- schlechte Idee..


 --Autoparametriesierung
select * from orders where orderid = 10249


select * from customers c inner join orders o on c.customerid = o.customerid
where o.employeeid = 5


