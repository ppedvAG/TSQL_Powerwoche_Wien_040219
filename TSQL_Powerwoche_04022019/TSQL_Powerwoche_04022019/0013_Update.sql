--UPDATE

--Daten ändern

select * from custmits

--
update tabelle set sp = wert where sp = wert

update custmitS set city = 'Wien' where customerid = 'SANTG'

select * from custmits

update custmits 
		set 
				city = 'Wien' 
			  , country = 'Austria'
		where 
				customerid = 'SANTG'

--auch Berechnungen

select * into #o1 from orders


update #o1 set freight = freight *1.2
where orderid = 10250



--was aber, wenn wir Daten in TAB A ändern wollen in Abh. von Werten in
--anderen Tabellen

--Tipp:

--Lass dir erst mal alle Datensätze ausgeben die betroffen sind
--wenn du dir nicht sicher bist: TX

--dann select in eine Zeile
--from nächste Zeile
--dann select auskommentieren



--wir wollen alle Frachtkosten um 10 % senken,
--bei denen der Kunde aus Austria kommt


begin tran


update orders set freight = freight *0.9
--select companyname, country, orderid, freight 
from 
customers c inner join orders o on c.customerid = o.customerid 
where country = 'AUSTRIA'
	

rollback














