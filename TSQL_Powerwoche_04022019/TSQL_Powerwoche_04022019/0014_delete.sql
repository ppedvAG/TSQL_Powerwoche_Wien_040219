--delete

delete from table where sp = wert

delete from custmits where customerid = 'SANTG'


--ohne where : alles weg!!!

--wie würdet ihr alle Datensätze einer Tabelle löschen?



select * from custmits

--Lösche den Conatctname aus custmits (SAVEA) raus
--ist ein Update
update custmitS set contactname=NULL
where customerid = 'SAVEA'



--Löschen von Datensätzen, auf der Basis anderer werte aus anderen Spalten
--Spielwiese
select * into cust from customers

--der Angestellte King ist ein Trickbetrüger
--seine Kunden haben das Weite gesucht und wollen
--dass wir ihre Datensätze löschen

--Lösche alle Kunden, die von King betreut wurde

select * from orders


begin tran
 delete from cust  
--select distinct c.customerid 
from cust c 
inner join orders o on c.customerid = o.customerid
inner join employees e on e.employeeid = o.employeeid
where lastname = 'king'

rollback




