--delete

delete from table where sp = wert

delete from custmits where customerid = 'SANTG'


--ohne where : alles weg!!!

--wie w�rdet ihr alle Datens�tze einer Tabelle l�schen?



select * from custmits

--L�sche den Conatctname aus custmits (SAVEA) raus
--ist ein Update
update custmitS set contactname=NULL
where customerid = 'SAVEA'



--L�schen von Datens�tzen, auf der Basis anderer werte aus anderen Spalten
--Spielwiese
select * into cust from customers

--der Angestellte King ist ein Trickbetr�ger
--seine Kunden haben das Weite gesucht und wollen
--dass wir ihre Datens�tze l�schen

--L�sche alle Kunden, die von King betreut wurde

select * from orders


begin tran
 delete from cust  
--select distinct c.customerid 
from cust c 
inner join orders o on c.customerid = o.customerid
inner join employees e on e.employeeid = o.employeeid
where lastname = 'king'

rollback




